LOAD DATA
INFILE 'makes.csv'
INTO TABLE marcas
FIELDS TERMINATED BY ','
(
  mar_id,
  mar_nome
)
