LOAD DATA
INFILE 'sellers.csv'
INTO TABLE VENDEDORES
FIELDS TERMINATED BY ','
(
  vdr_id,
  vdr_nome
)
