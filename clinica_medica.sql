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

CREATE TABLE especialidades 
(
  id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
  nome_especialidade VARCHAR(50) UNIQUE NOT NULL
  );

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
);

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

-- Registros tabelas pacientes (70 registros)
INSERT INTO pacientes (nome_pac, cpf_pac, sexo_pac, data_nasc_pac, telefone_pac, email_pac, data_cadastro_pac, rua_pac, bairro_pac, num_casa_pac, cidade_pac, uf_pac, cep_pac, complemento_pac) VALUES
('Mariana Silva Oliveira', '12345678901', 'F', '1996-04-12', '85981234567', 'mariana.silva.oliveira@gmail.com', '2021-03-15', 'Rua das Flores', 'Centro', '012', 'Itapajé', 'CE', '61900000', ''),
('João Pereira Santos', '98765432100', 'M', '1950-11-02', '85999876543', 'joao.pereira.santos@gmail.com', '2020-07-22', 'Avenida Brasil', 'Bela Vista', '078', 'Itapajé', 'CE', '61901000', 'Apto 2'),
('Ana Beatriz Costa Lima', '11122233344', 'F', '1989-06-30', '85991234567', 'ana.beatriz.costa.lima@gmail.com', '2019-12-05', 'Rua do Comércio', 'São José', '005', 'Uruburetama', 'CE', '62520000', ''),
('Lucas Almeida Ferreira', '22233344455', 'M', '2006-09-14', '85997654321', 'lucas.almeida.ferreira@gmail.com', '2022-01-10', 'Travessa Santo Antônio', 'Vila Nova', '023', 'Irauçuba', 'CE', '62530000', ''),
('Camila Rocha Nascimento', '33344455566', 'F', '2020-02-11', '85999912345', 'camila.rocha.nascimento@gmail.com', '2023-08-03', 'Rua Primeiro de Maio', 'Centro', '011', 'São Joaquim', 'CE', '62540000', 'Casa'),
('Ricardo Gomes Andrade', '44455566677', 'M', '1959-12-05', '85998123456', 'ricardo.gomes.andrade@gmail.com', '2018-05-20', 'Avenida Central', 'Jardim', '145', 'Itapipoca', 'CE', '62550000', ''),
('Fernanda Lopes Ribeiro', '55566677788', 'F', '1998-07-21', '85997456123', 'fernanda.lopes.ribeiro@gmail.com', '2024-02-18', 'Rua das Acácias', 'Boa Vista', '067', 'Itapajé', 'CE', '61900010', 'Bloco B'),
('Bruno Sousa Martins', '66677788899', 'M', '1948-03-09', '85996543210', 'bruno.sousa.martins@gmail.com', '2019-09-30', 'Rua do Rosário', 'Centro', '098', 'Uruburetama', 'CE', '62520010', ''),
('Patrícia Fernandes Barros', '77788899900', 'F', '1985-10-27', '85995321678', 'patricia.fernandes.barros@gmail.com', '2021-11-11', 'Rua Nova', 'Vila Rica', '034', 'Irauçuba', 'CE', '62530010', 'Fundos'),
('Eduardo Martins Silva', '88899900011', 'M', '1941-01-18', '85994217834', 'eduardo.martins.silva@gmail.com', '2018-08-01', 'Avenida dos Pioneiros', 'Centro', '177', 'São Joaquim', 'CE', '62540010', ''),
('Sofia Nunes Cardoso', '99900011122', 'F', '2018-05-05', '85993123456', 'sofia.nunes.cardoso@gmail.com', '2025-06-12', 'Rua das Palmeiras', 'Jardim Primavera', '009', 'Itapipoca', 'CE', '62550010', 'Sala 1'),
('Gustavo Ribeiro Almeida', '11223344556', 'M', '1992-08-16', '85992233445', 'gustavo.ribeiro.almeida@gmail.com', '2022-10-02', 'Rua do Sol', 'Vila Nova', '056', 'Itapajé', 'CE', '61902000', ''),
('Larissa Pinto Carvalho', '22334455667', 'F', '1979-03-29', '85991333555', 'larissa.pinto.carvalho@gmail.com', '2020-04-14', 'Travessa da Paz', 'Centro', '044', 'Uruburetama', 'CE', '62521000', ''),
('Felipe Carvalho Mendes', '33445566778', 'M', '1988-12-22', '85990444566', 'felipe.carvalho.mendes@gmail.com', '2019-07-07', 'Rua das Oliveiras', 'Bela Vista', '150', 'Irauçuba', 'CE', '62531000', ''),
('Isabela Moura Teixeira', '44556677889', 'F', '2008-11-30', '85999566778', 'isabela.moura.teixeira@gmail.com', '2023-03-29', 'Avenida das Nações', 'Centro', '031', 'São Joaquim', 'CE', '62541000', ''),
('Marcos Ferreira Souza', '55667788990', 'M', '1965-02-07', '85998677889', 'marcos.ferreira.souza@gmail.com', '2021-01-25', 'Rua da Matriz', 'Vila Real', '089', 'Itapipoca', 'CE', '62551000', ''),
('Bianca Araújo Pinto', '66778899001', 'F', '1995-09-03', '85997788990', 'bianca.araujo.pinto@gmail.com', '2024-11-05', 'Travessa Santa Luzia', 'Jardim', '014', 'Itapajé', 'CE', '61903000', ''),
('Daniel Costa Furtado', '77889900112', 'M', '2010-06-18', '85996899001', 'daniel.costa.furtado@gmail.com', '2020-02-20', 'Rua Sete de Setembro', 'Centro', '066', 'Uruburetama', 'CE', '62522000', ''),
('Paula Duarte Lima', '88990011223', 'F', '1944-10-01', '85995900112', 'paula.duarte.lima@gmail.com', '2018-12-12', 'Rua do Mercado', 'Vila Nova', '120', 'Irauçuba', 'CE', '62532000', ''),
('Thiago Teixeira Gomes', '99001122334', 'M', '1983-01-25', '85995011223', 'thiago.teixeira.gomes@gmail.com', '2022-06-30', 'Avenida Principal', 'Centro', '102', 'São Joaquim', 'CE', '62542000', ''),
('Aline Castro Figueiredo', '10111213141', 'F', '2021-04-02', '85994111213', 'aline.castro.figueiredo@gmail.com', '2024-09-19', 'Rua das Mangueiras', 'Bela Vista', '007', 'Itapipoca', 'CE', '62552000', ''),
('Rafael Pimentel Araújo', '12131415161', 'M', '1970-08-08', '85993222334', 'rafael.pimentel.araujo@gmail.com', '2019-05-06', 'Travessa do Limoeiro', 'Centro', '134', 'Itapajé', 'CE', '61904000', ''),
('Juliana Mendes Rocha', '13141516171', 'F', '1999-12-12', '85992333445', 'juliana.mendes.rocha@gmail.com', '2021-02-14', 'Rua das Acácias', 'Vila Rica', '029', 'Uruburetama', 'CE', '62523000', ''),
('André Silva Nogueira', '14151617181', 'M', '1958-07-17', '85991444556', 'andre.silva.nogueira@gmail.com', '2020-10-28', 'Rua do Sol Nascente', 'Jardim', '168', 'Irauçuba', 'CE', '62533000', ''),
('Carolina Reis Albuquerque', '15161718191', 'F', '1987-05-27', '85990555667', 'carolina.reis.albuquerque@gmail.com', '2023-12-01', 'Avenida Primavera', 'Centro', '052', 'São Joaquim', 'CE', '62543000', ''),
('Pedro Henrique Barros', '16171819201', 'M', '2004-03-15', '85999666778', 'pedro.henrique.barros@gmail.com', '2025-01-09', 'Rua do Pinheiro', 'Boa Vista', '018', 'Itapipoca', 'CE', '62553000', ''),
('Vanessa Lima Cardoso', '17181920211', 'F', '1994-10-10', '85998777889', 'vanessa.lima.cardoso@gmail.com', '2019-03-03', 'Rua Bela Vista', 'Centro', '064', 'Itapajé', 'CE', '61905000', ''),
('Leandro Rocha Monteiro', '18192021231', 'M', '1965-09-25', '85997888990', 'leandro.rocha.monteiro@gmail.com', '2021-07-07', 'Travessa do Sol', 'Vila Nova', '140', 'Uruburetama', 'CE', '62524000', ''),
('Natália Barros Vieira', '19202122241', 'F', '2000-01-20', '85996999001', 'natalia.barros.vieira@gmail.com', '2022-11-11', 'Rua das Laranjeiras', 'Jardim', '022', 'Irauçuba', 'CE', '62534000', ''),
('Carlos Eduardo Faria', '20212223251', 'M', '1977-06-06', '85996000112', 'carlos.eduardo.faria@gmail.com', '2018-06-18', 'Avenida Central', 'Centro', '156', 'São Joaquim', 'CE', '62544000', ''),
('Marina Oliveira Santos', '21222324261', 'F', '1982-02-02', '85995111223', 'marina.oliveira.santos@gmail.com', '2020-09-09', 'Rua do Bosque', 'Bela Vista', '048', 'Itapipoca', 'CE', '62554000', ''),
('Vitor Santos Almeida', '22232425271', 'M', '1991-11-11', '85994222334', 'vitor.santos.almeida@gmail.com', '2023-04-04', 'Travessa Verde', 'Vila Rica', '073', 'Itapajé', 'CE', '61906000', ''),
('Renata Farias Pinto', '23242526281', 'F', '1952-08-19', '85993333445', 'renata.farias.pinto@gmail.com', '2018-11-21', 'Rua do Mercado', 'Centro', '099', 'Uruburetama', 'CE', '62525000', ''),
('Hugo Menezes Rocha', '24252627291', 'M', '2008-05-13', '85992444556', 'hugo.menezes.rocha@gmail.com', '2024-05-30', 'Avenida do Cruzeiro', 'Jardim', '006', 'Irauçuba', 'CE', '62535000', ''),
('Lívia Cardoso Pereira', '25262728201', 'F', '1969-03-03', '85991555667', 'livia.cardoso.pereira@gmail.com', '2021-12-12', 'Rua Sete', 'Centro', '088', 'São Joaquim', 'CE', '62545000', ''),
('Mateus Ribeiro Moreira', '26272829211', 'M', '1997-07-07', '85990666778', 'mateus.ribeiro.moreira@gmail.com', '2019-01-01', 'Rua Azul', 'Vila Nova', '039', 'Itapipoca', 'CE', '62555000', ''),
('Carla Santos Miranda', '27282930221', 'F', '1989-09-09', '85999777889', 'carla.santos.miranda@gmail.com', '2022-08-08', 'Rua Ouro Preto', 'Bela Vista', '027', 'Itapajé', 'CE', '61907000', ''),
('Renan Lopes Freitas', '28293031331', 'M', '2003-12-12', '85998888990', 'renan.lopes.freitas@gmail.com', '2020-03-16', 'Travessa Nova', 'Jardim', '115', 'Uruburetama', 'CE', '62526000', ''),
('Marta Albuquerque Gomes', '29303132341', 'F', '1941-06-06', '85997999001', 'marta.albuquerque.gomes@gmail.com', '2018-02-02', 'Rua do Campo', 'Centro', '170', 'Irauçuba', 'CE', '62536000', ''),
('Igor Antunes Carvalho', '30313233341', 'M', '1984-10-10', '85997000112', 'igor.antunes.carvalho@gmail.com', '2021-05-05', 'Avenida das Estrelas', 'Vila Rica', '055', 'São Joaquim', 'CE', '62546000', ''),
('Priscila Mourão Fernandes', '31323334351', 'F', '1993-01-01', '85996111223', 'priscila.mourao.fernandes@gmail.com', '2023-09-09', 'Rua do Lago', 'Boa Vista', '016', 'Itapipoca', 'CE', '62556000', ''),
('Fábio Guimarães Lopes', '32333435361', 'M', '1972-04-04', '85995222334', 'fabio.guimaraes.lopes@gmail.com', '2019-06-06', 'Travessa do Sol', 'Centro', '129', 'Itapajé', 'CE', '61908000', ''),
('Ariana Silva Mendonça', '33343536371', 'F', '2009-08-08', '85994333445', 'ariana.silva.mendonca@gmail.com', '2024-01-20', 'Rua do Sossego', 'Vila Nova', '008', 'Uruburetama', 'CE', '62527000', ''),
('Diego Almeida Castro', '34353637381', 'M', '1959-11-11', '85993444556', 'diego.almeida.castro@gmail.com', '2022-12-12', 'Avenida das Acácias', 'Centro', '162', 'Irauçuba', 'CE', '62537000', ''),
('Sonia Ribeiro Matos', '35363738391', 'F', '1964-02-02', '85992555667', 'sonia.ribeiro.matos@gmail.com', '2020-08-08', 'Rua do Sossego', 'Jardim', '141', 'São Joaquim', 'CE', '62547000', ''),
('Wallace Cardozo Torres', '36373839401', 'M', '1986-03-03', '85991666778', 'wallace.cardozo.torres@gmail.com', '2019-11-11', 'Rua do Farol', 'Vila Rica', '083', 'Itapipoca', 'CE', '62557000', ''),
('Elisa Nascimento Braga', '37383940411', 'F', '2013-07-07', '85990777889', 'elisa.nascimento.braga@gmail.com', '2025-02-02', 'Travessa Esperança', 'Centro', '021', 'Itapajé', 'CE', '61909000', ''),
('Otávio Mello Duarte', '38394041421', 'M', '1976-05-05', '85999888990', 'otavio.mello.duarte@gmail.com', '2021-04-04', 'Rua das Rosas', 'Bela Vista', '138', 'Uruburetama', 'CE', '62528000', ''),
('Aline Rodrigues Faria', '39404142431', 'F', '1996-09-09', '85998999001', 'aline.rodrigues.faria@gmail.com', '2022-02-22', 'Avenida do Sol', 'Centro', '046', 'Irauçuba', 'CE', '62538000', ''),
('Samuel Campos Ribeiro', '40414243441', 'M', '1981-12-24', '85998000112', 'samuel.campos.ribeiro@gmail.com', '2018-10-10', 'Rua dos Jasmins', 'Vila Nova', '071', 'São Joaquim', 'CE', '62548000', '');

