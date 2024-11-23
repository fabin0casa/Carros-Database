
-- TABELA CARROS

-- Sequence
create sequence car_sq nocache;

--Trigger
create trigger car_tg_sq
before insert on carros
for each row
begin
    :new.car_id := car_sq.nextval;
end;
/
-- TABELA CORES

-- Sequence
create sequence cor_sq nocache;

--Trigger
create trigger cor_tg_sq
before insert on cores
for each row
begin
    :new.cor_id := cor_sq.nextval;
end;
/

-- TABELA MODELOS

-- Sequence
create sequence mod_sq nocache;

--Trigger
create trigger mod_tg_sq
before insert on modelos
for each row
begin
    :new.mod_id := mod_sq.nextval;
end;
/

-- TABELA VENDAS

-- Sequence
create sequence vnd_sq nocache;

--Trigger
create trigger vnd_tg_sq
before insert on vendas
for each row
begin
    :new.vnd_id := vnd_sq.nextval;
end;
/

-- TABELA VENDEDORES

-- Sequence
create sequence vdr_sq nocache;

--Trigger
create trigger vdr_tg_sq
before insert on vendedores
for each row
begin
    :new.vdr_id := vdr_sq.nextval;
end;
/

-- TABELA MARCAS

-- Sequence
create sequence mar_sq nocache;

--Trigger
create trigger mar_tg_sq
before insert on marcas
for each row
begin
    :new.mar_id := mar_sq.nextval;
end;
/

-- TABELA TRANSMISSÔES

-- Sequence
create sequence trs_sq nocache;

--Trigger
create trigger trs_tg_sq
before insert on transmissoes
for each row
begin
    :new.trs_id := trs_sq.nextval;
end;
/

