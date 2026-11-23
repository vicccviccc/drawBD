-- DML - povoamento do banco com os cenários do cemitério.
-- Os dados são fictícios. Os CPFs e as certidões são apenas exemplos.
-- Executar primeiro o script-ddl.sql em um banco de teste vazio.
USE cemiterio_atividade;
START TRANSACTION;

-- Cenário 1: Organização inicial (janeiro de 2017)
-- Antes de começar os registros, a administração cadastrou os serviços
-- disponíveis e seus preços de referência.
INSERT INTO TipoServico (idServico, codigo, descricao, valor_referencia)
VALUES
    (1, 'MANUTENCAO', 'Manutenção anual do jazigo', 120),
    (2, 'LIMPEZA', 'Limpeza do jazigo', 80),
    (3, 'SEPULTAMENTO', 'Serviço de sepultamento', 250),
    (4, 'EXUMACAO', 'Serviço de exumação', 300),
    (5, 'TRANSFERENCIA', 'Transferência para ossuário externo', 100);

-- Cenário 2: Cadastro das famílias e concessão dos jazigos (janeiro de 2017)
-- Seis responsáveis procuraram a administração. Helena Duarte ficou com
-- dois jazigos da família e cadastrou dois emails para receber avisos.
INSERT INTO Responsavel (idResponsavel, nome, cpf, telefone, endereco)
VALUES
    (1, 'Helena Duarte', '000.000.000-01', NULL, 'Rua das Acácias, 18'),
    (2, 'Marcos Nogueira', '000.000.000-02', NULL, 'Rua do Cajueiro, 42'),
    (3, 'Lúcia Fernandes', '000.000.000-03', NULL, 'Rua das Flores, 75'),
    (4, 'Paulo Ribeiro', '000.000.000-04', NULL, 'Travessa do Sol, 12'),
    (5, 'Renata Melo', '000.000.000-05', NULL, 'Rua da Lagoa, 33'),
    (6, 'André Batista', '000.000.000-06', NULL, 'Rua das Palmeiras, 90');

INSERT INTO ResponsavelEmail (idResponsavel, email, tipo, data_cadastro)
VALUES
    (1, 'helena.duarte@example.com', 'Pessoal', '2017-01-10'),
    (1, 'helena.trabalho@example.com', 'Trabalho', '2017-01-10'),
    (2, 'marcos.nogueira@example.com', 'Pessoal', '2017-01-11'),
    (3, 'lucia.fernandes@example.com', 'Pessoal', '2017-01-12'),
    (4, 'paulo.ribeiro@example.com', 'Pessoal', '2017-01-13'),
    (5, 'renata.melo@example.com', 'Pessoal', '2017-01-14'),
    (6, 'andre.batista@example.com', 'Pessoal', '2017-01-15');

-- Os sete jazigos começam disponíveis. O DEFAULT coloca esse status.
INSERT INTO Jazigo (id_jazigo, codigo_localizacao, tipo_estrutura, capacidade_maxima, Responsavel_idResponsavel)
VALUES
    (1, 'Setor A, Quadra 1, Nº 01', 'Jazigo familiar', 2, 1),
    (2, 'Setor A, Quadra 1, Nº 02', 'Gaveta', 1, 2),
    (3, 'Setor A, Quadra 1, Nº 03', 'Gaveta', 1, 3),
    (4, 'Setor B, Quadra 2, Nº 04', 'Jazigo familiar', 2, 4),
    (5, 'Setor B, Quadra 2, Nº 05', 'Gaveta', 1, 5),
    (6, 'Setor B, Quadra 2, Nº 06', 'Gaveta', 1, 6),
    (7, 'Setor C, Quadra 3, Nº 07', 'Jazigo familiar', 3, 1);

-- Cenário 3: Primeiros sepultamentos (2017 a 2018)
-- Cinco famílias apresentaram as certidões de óbito. Os falecidos foram
-- cadastrados primeiro e depois ligados aos jazigos de cada família.
INSERT INTO Falecido (idFalecido, nome, cpf, data_nascimento, data_falecimento, num_certidao_obito)
VALUES
    (1, 'Antônio Duarte', '000.000.000-11', '1940-05-09', '2017-02-03', 'FICT-OB-2017-001'),
    (2, 'Marta Nogueira', '000.000.000-12', '1952-08-21', '2017-04-10', 'FICT-OB-2017-002'),
    (3, 'José Fernandes', '000.000.000-13', '1945-11-14', '2017-09-13', 'FICT-OB-2017-003'),
    (4, 'Célia Ribeiro', '000.000.000-14', '1950-03-18', '2018-01-08', 'FICT-OB-2018-001'),
    (5, 'Francisco Melo', '000.000.000-15', '1938-12-02', '2018-05-19', 'FICT-OB-2018-002');

INSERT INTO Sepultamento (id_sepultamento, data_sepultamento, horario, observacoes, Jazigo_id_jazigo, Falecido_idFalecido)
VALUES
    (1, '2017-02-04', '09:00:00', 'Sepultamento no jazigo da família Duarte', 1, 1),
    (2, '2017-04-11', '15:00:00', 'Sepultamento na gaveta da família Nogueira', 2, 2),
    (3, '2017-09-14', '10:00:00', 'Sepultamento na gaveta da família Fernandes', 3, 3),
    (4, '2018-01-09', '14:00:00', 'Sepultamento no jazigo da família Ribeiro', 4, 4),
    (5, '2018-05-20', '08:00:00', 'Sepultamento na gaveta da família Melo', 5, 5);

