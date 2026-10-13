USE cemiterio;

-- ==========================================
-- PARTE 1.1 - TABELA A: RESPONSAVEL
-- 8 REGISTROS
-- ==========================================

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Joao Silva', '111.111.111-11', '84999990001', 'Natal/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Maria Santos', '222.222.222-22', '84999990002', 'Natal/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Carlos Oliveira', '333.333.333-33', '84999990003', 'Parnamirim/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Ana Souza', '444.444.444-44', '84999990004', 'Natal/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Pedro Costa', '555.555.555-55', '84999990005', 'Macaiba/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Juliana Lima', '666.666.666-66', '84999990006', 'Natal/RN');

INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Marcos Ferreira', '777.777.777-77', '84999990007', 'Sao Goncalo do Amarante/RN');

-- Este responsável ficará SEM nenhuma cobrança
INSERT INTO Responsavel (nome, cpf, telefone, endereco)
VALUES ('Fernanda Alves', '888.888.888-88', '84999990008', 'Natal/RN');


-- ==========================================
-- PARTE 1.2 - TABELA B: COBRANCA
-- ==========================================

-- RESPONSAVEL 1 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (150.00, '2026-10-10', '2026-10-08', 'Pago', 1);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (200.00, '2026-11-10', NULL, 'Pendente', 1);


-- RESPONSAVEL 2 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (180.00, '2026-10-15', '2026-10-14', 'Pago', 2);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (220.00, '2026-11-15', NULL, 'Pendente', 2);


-- RESPONSAVEL 3 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (130.00, '2026-10-20', '2026-10-18', 'Pago', 3);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (170.00, '2026-11-20', NULL, 'Pendente', 3);


-- RESPONSAVEL 4 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (250.00, '2026-10-25', '2026-10-23', 'Pago', 4);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (190.00, '2026-11-25', NULL, 'Pendente', 4);


-- RESPONSAVEL 5 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (160.00, '2026-10-30', '2026-10-29', 'Pago', 5);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (210.00, '2026-11-30', NULL, 'Pendente', 5);


-- RESPONSAVEL 6 - 2 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (140.00, '2026-10-12', '2026-10-11', 'Pago', 6);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (230.00, '2026-11-12', NULL, 'Pendente', 6);


-- RESPONSAVEL 7 - 4 COBRANCAS

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (120.00, '2026-08-05', '2026-08-04', 'Pago', 7);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (150.00, '2026-09-05', '2026-09-05', 'Pago', 7);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (180.00, '2026-10-05', '2026-10-03', 'Pago', 7);

INSERT INTO Cobranca
(valor, data_vencimento, data_pagamento, status_pagamento, Responsavel_idResponsavel)
VALUES (200.00, '2026-11-05', NULL, 'Pendente', 7);


-- RESPONSAVEL 8
-- NAO POSSUI COBRANCAS