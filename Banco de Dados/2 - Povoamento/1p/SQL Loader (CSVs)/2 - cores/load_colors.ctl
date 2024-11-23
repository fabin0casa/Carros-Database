LOAD DATA
INFILE 'colors.csv'
INTO TABLE CORES
FIELDS TERMINATED BY ','
(
  cor_id,
  cor_nome
)
