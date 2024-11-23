LOAD DATA
INFILE 'sales.csv'
REPLACE INTO TABLE VENDAS
FIELDS TERMINATED BY ','
(
  vnd_id,
  vnd_vdr_id,
  vnd_car_id,
  vnd_mmr,
  vnd_preco,
  vnd_estado,
  vnd_dia_semana,
  vnd_data DATE "DD-MM-YYYY HH24:MI:SS",
  vnd_fuso_horario,
  vnd_zona
)

