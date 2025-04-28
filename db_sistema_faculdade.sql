# Cria base de dados 
CREATE DATABASE db_sistema_faculdade;

# Seleciona database que será utilizado
USE db_sistema_faculdade;

# Cria tabela
CREATE TABLE tbl_departamento(
	cod_departamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    descricao TEXT NOT NULL,
    coordenador VARCHAR(100) NOT NULL,
    ramal_telefone VARCHAR(10) NOT NULL,
    email_institucional VARCHAR(256) NOT NULL,
    
    UNIQUE INDEX(cod_departamento)
);

CREATE TABLE tbl_disciplina(
	cod_disciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    carga_horaria INT NOT NULL,
    cod_departamento INT NOT NULL,
    
    # Cria relacionamento entre tbl_departamento e tbl_disciplina
    CONSTRAINT FK_departamento_disciplina
    FOREIGN KEY (cod_departamento)
    REFERENCES tbl_departamento (cod_departamento),
    
    UNIQUE INDEX(cod_disciplina)
);

CREATE TABLE tbl_professor(
	cod_professor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(14) NOT NULL,
    email_institucional VARCHAR(256) NOT NULL,
    cod_departamento INT NOT NULL,
    
    # Cria relacionamento entre tbl_departamento e tbl_professor
    CONSTRAINT FK_departamento_professor
    FOREIGN KEY (cod_departamento)
    REFERENCES tbl_departamento(cod_departamento),
    
    UNIQUE INDEX(cod_professor)
);

# Cria tabela associativa
CREATE TABLE tbl_professor_disciplina(
	cod_professor_disciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_professor INT NOT NULL,
    cod_disciplina INT NOT NULL,
    
    # Cria relacionamento entre tbl_professor e tbl_professor_disciplina
    CONSTRAINT FK_professor_professor_disciplina
    FOREIGN KEY (cod_professor)
    REFERENCES tbl_professor(cod_professor),
    
    # Cria relacionamento entre tbl_disciplina e tbl_professor_disciplina
    CONSTRAINT FK_disciplina_professor_disciplina
    FOREIGN KEY (cod_disciplina)
    REFERENCES tbl_disciplina (cod_disciplina),
    
    UNIQUE INDEX(cod_professor_disciplina)
);

CREATE TABLE tbl_curso(
	cod_curso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, 
    turno VARCHAR(10) NOT NULL,
    modalidade VARCHAR(15) NOT NULL,
    qtde_semestres INT NOT NULL,
    total_carga_horaria INT NOT NULL,
    cod_departamento INT NOT NULL,
    
    # Cria relacionamento entre tbl_departamento e tbl_curso
    CONSTRAINT FK_departamento_curso 
    FOREIGN KEY (cod_departamento)
    REFERENCES tbl_departamento(cod_departamento),
    
    UNIQUE INDEX(cod_curso)
);

# Cria tabela associativa
CREATE TABLE tbl_curso_disciplina(
	cod_curso_disciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_curso INT NOT NULL,
    cod_disciplina INT NOT NULL,
    
    # Cria relacionamento entre tbl_curso e tbl_curso_disciplina 
    CONSTRAINT FK_curso_curso_disciplina
    FOREIGN KEY (cod_curso)
    REFERENCES tbl_curso (cod_curso),
    
    # Cria relacionamento entre tbl_disciplina e tbl_curso_disciplina
    CONSTRAINT FK_disciplina_curso_disciplina
    FOREIGN KEY (cod_disciplina)
    REFERENCES tbl_disciplina(cod_disciplina),
    
    UNIQUE INDEX(cod_curso_disciplina)
);

CREATE TABLE tbl_turma(
	cod_turma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL, 
    data_inicio DATE NOT NULL,
    semestre INT NOT NULL,
    qtde_alunos INT NOT NULL,
    cod_curso INT NOT NULL,
    
    # Cria relacionamento entre tbl_curso e tbl_turma
    CONSTRAINT FK_curso_turma 
    FOREIGN KEY (cod_curso)
    REFERENCES tbl_curso(cod_curso),
    
    UNIQUE INDEX(cod_turma)
);