-- As três gavetas de uma vaga ficaram cheias. Os jazigos familiares
-- ainda possuem espaço, então continuam disponíveis.
UPDATE Jazigo SET status_ocupacao = 'Ocupado' WHERE id_jazigo IN (2, 3, 5);

-- Cenário 4: Exumações e cobranças (fevereiro a junho de 2025)
-- Anos depois, cinco famílias solicitaram exumações. Neste exemplo,
-- todas já tinham a autorização e a liberação do prazo legal.
-- As retiradas liberaram as vagas, e os serviços foram cobrados.

-- 2025-02-10: atendimento da família Duarte.
INSERT INTO Exumacao (idExumacao, data_exumacao, motivo, autorizacao_legal, Sepultamento_id_sepultamento)
VALUES
    (1, '2025-02-10', 'Transferência autorizada pela família', 'FICT-AUT-2025-001', 1);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (1, 380, '2025-02-10', '2025-03-10', '2025-02-20', 'Pago', 1);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (1, 4, 1, 300),
    (1, 2, 1, 80);

-- 2025-03-12: atendimento da família Nogueira.
INSERT INTO Exumacao (idExumacao, data_exumacao, motivo, autorizacao_legal, Sepultamento_id_sepultamento)
VALUES
    (2, '2025-03-12', 'Transferência para ossuário externo', 'FICT-AUT-2025-002', 2);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (2, 400, '2025-03-12', '2025-04-12', '2025-03-22', 'Pago', 2);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (2, 4, 1, 300),
    (2, 5, 1, 100);

-- 2025-04-08: atendimento da família Fernandes.
INSERT INTO Exumacao (idExumacao, data_exumacao, motivo, autorizacao_legal, Sepultamento_id_sepultamento)
VALUES
    (3, '2025-04-08', 'Retirada autorizada a pedido da família', 'FICT-AUT-2025-003', 3);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (3, 300, '2025-04-08', '2025-05-08', '2025-04-15', 'Pago', 3);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (3, 4, 1, 300);

-- 2025-05-13: atendimento da família Ribeiro.
INSERT INTO Exumacao (idExumacao, data_exumacao, motivo, autorizacao_legal, Sepultamento_id_sepultamento)
VALUES
    (4, '2025-05-13', 'Reorganização do jazigo familiar', 'FICT-AUT-2025-004', 4);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (4, 380, '2025-05-13', '2025-06-13', '2025-05-22', 'Pago', 4);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (4, 4, 1, 300),
    (4, 2, 1, 80);

-- 2025-06-17: atendimento da família Melo.
INSERT INTO Exumacao (idExumacao, data_exumacao, motivo, autorizacao_legal, Sepultamento_id_sepultamento)
VALUES
    (5, '2025-06-17', 'Transferência para ossuário externo', 'FICT-AUT-2025-005', 5);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (5, 480, '2025-06-17', '2025-07-17', '2025-06-25', 'Pago', 5);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (5, 4, 1, 300),
    (5, 5, 1, 100),
    (5, 2, 1, 80);

UPDATE Jazigo SET status_ocupacao = 'Disponivel' WHERE id_jazigo IN (2, 3, 5);

-- Cenário 5: Novos sepultamentos e manutenção (novembro de 2026)
-- Helena voltou para sepultar Isabel no jazigo familiar. André
-- usou a gaveta que ainda estava disponível para sepultar Rosa.
-- As cobranças reúnem os serviços de sepultamento e manutenção.
-- André pediu também duas limpezas, e sua cobrança ficou pendente.

-- Atendimento da família Duarte.
INSERT INTO Falecido (idFalecido, nome, cpf, data_nascimento, data_falecimento, num_certidao_obito)
VALUES
    (6, 'Isabel Duarte', '000.000.000-16', '1949-07-24', '2026-11-03', 'FICT-OB-2026-001');
INSERT INTO Sepultamento (id_sepultamento, data_sepultamento, horario, observacoes, Jazigo_id_jazigo, Falecido_idFalecido)
VALUES
    (6, '2026-11-04', '09:00:00', 'Novo sepultamento no jazigo da família Duarte', 1, 6);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (6, 370, '2026-11-04', '2026-12-04', '2026-11-09', 'Pago', 1);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (6, 1, 1, 120),
    (6, 3, 1, 250);

-- Atendimento da família Batista.
INSERT INTO Falecido (idFalecido, nome, cpf, data_nascimento, data_falecimento, num_certidao_obito)
VALUES
    (7, 'Rosa Batista', '000.000.000-17', '1957-09-15', '2026-11-12', 'FICT-OB-2026-002');
INSERT INTO Sepultamento (id_sepultamento, data_sepultamento, horario, observacoes, Jazigo_id_jazigo, Falecido_idFalecido)
VALUES
    (7, '2026-11-13', '15:00:00', 'Sepultamento na gaveta da família Batista', 6, 7);
INSERT INTO Cobranca (idCobranca, valor, data_emissao, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES
    (7, 530, '2026-11-13', '2026-12-13', NULL, 'Pendente', 6);
INSERT INTO ItemCobranca (idCobranca, idServico, quantidade, precoPraticado)
VALUES
    (7, 1, 1, 120),
    (7, 3, 1, 250),
    (7, 2, 2, 80);

-- A gaveta da família Batista ficou cheia após o sepultamento.
UPDATE Jazigo SET status_ocupacao = 'Ocupado' WHERE id_jazigo = 6;

-- Salvei os registros para poder consultar depois.
COMMIT;
