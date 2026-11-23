-- DDL - estrutura do banco de dados do cemiterio.
-- Usei outro nome de banco para não mexer no banco cemiterio antigo.
-- ATENCAO: executar de novo apaga somente o banco cemiterio_atividade.
DROP DATABASE IF EXISTS cemiterio_atividade;
CREATE DATABASE cemiterio_atividade CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cemiterio_atividade;

-- Um responsavel pode ter varios jazigos e receber varias cobrancas.
CREATE TABLE Responsavel (
    idResponsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(255)
) ENGINE=InnoDB;

-- A FK fica no lado muitos (Jazigo).
CREATE TABLE Jazigo (
    id_jazigo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_localizacao VARCHAR(100) NOT NULL UNIQUE,
    tipo_estrutura VARCHAR(100) NOT NULL,
    capacidade_maxima INT NOT NULL,
    status_ocupacao VARCHAR(30) NOT NULL DEFAULT 'Disponivel',
    Responsavel_idResponsavel INT NOT NULL,
    CONSTRAINT ck_jazigo_capacidade CHECK (capacidade_maxima > 0),
    CONSTRAINT ck_jazigo_status CHECK (status_ocupacao IN ('Disponivel', 'Ocupado', 'Manutencao')),
    CONSTRAINT fk_jazigo_responsavel FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
) ENGINE=InnoDB;

CREATE TABLE Falecido (
    idFalecido INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14),
    data_nascimento DATE,
    data_falecimento DATE NOT NULL,
    num_certidao_obito VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT ck_falecido_datas CHECK (data_nascimento IS NULL OR data_nascimento <= data_falecimento)
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- Uma exumacao pertence a um sepultamento, e nao pode repetir esse vinculo.
CREATE TABLE Exumacao (
    idExumacao INT AUTO_INCREMENT PRIMARY KEY,
    data_exumacao DATE NOT NULL,
    motivo VARCHAR(255),
    autorizacao_legal VARCHAR(50) NOT NULL UNIQUE,
    Sepultamento_id_sepultamento INT NOT NULL UNIQUE,
    CONSTRAINT fk_exumacao_sepultamento FOREIGN KEY (Sepultamento_id_sepultamento)
        REFERENCES Sepultamento(id_sepultamento)
) ENGINE=InnoDB;

CREATE TABLE Cobranca (
    idCobranca INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_emissao DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    status_pagamento VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    Responsavel_idResponsavel INT NOT NULL,
    CONSTRAINT ck_cobranca_valor CHECK (valor >= 0),
    CONSTRAINT ck_cobranca_vencimento CHECK (data_vencimento >= data_emissao),
    CONSTRAINT ck_cobranca_pagamento CHECK (data_pagamento IS NULL OR data_pagamento >= data_emissao),
    CONSTRAINT ck_cobranca_status CHECK (
        (status_pagamento = 'Pago' AND data_pagamento IS NOT NULL)
        OR (status_pagamento IN ('Pendente', 'Atrasado') AND data_pagamento IS NULL)
    ),
    CONSTRAINT fk_cobranca_responsavel FOREIGN KEY (Responsavel_idResponsavel)
        REFERENCES Responsavel(idResponsavel)
) ENGINE=InnoDB;

-- Um responsavel pode ter varios emails. Coloquei tambem o tipo e a data de cadastro.
CREATE TABLE ResponsavelEmail (
    idResponsavel INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL DEFAULT 'Pessoal',
    data_cadastro DATE NOT NULL,
    PRIMARY KEY (idResponsavel, email),
    CONSTRAINT ck_email_tipo CHECK (tipo IN ('Pessoal', 'Trabalho')),
    CONSTRAINT fk_email_responsavel FOREIGN KEY (idResponsavel)
        REFERENCES Responsavel(idResponsavel)
) ENGINE=InnoDB;

CREATE TABLE TipoServico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(35) NOT NULL UNIQUE,
    descricao VARCHAR(120) NOT NULL,
    valor_referencia DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_servico_valor CHECK (valor_referencia >= 0)
) ENGINE=InnoDB;

-- A tabela intermediaria resolve o N:N de Cobranca e TipoServico.
CREATE TABLE ItemCobranca (
    idCobranca INT NOT NULL,
    idServico INT NOT NULL,
    quantidade INT NOT NULL,
    precoPraticado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idCobranca, idServico),
    CONSTRAINT ck_item_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_item_preco CHECK (precoPraticado >= 0),
    CONSTRAINT fk_item_cobranca FOREIGN KEY (idCobranca)
        REFERENCES Cobranca(idCobranca),
    CONSTRAINT fk_item_servico FOREIGN KEY (idServico)
        REFERENCES TipoServico(idServico)
) ENGINE=InnoDB;

-- A lotacao do jazigo e o prazo de exumacao ainda precisam
-- ser conferidos pela logica do sistema, nao apenas pelas FKs.