-- Registros tabela medicos
INSERT INTO medicos
(nome_med, cpf_med, crm_med, uf_crm_med, sexo_med, telefone_med, email_med, data_contrato_med, salario_med)
VALUES
('Ana Beatriz Silva', '11122233344', '12345', 'SP', 'F', '11999990001', 'ana.silva@example.com', '2019-03-15', 8500.00),
('Bruno Costa', '22233344455', '23456', 'RJ', 'M', '21988880002', 'bruno.costa@example.com', '2020-07-01', 9200.00),
('Carla Pereira', '33344455566', '34567', 'MG', 'F', '31977770003', 'carla.pereira@example.com', '2018-11-20', 7800.00),
('Diego Almeida', '44455566677', '45678', 'BA', 'M', '71966660004', 'diego.almeida@example.com', '2021-05-10', 8800.00),
('Eduarda Nunes', '55566677788', '56789', 'PR', 'F', '41955550005', 'eduarda.nunes@example.com', '2017-09-05', 8100.00),
('Felipe Rocha', '66677788899', '67890', 'RS', 'M', '51944440006', 'felipe.rocha@example.com', '2016-01-12', 9400.00),
('Gabriela Mendes', '77788899900', '78901', 'CE', 'F', '85933330007', 'gabriela.mendes@example.com', '2022-02-28', 7600.00),
('Hugo Fernandes', '88899900011', '89012', 'PE', 'M', '81922220008', 'hugo.fernandes@example.com', '2015-06-18', 10000.00),
('Isabela Moreira', '99900011122', '90123', 'PA', 'F', '91911110009', 'isabela.moreira@example.com', '2019-12-01', 8300.00),
('João Carvalho', '12312312312', '01234', 'CE', 'M', '88999990010', 'joao.carvalho@example.com', '2014-04-22', 10500.00),
('Karina Lopes', '23123123123', '11223', 'SP', 'F', '11988880011', 'karina.lopes@example.com', '2020-10-15', 7900.00),
('Lucas Martins', '31231231231', '22334', 'RJ', 'M', '21977770012', 'lucas.martins@example.com', '2018-08-30', 8700.00),
('Mariana Rocha', '41241241241', '33445', 'MG', 'F', '31966660013', 'mariana.rocha@example.com', '2021-03-05', 8000.00),
('Nathan Silva', '51351351351', '44556', 'BA', 'M', '71955550014', 'nathan.silva@example.com', '2017-11-11', 9100.00),
('Olivia Castro', '61461461461', '55667', 'PR', 'F', '41944440015', 'olivia.castro@example.com', '2016-02-20', 7700.00),
('Paulo Duarte', '71571571571', '66778', 'RS', 'M', '51933330016', 'paulo.duarte@example.com', '2015-09-29', 9800.00),
('Quesia Andrade', '81681681681', '77889', 'CE', 'F', '85922220017', 'quesia.andrade@example.com', '2022-06-01', 7400.00),
('Rafael Gomes', '91791791791', '88990', 'PE', 'M', '81911110018', 'rafael.gomes@example.com', '2013-07-07', 11200.00),
('Sofia Pinto', '10101010101', '99001', 'PA', 'F', '91900000019', 'sofia.pinto@example.com', '2020-01-20', 8200.00),
('Thiago Barros', '12121212121', '10112', 'SP', 'M', '11977770020', 'thiago.barros@example.com', '2019-05-25', 8950.00),
('Ursula Freitas', '13131313131', '21223', 'RJ', 'F', '21966660021', 'ursula.freitas@example.com', '2018-02-14', 7650.00),
('Vitor Souza', '14141414141', '32334', 'MG', 'M', '31955550022', 'vitor.souza@example.com', '2017-08-08', 9300.00),
('Wanda Ribeiro', '15151515151', '43445', 'BA', 'F', '71944440023', 'wanda.ribeiro@example.com', '2016-12-12', 8050.00),
('Xavier Lima', '16161616161', '54556', 'PR', 'M', '41933330024', 'xavier.lima@example.com', '2015-03-03', 9700.00),
('Yasmin Teixeira', '17171717171', '65667', 'RS', 'F', '51922220025', 'yasmin.teixeira@example.com', '2021-09-09', 7550.00),
('Zeca Moura', '18181818181', '76778', 'CE', 'M', '85911110026', 'zeca.moura@example.com', '2014-11-30', 10800.00),
('Aline Batista', '19191919191', '87889', 'PE', 'F', '81900000027', 'aline.batista@example.com', '2019-06-06', 7850.00),
('Braulio Reis', '20202020202', '98990', 'PA', 'M', '91999990028', 'braulio.reis@example.com', '2013-01-15', 11500.00),
('Camila Farias', '21212121212', '09012', 'SP', 'F', '11966660029', 'camila.farias@example.com', '2022-04-18', 7200.00),
('Diego Viana', '23232323232', '10123', 'RJ', 'M', '21955550030', 'diego.viana@example.com', '2018-10-02', 8900.00),
('Carlos Silva', '12345678910', '123456', 'CE', 'M', '85987654321', 'carlos.silva@example.com', '2019-03-15', 8500.00),
('Mariana Oliveira', '23456789011', '123457', 'CE', 'F', '85998765432', 'mariana.oliveira@example.com', '2020-06-10', 9200.00),
('Roberto Gomes', '34567890112', '123458', 'SP', 'M', '11986543210', 'roberto.gomes@example.com', '2018-11-22', 10000.00),
('Juliana Lima', '45678901213', '123459', 'CE', 'F', '85997654321', 'juliana.lima@example.com', '2021-01-08', 8800.00),
('Felipe Santos', '56789012314', '123460', 'BA', 'M', '71985432109', 'felipe.santos@example.com', '2019-08-30', 9100.00),
('Beatriz Castro', '67890123415', '123461', 'CE', 'F', '85996543210', 'beatriz.castro@example.com', '2022-02-14', 8600.00),
('Gustavo Neves', '78901234516', '123462', 'MG', 'M', '31984321098', 'gustavo.neves@example.com', '2017-09-05', 10500.00),
('Fernanda Souza', '89012345617', '123463', 'CE', 'F', '85995432109', 'fernanda.souza@example.com', '2020-12-01', 9300.00),
('Bruno Costa', '90123456718', '123464', 'RJ', 'M', '21983210987', 'bruno.costa@example.com', '2019-05-20', 9600.00),
('Isabela Rocha', '01234567819', '123465', 'CE', 'F', '85994321098', 'isabela.rocha@example.com', '2021-07-11', 8900.00),
('Thiago Ribeiro', '12345678020', '123466', 'RS', 'M', '51982100876', 'thiago.ribeiro@example.com', '2018-04-17', 10200.00),
('Camila Monteiro', '23456789121', '123467', 'CE', 'F', '85993210987', 'camila.monteiro@example.com', '2022-09-06', 8700.00),
('Leonardo Nunes', '34567890222', '123468', 'PE', 'M', '81981090765', 'leonardo.nunes@example.com', '2020-03-25', 9400.00),
('Patrícia Duarte', '45678901323', '123469', 'CE', 'F', '85992100876', 'patricia.duarte@example.com', '2019-10-12', 9000.00),
('Wagner Araújo', '56789012424', '123470', 'SC', 'M', '47979980654', 'wagner.araujo@example.com', '2017-12-30', 10800.00),
('Simone Ferreira', '67890123525', '123471', 'CE', 'F', '85991090765', 'simone.ferreira@example.com', '2021-04-19', 8500.00),
('André Lobo', '78901234626', '123472', 'DF', 'M', '61979870543', 'andre.lobo@example.com', '2020-08-02', 10300.00),
('Viviane Mendes', '89012345727', '123473', 'CE', 'F', '85989980654', 'viviane.mendes@example.com', '2022-05-23', 8800.00),
('Marcos Pinto', '90123456828', '123474', 'GO', 'M', '62978760432', 'marcos.pinto@example.com', '2019-02-08', 9700.00),
('Vanessa Assis', '01234567929', '123475', 'CE', 'F', '85989870543', 'vanessa.assis@example.com', '2021-10-15', 9100.00);


