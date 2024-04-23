-- просмотры таблиц 
   
select id, name from singer s ;
select id, name from genre g ;
select id, name, year_of_issue from album a ;
select id, name, duration, id_album from track t ;
select id, name, year_of_issue from collection c ;
select genre_id, singer_id from genre_singer gs  ;
select id_singer, id_album from singer_album sa ;
select id_collection, id_track from collection_track ct ;


-- пример очистка таблицы 
delete from genre_singer

-- осле очистки так сбрасывать id
    ALTER SEQUENCE collection_id_seq RESTART WITH 1;
    UPDATE collection SET id=nextval('collection_id_seq');

-- название и год выхода альбомов, вышедших в 2018 году
select name, year_of_issue from album 
where year_of_issue between '2018-01-01' and '2018-12-31';
-- название и продолжительность самого длительного трека
select name, duration from track 
where duration = (select max(duration) from track);
-- название треков, продолжительность которых не менее 3,5 минуты
select name from track 
where duration >= '00:03:30';
-- названия сборников, вышедших в период с 2018 по 2020 год включительно
select name from collection
where year_of_issue between '2018-01-01' and '2020-12-31';
-- исполнители, чье имя состоит из 1 слова
select name from singer 
where name not like '% %';
-- название треков, которые содержат слово “мой”/“my"
select name from track 
where lower(name) like '%my%' or lower(name) like '%мой%';

-- количество исполнителей в каждом жанре
select g.name, count(gs.singer_id) from genre_singer gs  
left join genre g on gs.genre_id = g.id  
group by g.name;
--повторяет предыдущий только с ключами
select gs.genre_id , count(gs.singer_id) from genre_singer gs 
group by gs.genre_id;
-- количество треков, вошедших в альбомы 2019-2020 годов
select count(t.id) from track t 
left join album a on t.id_album = a.id  
where a.year_of_issue between '2019-01-01' and '2020-12-31';
--средняя продолжительность треков по каждому альбому
select a.name, avg(t.duration) from track t  
left join album a  on t.id_album  = a.id  
group by a.name;
-- все исполнители, которые не выпустили альбомы в 2020 году
select s.name from singer_album sa 
join singer s on s.id = sa.id_singer 
join album a on a.id = sa.id_album 
where a.year_of_issue not between '2018-01-01' and '2018-12-31'
group by s.name;
--названия сборников, в которых присутствует конкретный исполнитель "Vovan"
select c.name from singer_album sa 
join singer s on s.id = sa.id_singer 
join album a on a.id = sa.id_album 
join track t  on t.id_album = a.id 
join collection_track ct on ct.id_track = t.id 
join collection c on c.id = ct.id_collection 
where s.name = 'Vovan'
group by c.name;
--название альбомов, в которых присутствуют исполнители более 1 жанра
select a.name, count(gs.genre_id) from singer_album sa 
join album a on a.id = sa.id_album 
join genre_singer gs  on gs.singer_id  = sa.id_singer 
group by a.name
having count(gs.genre_id) > 1;
-- наименование треков, которые не входят в сборники
select t.name from track t 
left join collection_track ct on ct.id_track  = t.id 
group by t.name
having count(ct.id_track) = 0;
--исполнителя(-ей), написавшего самый короткий по продолжительности трек 
select s.name from track t  
join album a on t.id_album = a.id
join singer_album sa on a.id = sa.id_album 
join singer s on s.id = sa.id_singer 
where t.duration = (select min(duration) from track)
group by s.name;
--название альбомов, содержащих наименьшее количество треков
select a.name, count(t.id_album)  from album a 
left join track t on t.id_album = a.id 
group by a.name 
order by count(t.id_album) asc
limit 1;
--удалить строки
delete from singer as s
where s.id > 9;