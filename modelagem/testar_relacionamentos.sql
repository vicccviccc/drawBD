-- Testes simples do banco de cemiterio
-- Antes, execute o arquivo atividade_relacionamentos.sql no Workbench.
USE cemiterio;

-- Aqui eu vejo as tabelas que foram criadas.
SHOW TABLES;

-- Aqui vejo para onde apontam as chaves estrangeiras.
SELECT TABLE_NAME AS tabela, COLUMN_NAME AS coluna,
       REFERENCED_TABLE_NAME AS tabela_referenciada,
       REFERENCED_COLUMN_NAME AS coluna_referenciada
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'cemiterio'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;

-- Vou colocar alguns dados so para conferir os relacionamentos.
-- ROLLBACK no final desfaz os INSERTs se as tabelas usarem InnoDB.
START TRANSACTION;

INSERT INTO Responsavel (nome, cpf)
VALUES ('Pessoa de teste', 'TESTE000000001');
SET @responsavel := LAST_INSERT_ID();

-- Relacao 1:N: dois jazigos para o mesmo responsavel.
INSERT INTO Jazigo (codigo_localizacao, Responsavel_idResponsavel)
VALUES ('QUADRA-TESTE-1', @responsavel),
       ('QUADRA-TESTE-2', @responsavel);

INSERT INTO Falecido (nome, data_falecimento, num_certidao_obito)
VALUES ('Falecido de teste', '2026-01-01', 'CERTIDAO-TESTE-001');
SET @falecido := LAST_INSERT_ID();

INSERT INTO Sepultamento (data_sepultamento, Jazigo_id_jazigo, Falecido_idFalecido)
SELECT '2026-01-02', id_jazigo, @falecido
FROM Jazigo WHERE codigo_localizacao = 'QUADRA-TESTE-1'
  AND Responsavel_idResponsavel = @responsavel
LIMIT 1;
SET @sepultamento := LAST_INSERT_ID();

INSERT INTO Exumacao (data_exumacao, motivo, Sepultamento_id_sepultamento)
VALUES ('2026-11-16', 'Registro de teste', @sepultamento);

-- Duas cobrancas para o mesmo responsavel.
INSERT INTO Cobranca (valor, Responsavel_idResponsavel)
VALUES (100.00, @responsavel);
SET @cobranca1 := LAST_INSERT_ID();
INSERT INTO Cobranca (valor, Responsavel_idResponsavel)
VALUES (150.00, @responsavel);
SET @cobranca2 := LAST_INSERT_ID();

INSERT INTO TipoServico (codigo, descricao)
VALUES ('TESTE_LIMPEZA', 'Limpeza de teste');
SET @servico1 := LAST_INSERT_ID();
INSERT INTO TipoServico (codigo, descricao)
VALUES ('TESTE_MANUTENCAO', 'Manutencao de teste');
SET @servico2 := LAST_INSERT_ID();

-- Relacao N:N: uma cobranca tem dois servicos e um servico aparece em duas cobrancas.
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES (@cobranca1, @servico1, 1, 50.00),
       (@cobranca1, @servico2, 1, 50.00),
       (@cobranca2, @servico1, 2, 75.00);

INSERT INTO ResponsavelEmail (idResponsavel, email)
VALUES (@responsavel, 'teste1@exemplo.com'),
       (@responsavel, 'teste2@exemplo.com');

-- Este SELECT deve mostrar tres itens, com seus servicos e cobrancas.
SELECT c.idCobranca, s.descricao, i.quantidade, i.precoPraticado
FROM ItemCobranca i
JOIN Cobranca c ON c.idCobranca = i.idCobranca
JOIN TipoServico s ON s.idServico = i.idServico
WHERE c.idCobranca IN (@cobranca1, @cobranca2)
ORDER BY c.idCobranca, s.idServico;

-- Assim nao ficam dados de teste guardados no banco.
ROLLBACK;
