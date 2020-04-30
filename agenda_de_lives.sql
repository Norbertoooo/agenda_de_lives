create database agenda_de_lives;


create table plataformas(
    codigo integer primary key,
    nome text not null unique
);


create table artistas (
    codigo integer primary key,
    nome text not null ,
    genero text
);


create table lives(
    codigo integer primary key ,
    artista integer references artistas(codigo),
    data_hora timestamp not null check ( data_hora > CURRENT_TIMESTAMP )
);


create table lives_plataformas(
    live integer references lives(codigo),
    plataforma integer references plataformas(codigo),
    url text not null,
    primary key (live, plataforma)
);


-- insert de 10 artistas, 8 com genero, 2 sem genero
insert into artistas (codigo, nome, genero)
VALUES (1, 'ana e vitoria', null),
       (2, 'Rihanna', 'Pop'),
       (3, 'Duo lipa', 'Pop'),
       (4, 'Imagine dragons', 'Rock'),
       (5, 'Maroon 5', 'Pop/Rock'),
       (6, 'Ed Sheeran', 'Indie'),
       (7, 'Coldplay', 'Pop/Rock'),
       (8, 'Eminem', 'Rap'),
       (9, 'Billie Eilish', null),
       (10, 'Lady Gaga', 'Pop');


-- insert de 4 plataformas
insert into plataformas(codigo, nome)
VALUES (1, 'Youtube'),
       (2, 'Instagram'),
       (3, 'Site oficial'),
       (4, 'Twitter');

-- insert de 6 lives
insert into lives(codigo, artista, data_hora) VALUES (1,3,'2020-08-15 17:45:00');
insert into lives(codigo, artista, data_hora) VALUES (2,2,'2020-07-30 22:00:00');
insert into lives(codigo, artista, data_hora) VALUES (3,5,'2020-06-20 22:00:00');
insert into lives(codigo, artista, data_hora) VALUES (4,10,'2020-06-09 22:00:00');
insert into lives(codigo, artista, data_hora) VALUES (5,9,'2020-06-15 22:00:00');
insert into lives(codigo, artista, data_hora) VALUES (6,4,'2020-07-15 22:00:00');

-- violacao de constraint de data_hora
insert into lives(codigo, artista, data_hora) VALUES (7,8,'2020-01-15 15:00:00');


-- insert de 8 lives_plataformas
insert into lives_plataformas(live, plataforma, url) VALUES (1,1,'www.youtube.com.br/1');
insert into lives_plataformas(live, plataforma, url) VALUES (1,2,'www.instagram.com.br/2');
insert into lives_plataformas(live, plataforma, url) VALUES (2,2,'www.instagram.com.br/2');
insert into lives_plataformas(live, plataforma, url) VALUES (3,4,'www.twitter.com.br/3');
insert into lives_plataformas(live, plataforma, url) VALUES (4,3,'www.siteoficial.com.br/4');
insert into lives_plataformas(live, plataforma, url) VALUES (5,2,'www.instagram.com.br/5');
insert into lives_plataformas(live, plataforma, url) VALUES (6,2,'www.instagram.com.br/6');
insert into lives_plataformas(live, plataforma, url) VALUES (5,1,'www.youtube.com.br/5');


-- selects
select * from lives_plataformas;
select * from artistas;
select * from lives;
select current_timestamp;


-- sessao de drop/truncate

drop database agenda_de_lives;

drop table plataformas;
truncate table plataformas cascade ;
drop table artistas;
truncate table artistas cascade;
drop table lives;
truncate table lives cascade ;
drop table lives_plataformas;
truncate table lives_plataformas cascade ;