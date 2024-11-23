LOAD DATA
INFILE 'transmissions.csv'
INTO TABLE transmissoes
FIELDS TERMINATED BY ','
(
  trs_id,
  trs_tipo
)
