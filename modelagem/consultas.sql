-- Consultas para conferir o resultado da atividade no Workbench.
-- Rodar depois do script-ddl.sql e do script-dml.sql.
USE cemiterio_atividade;

-- 1. Ver as tabelas e a quantidade de registros em cada uma.
SHOW TABLES;

SELECT 'Responsavel' AS tabela, COUNT(*) AS registros FROM Responsavel
UNION ALL SELECT 'Jazigo', COUNT(*) FROM Jazigo
UNION ALL SELECT 'Falecido', COUNT(*) FROM Falecido
UNION ALL SELECT 'Sepultamento', COUNT(*) FROM Sepultamento
UNION ALL SELECT 'Exumacao', COUNT(*) FROM Exumacao
UNION ALL SELECT 'Cobranca', COUNT(*) FROM Cobranca
UNION ALL SELECT 'ResponsavelEmail', COUNT(*) FROM ResponsavelEmail
UNION ALL SELECT 'TipoServico', COUNT(*) FROM TipoServico
UNION ALL SELECT 'ItemCobranca', COUNT(*) FROM ItemCobranca;

-- 2. Aqui aparece o 1:N: Helena tem dois jazigos.
SELECT r.nome, j.codigo_localizacao, j.tipo_estrutura
FROM Responsavel r
JOIN Jazigo j ON j.Responsavel_idResponsavel = r.idResponsavel
ORDER BY r.idResponsavel, j.id_jazigo;

-- 3. Aqui aparece o N:N: a cobranca pode ter mais de um servico.
SELECT c.idCobranca, r.nome, s.descricao, i.quantidade,
       i.precoPraticado, i.quantidade * i.precoPraticado AS subtotal
FROM ItemCobranca i
JOIN Cobranca c ON c.idCobranca = i.idCobranca
JOIN Responsavel r ON r.idResponsavel = c.Responsavel_idResponsavel
JOIN TipoServico s ON s.idServico = i.idServico
ORDER BY c.idCobranca, i.idServico;

-- 4. Comparei o valor da cobranca com a soma dos seus itens.
-- A diferenca deve ser zero em todas as cobrancas.
SELECT c.idCobranca, c.valor,
       COALESCE(SUM(i.quantidade * i.precoPraticado), 0) AS soma_itens,
       c.valor - COALESCE(SUM(i.quantidade * i.precoPraticado), 0) AS diferenca
FROM Cobranca c
LEFT JOIN ItemCobranca i ON i.idCobranca = c.idCobranca
GROUP BY c.idCobranca, c.valor
ORDER BY c.idCobranca;

-- 5. Valores das cobrancas pagas e pendentes.
SELECT status_pagamento, COUNT(*) AS quantidade, SUM(valor) AS total
FROM Cobranca
GROUP BY status_pagamento
ORDER BY status_pagamento;

-- 6. Sepultamentos e exumacoes. Os mais recentes nao foram exumados.
SELECT f.nome, s.data_sepultamento, e.data_exumacao, e.autorizacao_legal
FROM Sepultamento s
JOIN Falecido f ON f.idFalecido = s.Falecido_idFalecido
LEFT JOIN Exumacao e ON e.Sepultamento_id_sepultamento = s.id_sepultamento
ORDER BY s.data_sepultamento;

-- 7. Conferi a ocupacao contando somente quem ainda nao foi exumado.
SELECT j.codigo_localizacao, j.capacidade_maxima, j.status_ocupacao,
       COUNT(CASE WHEN e.idExumacao IS NULL THEN s.id_sepultamento END) AS ocupados,
       j.capacidade_maxima -
       COUNT(CASE WHEN e.idExumacao IS NULL THEN s.id_sepultamento END) AS vagas
FROM Jazigo j
LEFT JOIN Sepultamento s ON s.Jazigo_id_jazigo = j.id_jazigo
LEFT JOIN Exumacao e ON e.Sepultamento_id_sepultamento = s.id_sepultamento
GROUP BY j.id_jazigo, j.codigo_localizacao, j.capacidade_maxima, j.status_ocupacao
ORDER BY j.id_jazigo;
