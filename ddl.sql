-- Criação do Schema (opcional)
CREATE DATABASE IF NOT EXISTS sgmc;
USE sgmc;

-- 1. Tabelas Independentes (Nível 0)

CREATE TABLE IF NOT EXISTS pais (
    pais_sigla VARCHAR(2) NOT NULL,
    nome VARCHAR(150),
    continente VARCHAR(50),
    PRIMARY KEY (pais_sigla)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS cargo (
    id_cargo BIGINT AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(100),
    descricao VARCHAR(255),
    PRIMARY KEY (id_cargo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS marca (
    id_marca BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60),
    PRIMARY KEY (id_marca)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS seguro (
    idseguro BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255),
    PRIMARY KEY (idseguro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Tabelas Dependentes (Nível 1)

CREATE TABLE IF NOT EXISTS estado_provincia (
    estado_sigla VARCHAR(2) NOT NULL,
    nome VARCHAR(255),
    regiao VARCHAR(255),
    pais_sigla VARCHAR(2),
    PRIMARY KEY (estado_sigla),
    CONSTRAINT fk_estado_pais FOREIGN KEY (pais_sigla) REFERENCES pais(pais_sigla)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS condicao_seguro (
    id_condicao_seguro BIGINT AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(45),
    validade_fim DATETIME(6),
    valor FLOAT,
    id_seguro BIGINT,
    PRIMARY KEY (id_condicao_seguro),
    CONSTRAINT fk_condicao_seguro FOREIGN KEY (id_seguro) REFERENCES seguro(idseguro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS modelo (
    id_modelo BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(70),
    cilindrada INT NOT NULL,
    marca_id BIGINT NOT NULL,
    PRIMARY KEY (id_modelo),
    CONSTRAINT fk_modelo_marca FOREIGN KEY (marca_id) REFERENCES marca(id_marca)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Tabelas Dependentes (Nível 2)

CREATE TABLE IF NOT EXISTS cidade (
    id_cidade BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255),
    estado_sigla VARCHAR(2) NOT NULL,
    PRIMARY KEY (id_cidade),
    CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_sigla) REFERENCES estado_provincia(estado_sigla)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. Tabelas Dependentes (Nível 3)

CREATE TABLE IF NOT EXISTS sede (
    id_sede BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    bairro VARCHAR(150),
    numero VARCHAR(6),
    codigo_postal VARCHAR(10),
    ativa BOOLEAN,
    id_cidade BIGINT,
    PRIMARY KEY (id_sede),
    CONSTRAINT fk_sede_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS local (
    id_local BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    bairro VARCHAR(150),
    numero VARCHAR(6),
    codigo_postal VARCHAR(10),
    capacidade INT NOT NULL,
    contato VARCHAR(15),
    id_cidade BIGINT,
    PRIMARY KEY (id_local),
    CONSTRAINT fk_local_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. Tabelas Dependentes (Nível 4)

CREATE TABLE IF NOT EXISTS evento (
    id_evento BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(150),
    descricao VARCHAR(255),
    data_inicio DATETIME(6),
    data_fim DATETIME(6),
    valor FLOAT NOT NULL,
    id_local BIGINT,
    PRIMARY KEY (id_evento),
    CONSTRAINT fk_evento_local FOREIGN KEY (id_local) REFERENCES local(id_local)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS membro (
    id_membro BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(200),
    apelido VARCHAR(45),
    sexo VARCHAR(1),
    email VARCHAR(254),
    telefone VARCHAR(15),
    data_nascimento DATE,
    nacionalidade VARCHAR(50),
    naturalidade VARCHAR(50),
    batizado INT,
    tem_escudo INT,
    data_admissao DATE,
    ativo INT,
    tamanho_camisa VARCHAR(20),
    nome_contato_emergencia VARCHAR(100),
    telefone_contato_emergencia VARCHAR(15),
    id_cargo BIGINT,
    id_sede BIGINT,
    PRIMARY KEY (id_membro),
    CONSTRAINT fk_membro_cargo FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    CONSTRAINT fk_membro_sede FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. Tabelas Dependentes de Membro (Nível 5)

CREATE TABLE IF NOT EXISTS identificacao (
    id_identificacao BIGINT AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(7),
    identidade VARCHAR(45),
    emissor VARCHAR(150),
    data_emissao DATE,
    pais_sigla VARCHAR(2),
    id_membro BIGINT,
    PRIMARY KEY (id_identificacao),
    CONSTRAINT fk_identificacao_pais FOREIGN KEY (pais_sigla) REFERENCES pais(pais_sigla),
    CONSTRAINT fk_identificacao_membro FOREIGN KEY (id_membro) REFERENCES membro(id_membro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS ficha_medica (
    id_ficha_medica BIGINT AUTO_INCREMENT NOT NULL,
    nome_plano VARCHAR(100),
    carteira_saude VARCHAR(45),
    tipo_sanguineo VARCHAR(5),
    alergias VARCHAR(255),
    medicamentos_continuos VARCHAR(255),
    condicoes_medicas VARCHAR(255),
    observacoes VARCHAR(255),
    id_membro BIGINT,
    PRIMARY KEY (id_ficha_medica),
    CONSTRAINT fk_ficha_medica_membro FOREIGN KEY (id_membro) REFERENCES membro(id_membro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS moto (
    placa VARCHAR(7) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(255),
    id_seguro BIGINT,
    id_membro BIGINT,
    id_modelo BIGINT NOT NULL,
    PRIMARY KEY (placa),
    CONSTRAINT fk_moto_seguro FOREIGN KEY (id_seguro) REFERENCES seguro(idseguro),
    CONSTRAINT fk_moto_membro FOREIGN KEY (id_membro) REFERENCES membro(id_membro),
    CONSTRAINT fk_moto_modelo FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 7. Tabelas de Associação N:M (Muitos para Muitos) / Chaves Compostas

CREATE TABLE IF NOT EXISTS posse (
    id_cargo BIGINT NOT NULL,
    id_membro BIGINT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    PRIMARY KEY (id_cargo, id_membro),
    CONSTRAINT fk_posse_cargo FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    CONSTRAINT fk_posse_membro FOREIGN KEY (id_membro) REFERENCES membro(id_membro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS inscricao (
    id_evento BIGINT NOT NULL,
    id_membro BIGINT NOT NULL,
    data_inscricao DATE,
    moto_placa VARCHAR(7),
    PRIMARY KEY (id_evento, id_membro),
    CONSTRAINT fk_inscricao_evento FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    CONSTRAINT fk_inscricao_membro FOREIGN KEY (id_membro) REFERENCES membro(id_membro),
    CONSTRAINT fk_inscricao_moto FOREIGN KEY (moto_placa) REFERENCES moto(placa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
