use test_memory;
go

--Заполняем материаля
insert into materials (name, price, description)
values ('Кирпич', 25, 'цена за шт'),
('Плитка', 100, 'цена за шт'),
('Цемент', 70, 'цена за кг'),
('Песок', 50, 'цена за кг'),
('Арматура', 250, 'цена за шт');