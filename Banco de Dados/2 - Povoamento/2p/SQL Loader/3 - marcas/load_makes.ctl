LOAD DATA
INFILE 'makes.csv'
APPEND INTO TABLE marcas
FIELDS TERMINATED BY ','
(
  mar_id,
  mar_nome
)
