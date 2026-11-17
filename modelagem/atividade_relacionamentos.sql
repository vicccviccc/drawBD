-- Atividade de relacionamentos do projeto de cemiterio
-- ATENCAO: esse script apaga os dados antigos do banco cemiterio.
-- Deixei assim para conseguir executar tudo de novo durante os testes.
DROP DATABASE IF EXISTS cemiterio;
CREATE DATABASE cemiterio CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cemiterio;

-- Um responsavel pode ter varios jazigos e receber varias cobrancas.
CREATE TABLE Responsavel (
    idResponsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

-- A FK fica no lado muitos (Jazigo).
CREATE TABLE Jazigo (
    id_jazigo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_localizacao VARCHAR(100) NOT NULL,
    tipo_estrutura VARCHAR(100),
    capacidade_maxima INT,
    status_ocupacao VARCHAR(30),
    Responsavel_idResponsavel INT NOT NULL,
    CONSTRAINT fk_jazigo_responsavel FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
);

CREATE TABLE Falecido (
    idFalecido INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14),
    data_nascimento DATE,
    data_falecimento DATE NOT NULL,
    num_certidao_obito VARCHAR(50) NOT NULL UNIQUE
);

-- Um jazigo recebe varios sepultamentos, mas cada falecido tem no maximo um.
CREATE TABLE Sepultamento (
    id_sepultamento INT AUTO_INCREMENT PRIMARY KEY,
    data_sepultamento DATE NOT NULL,
    horario TIME,
    observacoes VARCHAR(255),
    Jazigo_id_jazigo INT NOT NULL,
    Falecido_idFalecido INT NOT NULL UNIQUE,
    CONSTRAINT fk_sepultamento_jazigo FOREIGN KEY (Jazigo_id_jazigo)
        REFERENCES Jazigo(id_jazigo),
    CONSTRAINT fk_sepultamento_falecido FOREIGN KEY (Falecido_idFalecido)
        REFERENCES Falecido(idFalecido)
);

-- Uma exumacao pertence a um sepultamento, e nao pode repetir esse vinculo.
CREATE TABLE Exumacao (
    idExumacao INT AUTO_INCREMENT PRIMARY KEY,
    data_exumacao DATE,
    motivo VARCHAR(255),
    autorizacao_legal VARCHAR(50),
    Sepultamento_id_sepultamento INT NOT NULL UNIQUE,
    CONSTRAINT fk_exumacao_sepultamento FOREIGN KEY (Sepultamento_id_sepultamento)
        REFERENCES Sepultamento(id_sepultamento)
);

CREATE TABLE Cobranca (
    idCobranca INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE,
    data_pagamento DATE,
    status_pagamento VARCHAR(30),
    Responsavel_idResponsavel INT NOT NULL,
    CONSTRAINT fk_cobranca_responsavel FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
);

-- Tabela separada porque um responsavel pode ter mais de um email.
CREATE TABLE ResponsavelEmail (
    idResponsavel INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (idResponsavel, email),
    CONSTRAINT fk_email_responsavel FOREIGN KEY (idResponsavel)
        REFERENCES Responsavel(idResponsavel)
);

CREATE TABLE TipoServico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(35) NOT NULL UNIQUE,
    descricao VARCHAR(120) NOT NULL,
    valor_referencia DECIMAL(10,2)
);

-- A tabela intermediaria resolve o N:N de Cobranca e TipoServico.
CREATE TABLE ItemCobranca (
    idCobranca INT NOT NULL,
    idServico INT NOT NULL,
    quantidade INT NOT NULL,
    precoPraticado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idCobranca, idServico),
    CONSTRAINT fk_item_cobranca FOREIGN KEY (idCobranca)
        REFERENCES Cobranca(idCobranca),
    CONSTRAINT fk_item_servico FOREIGN KEY (idServico)
        REFERENCES TipoServico(idServico)
);

-- A lotacao do jazigo e o prazo de exumacao ainda precisam
-- ser conferidos pela logica do sistema, nao apenas pelas FKs.
