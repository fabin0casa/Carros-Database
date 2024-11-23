-- JOÃO VITOR

-- Total de vendas por modelo

SELECT
    marcas.mar_nome AS Marca,
    modelos.mod_nome AS Modelo,
    COUNT(vendas_union.vnd_car_id) AS Total_de_Vendas
FROM (
    SELECT vnd_car_id FROM vendas
    UNION ALL
    SELECT hvnd_car_id FROM hVendas
) vendas_union
JOIN carros ON vendas_union.vnd_car_id = carros.car_id
JOIN modelos ON carros.car_mod_id = modelos.mod_id
JOIN marcas ON modelos.mod_mar_id = marcas.mar_id
GROUP BY marcas.mar_nome, modelos.mod_nome
HAVING COUNT(vendas_union.vnd_car_id) = (
    SELECT MAX(vendas_count)
    FROM (
        SELECT
            marcas.mar_nome AS Marca,
            modelos.mod_nome AS Modelo,
            COUNT(vendas_union.vnd_car_id) AS vendas_count
        FROM (
            SELECT vnd_car_id FROM vendas
            UNION ALL
            SELECT hvnd_car_id FROM hVendas
        ) vendas_union
        JOIN carros ON vendas_union.vnd_car_id = carros.car_id
        JOIN modelos ON carros.car_mod_id = modelos.mod_id
        JOIN marcas ON modelos.mod_mar_id = marcas.mar_id
        GROUP BY marcas.mar_nome, modelos.mod_nome
    ) subquery
    WHERE subquery.Marca = marcas.mar_nome
    GROUP BY subquery.Marca
)
ORDER BY Total_de_Vendas DESC;

-- Total de vendas por quilometragem

SELECT
    CASE
        WHEN carros.car_odometro < 50000 THEN 'Menos de 50.000 km'
        WHEN carros.car_odometro BETWEEN 50000 AND 100000 THEN '50.000 - 100.000'
        WHEN carros.car_odometro BETWEEN 100000 AND 200000 THEN '100.000 - 200.000'
        WHEN carros.car_odometro BETWEEN 200000 AND 500000 THEN '200.000 - 500.000'
        ELSE 'Acima de 500.000'
    END AS Quilometragem,
    COUNT(*) AS Total_de_Vendas
FROM (
    SELECT vnd_car_id FROM vendas
    UNION ALL
    SELECT hvnd_car_id FROM hVendas
) vendas_union
JOIN carros ON vendas_union.vnd_car_id = carros.car_id
GROUP BY
    CASE
        WHEN carros.car_odometro < 50000 THEN 'Menos de 50.000 km'
        WHEN carros.car_odometro BETWEEN 50000 AND 100000 THEN '50.000 - 100.000'
        WHEN carros.car_odometro BETWEEN 100000 AND 200000 THEN '100.000 - 200.000'
        WHEN carros.car_odometro BETWEEN 200000 AND 500000 THEN '200.000 - 500.000'
        ELSE 'Acima de 500.000'
    END
ORDER BY Total_de_Vendas DESC;