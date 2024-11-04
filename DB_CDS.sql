create database DB_CDS;

use DB_CDS;

create table artista(
	cod_artista int not null auto_increment primary key,
    nome_art varchar(100)
);

create table gravadora(
	cod_grav int not null auto_increment primary key,
    nome_grav varchar(50) not null
);

create table categoria(
	cod_cat int not null auto_increment primary key,
    nome_cat varchar(50) not null
);

create table estado(
	sigla_est char(2) not null primary key,
    nome_est char(50) not null
);

create table cidade(
	cod_cid int not null auto_increment primary key,
    sigla_est char(2) not null primary key,
    foreign key (sigla_est) references estado(sigla_est),
    nome_cid varchar(100) not null
);

create table cliente(
	cod_cli int not null auto_increment primary key,
    cod_cid int not null,
    foreign key (cod_cid) references cidade(cod_cid),
    nome_cli varchar(100) not null,
    end_cli varchar(200) not null,
    renda_cli decimal(10,2) not null default 0 check (renda_cli >= 0),
    sexo_cli  enum('f', 'm', 'o') not null
);

create table conjuge(
	cod_cli int not null primary key,
    foreign key (cod_cli) references cliente(cod_cli),
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null default 0 check (renda_conj >= 0),
    sexo_conj enum('f','m','o')
);

create table funcionario(
	cod_func int not null auto_increment primary key,
	nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sal_func decimal(10,2) not null default 0 check (sal_func >= 0),
    sexo_func enum('f','m','o') default 'm'
);

create table dependente(
	cod_dep int not null auto_increment primary key,
    cod_func int not null,
    foreign key (cod_func) references funcionario(cod_func),
    nome_dep varchar(100) not null,
    sexo_dep enum('f','m','o') default 'm'
);

create table titulo(
	cod_tit int not null primary key,
    cod_cat int not null,
    foreign key (cod_cat) references categoria(cod_cat),
    cod_grav int not null,
    foreign key (cod_grav) references gravadora(cod_grav),
    nome_cd varchar(100) not null,
    val_cd decimal(10,2) check (val_cd > 0),
    qtd_estq int not null check (qtd_estq >= 0)
);

create table pedido(
	num_ped int not null auto_increment primary key,
	cod_cli int not null,
    foreign key (cod_cli) references cliente(cod_cli),
    cod_func int not null,
    foreign key (cod_func) references funcionario(cod_func),
    data_ped datetime not null,
    val_ped decimal(10,2) not null check (val_ped >= 0) default 0
);

create table titulo_pedido(
	num_ped int not null,
    foreign key (num_ped) references pedido(num_ped),
    cod_tit int not null,
    foreign key (cod_tit) references titutlo(cod_tit),
    qtd_cd int not null check (qtd_cd >= 1),
    val_cd decimal(10,2) not null check (val_cd > 0)
);

create table titulo_artista(
	cod_tit int not null,
    foreign key (cod_tit) references titulo(cod_tit),
    cod_art int not null,
    foreign key (cod_art) references artista(cod_art)
);

