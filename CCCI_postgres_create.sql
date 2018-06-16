CREATE TABLE "aluno" (
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
	CONSTRAINT aluno_pk PRIMARY KEY ("matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "universidade" (
	"nome" character varying(40) NOT NULL,
	"sigla" character varying(7) NOT NULL,
	"estado" character varying(40) NOT NULL,
	"pais" character varying(3) NOT NULL,
	"FK_Professor_matricula" integer NOT NULL,
	CONSTRAINT universidade_pk PRIMARY KEY ("sigla","estado","pais")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "fala" (
	"FK_Idioma_nome" character varying(20) NOT NULL,
	"FK_Aluno_matricula" integer NOT NULL,
	"proeficiencia" integer NOT NULL,
	"certificado" character varying(60),
	CONSTRAINT fala_pk PRIMARY KEY ("FK_Idioma_nome","FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "discilpina" (
	"codigo" integer NOT NULL,
	"nome" character varying(20) NOT NULL,
	"creditos" integer NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT discilpina_pk PRIMARY KEY ("codigo","FK_Departamento_sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "curso" (
	"sigla" character varying(7) NOT NULL,
	"nome" character varying(30) NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT curso_pk PRIMARY KEY ("sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "departamento" (
	"sigla" character varying(7) NOT NULL,
	"nome" character varying(40) NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY ("sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "professor" (
	"nome" character varying(50) NOT NULL,
	"matricula" integer NOT NULL,
	"FK_Departamento_sigla" character varying(7) NOT NULL,
	CONSTRAINT professor_pk PRIMARY KEY ("matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "turma" (
	"turma" character varying(7) NOT NULL,
	"periodo" integer NOT NULL,
	"FK_Professor_matricula" integer NOT NULL,
	"FK_Disciplina_codigo" integer(8) NOT NULL,
	"FK_Departamento_Sigla" character varying(7) NOT NULL,
	"FK_Aluno_matricula" integer NOT NULL,
	CONSTRAINT turma_pk PRIMARY KEY ("turma","periodo","FK_Professor_matricula","FK_Disciplina_codigo","FK_Departamento_Sigla","FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "contato" (
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
	CONSTRAINT contato_pk PRIMARY KEY ("FK_Aluno_matricula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "curriculo" (
	"FK_Discipla_codigo" integer NOT NULL,
	"FK_Departamento_sigla" varchar(7) NOT NULL,
	"FK_Curso_sigla" varchar(7) NOT NULL,
	CONSTRAINT curriculo_pk PRIMARY KEY ("FK_Discipla_codigo","FK_Departamento_sigla","FK_Curso_sigla")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "idioma" (
	"nome" varchar(20) NOT NULL,
	CONSTRAINT idioma_pk PRIMARY KEY ("nome")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "aluno" ADD CONSTRAINT "aluno_fk0" FOREIGN KEY ("FK_Universidade_estado") REFERENCES "universidade"("estado");
ALTER TABLE "aluno" ADD CONSTRAINT "aluno_fk1" FOREIGN KEY ("FK_Universidade_sigla") REFERENCES "universidade"("estado");
ALTER TABLE "aluno" ADD CONSTRAINT "aluno_fk2" FOREIGN KEY ("FK_Universidade_pais") REFERENCES "universidade"("pais");
ALTER TABLE "aluno" ADD CONSTRAINT "aluno_fk3" FOREIGN KEY ("FK_Curso_sigla") REFERENCES "curso"("sigla");

ALTER TABLE "universidade" ADD CONSTRAINT "universidade_fk0" FOREIGN KEY ("FK_Professor_matricula") REFERENCES "professor"("matricula");

ALTER TABLE "fala" ADD CONSTRAINT "fala_fk0" FOREIGN KEY ("FK_Idioma_nome") REFERENCES "idioma"("nome");
ALTER TABLE "fala" ADD CONSTRAINT "fala_fk1" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "aluno"("matricula");


ALTER TABLE "curso" ADD CONSTRAINT "curso_fk0" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "departamento"("sigla");


ALTER TABLE "professor" ADD CONSTRAINT "professor_fk0" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "departamento"("sigla");

ALTER TABLE "turma" ADD CONSTRAINT "turma_fk0" FOREIGN KEY ("FK_Professor_matricula") REFERENCES "professor"("matricula");
ALTER TABLE "turma" ADD CONSTRAINT "turma_fk1" FOREIGN KEY ("FK_Disciplina_codigo") REFERENCES "discilpina"("codigo");
ALTER TABLE "turma" ADD CONSTRAINT "turma_fk2" FOREIGN KEY ("FK_Departamento_Sigla") REFERENCES "departamento"("sigla");
ALTER TABLE "turma" ADD CONSTRAINT "turma_fk3" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "aluno"("matricula");

ALTER TABLE "contato" ADD CONSTRAINT "contato_fk0" FOREIGN KEY ("FK_Aluno_matricula") REFERENCES "aluno"("matricula");

ALTER TABLE "curriculo" ADD CONSTRAINT "curriculo_fk0" FOREIGN KEY ("FK_Discipla_codigo") REFERENCES "discilpina"("codigo");
ALTER TABLE "curriculo" ADD CONSTRAINT "curriculo_fk1" FOREIGN KEY ("FK_Departamento_sigla") REFERENCES "departamento"("sigla");
ALTER TABLE "curriculo" ADD CONSTRAINT "curriculo_fk2" FOREIGN KEY ("FK_Curso_sigla") REFERENCES "curso"("sigla");
