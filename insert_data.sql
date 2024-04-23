-- заполняем_исполнитель
insert into singer (name) values 
    ('Vovan'),
    ('Gosha'),
    ('Voi'),
    ('Muh'),
    ('Olivye'),
    ('Mull'),
    ('Guse'),
    ('Stella'),
    ('Son of sun');

-- заполняем_жанр
insert into genre (name) values 
    ('Pop'),
    ('Gop'),
    ('Top'),
    ('Mop'),
    ('Oop');  

-- заполняем_альбом
insert into album (name, year_of_issue)  values 
    ('Chill', '2022-01-22'),
    ('MeaL', '2021-08-13'),
    ('Milk', '2020-03-01'),
    ('Gem', '2021-06-26'),
    ('Song', '2019-11-03'),
    ('Summer', '2022-04-22'),
    ('Hell', '2017-06-11'),
    ('Road', '2018-09-06'),
    ('Sword', '2021-08-13');  

-- заполняем_трек
insert into track (name, duration, id_album) values 
    ('Chill', '00:03:33', (select id from album where name = 'Chill')),
    ('MeaL', '00:02:21', (select id from album where name = 'MeaL')),
    ('Milk','00:2:35', (select id from album where name = 'Milk')),
    ('Gem', '00:09:01', (select id from album where name = 'Gem')),
    ('Song', '00:1:57', (select id from album where name = 'Song')),
    ('Summer', '00:02:33', (select id from album where name = 'Summer')),
    ('Hell', '00:05:24', (select id from album where name = 'Hell')),
    ('Road', '00:3:07', (select id from album where name = 'Road')),
    ('Sword', '00:3:17', (select id from album where name = 'Sword')),
    ('Out', '00:03:33', (select id from album where name = 'Chill')),
    ('From', '00:02:21', (select id from album where name = 'MeaL')),
    ('River Of','00:2:35', (select id from album where name = 'Milk')),
    ('Loght', '00:09:01', (select id from album where name = 'Gem')),
    ('Time', '00:1:57', (select id from album where name = 'Song')),
    ('Tree', '00:02:33', (select id from album where name = 'Summer')),
    ('Fire', '00:05:24', (select id from album where name = 'Hell')),
    ('Driver', '00:3:07', (select id from album where name = 'Road')),
    ('My Ass', '09:3:07', (select id from album where name = 'Hell')),
    ('Not for all', '00:11:37', (select id from album where name = 'Hell'));

-- заполняем_сборник
insert into collection (name, year_of_issue) values 
    ('All', '2020-11-20'),
    ('CallMe', '2022-11-20'),
    ('OffSide','2022-11-21'),
    ('Safe', '2020-11-21'),
    ('Fate', '2020-11-22'),
    ('TooBad', '2022-11-22'),
    ('JustDanse', '2021-11-23'),
    ('Clock', '2021-11-24');   

-- заполняем_жанр_исполнитель
insert into genre_singer (genre_id, singer_id) values 
    ((select id from genre where name = 'Pop'), (select id from singer where name = 'Vovan')),   
    ((select id from genre where name = 'Gop'), (select id from singer where name = 'Gosha')),  
    ((select id from genre where name = 'Top'), (select id from singer where name = 'Voi')),
    ((select id from genre where name = 'Mop'), (select id from singer where name = 'Muh')),
    ((select id from genre where name = 'Gop'), (select id from singer where name = 'Olivye')),
    ((select id from genre where name = 'Pop'), (select id from singer where name = 'Mull')),  
    ((select id from genre where name = 'Top'), (select id from singer where name = 'Guse')),
    ((select id from genre where name = 'Oop'), (select id from singer where name = 'Stella')),
    ((select id from genre where name = 'Oop'), (select id from singer where name = 'Mull')),
    ((select id from genre where name = 'Gop'), (select id from singer where name = 'Guse')),
    ((select id from genre where name = 'Oop'), (select id from singer where name = 'Son of sun'));

-- заполняем_исполнитель_альбом
insert into singer_album (id_singer, id_album) values 
    ((select id from singer where name = 'Vovan'), (select id from album where name = 'Chill')),
    ((select id from singer where name = 'Gosha'), (select id from album where name = 'MeaL')),
    ((select id from singer where name = 'Voi'), (select id from album where name = 'Milk')),
    ((select id from singer where name = 'Muh'), (select id from album where name = 'Gem')),
    ((select id from singer where name = 'Olivye'), (select id from album where name = 'Song')),
    ((select id from singer where name = 'Mull'), (select id from album where name = 'Summer')),
    ((select id from singer where name = 'Guse'), (select id from album where name = 'Hell')),
    ((select id from singer where name = 'Stella'), (select id from album where name = 'Road')),
    ((select id from singer where name = 'Voi'), (select id from album where name = 'Sword')),
    ((select id from singer where name = 'Olivye'), (select id from album where name = 'Milk')),
    ((select id from singer where name = 'Vovan'), (select id from album where name = 'Summer')),
    ((select id from singer where name = 'Gosha'), (select id from album where name = 'Hell')),
    ((select id from singer where name = 'Son of sun'), (select id from album where name = 'Hell'));   

-- заполняем_сборник_трек
insert into collection_track (id_collection, id_track) values 
    ((select id from collection where name = 'All'), (select id from track where name = 'Chill')),
    ((select id from collection where name = 'CallMe'), (select id from track where name = 'MeaL')),
    ((select id from collection where name = 'OffSide'), (select id from track where name = 'Milk')),
    ((select id from collection where name = 'Safe'), (select id from track where name = 'Gem')),
    ((select id from collection where name = 'Fate'), (select id from track where name = 'Song')),
    ((select id from collection where name = 'TooBad'), (select id from track where name = 'Summer')),
    ((select id from collection where name = 'JustDanse'), (select id from track where name = 'Hell')),
    ((select id from collection where name = 'Clock'), (select id from track where name = 'Road')),
    ((select id from collection where name = 'OffSide'), (select id from track where name = 'Sword')),
    ((select id from collection where name = 'Fate'), (select id from track where name = 'Out')),
    ((select id from collection where name = 'All'), (select id from track where name = 'From')),
    ((select id from collection where name = 'CallMe'), (select id from track where name = 'River Of')),
    ((select id from collection where name = 'All'), (select id from track where name = 'Loght')),
    ((select id from collection where name = 'CallMe'), (select id from track where name = 'Time')),
    ((select id from collection where name = 'OffSide'), (select id from track where name = 'Tree')),
    ((select id from collection where name = 'Safe'), (select id from track where name = 'Fire')),
    ((select id from collection where name = 'All'), (select id from track where name = 'Driver')),
    ((select id from collection where name = 'CallMe'), (select id from track where name = 'My Ass')),
    ((select id from collection where name = 'OffSide'), (select id from track where name = 'Hell')),
    ((select id from collection where name = 'Safe'), (select id from track where name = 'Road')),
    ((select id from collection where name = 'OffSide'), (select id from track where name = 'MeaL')),
    ((select id from collection where name = 'Fate'), (select id from track where name = 'Milk')),
    ((select id from collection where name = 'All'), (select id from track where name = 'Gem')),
    ((select id from collection where name = 'CallMe'), (select id from track where name = 'Out'));   