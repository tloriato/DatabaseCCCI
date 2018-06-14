CREATE TABLE "Aluno" (
	"nome" character varying(70) NOT NULL,
	"docEmissor" character varying(60) NOT NULL,
	"docNumero" character varying(20) NOT NULL,
	"docDataValidade" DATE NOT NULL,
	"docDataEmissao" DATE NOT NULL,
	"dataNascimento" DATE NOT NULL,
	"temNecessidadeMotora" BOOLEAN NOT NULL,
	"temNecessidadeAuditiva" BOOLEAN NOT NULL,
	"temNecessidadeVisual" BOOLEAN NOT NULL,
	"nacionalidade" character varying(3) NOT NULL,
	"matricula" int NOT NULL,
	"FK_Universidade_estado" character varying(30) NOT NULL,
	"FK_Universidade_sigla" character varying(7) NOT NULL,
	"FK_Universidade_pais" character varying(20) NOT NULL,
	"tipoIntercambio" character varying(10) NOT NULL,
	"dataIntercambioInicial" DATE NOT NULL,
	"dataIntercambioFinal" DATE NOT NULL,
	"cursoOrigem" character varying(20) NOT NULL,
	"FK_Curso_sigla" character varying(7) NOT NULL,
	"email" character varying(60) NOT NULL,
	"sexo" char NOT NULL,
	"telefone" bigint NOT NULL,
	"enderecoPais" character varying(3) NOT NULL,
	"enderecoEstado" character varying(40) NOT NULL,
	"enderecoCidade" character varying(40) NOT NULL,
	"enderecoCodigoPostal" bigint NOT NULL,
	"enderecoLogradouro" character varying(70) NOT NULL,
	"enderecoNumero" integer NOT NULL,
	"enderecoComplemento" character varying(20),
	CONSTRAINT Aluno_pk PRIMARY KEY ("matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Universidade" (
	"nome" character varying(40) NOT NULL,
	"sigla" character varying(7) NOT NULL,
	"estado" character varying(40) NOT NULL,
	"pais" character varying(3) NOT NULL,
	"FK_Professor_matricula" integer NOT NULL,
	CONSTRAINT Universidade_pk PRIMARY KEY ("sigla","estado","pais")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Fala" (
	"FK_Idioma_nome" character varying(20) NOT NULL,
	"FK_Aluno_matricula" integer NOT NULL,
	"proeficiencia" integer NOT NULL,
	"certificado" character varying(60) NOT NULL,
	CONSTRAINT Fala_pk PRIMARY KEY ("FK_Idioma_nome","FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Disciplina" (
	"codigo" integer NOT NULL,
	"nome" character varying(20) NOT NULL,
	"creditos" integer NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT Disciplina_pk PRIMARY KEY ("codigo","FK_Departamento_sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Curso" (
	"sigla" character varying(7) NOT NULL,
	"nome" character varying(30) NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT Curso_pk PRIMARY KEY ("sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Departamento" (
	"sigla" character varying(7) NOT NULL,
	"nome" character varying(40) NOT NULL,
	CONSTRAINT Departamento_pk PRIMARY KEY ("sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Professor" (
	"nome" character varying(50) NOT NULL,
	"matricula" integer NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT Professor_pk PRIMARY KEY ("matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Turma" (
	"turma" character varying(7) NOT NULL,
	"periodo" integer NOT NULL,
	"FK_Professor_matricula" integer NOT NULL,
	"FK_Disciplina_codigo" integer(8) NOT NULL,
	"FK_Departamento_Sigla" character varying(7) NOT NULL,
	"FK_Aluno_matricula" integer NOT NULL,
	CONSTRAINT Turma_pk PRIMARY KEY ("turma","periodo","FK_Professor_matricula","FK_Disciplina_codigo","FK_Departamento_Sigla","FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Contato" (
	"nome" character varying(70) NOT NULL,
	"email" character varying(60) NOT NULL,
	"sexo" char NOT NULL,
	"telefone" bigint NOT NULL,
	"enderecoPais" character varying(3) NOT NULL,
	"enderecoEstado" character varying(40) NOT NULL,
	"enderecoCidade" character varying(40) NOT NULL,
	"enderecoCodigoPostal" bigint NOT NULL,
	"enderecoLogradouro" character varying(70) NOT NULL,
	"enderecoNumero" integer NOT NULL,
	"enderecoComplemento" character varying(20),
	"parentesco" character varying(20) NOT NULL,
	"FK_Aluno_matricula" integer NOT NULL,
	CONSTRAINT Contato_pk PRIMARY KEY ("FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Curriculo" (
	"FK_Discipla_codigo" integer NOT NULL,
	"FK_Departamento_sigla" varchar(7) NOT NULL,
	"FK_Curso_sigla" varchar(7) NOT NULL,
	CONSTRAINT Curriculo_pk PRIMARY KEY ("FK_Discipla_codigo","FK_Departamento_sigla","FK_Curso_sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Idioma" (
	"nome" varchar(20) NOT NULL,
	CONSTRAINT Idioma_pk PRIMARY KEY ("nome")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_fk0" FOREIGN KEY ("FK_Universidade_estado") REFERENCES "Universidade"("estado");
ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_fk1" FOREIGN KEY ("FK_Universidade_sigla") REFERENCES "Universidade"("estado");
ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_fk2" FOREIGN KEY ("FK_Universidade_pais") REFERENCES "Universidade"("pais");
ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_fk3" FOREIGN KEY ("FK_Curso_sigla") REFERENCES "Curso"("sigla");

ALTER TABLE "Universidade" ADD CONSTRAINT "Universidade_fk0" FOREIGN KEY ("FK_Professor_matricula") REFERENCES "Professor"("matricula");

ALTER TABLE "Fala" ADD CONSTRAINT "Fala_fk0" FOREIGN KEY ("FK_Idioma_nome") REFERENCES "Idioma"("nome");
ALTER TABLE "Fala" ADD CONSTRAINT "Fala_fk1" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "Aluno"("matricula");


ALTER TABLE "Curso" ADD CONSTRAINT "Curso_fk0" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "Departamento"("sigla");


ALTER TABLE "Professor" ADD CONSTRAINT "Professor_fk0" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "Departamento"("sigla");

ALTER TABLE "Turma" ADD CONSTRAINT "Turma_fk0" FOREIGN KEY ("FK_Professor_matricula") REFERENCES "Professor"("matricula");
ALTER TABLE "Turma" ADD CONSTRAINT "Turma_fk1" FOREIGN KEY ("FK_Disciplina_codigo") REFERENCES "Disciplina"("codigo");
ALTER TABLE "Turma" ADD CONSTRAINT "Turma_fk2" FOREIGN KEY ("FK_Departamento_Sigla") REFERENCES "Departamento"("sigla");
ALTER TABLE "Turma" ADD CONSTRAINT "Turma_fk3" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "Aluno"("matricula");

ALTER TABLE "Contato" ADD CONSTRAINT "Contato_fk0" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "Aluno"("matricula");

ALTER TABLE "Curriculo" ADD CONSTRAINT "Curriculo_fk0" FOREIGN KEY ("FK_Discipla_codigo") REFERENCES "Disciplina"("codigo");
ALTER TABLE "Curriculo" ADD CONSTRAINT "Curriculo_fk1" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "Departamento"("sigla");
ALTER TABLE "Curriculo" ADD CONSTRAINT "Curriculo_fk2" FOREIGN KEY ("FK_Curso_sigla") REFERENCES "Curso"("sigla");