CREATE TABLE tbl_endereco(
	cod_endereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    cep VARCHAR(10) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    
    UNIQUE INDEX(cod_endereco)
);

CREATE TABLE tbl_aluno(
	RA_aluno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(14) NOT NULL,
    rg VARCHAR(10) NOT NULL,
    sexo VARCHAR(15),
    data_nascimento DATE NOT NULL,
    data_ingresso DATE NOT NULL,
    situacao VARCHAR(10) NOT NULL,
    cod_endereco INT NOT NULL,
    cod_curso INT NOT NULL,
    cod_turma INT NOT NULL,
    
    # Cria relacionamento entre tbl_endereco e tbl_aluno
    CONSTRAINT FK_endereco_aluno
    FOREIGN KEY (cod_endereco)
    REFERENCES tbl_endereco(cod_endereco),
    
    # Cria relacionamento entre tbl_curso e tbl_aluno
    CONSTRAINT FK_curso_aluno
    FOREIGN KEY (cod_curso)
    REFERENCES tbl_curso(cod_curso),
    
    # Cria relacionamento entre tbl_turma e tbl_aluno
    CONSTRAINT FK_turma_aluno
	FOREIGN KEY (cod_turma)
    REFERENCES tbl_turma(cod_turma),
    
    UNIQUE INDEX(RA_aluno)
);

# Cria tabela associativa
CREATE TABLE tbl_aluno_disciplina(
	cod_aluno_disciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_aluno INT NOT NULL,
    cod_disciplina INT NOT NULL,
    
    # Cria relacionamento entre tbl_aluno e tbl_aluno_disciplina
    CONSTRAINT FK_aluno_aluno_disciplina
    FOREIGN KEY (cod_aluno)
    REFERENCES tbl_aluno(RA_aluno),
    
    # Cria relacionamento entre tbl_disciplina e tbl_aluno_disciplina
    CONSTRAINT FK_disciplina_aluno_disciplina
    FOREIGN KEY (cod_disciplina)
    REFERENCES tbl_disciplina(cod_disciplina),
    
    UNIQUE INDEX(cod_aluno_disciplina)
);

CREATE TABLE tbl_telefone(
	cod_telefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numero_telefone VARCHAR(15) NOT NULL,
    cod_aluno INT NOT NULL,
    
    # Cria relacionamento entre tbl_aluno e tbl_telefone
    CONSTRAINT FK_aluno_telefone
    FOREIGN KEY (cod_aluno)
    REFERENCES tbl_aluno(RA_aluno),
    
    UNIQUE INDEX(cod_telefone)
);

CREATE TABLE tbl_email(
	cod_email INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    endereco_email VARCHAR(256) NOT NULL,
    tipo_email VARCHAR(15) NOT NULL,
    cod_aluno INT NOT NULL,
    
     # Cria relacionamento entre tbl_aluno e tbl_email
    CONSTRAINT FK_aluno_email
    FOREIGN KEY (cod_aluno)
    REFERENCES tbl_aluno(RA_aluno),
    
    UNIQUE INDEX(cod_email)
);

CREATE TABLE tbl_nota(
	cod_nota INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nota_trabalho1 FLOAT NOT NULL,
    nota_trabalho2 FLOAT NOT NULL,
    nota_prova FLOAT NOT NULL,
    media_final FLOAT NOT NULL,
    cod_aluno_disciplina INT NOT NULL,
    
     # Cria relacionamento entre tbl_aluno_disciplina e tbl_nota
    CONSTRAINT FK_aluno_disciplina_nota
    FOREIGN KEY (cod_aluno_disciplina)
    REFERENCES tbl_aluno_disciplina(cod_aluno_disciplina),

	UNIQUE INDEX(cod_nota)
);

# Lista todas as tabelas do banco
SHOW TABLES;

# Lista os atributos da tabela
DESC tbl_departamento;