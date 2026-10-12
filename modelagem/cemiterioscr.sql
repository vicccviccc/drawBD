CREATE DATABASE IF NOT EXISTS cemiterio;
USE cemiterio;

-- =========================
-- RESPONSAVEL
-- =========================
CREATE TABLE Responsavel (
    idResponsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

-- =========================
-- EXUMACAO
-- =========================
CREATE TABLE Exumacao (
    idExumacao INT AUTO_INCREMENT PRIMARY KEY,
    data_exumacao DATE,
    motivo VARCHAR(255),
    autorizacao_legal VARCHAR(50)
);

-- =========================
-- JAZIGO
-- =========================
CREATE TABLE Jazigo (
    id_jazigo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_localizacao VARCHAR(100) NOT NULL,
    tipo_estrutura VARCHAR(100),
    capacidade_maxima INT,
    status_ocupacao VARCHAR(30),

    Responsavel_idResponsavel INT NOT NULL,

    CONSTRAINT fk_jazigo_responsavel
        FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
);

-- =========================
-- COBRANCA
-- =========================
CREATE TABLE Cobranca (
    idCobranca INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE,
    data_pagamento DATE,
    status_pagamento VARCHAR(30),

    Responsavel_idResponsavel INT NOT NULL,

    CONSTRAINT fk_cobranca_responsavel
        FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
);

-- =========================
-- SEPULTAMENTO
-- =========================
CREATE TABLE sepultamento (
    id_sepultamento INT AUTO_INCREMENT PRIMARY KEY,
    data_sepultamento DATE NOT NULL,
    horario TIME,
    observacoes VARCHAR(255),

    Jazigo_id_jazigo INT NOT NULL,
    Exumacao_idExumacao INT,

    CONSTRAINT fk_sepultamento_jazigo
        FOREIGN KEY (Jazigo_id_jazigo)
        REFERENCES Jazigo(id_jazigo),

    CONSTRAINT fk_sepultamento_exumacao
        FOREIGN KEY (Exumacao_idExumacao)
        REFERENCES Exumacao(idExumacao)
);

-- =========================
-- FALECIDO
-- =========================
CREATE TABLE Falecido (
    idFalecido INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14),
    data_nascimento DATE,
    data_falecimento DATE NOT NULL,
    num_certidao_obito VARCHAR(50),

    sepultamento_id_sepultamento INT NOT NULL,
    sepultamento_Jazigo_id_jazigo INT NOT NULL,

    CONSTRAINT fk_falecido_sepultamento
        FOREIGN KEY (sepultamento_id_sepultamento)
        REFERENCES sepultamento(id_sepultamento),

    CONSTRAINT fk_falecido_jazigo
        FOREIGN KEY (sepultamento_Jazigo_id_jazigo)
        REFERENCES Jazigo(id_jazigo)
);