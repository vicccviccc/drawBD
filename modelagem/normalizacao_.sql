USE cemiterio;

-- 1FN: fiz uma tabela separada para guardar mais de um email por responsavel.
CREATE TABLE IF NOT EXISTS ResponsavelEmail (
  idResponsavel INT NOT NULL,
  email VARCHAR(100) NOT NULL,
  -- Os dois campos juntos evitam repetir o mesmo email.
  PRIMARY KEY (idResponsavel, email),
  FOREIGN KEY (idResponsavel) REFERENCES Responsavel(idResponsavel)
);

-- 2FN: deixei os dados do servico separados dos itens da cobranca.
CREATE TABLE IF NOT EXISTS TipoServico (
  idServico INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(35) NOT NULL UNIQUE,
  descricao VARCHAR(120) NOT NULL,
  valor_referencia DECIMAL(10,2)
);

-- Aqui liguei a cobranca ao servico usando os dois IDs.
CREATE TABLE IF NOT EXISTS ItemCobranca (
  idCobranca INT NOT NULL,
  idServico INT NOT NULL,
  quantidade INT NOT NULL,
  precoPraticado DECIMAL(10,2) NOT NULL,
  -- A chave composta identifica cada item sem repetir a descricao.
  PRIMARY KEY (idCobranca, idServico),
  FOREIGN KEY (idCobranca) REFERENCES Cobranca(idCobranca),
  FOREIGN KEY (idServico) REFERENCES TipoServico(idServico)
);

-- 3FN: a tabela Cobranca ja guarda o ID do responsavel, nao o nome.
-- Agora coloquei alguns dados para testar. O IGNORE evita duplicatas.
INSERT IGNORE INTO ResponsavelEmail
SELECT idResponsavel, 'contato@exemplo.com'
FROM Responsavel ORDER BY idResponsavel LIMIT 1;

-- O mesmo responsavel pode ter outro email.
INSERT IGNORE INTO ResponsavelEmail
SELECT idResponsavel, 'outro@exemplo.com'
FROM Responsavel ORDER BY idResponsavel LIMIT 1;

-- Cadastrei um servico de exemplo.
INSERT IGNORE INTO TipoServico (codigo, descricao, valor_referencia)
VALUES ('LIMPEZA', 'Limpeza de jazigo', 100.00);

-- Liguei a primeira cobranca a esse servico so para demonstrar.
INSERT IGNORE INTO ItemCobranca
SELECT c.idCobranca, s.idServico, 1, c.valor
FROM Cobranca c JOIN TipoServico s ON s.codigo = 'LIMPEZA'
ORDER BY c.idCobranca LIMIT 1;

-- 1FN: o JOIN mostra os emails junto com o nome do responsavel.
SELECT r.nome, e.email
FROM Responsavel r JOIN ResponsavelEmail e
ON r.idResponsavel = e.idResponsavel;

-- 2FN e 3FN: juntei as tabelas para mostrar nomes sem repetir os dados.
SELECT r.nome, s.descricao, i.quantidade, i.precoPraticado
FROM Cobranca c
JOIN Responsavel r ON r.idResponsavel = c.Responsavel_idResponsavel
JOIN ItemCobranca i ON i.idCobranca = c.idCobranca
JOIN TipoServico s ON s.idServico = i.idServico;

-- Aqui contei as cobrancas e somei o valor de cada responsavel.
SELECT r.nome, COUNT(c.idCobranca) AS total, SUM(c.valor) AS valor
FROM Responsavel r JOIN Cobranca c
ON c.Responsavel_idResponsavel = r.idResponsavel
GROUP BY r.idResponsavel, r.nome;
