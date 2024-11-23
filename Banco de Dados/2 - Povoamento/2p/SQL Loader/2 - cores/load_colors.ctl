LOAD DATA
INFILE 'colors.csv'
APPEND INTO TABLE CORES
FIELDS TERMINATED BY ','
(
  cor_id,
  cor_nome
)
