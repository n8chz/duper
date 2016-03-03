create view unit-prices as
select gendesc, entities.name supplier, price/size/factor/100 unitprice
 from transaktions, entries, items, entities, units
 where entries.transaktion_id = transaktions.id
 and entries.item_id = items.id
 and transaktions.entity_id = entities.id
 and items.unit_id = units.id
 order by gendesc, unitprice;
