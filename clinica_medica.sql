CREATE DATABASE clinica_medica;

USE clinica_medica;

CREATE TABLE pacientes
(
  id_pac INT PRIMARY KEY AUTO_INCREMENT, 
  nome_pac VARCHAR(100) NOT NULL, 
  cpf_pac CHAR(11) UNIQUE NOT NULL,
  sexo_pac CHAR(1) NOT NULL, 
  data_nasc_pac DATE NOT NULL,
  telefone_pac CHAR(11) NOT NULL,
  email_pac VARCHAR(255),
  data_cadastro_pac DATE NOT NULL,
  -- Endereço
  rua_pac VARCHAR(255) NOT NULL,
  bairro_pac VARCHAR(100) NOT NULL,
  num_casa_pac VARCHAR(6) NOT NULL,
  cidade_pac VARCHAR(100) NOT NULL,
  uf_pac CHAR(2) NOT NULL,
  cep_pac CHAR(8),
  complemento_pac VARCHAR(255)
);

CREATE TABLE medicos
(
  id_med INT PRIMARY KEY AUTO_INCREMENT,
  nome_med VARCHAR(100) NOT NULL,
  cpf_med CHAR(11) UNIQUE NOT NULL,
  crm_med VARCHAR(10) NOT NULL,
  uf_crm_med CHAR(2) NOT NULL,
  sexo_med CHAR(1) NOT NULL,
  telefone_med CHAR(11) NOT NULL UNIQUE,
  email_med VARCHAR(255) NOT NULL,
  data_contrato_med DATE NOT NULL,
  salario_med NUMERIC(10,2) NOT NULL
);

CREATE TABLE funcionarios
(
  id_func INT PRIMARY KEY AUTO_INCREMENT,
  nome_func VARCHAR(100) NOT NULL,
  cpf_func CHAR(11) UNIQUE NOT NULL,
  telefone_func CHAR(11) UNIQUE NOT NULL,
  email_func VARCHAR(255) NOT NULL,
  cargo_func VARCHAR(50) NOT NULL,
  data_contrato_func DATE NOT NULL,
  salario_func NUMERIC(10,2) NOT NULL
);

CREATE TABLE especialidades 
(
  id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
  nome_especialidade VARCHAR(50) UNIQUE NOT NULL
)

-- Relacionamento N:N entre medicos e especialidades
CREATE TABLE medico_especialidade (
    id_med INT NOT NULL,
    id_especialidade INT NOT NULL,

    PRIMARY KEY (id_med, id_especialidade),

    FOREIGN KEY (id_med) REFERENCES medicos(id_med),
    FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade)
);

-- Relacionamento 1:1 com paciente
CREATE TABLE prontuario_paciente
(
  id_pac INT PRIMARY KEY,
  -- Peso e altura
  peso_pac NUMERIC(5,2),
  altura_pac NUMERIC(3,2),

  alergias_pac VARCHAR(255) NOT NULL,
  doencas_preexistentes VARCHAR(255) NOT NULL,
  medicamentos_uso_continuo VARCHAR(255) NOT NULL,
  cirurgias_previas VARCHAR(255) NOT NULL,

  doencas_familiares VARCHAR(255) NOT NULL,

  observacoes VARCHAR(255),

  FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac)
)

-- 3 Relacionamentos 1:N com pacientes, medicos e especialidades 
CREATE TABLE agendamento_consulta
(
  id_agend_consult INT PRIMARY KEY AUTO_INCREMENT,
  id_pac INT NOT NULL,
  id_med INT NOT NULL,
  id_especialidade INT NOT NULL,
  data_agend_consult DATE NOT NULL,
  hora_agend_consult TIME NOT NULL,
  status_agend_consult VARCHAR(30) NOT NULL,
  motivo_agend_consult VARCHAR(255) NOT NULL,
  valor_agend_consult NUMERIC(7,2) NOT NULL,
  sala_agend_consult CHAR(2) NOT NULL,
  andar_agend_consult CHAR(2) NOT NULL,

  FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac),
  FOREIGN KEY (id_med) REFERENCES medicos(id_med),
  FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade)
  
);

-- Relacionamento 1:1
CREATE TABLE consulta_medica
(
  id_agend_consult INT PRIMARY KEY,
  data_atendimento DATE NOT NULL,
  hora_atendimento TIME NOT NULL,
  -- Sintomas
  sintomas_relatados VARCHAR(255) NOT NULL,
  tempo_sintomas_relatados VARCHAR(50) NOT NULL,
  -- Diagnostico
  suspeita_diagnostico VARCHAR(255) NOT NULL,
  diagnostico VARCHAR(100),
  tratamento VARCHAR(255),
  -- Retorno e observações
  retorno VARCHAR(30), -- Ex: 15 dias
  observacoes VARCHAR(255),

  FOREIGN KEY (id_agend_consult) REFERENCES agendamento_consulta(id_agend_consult)
);

SHOW TABLES