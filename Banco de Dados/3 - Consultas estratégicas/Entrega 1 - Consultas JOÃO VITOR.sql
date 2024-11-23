--Joao Vitor
– Total de vendas por quilometragem

SELECT
      case
            when carros.car_odometro < 50000 then 'Menos de 50.000 km'
            when carros.car_odometro between 50000 and 100000 then '50.000 - 100.000'
            when carros.car_odometro between 100000 and 200000 then '100.000 - 200.000'
	when carros.car_odometro between 200000 and 500000 then '200.000 - 500.000'
        else 'Acima de 500.000'
    end "Quilometragem",
    COUNT(*) AS "Total de Vendas"


FROM vendas
JOIN carros ON vendas.vnd_car_id = carros.car_id


GROUP BY 
    case
        when carros.car_odometro < 50000 then 'Menos de 50.000 km'
        when carros.car_odometro between 50000 and 100000 then '50.000 - 100.000'
        when carros.car_odometro between 100000 and 200000 then '100.000 - 200.000'
        when carros.car_odometro between 200000 and 500000 then '200.000 - 500.000'
     else 'Acima de 500.000'
   end  
    
order by "Total de Vendas" desc;


– Total de vendas por marca e modelo
SELECT
    modelos.mod_marca AS Marca,
    modelos.mod_nome AS Modelo,
    COUNT(*) AS "Total de Vendas"

FROM modelos

GROUP BY modelos.mod_marca, modelos.mod_nome

HAVING
	COUNT(*) = (
        SELECT  
            MAX(vendas)
        FROM (
            SELECT
                modelos.mod_marca AS Marca,
                modelos.mod_nome AS Modelo,
                COUNT(*) AS vendas
               
            FROM modelos

            GROUP BY modelos.mod_marca, modelos.mod_nome
        ) subquery
        WHERE subquery.marca = modelos.mod_marca
        GROUP BY subquery.marca
    )
ORDER BY "Total de Vendas" desc;