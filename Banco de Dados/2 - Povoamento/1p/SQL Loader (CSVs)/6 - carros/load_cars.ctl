LOAD DATA
INFILE 'cars.csv'
INTO TABLE CARROS
FIELDS TERMINATED BY ','
(
  car_id,
  car_ano,
  car_mod_id,
  car_vin,
  car_condicao,
  car_odometro,
  car_cor_id_ext,
  car_cor_id_int 
)
