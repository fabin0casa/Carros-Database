-- JOÃO SALVADOR NETO

-- Growth or decline rate of vehicle sales by brand

create view joao_salvador_q1 as 
    with 
        veiculos_historico as (
            
            select 
                ma.mar_id id_mar_historico, 
                ma.mar_nome "Marca Historico", 
                count(hvnd_id) "Total de Vendas Historico" 
            from 
                C##JOAO.hvendas hv
                full join C##JOAO.carros c on c.car_id = hv.hvnd_car_id
                full join C##JOAO.modelos m on c.car_mod_id = m.mod_id
                full join C##JOAO.marcas ma on ma.mar_id = m.mod_mar_id
            where 
                hv.hvnd_data between to_date('01/08/2014', 'DD/MM/YYYY') and to_date('01/04/2015', 'DD/MM/YYYY')
            group by 
                ma.mar_id, 
                ma.mar_nome
            
        ),
        
        veiculos_atual as (
        
            select 
                ma.mar_id id_mar_atual, 
                ma.mar_nome "Marca Corrente", 
                count(vnd_id) "Total de Venda Corrente" 
            from 
                C##JOAO.vendas v
                full join C##JOAO.carros c on c.car_id = v.vnd_car_id
                full join C##JOAO.modelos m on c.car_mod_id = m.mod_id
                full join C##JOAO.marcas ma on ma.mar_id = m.mod_mar_id
            group by 
                ma.mar_id, 
                ma.mar_nome
            
            
        )
        
    select 
        nvl(vh."Marca Historico", 'sem marca') "Marcas 2P", 
        nvl(vh."Total de Vendas Historico", 0) "Total de Vendas 2P",  
        va."Marca Corrente",
        va."Total de Venda Corrente",
        to_char(nvl(ROUND(((va."Total de Venda Corrente" - vh."Total de Vendas Historico") / vh."Total de Vendas Historico") * 100, 0), 0), '999') || '%' "Taxas"
    from 
        veiculos_atual va
        full join veiculos_historico vh on va.id_mar_atual = vh.id_mar_historico
    order by 
        va."Total de Venda Corrente" desc;

-- Sales analysis of sellers from the first period to the current period

create view joao_salvador_q2 as 
    with 
    
        vendedores_p1 as (
        
            select 
                vdr.vdr_nome "Vendedores 1P", 
                count(vdr.vdr_id) "Total de Vendas 1P" 
            from C##JOAO.vendedores vdr
                join C##JOAO.hvendas hvnd on hvnd.hvnd_vdr_id = vdr.vdr_id
            where 
                hvnd.hvnd_data between to_date('01/01/2014', 'DD/MM/YYYY') and to_date('01/08/2014', 'DD/MM/YYYY')
            group by 
                vdr.vdr_nome
        ),
        
        vendedores_corrente as (
        
            select 
                vdr.vdr_nome "Nome Corrente", 
                count(vdr.vdr_id) "Total de Vendas Corrente" 
            from 
                C##JOAO.vendedores vdr
                join C##JOAO.vendas vnd on vnd.vnd_vdr_id = vdr.vdr_id
            group by 
                vdr.vdr_nome
        
        )
        
    select
        vp1."Vendedores 1P",
        vp1."Total de Vendas 1P",
        vc."Total de Vendas Corrente",
        to_char(ROUND(((vc."Total de Vendas Corrente" - vp1."Total de Vendas 1P") / vp1."Total de Vendas 1P") * 100, 0), '999999') || '%' "Taxas"
    from 
        vendedores_p1 vp1
        join vendedores_corrente vc on vc."Nome Corrente" = vp1."Vendedores 1P"
    order by 
        vc."Total de Vendas Corrente" desc;
        

--Fábio

--Variação de vendas pelo dia da semana.

create view fabio_q1 as

    SELECT 
        dia_da_semana,
        COUNT(*) AS total_vendas,
        ROUND(AVG(preco), 2) AS preco_medio,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_vendas
    FROM (
        SELECT 
            hvnd_dia_semana AS dia_da_semana,
            hvnd_preco AS preco
        FROM 
            C##JOAO.hVendas
    
        UNION ALL
    
        SELECT 
            vnd_dia_semana AS dia_da_semana,
            vnd_preco AS preco
        FROM 
            C##JOAO.Vendas
    ) vendas_comb
    GROUP BY 
        dia_da_semana
    ORDER BY 
        rank_vendas;


--Desempenho dos vendedores ao longo dos meses, e mostrando a diferença média do preço pelo mmr

