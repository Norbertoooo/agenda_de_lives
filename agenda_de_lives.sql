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



-- O nome e gênero dos artistas, a data/hora da live e a URL das lives em que o código do artista seja diferente de 1 (um)

select 
      artistas.nome, artistas.genero , lives.data_hora, lives_plataformas.url 
from 
      artistas, lives, lives_plataformas 
where 
     (artistas.codigo = lives.artista) 
     and (lives.codigo = lives_plataformas.live ) 
     and (artistas.codigo <> 1)



-- O nome do artista, a data/hora da live, o nome da plataforma e a URL das próximas 3 lives (apenas lives futuras)

select 
      artistas.nome, lives.data_hora, plataformas.nome, lives_plataformas.url 
from 
      artistas, lives, lives_plataformas, plataformas 
where 
      (artistas.codigo = lives.artista) 
	and (lives.codigo = lives_plataformas.live ) 
	and (plataformas.codigo = lives_plataformas.live )
	and (current_timestamp < lives.data_hora) 
limit 3


--O nome e gênero dos artistas que não tem lives cadastradas

select 
      artistas.nome,  artistas.genero 
from 
	artistas
	  
where 
      artistas.codigo not in (
	  select
	  	artistas.codigo
	  from 
	      artistas, lives 
	  where 
	      artistas.codigo = lives.artista
	  )
	  


--O nome do artista, a data/hora da live e a URL das lives de gênero “Rock”

select 
      artistas.nome, lives.data_hora, lives_plataformas.url 
from 
	artistas, lives, lives_plataformas 
where 
      (artistas.codigo = lives.artista) 
	and (lives.codigo = lives_plataformas.live ) 
	and (artistas.genero = 'Rock')


--agendadas para a semana de “04/05/2020” a “10/05/2020”, ordenados por data/hora

select 
      artistas.nome, lives.data_hora, lives_plataformas.url 
from 
	artistas, lives, lives_plataformas 
where 
      (artistas.codigo = lives.artista) 
	and (lives.data_hora >='2020-05-04 00:00:00'  and lives.data_hora <= '2020-05-10 23:59:59')
	and (lives.codigo = lives_plataformas.live ) 
order by  
      lives.data_hora

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