INSERT INTO especialidades (nome_especialidade) VALUES
('Clínica Geral'),
('Cardiologia'),
('Pediatria'),
('Dermatologia'),
('Ortopedia'),
('Ginecologia'),
('Urologia'),
('Cirurgia Geral'),
('Pneumologia'),
('Gastroenterologia'),
('Hepatologia'),
('Neurologia'),
('Neurocirurgia'),
('Psiquiatria'),
('Oftalmologia'),
('Otorrinolaringologia'),
('Endocrinologia'),
('Reumatologia'),
('Infectologia'),
('Hematologia'),
('Oncologia'),
('Radioterapia'),
('Radiologia'),
('Anestesiologia'),
('Cirurgia Plástica'),
('Cirurgia Vascular'),
('Flebologia'),
('Traumatologia'),
('Proctologia'),
('Mastologia'),
('Terapia Intensiva'),
('Geriatria'),
('Fisioterapia'),
('Nutrição'),
('Fonoaudiologia'),
('Alergologia'),
('Imunologia'),
('Acupuntura'),
('Homeopatia'),
('Medicina Esportiva'),
('Medicina do Trabalho'),
('Medicina Preventiva'),
('Medicina Ocupacional'),
('Patologia'),
('Nefropatia'),
('Coloproctologia'),
('Periodontia'),
('Dermatologia Estética'),
('Clínica Médica'),
('Fisiologia');

