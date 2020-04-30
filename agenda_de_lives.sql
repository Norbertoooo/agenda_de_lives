create database agenda_de_lives;

create table artistas (
    codigo integer primary key,
    nome text not null ,
    genero text
);

create table lives(
    codigo integer,
    artista integer not null,
    data_hora timestamp not null check ( data_hora > CURRENT_TIMESTAMP )
);

create table lives_plataformas(
    live integer primary key ,
    plataforma integer not null,
    url text
);

create table plataformas(
    codigo integer primary key,
    nome text not null unique
);


-- insert de 10 artistas, 8 com genero, 2 sem genero
insert into artistas(codigo, nome, genero)
VALUES (1, 'ana e vitoria'),
       (2, 'Rihanna', 'Pop'),
       (3, 'Duo lipa', 'Pop'),
       (4, 'Imagine dragons', 'Rock'),
       (5, 'Maroon 5', 'Pop/Rock'),
       (6, 'Ed Sheeran', 'Indie'),
       (7, 'Coldplay', 'Pop/Rock'),
       (8, 'Eminem', 'Rap'),
       (9, 'Billie Eilish'),
       (10, 'Lady Gaga', 'Pop');



-- insert de 4 plataformas
insert into plataformas(codigo, nome)
VALUES (1, 'Youtube'),
       (2, 'Instagram'),
       (3, 'Site oficial'),
       (4, 'Twitter');


-- sessao de drop/truncate

drop database agenda_de_lives;

drop table plataformas;
truncate table plataformas;
drop table artistas;
truncate table artistas;
drop table lives;
truncate table lives;
drop table lives_plataformas;
truncate table lives_plataformas;