LOAD DATA
INFILE 'models.csv'
APPEND INTO TABLE MODELOS
FIELDS TERMINATED BY ','
(
  mod_id,
  mod_mar_id,
  mod_nome,
  mod_trim,
  mod_body,
  mod_trs_id
)