INSERT INTO medico_especialidade (id_med, id_especialidade) VALUES
(1, 1),
(1, 3),

(2, 2),
(2, 5),

(3, 4),
(3, 6),

(4, 1),
(4, 7),

(5, 3),
(5, 7),

(6, 2),

(7, 4),
(7, 5),
(7, 6),

(8, 1),

(9, 5),
(9, 6),

(10, 2),
(10, 3),

(11, 4),

(12, 6),
(12, 7),

(13, 1),
(13, 2),
(13, 4),

(14, 3),

(15, 5),
(15, 7),

(16, 6),

(17, 2),
(17, 5),

(18, 1),
(18, 4),
(18, 6),

(19, 3),

(20, 7),
(20, 4),

(21, 2),
(21, 5),

(22, 4),

(23, 1),
(23, 3),

(24, 6),
(24, 7),
(24, 3),

(25, 2),

(26, 5),
(26, 6),

(27, 1),
(27, 4),

(28, 3),
(28, 7),

(29, 2),

(30,1),

(1, 5),
(2, 12),
(3, 8),
(4, 25),
(5, 1),
(6, 18),
(7, 35),
(8, 9),
(9, 42),
(10, 3),
(11, 28),
(12, 15),
(13, 21),
(14, 6),
(15, 38),
(16, 11),
(17, 2),
(18, 40),
(19, 32),
(20, 17),
(21, 44),
(22, 7),
(23, 19),
(24, 50),
(25, 14),
(26, 31),
(27, 23),
(28, 10),
(29, 36),
(30, 4),
(31, 26),
(32, 39),
(33, 22),
(34, 13),
(35, 47),
(36, 16),
(37, 20),
(38, 45),
(39, 24),
(40, 34),
(41, 49),
(42, 27),
(43, 37),
(44, 9),
(45, 12),
(46, 5),
(47, 30),
(48, 43),
(49, 18),
(50, 1);