create view fabio_q2 as

    SELECT 
        vendedor,
        mes_ano,
        COUNT(*) AS total_vendas,
        ROUND(AVG(preco), 2) AS preco_medio,
        ROUND(AVG(preco - mmr), 2) AS diferenca_mmr_preco
    FROM (
        SELECT 
            vdr.vdr_nome AS vendedor,
            TO_CHAR(hv.hvnd_data, 'YYYY-MM') AS mes_ano,
            hv.hvnd_preco AS preco,
            hv.hvnd_mmr AS mmr
        FROM 
            C##JOAO.hVendas hv
        JOIN 
            C##JOAO.vendedores vdr ON hv.hvnd_vdr_id = vdr.vdr_id
    
        UNION ALL
    
        SELECT 
            vdr.vdr_nome AS vendedor,
            TO_CHAR(v.vnd_data, 'YYYY-MM') AS mes_ano,
            v.vnd_preco AS preco,
            v.vnd_mmr AS mmr
        FROM 
            C##JOAO.Vendas v
        JOIN 
            C##JOAO.vendedores vdr ON v.vnd_vdr_id = vdr.vdr_id
    ) vendas_comb
    GROUP BY 
        vendedor, mes_ano
    ORDER BY 
        mes_ano, total_vendas DESC;
        
        
-- GABI
    
-- Média dos preços de vendas ao longo do tempo, agrupado por marca, usando o histórico de vendas e o histórico de marcas.

create view gabriela_q1 as

    SELECT 
        m.mar_nome, 
        ROUND(AVG(hv.hvnd_preco), 2) AS preco_medio, 
        EXTRACT(YEAR FROM hv.hvnd_dt_entrada) AS ano
    FROM 
        C##JOAO.hVendas hv
        JOIN C##JOAO.carros c ON hv.hvnd_car_id = c.car_id
        JOIN C##JOAO.modelos mo ON c.car_mod_id = mo.mod_id
        JOIN C##JOAO.marcas m ON mo.mod_mar_id = m.mar_id
    GROUP BY m.mar_nome, EXTRACT(YEAR FROM hv.hvnd_dt_entrada)
    ORDER BY ano, m.mar_nome;

-- Exibe o número de vendas agrupadas por estado, comparando diferentes períodos históricos.

create view gabriela_q2 as 

    SELECT 
        hv.hvnd_estado, 
        COUNT(hv.hvnd_id) AS total_vendas, 
        EXTRACT(YEAR FROM hv.hvnd_dt_entrada) AS ano
    FROM 
        C##JOAO.hVendas hv
    GROUP BY hv.hvnd_estado, EXTRACT(YEAR FROM hv.hvnd_dt_entrada)
    ORDER BY ano, hv.hvnd_estado;
    
    
-- JOÃO VITOR

-- Total de vendas por modelo

create view joao_vitor_q1 as

    SELECT
        marcas.mar_nome AS Marca,
        modelos.mod_nome AS Modelo,
        COUNT(vendas_union.vnd_car_id) AS Total_de_Vendas
    FROM (
        SELECT vnd_car_id FROM C##JOAO.vendas
        UNION ALL
        SELECT hvnd_car_id FROM C##JOAO.hVendas
    ) vendas_union
    JOIN C##JOAO.carros ON vendas_union.vnd_car_id = carros.car_id
    JOIN C##JOAO.modelos ON carros.car_mod_id = modelos.mod_id
    JOIN C##JOAO.marcas ON modelos.mod_mar_id = marcas.mar_id
    GROUP BY marcas.mar_nome, modelos.mod_nome
    HAVING COUNT(vendas_union.vnd_car_id) = (
        SELECT MAX(vendas_count)
        FROM (
            SELECT
                marcas.mar_nome AS Marca,
                modelos.mod_nome AS Modelo,
                COUNT(vendas_union.vnd_car_id) AS vendas_count
            FROM (
                SELECT vnd_car_id FROM C##JOAO.vendas
                UNION ALL
                SELECT hvnd_car_id FROM C##JOAO.hVendas
            ) vendas_union
            JOIN C##JOAO.carros ON vendas_union.vnd_car_id = carros.car_id
            JOIN C##JOAO.modelos ON carros.car_mod_id = modelos.mod_id
            JOIN C##JOAO.marcas ON modelos.mod_mar_id = marcas.mar_id
            GROUP BY marcas.mar_nome, modelos.mod_nome
        ) subquery
        WHERE subquery.Marca = marcas.mar_nome
        GROUP BY subquery.Marca
    )
    ORDER BY Total_de_Vendas DESC;

-- Total de vendas por quilometragem

create view joao_vitor_q2 as

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
        SELECT vnd_car_id FROM C##JOAO.vendas
        UNION ALL
        SELECT hvnd_car_id FROM C##JOAO.hVendas
    ) vendas_union
    JOIN C##JOAO.carros ON vendas_union.vnd_car_id = carros.car_id
    GROUP BY
        CASE
            WHEN carros.car_odometro < 50000 THEN 'Menos de 50.000 km'
            WHEN carros.car_odometro BETWEEN 50000 AND 100000 THEN '50.000 - 100.000'
            WHEN carros.car_odometro BETWEEN 100000 AND 200000 THEN '100.000 - 200.000'
            WHEN carros.car_odometro BETWEEN 200000 AND 500000 THEN '200.000 - 500.000'
            ELSE 'Acima de 500.000'
        END
    ORDER BY Total_de_Vendas DESC;
