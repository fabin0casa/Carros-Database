--Fabio
-- Taxa de crescimento ou decrescimento de vendas de carros de cada montadora de carro no último mês (adotando 28/02/2014 como data atual)
WITH vendas_mes_atual AS (
    SELECT
        ma.mar_nome AS montadora,
        COUNT(*) AS vendas_mes_atual
    FROM vendas v
    JOIN carros c ON v.vnd_car_id = c.car_id
    JOIN modelos m ON c.car_mod_id = m.mod_id
    JOIN marcas ma ON m.marca_mar_id = ma.mar_id
    WHERE
        v.vnd_data >= TRUNC(ADD_MONTHS(TO_DATE('28/02/2014', 'DD/MM/YYYY'), -1), 'MM')
    AND v.vnd_data < TRUNC(TO_DATE('28/02/2014', 'DD/MM/YYYY'), 'MM')
    GROUP BY ma.mar_nome
),


vendas_mes_anterior AS (
    SELECT
        ma.mar_nome AS montadora,
        COUNT(*) AS vendas_mes_anterior
    FROM vendas v
    JOIN carros c ON v.vnd_car_id = c.car_id
    JOIN modelos m ON c.car_mod_id = m.mod_id
    JOIN marcas ma ON m.marca_mar_id = ma.mar_id
    WHERE
        v.vnd_data >= TRUNC(ADD_MONTHS(TO_DATE('28/02/2014', 'DD/MM/YYYY'), -2), 'MM')
    AND v.vnd_data < TRUNC(ADD_MONTHS(TO_DATE('28/02/2014', 'DD/MM/YYYY'), -1), 'MM')
    GROUP BY ma.mar_nome
)


SELECT
    COALESCE(vendas_mes_atual.montadora, vendas_mes_anterior.montadora) AS montadora,
    COALESCE(vendas_mes_anterior.vendas_mes_anterior, 0) AS vendas_mes_anterior,
    COALESCE(vendas_mes_atual.vendas_mes_atual, 0) AS vendas_mes_atual,
    CASE
        WHEN COALESCE(vendas_mes_anterior.vendas_mes_anterior, 0) = 0 THEN
            CASE
                WHEN COALESCE(vendas_mes_atual.vendas_mes_atual, 0) = 0 THEN '0%'
                ELSE 'indefinido'
            END
        ELSE
            ROUND(
                ((COALESCE(vendas_mes_atual.vendas_mes_atual, 0) - COALESCE(vendas_mes_anterior.vendas_mes_anterior, 0)) * 100.0) /
                COALESCE(vendas_mes_anterior.vendas_mes_anterior, 1), 2
            ) || '%'
    END AS taxa_crescimento
FROM vendas_mes_atual
FULL OUTER JOIN
    vendas_mes_anterior ON vendas_mes_atual.montadora = vendas_mes_anterior.montadora
ORDER BY montadora;




-- Mostrar cada estado americano, e ao lado mostrar a montadora de carro que teve mais carros vendidos nas concessionárias no respectivo estado, de todos os tempos
SELECT
    vendas.vnd_estado AS estado,
    marcas.mar_nome AS montadora,
    COUNT(*) AS total_vendas

FROM vendas
JOIN carros ON vendas.vnd_car_id = carros.car_id
JOIN modelos ON carros.car_mod_id = modelos.mod_id
JOIN marcas ON modelos.marca_mar_id = marcas.mar_id

GROUP BY vendas.vnd_estado, marcas.mar_nome

HAVING
    COUNT(*) = (
        SELECT  
            MAX(vendas_count)
        FROM (
            SELECT
                vendas.vnd_estado,
                marcas.mar_nome,
                COUNT(*) AS vendas_count
               
            FROM vendas
            JOIN carros ON vendas.vnd_car_id = carros.car_id
            JOIN modelos ON carros.car_mod_id = modelos.mod_id
            JOIN marcas ON modelos.marca_mar_id = marcas.mar_id

            GROUP BY vendas.vnd_estado,
                    marcas.mar_nome
        ) subquery
        WHERE subquery.vnd_estado = vendas.vnd_estado
        GROUP BY subquery.vnd_estado
    )
ORDER BY estado;