INSERT INTO prontuario_paciente
(id_pac, peso_pac, altura_pac, alergias_pac, doencas_preexistentes, medicamentos_uso_continuo, cirurgias_previas, doencas_familiares, observacoes)
VALUES
(1, 68.50, 1.72, 'Nenhuma', 'Hipertensão', 'Losartana', 'Apendicectomia', 'Hipertensão', 'Paciente em acompanhamento regular'),
(2, 74.20, 1.78, 'Penicilina', 'Asma', 'Salbutamol', 'Nenhuma', 'Asma', 'Relata falta de ar em esforço intenso'),
(3, 59.80, 1.65, 'Poeira', 'Nenhuma', 'Nenhum', 'Cesárea', 'Diabetes', 'Consulta de rotina'),
(4, 82.30, 1.80, 'Dipirona', 'Diabetes tipo 2', 'Metformina', 'Colecistectomia', 'Diabetes', 'Glicemia controlada'),
(5, 63.40, 1.67, 'Nenhuma', 'Gastrite', 'Omeprazol', 'Nenhuma', 'Gastrite', 'Queixa de desconforto abdominal ocasional'),
(6, 90.10, 1.85, 'Amendoim', 'Hipertensão', 'Amlodipino', 'Herniorrafia', 'Hipertensão', 'Controle de pressão arterial necessário'),
(7, 70.00, 1.73, 'Frutos do mar', 'Nenhuma', 'Nenhum', 'Nenhuma', 'Nenhuma', 'Sem alterações relevantes'),
(8, 55.90, 1.60, 'Látex', 'Anemia', 'Sulfato ferroso', 'Apendicectomia', 'Anemia', 'Fadiga leve relatada'),
(9, 77.25, 1.76, 'Nenhuma', 'Hipotireoidismo', 'Levotiroxina', 'Nenhuma', 'Tireoide', 'Em uso contínuo de medicação'),
(10, 68.90, 1.70, 'Mariscos', 'Sinusite crônica', 'Antialérgico', 'Septoplastia', 'Rinite', 'Apresenta crises sazonais'),
(11, 84.60, 1.82, 'Nenhuma', 'Obesidade', 'Nenhum', 'Nenhuma', 'Diabetes', 'Orientado sobre dieta e exercícios'),
(12, 61.10, 1.64, 'Pólen', 'Asma', 'Budesonida', 'Amigdalectomia', 'Asma', 'Uso de inalador em dias frios'),
(13, 73.50, 1.75, 'Ibuprofeno', 'Enxaqueca', 'Topiramato', 'Nenhuma', 'Enxaqueca', 'Crises menos frequentes'),
(14, 66.40, 1.68, 'Nenhuma', 'Hipertensão', 'Enalapril', 'Nenhuma', 'Hipertensão', 'Pressão sob controle'),
(15, 58.70, 1.62, 'Pênicilina', 'Nenhuma', 'Nenhum', 'Apendicectomia', 'Nenhuma', 'Sem queixas no momento'),
(16, 79.90, 1.79, 'Poeira', 'Rinite alérgica', 'Loratadina', 'Nenhuma', 'Rinite', 'Sintomas leves na primavera'),
(17, 92.40, 1.86, 'Nenhuma', 'Diabetes tipo 2', 'Insulina', 'Colecistectomia', 'Diabetes', 'Acompanhamento endocrinológico'),
(18, 64.30, 1.66, 'Chocolate', 'Refluxo', 'Omeprazol', 'Nenhuma', 'Gastrite', 'Evitar alimentos gordurosos'),
(19, 71.80, 1.74, 'Nenhuma', 'Depressão', 'Sertralina', 'Nenhuma', 'Depressão', 'Em acompanhamento psicológico'),
(20, 60.50, 1.63, 'Glúten', 'Doença celíaca', 'Dieta sem glúten', 'Nenhuma', 'Doença autoimune', 'Adaptação alimentar em curso'),
(21, 86.20, 1.81, 'Nenhuma', 'Hipertensão', 'Losartana', 'Herniorrafia', 'Hipertensão', 'Redução de sal na dieta'),
(22, 57.40, 1.59, 'Corante alimentício', 'Dermatite', 'Antialérgico', 'Nenhuma', 'Alergias', 'Coceira controlada'),
(23, 75.10, 1.77, 'Nenhuma', 'Bronquite', 'Brometo de ipratrópio', 'Nenhuma', 'Asma', 'Sem exacerbações recentes'),
(24, 69.30, 1.71, 'Nível', 'Nenhuma', 'Nenhum', 'Apendicectomia', 'Nenhuma', 'Consulta preventiva'),
(25, 88.00, 1.84, 'Nenhuma', 'Colesterol alto', 'Sinvastatina', 'Nenhuma', 'Dislipidemia', 'Orientado sobre alimentação'),
(26, 62.70, 1.69, 'Poeira', 'Sinusite', 'Desloratadina', 'Septoplastia', 'Rinite', 'Queixa de congestão nasal'),
(27, 80.50, 1.78, 'Nenhuma', 'Hipotireoidismo', 'Levotiroxina', 'Nenhuma', 'Tireoide', 'Exames laboratoriais em dia'),
(28, 53.90, 1.58, 'Lactose', 'Intolerância alimentar', 'Nenhum', 'Nenhuma', 'Intolerância', 'Faz dieta restritiva'),
(29, 76.80, 1.75, 'Nenhuma', 'Ansiedade', 'Clonazepam', 'Nenhuma', 'Ansiedade', 'Acompanhamento com psiquiatra'),
(30, 67.20, 1.70, 'Ácaro', 'Asma', 'Budesonida', 'Nenhuma', 'Asma', 'Crises leves em períodos frios'),
(31, 85.40, 1.83, 'Nenhuma', 'Hipertensão', 'Hidroclorotiazida', 'Nenhuma', 'Hipertensão', 'Pressão elevada em casa'),
(32, 61.50, 1.65, 'Amendoim', 'Asma', 'Formoterol', 'Amigdalectomia', 'Asma', 'Falta ar com exercícios'),
(33, 72.10, 1.73, 'Nenhuma', 'Gastrite', 'Ranitidina', 'Nenhuma', 'Gastrite', 'Dor abdominal ocasional'),
(34, 79.80, 1.81, 'Dipirona', 'Diabetes', 'Glibenclamida', 'Colecistectomia', 'Diabetes', 'Glicemia em 180 mg/dL'),
(35, 56.30, 1.61, 'Pênicilina', 'Nenhuma', 'Nenhum', 'Cesárea', 'Nenhuma', 'Sem problemas de saúde'),
(36, 89.70, 1.85, 'Látex', 'Hipertensão', 'Captopril', 'Herniorrafia', 'Hipertensão', 'Necessário ajuste de dose'),
(37, 65.20, 1.68, 'Poeira', 'Rinite', 'Fexofenadina', 'Nenhuma', 'Rinite', 'Sintomas piores na primavera'),
(38, 81.60, 1.80, 'Nenhuma', 'Colesterol', 'Atorvastatina', 'Nenhuma', 'Dislipidemia', 'Triglicerídeos elevados'),
(39, 59.40, 1.63, 'Glúten', 'Doença celíaca', 'Dieta', 'Apendicectomia', 'Autoimune', 'Dieta sem glúten'),
(40, 73.90, 1.76, 'Nenhuma', 'Hipotireoidismo', 'Levotiroxina', 'Nenhuma', 'Tireoide', 'TSH controlado'),
(41, 87.50, 1.82, 'Mariscos', 'Obesidade', 'Nenhum', 'Nenhuma', 'Diabetes', 'IMC 32, orientado sobre dieta'),
(42, 62.80, 1.66, 'Pólen', 'Alergia sazonal', 'Loratadina', 'Septoplastia', 'Alergias', 'Crises na primavera'),
(43, 74.30, 1.74, 'Ibuprofeno', 'Refluxo', 'Omeprazol', 'Nenhuma', 'Gastrite', 'Sintomas à noite'),
(44, 67.60, 1.69, 'Nenhuma', 'Ansiedade', 'Paroxetina', 'Nenhuma', 'Ansiedade', 'Acompanhamento psicológico'),
(45, 55.10, 1.60, 'Chocolate', 'Nenhuma', 'Nenhum', 'Apendicectomia', 'Nenhuma', 'Sem queixas'),
(46, 80.20, 1.79, 'Nenhuma', 'Hipertensão', 'Valsartana', 'Nenhuma', 'Hipertensão', 'Pressão sob controle'),
(47, 68.40, 1.71, 'Corante', 'Dermatite', 'Fluticasona', 'Nenhuma', 'Alergias', 'Dermatite leve'),
(48, 76.90, 1.75, 'Nenhuma', 'Asma', 'Salmeterol', 'Nenhuma', 'Asma', 'Sem crises em 6 meses'),
(49, 63.50, 1.67, 'Ácaro', 'Rinite crônica', 'Mometasona', 'Septoplastia', 'Rinite', 'Congestão persistente'),
(50, 91.30, 1.87, 'Nenhuma', 'Diabetes tipo 2', 'Sitagliptina', 'Colecistectomia', 'Diabetes', 'Acompanhamento endocrinológico mensal');

