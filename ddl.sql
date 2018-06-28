create table "aluno" (
	"nome" character varying(70) not null,
	"docemissor" character varying(60) not null,
	"docnumero" character varying(20) not null,
	"docdatavalidade" date not null,
	"docdataemissao" date not null,
	"datanascimento" date not null,
	"temnecessidademotora" boolean not null,
	"temnecessidadeauditiva" boolean not null,
	"temnecessidadevisual" boolean not null,
	"nacionalidade" character varying(3) not null,
	"matricula" int not null,
	"fk_universidade_estado" character varying(30) not null,
	"fk_universidade_sigla" character varying(7) not null,
	"fk_universidade_pais" character varying(20) not null,
	"tipointercambio" character varying(10) not null,
	"dataintercambioinicial" date not null,
	"dataintercambiofinal" date not null,
	"cursoorigem" character varying(20) not null,
	"fk_curso_sigla" character varying(7) not null,
	"email" character varying(60) not null,
	"sexo" char not null,
	"telefone" bigint not null,
	"enderecopais" character varying(3) not null,
	"enderecoestado" character varying(40) not null,
	"enderecocidade" character varying(40) not null,
	"enderecocodigopostal" bigint not null,
	"enderecologradouro" character varying(70) not null,
	"endereconumero" integer not null,
	"enderecocomplemento" character varying(20),
	constraint aluno_pk primary key ("matricula")
) with (
  oids=false
);



create table "universidade" (
	"nome" character varying(40) not null,
	"sigla" character varying(7) not null,
	"estado" character varying(40) not null,
	"pais" character varying(3) not null,
	"fk_professor_matricula" integer not null,
	constraint universidade_pk primary key ("sigla","estado","pais")
) with (
  oids=false
);



create table "fala" (
	"fk_idioma_nome" character varying(20) not null,
	"fk_aluno_matricula" integer not null,
	"proeficiencia" integer not null,
	"certificado" character varying(60),
	constraint fala_pk primary key ("fk_idioma_nome","fk_aluno_matricula")
) with (
  oids=false
);



create table "disciplina" (
	"codigo" integer not null,
	"nome" character varying(20) not null,
	"creditos" integer not null,
	"fk_departamento_sigla" character varying(7) not null,
	constraint disciplina_pk primary key ("codigo","fk_departamento_sigla")
) with (
  oids=false
);



create table "curso" (
	"sigla" character varying(7) not null,
	"nome" character varying(30) not null,
	"fk_departamento_sigla" character varying(7) not null,
	constraint curso_pk primary key ("sigla")
) with (
  oids=false
);



create table "departamento" (
	"sigla" character varying(7) not null,
	"nome" character varying(40) not null,
	constraint departamento_pk primary key ("sigla")
) with (
  oids=false
);



create table "professor" (
	"nome" character varying(50) not null,
	"matricula" integer not null,
	"fk_departamento_sigla" character varying(7) not null,
	constraint professor_pk primary key ("matricula")
) with (
  oids=false
);



create table "turma" (
	"turma" character varying(7) not null,
	"periodo" integer not null,
	"fk_professor_matricula" integer not null,
	"fk_disciplina_codigo" integer not null,
	"fk_departamento_sigla" character varying(7) not null,
	"fk_aluno_matricula" integer not null,
	constraint turma_pk primary key ("turma","periodo","fk_professor_matricula","fk_disciplina_codigo","fk_departamento_sigla","fk_aluno_matricula")
) with (
  oids=false
);



create table "contato" (
	"nome" character varying(70) not null,
	"email" character varying(60) not null,
	"sexo" char not null,
	"telefone" bigint not null,
	"enderecopais" character varying(3) not null,
	"enderecoestado" character varying(40) not null,
	"enderecocidade" character varying(40) not null,
	"enderecocodigopostal" bigint not null,
	"enderecologradouro" character varying(70) not null,
	"endereconumero" integer not null,
	"enderecocomplemento" character varying(20),
	"parentesco" character varying(20) not null,
	"fk_aluno_matricula" integer not null,
	constraint contato_pk primary key ("fk_aluno_matricula")
) with (
  oids=false
);



create table "curriculo" (
	"fk_disciplina_codigo" integer not null,
	"fk_departamento_sigla" varchar(7) not null,
	"fk_curso_sigla" varchar(7) not null,
	constraint curriculo_pk primary key ("fk_discipla_codigo","fk_departamento_sigla","fk_curso_sigla")
) with (
  oids=false
);



create table "idioma" (
	"nome" varchar(20) not null,
	constraint idioma_pk primary key ("nome")
) with (
  oids=false
);



alter table "aluno" add constraint "aluno_fk0" foreign key ("fk_universidade_estado", "fk_universidade_sigla", "fk_universidade_pais") references "universidade"("estado", "sigla", "pais");
alter table "aluno" add constraint "aluno_fk3" foreign key ("fk_curso_sigla") references "curso"("sigla");

alter table "universidade" add constraint "universidade_fk0" foreign key ("fk_professor_matricula") references "professor"("matricula");

alter table "fala" add constraint "fala_fk0" foreign key ("fk_idioma_nome") references "idioma"("nome");
alter table "fala" add constraint "fala_fk1" foreign key ("fk_aluno_matricula") references "aluno"("matricula");


alter table "curso" add constraint "curso_fk0" foreign key ("fk_departamento_sigla") references "departamento"("sigla");


alter table "professor" add constraint "professor_fk0" foreign key ("fk_departamento_sigla") references "departamento"("sigla");

alter table "turma" add constraint "turma_fk0" foreign key ("fk_professor_matricula") references "professor"("matricula");
alter table "turma" add constraint "turma_fk1" foreign key ("fk_disciplina_codigo", "fk_departamento_sigla") references "disciplina"("codigo", "fk_departamento_sigla");
alter table "turma" add constraint "turma_fk3" foreign key ("fk_aluno_matricula") references "aluno"("matricula");

alter table "contato" add constraint "contato_fk0" foreign key ("fk_aluno_matricula") references "aluno"("matricula");

alter table "curriculo" add constraint "curriculo_fk0" foreign key ("fk_disciplina_codigo", "fk_departamento_sigla") references "disciplina"("codigo", "fk_departamento_sigla");
alter table "curriculo" add constraint "curriculo_fk2" foreign key ("fk_curso_sigla") references "curso"("sigla");

alter table "disciplina" add constraint "disciplina_fk0" foreign key ("fk_departamento_sigla") references "departamento"("sigla");
