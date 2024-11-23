--FABIO

CREATE VIEW vendas_1p AS
SELECT
    ma.mar_id,
    COUNT(*) AS vendas_1p,
    SUM(hv.hvnd_preco) AS lucro_bruto_1p
FROM hVendas hv
JOIN carros c ON hv.hvnd_car_id = c.car_id
JOIN modelos m ON c.car_mod_id = m.mod_id
JOIN marcas ma ON m.mod_mar_id = ma.mar_id
WHERE
    hv.hvnd_data >= TO_DATE('01/01/2014', 'DD/MM/YYYY')
    AND hv.hvnd_data < TO_DATE('01/08/2014', 'DD/MM/YYYY')
GROUP BY ma.mar_id;


CREATE VIEW vendas_2p AS
SELECT
    ma.mar_id,
    COUNT(*) AS vendas_2p,
    SUM(hv.hvnd_preco) AS lucro_bruto_2p
FROM hVendas hv
JOIN carros c ON hv.hvnd_car_id = c.car_id
JOIN modelos m ON c.car_mod_id = m.mod_id
JOIN marcas ma ON m.mod_mar_id = ma.mar_id
WHERE
    hv.hvnd_data >= TO_DATE('01/08/2014', 'DD/MM/YYYY')
    AND hv.hvnd_data < TO_DATE('01/04/2015', 'DD/MM/YYYY')
GROUP BY ma.mar_id;


CREATE VIEW vendas_3p AS
SELECT
    ma.mar_id,
    COUNT(*) AS vendas_3p,
    SUM(v.vnd_preco) AS lucro_bruto_3p
FROM vendas v
JOIN carros c ON v.vnd_car_id = c.car_id
JOIN modelos m ON c.car_mod_id = m.mod_id
JOIN marcas ma ON m.mod_mar_id = ma.mar_id
WHERE
    v.vnd_data >= TO_DATE('01/04/2015', 'DD/MM/YYYY')
GROUP BY ma.mar_id;


CREATE VIEW estatisticas_marcas AS
SELECT 
    ma.mar_id,
    ROUND(STATS_MODE(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS moda_preco,
    ROUND(AVG(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS media_preco,
    ROUND(MEDIAN(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS mediana_preco,
    MIN(hv.hvnd_data) AS primeira_venda,
    MAX(v.vnd_data) AS ultima_venda,
    RANK() OVER (ORDER BY COUNT(DISTINCT COALESCE(v.vnd_id, hv.hvnd_id)) DESC) AS ranking_vendas,
    (SELECT v.vnd_estado
     FROM vendas v
     JOIN carros c ON v.vnd_car_id = c.car_id
     JOIN modelos m ON c.car_mod_id = m.mod_id
     WHERE m.mod_mar_id = ma.mar_id
     GROUP BY v.vnd_estado
     ORDER BY COUNT(v.vnd_id) DESC
     FETCH FIRST 1 ROW ONLY) AS estado_que_mais_vendeu
FROM marcas ma
JOIN modelos m ON ma.mar_id = m.mod_mar_id
JOIN carros c ON m.mod_id = c.car_mod_id
LEFT JOIN vendas v ON c.car_id = v.vnd_car_id
LEFT JOIN hVendas hv ON c.car_id = hv.hvnd_car_id
GROUP BY ma.mar_id;