INSERT INTO agendamento_consulta
(id_pac, id_med, id_especialidade, data_agend_consult, hora_agend_consult, status_agend_consult, motivo_agend_consult, valor_agend_consult, sala_agend_consult, andar_agend_consult)
VALUES
(3, 1, 1, '2026-06-01', '08:00:00', 'Agendado', 'Consulta de rotina', 150.00, 'A1', '01'),
(8, 2, 2, '2026-06-01', '08:30:00', 'Agendado', 'Avaliação clínica', 170.00, 'A2', '01'),
(12, 3, 3, '2026-06-02', '09:00:00', 'Agendado', 'Dor de cabeça frequente', 160.00, 'B1', '01'),
(15, 4, 4, '2026-06-02', '09:30:00', 'Confirmado', 'Dor nas costas', 180.00, 'B2', '01'),
(21, 5, 5, '2026-06-03', '10:00:00', 'Agendado', 'Exame preventivo', 140.00, 'C1', '02'),
(24, 6, 6, '2026-06-03', '10:30:00', 'Confirmado', 'Acompanhamento de tratamento', 200.00, 'C2', '02'),
(27, 7, 7, '2026-06-04', '11:00:00', 'Agendado', 'Queixa de alergia', 155.00, 'D1', '02'),
(30, 8, 1, '2026-06-04', '11:30:00', 'Agendado', 'Retorno médico', 150.00, 'D2', '02'),
(34, 9, 2, '2026-06-05', '13:00:00', 'Confirmado', 'Pressão alta', 175.00, 'E1', '03'),
(38, 10, 3, '2026-06-05', '13:30:00', 'Agendado', 'Consulta pediátrica', 165.00, 'E2', '03'),
(41, 11, 4, '2026-06-06', '14:00:00', 'Agendado', 'Avaliação ortopédica', 190.00, 'F1', '03'),
(44, 12, 5, '2026-06-06', '14:30:00', 'Confirmado', 'Controle de diabetes', 210.00, 'F2', '03'),
(47, 13, 6, '2026-06-07', '15:00:00', 'Agendado', 'Exame de rotina', 150.00, 'G1', '04'),
(50, 14, 7, '2026-06-07', '15:30:00', 'Cancelado', 'Dor abdominal', 160.00, 'G2', '04'),
(48, 15, 1, '2026-06-08', '16:00:00', 'Agendado', 'Acompanhamento geral', 150.00, 'H1', '04'),
(49, 16, 2, '2026-06-08', '16:30:00', 'Confirmado', 'Avaliação cardiológica', 220.00, 'H2', '04'),
(50, 17, 3, '2026-06-09', '08:00:00', 'Agendado', 'Consulta de retorno', 155.00, 'A3', '01'),
(45, 18, 4, '2026-06-09', '08:30:00', 'Agendado', 'Dor no joelho', 180.00, 'A4', '01'),
(18, 19, 5, '2026-06-10', '09:00:00', 'Confirmado', 'Controle de medicação', 205.00, 'B3', '01'),
(26, 20, 6, '2026-06-10', '09:30:00', 'Agendado', 'Exame ginecológico', 195.00, 'B4', '01'),
(1, 21, 7, '2026-06-11', '10:00:00', 'Agendado', 'Sintomas de gripe', 145.00, 'C3', '02'),
(5, 22, 1, '2026-06-11', '10:30:00', 'Confirmado', 'Check-up anual', 150.00, 'C4', '02'),
(9, 23, 2, '2026-06-12', '11:00:00', 'Agendado', 'Dor no peito', 230.00, 'D3', '02'),
(14, 24, 3, '2026-06-12', '11:30:00', 'Cancelado', 'Consulta dermatológica', 170.00, 'D4', '02'),
(18, 25, 4, '2026-06-13', '13:00:00', 'Agendado', 'Lesão esportiva', 185.00, 'E3', '03'),
(22, 26, 5, '2026-06-13', '13:30:00', 'Confirmado', 'Acompanhamento endocrinológico', 215.00, 'E4', '03'),
(26, 27, 6, '2026-06-14', '14:00:00', 'Agendado', 'Consulta neurológica', 240.00, 'F3', '03'),
(29, 28, 7, '2026-06-14', '14:30:00', 'Agendado', 'Sintomas respiratórios', 165.00, 'F4', '03'),
(33, 29, 1, '2026-06-15', '15:00:00', 'Confirmado', 'Retorno de exame', 150.00, 'G3', '04'),
(37, 30, 2, '2026-06-15', '15:30:00', 'Agendado', 'Avaliação de rotina', 175.00, 'G4', '04'),
(2, 1, 2, '2026-06-16', '10:00:00', 'Agendado', 'Avaliação geral', 155.00, 'A1', '01'),
(4, 2, 3, '2026-06-16', '10:30:00', 'Confirmado', 'Dor de cabeça', 160.00, 'A2', '01'),
(6, 3, 4, '2026-06-17', '11:00:00', 'Agendado', 'Dor nas articulações', 185.00, 'B1', '01'),
(7, 4, 5, '2026-06-17', '11:30:00', 'Confirmado', 'Controle de hipertensão', 200.00, 'B2', '01'),
(10, 5, 6, '2026-06-18', '13:00:00', 'Agendado', 'Exame preventivo', 150.00, 'C1', '02'),
(11, 6, 7, '2026-06-18', '13:30:00', 'Cancelado', 'Acompanhamento', 175.00, 'C2', '02'),
(13, 7, 1, '2026-06-19', '14:00:00', 'Agendado', 'Consulta geral', 145.00, 'D1', '02'),
(16, 8, 2, '2026-06-19', '14:30:00', 'Confirmado', 'Pressão arterial', 165.00, 'D2', '02'),
(17, 9, 3, '2026-06-20', '15:00:00', 'Agendado', 'Dor crônica', 195.00, 'E1', '03'),
(19, 10, 4, '2026-06-20', '15:30:00', 'Agendado', 'Lesão muscular', 180.00, 'E2', '03'),
(20, 11, 5, '2026-06-21', '08:00:00', 'Confirmado', 'Controle de glicemia', 210.00, 'F1', '03'),
(23, 12, 6, '2026-06-21', '08:30:00', 'Agendado', 'Consulta dermatológica', 170.00, 'F2', '03'),
(25, 13, 7, '2026-06-22', '09:00:00', 'Agendado', 'Sintomas respiratórios', 160.00, 'G1', '04'),
(28, 14, 1, '2026-06-22', '09:30:00', 'Confirmado', 'Retorno médico', 150.00, 'G2', '04'),
(31, 15, 2, '2026-06-23', '10:00:00', 'Agendado', 'Avaliação cardiológica', 220.00, 'H1', '04'),
(32, 16, 3, '2026-06-23', '10:30:00', 'Cancelado', 'Consulta neurológica', 240.00, 'H2', '04'),
(35, 17, 4, '2026-06-24', '11:00:00', 'Agendado', 'Dor nas costas', 180.00, 'A3', '01'),
(36, 18, 5, '2026-06-24', '11:30:00', 'Confirmado', 'Controle de medicação', 205.00, 'A4', '01'),
(39, 19, 6, '2026-06-25', '13:00:00', 'Agendado', 'Acompanhamento geral', 150.00, 'B3', '01'),
(40, 20, 7, '2026-06-25', '13:30:00', 'Agendado', 'Consulta de rotina', 155.00, 'B4', '01');


