-- This file will create a basic database for local development
-- and populate it with a few paints and alternatives.
-- See README on how to run it

create table paints (id serial PRIMARY KEY,
    name text,
    brand text,
    price numeric,
    hex text
);

insert into paints(name, brand, price, hex) values('Eshin Grey', 'Citadel', 3.50, '#535659');
insert into paints(name, brand, price, hex) values('Cold Grey', 'Vallejo Game Color', 3.50, '#54646d');
insert into paints(name, brand, price, hex) values('Grey Green', 'Vallejo Model Color', 3.50, '#565a60');


create table paint_to_paint_rel(id serial PRIMARY KEY,
    paint_id int,
    alt_paint_id int
);

alter table paint_to_paint_rel
	add foreign KEY(alt_paint_id)
	references paints(id);
	
insert into paint_to_paint_rel(paint_id, alt_paint_id) values(1,2);
insert into paint_to_paint_rel(paint_id, alt_paint_id) values(1,3);



-- Use below query to get brand alternatives
-- 
-- select p.name, p.brand, p2."name" as altName, p2.brand as altBrand from paints p 
-- inner join paints p2 on p2.id in (
--  select ptpr.alt_paint_id from paint_to_paint_rel ptpr
--  where p.id = ptpr.paint_id 
-- )
-- where p.brand = 'Citadel'
