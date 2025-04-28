USE db_sistema_faculdade;

# Povoamento do database com dados fictícios
INSERT INTO tbl_departamento (nome, sigla, descricao, coordenador, ramal_telefone, email_institucional) VALUES 
('Departamento de Computação', 'DCOMP', 'Departamento responsável pelos cursos de TI', 'Carla Silva', '3210', 'computacao@faculdade.edu'), 
('Departamento de Saúde', 'DSAU', 'Departamento responsável pelos cursos de saúde', 'João Pereira', '3220', 'saude@faculdade.edu');

INSERT INTO tbl_endereco (logradouro, bairro, numero, cep, cidade) VALUES 
('Rua das Flores', 'Centro', 123, '12345-678', 'São Paulo'), 
('Av. Brasil', 'Jardins', 456, '98765-432', 'São Paulo');

INSERT INTO tbl_curso (nome, turno, modalidade, qtde_semestres, total_carga_horaria, cod_departamento) VALUES
('Análise e Desenvolvimento de Sistemas', 'Noturno', 'Presencial', 5, 2000, 1), 
('Enfermagem', 'Integral', 'Presencial', 8, 4000, 2);

INSERT INTO tbl_disciplina (nome, descricao, carga_horaria, cod_departamento) VALUES 
('Programação Web', 'Desenvolvimento de aplicações para a web.', 80, 1),
('Banco de Dados', 'Modelagem e implementação de bancos de dados.', 80, 1),
('Fundamentos de Enfermagem', 'Bases para atuação em enfermagem.', 100, 2);

INSERT INTO tbl_professor (nome, cpf, email_institucional, cod_departamento) VALUES
('Ana Beatriz', '123.456.789-00', 'ana.beatriz@faculdade.edu', 1),
('Carlos Henrique', '987.654.321-00', 'carlos.henrique@faculdade.edu', 2);

INSERT INTO tbl_professor_disciplina (cod_professor, cod_disciplina) VALUES 
(1, 1),
(1, 2),
(2, 3);

INSERT INTO tbl_turma (nome, data_inicio, semestre, qtde_alunos, cod_curso) VALUES 
('ADS Noturno 2025', '2025-02-03', 1, 40, 1),
('Enfermagem 2025', '2025-02-03', 1, 35, 2);

INSERT INTO tbl_aluno (nome, cpf, rg, sexo, data_nascimento, data_ingresso, situacao, cod_endereco, cod_curso, cod_turma) VALUES
('Pedro Silva', '321.654.987-11', 'MG1234567', 'Masculino', '2000-05-10', '2025-02-03', 'Ativo', 1, 1, 1),
('Maria Souza', '654.321.987-22', 'SP7654321', 'Feminino', '1999-08-15', '2025-02-03', 'Ativo', 2, 2, 2);

INSERT INTO tbl_telefone (numero_telefone, cod_aluno) VALUES
('11988887777', 1),
('11999998888', 2);

INSERT INTO tbl_email (endereco_email, tipo_email, cod_aluno) VALUES
('pedro.silva@email.com', 'Pessoal', 1),
('maria.souza@email.com', 'Pessoal', 2);

INSERT INTO tbl_curso_disciplina (cod_curso, cod_disciplina) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO tbl_aluno_disciplina (cod_aluno, cod_disciplina) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO tbl_nota (nota_trabalho1, nota_trabalho2, nota_prova, media_final, cod_aluno_disciplina) VALUES 
(8.0, 7.5, 9.0, 8.2, 1),
(7.0, 6.5, 8.0, 7.2, 2),
(9.0, 8.5, 9.5, 9.0, 3);

# Consultas de listagens simples
SELECT * FROM tbl_departamento;
SELECT * FROM tbl_curso;                            
SELECT * FROM tbl_disciplina;
SELECT * FROM tbl_professor;
SELECT * FROM tbl_professor_disciplina;
SELECT * FROM tbl_turma;
SELECT * FROM tbl_aluno;
SELECT * FROM tbl_telefone;
SELECT * FROM tbl_email;
SELECT * FROM tbl_curso_disciplina;
SELECT * FROM tbl_aluno_disciplina;
SELECT * FROM tbl_nota;

# Lista todos os alunos e seus respectivos cursos
SELECT aluno.nome, curso.nome AS curso_nome
FROM tbl_aluno AS aluno
JOIN tbl_curso AS curso ON aluno.cod_curso = curso.cod_curso;

# Lista todos os professores e seus depatamentos 
SELECT professor.nome, departamento.nome AS departamento_nome
FROM tbl_professor AS professor
JOIN tbl_departamento AS departamento ON professor.cod_departamento = departamento.cod_departamento;

# Busca alunos ativos (situacao = 'Ativo')
SELECT nome, RA_aluno AS cod_aluno
FROM tbl_aluno
WHERE situacao = 'Ativo';

# Lista os alunos com suas respectivas turmas
SELECT aluno.nome, turma.nome AS turma_nome
FROM tbl_aluno AS aluno
JOIN tbl_turma AS turma ON aluno.cod_turma = turma.cod_turma;

# Lista disciplinas de um departamento específico
SELECT disciplina.nome AS nome_disciplina
FROM tbl_disciplina AS disciplina
JOIN tbl_departamento AS departamento ON disciplina.cod_departamento = departamento.cod_departamento
WHERE departamento.nome = 'Departamento de Computação'; 

# Lista todos os professores e as disciplinas que eles lecionam
SELECT professor.nome AS professor_nome, disciplina.nome AS disciplina_nome
FROM tbl_professor_disciplina AS professor_disciplina
JOIN tbl_professor AS professor ON professor_disciplina.cod_professor = professor.cod_professor
JOIN tbl_disciplina AS disciplina ON professor_disciplina.cod_disciplina = disciplina.cod_disciplina
ORDER BY professor.nome;

# Lista todos os alunos e as disciplinas que estão matriculados
SELECT aluno.nome AS aluno_nome, disciplina.nome AS disciplina_nome
FROM tbl_aluno_disciplina AS aluno_disciplina
JOIN tbl_aluno AS aluno ON aluno_disciplina.cod_aluno = aluno.RA_aluno
JOIN tbl_disciplina AS disciplina ON aluno_disciplina.cod_disciplina = disciplina.cod_disciplina
ORDER BY aluno.nome;