INSERT INTO consulta_medica
(id_agend_consult, data_atendimento, hora_atendimento, sintomas_relatados, tempo_sintomas_relatados, suspeita_diagnostico, diagnostico, tratamento, retorno, observacoes)
VALUES
(51, '2026-06-01', '08:10:00', 'Dor de cabeça e cansaço', '3 dias', 'Enxaqueca', 'Enxaqueca', 'Analgésico e repouso', '15 dias', 'Paciente orientado a manter hidratação'),
(52, '2026-06-01', '08:40:00', 'Tosse seca e coriza', '5 dias', 'Virose respiratória', 'Rinite aguda', 'Antialérgico e lavagem nasal', '7 dias', 'Sem febre no momento'),
(53, '2026-06-02', '09:10:00', 'Dor abdominal leve', '2 dias', 'Gastrite', 'Gastrite', 'Omeprazol e dieta leve', '10 dias', 'Evitar alimentos gordurosos'),
(54, '2026-06-02', '09:40:00', 'Dor lombar', '1 semana', 'Lombalgia', 'Lombalgia', 'Anti-inflamatório e alongamento', '15 dias', 'Orientado a evitar esforço'),
(55, '2026-06-03', '10:10:00', 'Pressão alta e tontura', '2 dias', 'Hipertensão descompensada', 'Hipertensão', 'Ajuste medicamentoso', '7 dias', 'Monitorar pressão em casa'),
(56, '2026-06-03', '10:40:00', 'Falta de ar ao esforço', '4 dias', 'Asma', 'Crise asmática leve', 'Broncodilatador inalatório', '7 dias', 'Paciente com histórico respiratório'),
(57, '2026-06-04', '11:10:00', 'Coceira e vermelhidão na pele', '3 dias', 'Alergia cutânea', 'Dermatite alérgica', 'Antialérgico tópico', '10 dias', 'Sem sinais de infecção'),
(58, '2026-06-04', '11:40:00', 'Febre e dor no corpo', '2 dias', 'Infecção viral', 'Síndrome gripal', 'Hidratação e sintomáticos', '5 dias', 'Orientado repouso'),
(59, '2026-06-05', '13:10:00', 'Azia e queimação', '1 semana', 'Refluxo gastroesofágico', 'DRGE', 'Inibidor de ácido e dieta', '15 dias', 'Fracionar refeições'),
(60, '2026-06-05', '13:40:00', 'Dor no peito ao esforço', '2 dias', 'Investigação cardíaca', 'Sem alterações agudas', 'Solicitado exame complementar', '7 dias', 'Retorno com exames'),
(61, '2026-06-06', '14:10:00', 'Dor no joelho', '10 dias', 'Lesão articular', 'Tendinite', 'Repouso e anti-inflamatório', '15 dias', 'Evitar impacto'),
(62, '2026-06-06', '14:40:00', 'Tremores e ansiedade', '1 mês', 'Transtorno ansioso', 'Ansiedade', 'Acompanhamento psicológico', '30 dias', 'Paciente bem orientado'),
(63, '2026-06-07', '15:10:00', 'Visão embaçada', '4 dias', 'Alteração refracional', 'A ser confirmado', 'Encaminhado para avaliação especializada', '15 dias', 'Solicitado exame oftalmológico'),
(64, '2026-06-07', '15:40:00', 'Dor de garganta', '3 dias', 'Faringite', 'Faringite aguda', 'Analgésico e hidratação', '7 dias', 'Sem placas visíveis'),
(65, '2026-06-08', '16:10:00', 'Náusea e vômitos', '2 dias', 'Gastroenterite', 'Gastroenterite', 'Soro oral e dieta leve', '5 dias', 'Orientado sinais de alarme'),
(66, '2026-06-08', '16:40:00', 'Coceira nos olhos', '1 semana', 'Conjuntivite alérgica', 'Conjuntivite alérgica', 'Colírio antialérgico', '7 dias', 'Evitar coçar os olhos'),
(67, '2026-06-09', '08:10:00', 'Cansaço e palidez', '15 dias', 'Anemia', 'Anemia leve', 'Suplementação e exames', '30 dias', 'Solicitado hemograma de controle'),
(68, '2026-06-09', '08:40:00', 'Dor no ombro', '1 semana', 'Inflamação muscular', 'Bursite', 'Fisioterapia e anti-inflamatório', '15 dias', 'Reduzir movimentos repetitivos'),
(69, '2026-06-10', '09:10:00', 'Pressão baixa e fraqueza', '3 dias', 'Desidratação', 'Hipotensão leve', 'Aumentar ingestão hídrica', '7 dias', 'Orientado repouso'),
(70, '2026-06-10', '09:40:00', 'Escurecimento da urina', '2 dias', 'Infecção urinária', 'ITU', 'Antibiótico', '7 dias', 'Retorno se houver febre'),
(71, '2026-06-11', '10:10:00', 'Dor nas articulações', '1 mês', 'Doença reumatológica', 'Artralgia em investigação', 'Analgesia e exames', '15 dias', 'Aguardando resultados'),
(72, '2026-06-11', '10:40:00', 'Tosse com catarro', '6 dias', 'Bronquite', 'Bronquite aguda', 'Nebulização e sintomáticos', '7 dias', 'Sem falta de ar importante'),
(73, '2026-06-12', '11:10:00', 'Dor de ouvido', '2 dias', 'Otite', 'Otite média', 'Antibiótico e analgésico', '7 dias', 'Orientado não molhar o ouvido'),
(74, '2026-06-12', '11:40:00', 'Espirros frequentes', '2 semanas', 'Rinite alérgica', 'Rinite alérgica', 'Antialérgico', '15 dias', 'Crises em ambiente com poeira'),
(75, '2026-06-13', '13:10:00', 'Inchaço nas pernas', '5 dias', 'Retenção hídrica', 'Edema em investigação', 'Solicitado exame laboratorial', '10 dias', 'Reduzir sal na alimentação'),
(76, '2026-06-13', '13:40:00', 'Dor ao urinar', '3 dias', 'Infecção urinária', 'ITU', 'Antibiótico', '7 dias', 'Aumentar ingestão de água'),
(77, '2026-06-14', '14:10:00', 'Tontura ao levantar', '1 semana', 'Hipotensão postural', 'Hipotensão', 'Hidratação e orientação postural', '7 dias', 'Paciente orientado lentamente ao levantar'),
(78, '2026-06-14', '14:40:00', 'Coceira no corpo inteiro', '4 dias', 'Reação alérgica', 'Urticária', 'Antialérgico oral', '7 dias', 'Evitar possível agente causador'),
(79, '2026-06-15', '15:10:00', 'Dor no abdômen inferior', '3 dias', 'Problema ginecológico', 'Em investigação', 'Solicitado exame complementar', '15 dias', 'Encaminhada para avaliação'),
(80, '2026-06-15', '15:40:00', 'Desânimo e insônia', '2 semanas', 'Transtorno emocional', 'Ansiedade', 'Acompanhamento e orientação', '30 dias', 'Paciente orientado sobre rotina do sono'),
(81, '2026-06-16', '10:10:00', 'Dor nas costas', '1 semana', 'Hérnia de disco', 'Lombalgia crônica', 'Anti-inflamatório e fisioterapia', '15 dias', 'Solicitado ressonância magnética'),
(82, '2026-06-16', '10:40:00', 'Tosse persistente', '3 semanas', 'Tuberculose descartada', 'Tosse alérgica', 'Antitussígeno e antialérgico', '10 dias', 'Sem hemoptise'),
(83, '2026-06-17', '11:10:00', 'Dor no estômago', '2 dias', 'Úlcera gástrica', 'Gastrite erosiva', 'Omeprazol em dose elevada', '15 dias', 'Dieta restritiva'),
(84, '2026-06-17', '11:40:00', 'Dormência nas mãos', '1 semana', 'Compressão nervosa', 'Síndrome do túnel carpiano', 'Imobilização e analgésico', '15 dias', 'Orientado exercícios preventivos'),
(85, '2026-06-18', '13:10:00', 'Sudoração excessiva', '2 semanas', 'Hipertireoidismo', 'Hipertireoidismo suspeito', 'Solicitado TSH e T4', '7 dias', 'Encaminhado endocrinologia'),
(86, '2026-06-18', '13:40:00', 'Inflamação na garganta', '4 dias', 'Amigdalite', 'Amigdalite aguda', 'Antibiótico e analgésico', '10 dias', 'Sem dispneia'),
(87, '2026-06-19', '14:10:00', 'Dor no calcanhar', '5 dias', 'Fascite plantar', 'Fascite plantar', 'Analgésico e alongamento', '15 dias', 'Orientado uso de palmilha'),
(88, '2026-06-19', '14:40:00', 'Episódios de taquicardia', '1 semana', 'Arritmia cardíaca', 'Taquicardia sinusal', 'Solicitado ECG e Holter', '7 dias', 'Retorno com exames'),
(89, '2026-06-20', '15:10:00', 'Perda de cabelo', '2 meses', 'Alopecia', 'Alopecia areata', 'Minoxidil tópico', '30 dias', 'Consulta dermatologia'),
(90, '2026-06-20', '15:40:00', 'Dor na boca', '3 dias', 'Aftas', 'Úlcera oral', 'Antisséptico bucal', '7 dias', 'Sem infecção secundária'),
(91, '2026-06-21', '08:10:00', 'Estalo e dor no maxilar', '1 semana', 'Disfunção temporomandibular', 'DTM', 'Fisioterapia e miorrelaxante', '15 dias', 'Orientado evitar alimentos duros'),
(92, '2026-06-21', '08:40:00', 'Dor nas pernas ao caminhar', '2 semanas', 'Trombose venosa', 'Varizes com insuficiência', 'Meia compressiva e analgésico', '15 dias', 'Encaminhado angiologia'),
(93, '2026-06-22', '09:10:00', 'Afonia', '4 dias', 'Laringite', 'Laringite aguda', 'Repouso vocal e antisséptico', '7 dias', 'Evitar cigarro e álcool'),
(94, '2026-06-22', '09:40:00', 'Palpitações à noite', '1 semana', 'Arritmia', 'Extrassístoles', 'Solicitado monitoramento 24h', '10 dias', 'Reduzir cafeína'),
(95, '2026-06-23', '10:10:00', 'Hálito cetônico', '3 dias', 'Descompensação metabólica', 'Cetonemia', 'Ajuste insulínico', '3 dias', 'Retorno urgente'),
(96, '2026-06-23', '10:40:00', 'Prurido anal', '2 semanas', 'Hemorrhoidas', 'Hemorrhoidas internas', 'Pomada anestésica', '10 dias', 'Aumentar fibras alimentares'),
(97, '2026-06-24', '11:10:00', 'Tremor nas mãos', '2 semanas', 'Parkinson precoce', 'Tremor essencial', 'Avaliação neurológica complementar', '15 dias', 'Encaminhado neurologista'),
(98, '2026-06-24', '11:40:00', 'Dor nas articulações dos dedos', '3 semanas', 'Artrite reumatoide', 'Possível artrite', 'Solicitado FAN e fator reumatoide', '15 dias', 'Iniciar investigação'),
(99, '2026-06-25', '13:10:00', 'Manchas vermelhas na pele', '5 dias', 'Sífilis descartada', 'Erupção viral', 'Antialérgico', '10 dias', 'Sem outras manifestações'),
(100, '2026-06-25', '13:40:00', 'Dormência nos pés', '1 mês', 'Neuropatia diabética', 'Polineuropatia periférica', 'Controle glicêmico rigoroso', '30 dias', 'Solicitado eletroneuromiografia');
