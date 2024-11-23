-- JOAO VITOR

CREATE MATERIALIZED VIEW mv_modelos AS
    WITH vendas_1p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_1p,
            ROUND(STATS_MODE(hv.hvnd_preco), 2) AS moda_preco_1p,
            ROUND(AVG(hv.hvnd_preco), 2) AS media_preco_1p,
            ROUND(MEDIAN(hv.hvnd_preco), 2) AS mediana_preco_1p,
            MIN(hv.hvnd_data) AS primeira_venda_1p,
            MAX(hv.hvnd_data) AS ultima_venda_1p
        FROM hVendas hv
        JOIN carros c ON hv.hvnd_car_id = c.car_id
        JOIN modelos m ON c.car_mod_id = m.mod_id
        WHERE
            hv.hvnd_data >= TO_DATE('01/01/2014', 'DD/MM/YYYY')
            AND hv.hvnd_data < TO_DATE('01/08/2014', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    ),
    vendas_2p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_2p,
            ROUND(STATS_MODE(hv.hvnd_preco), 2) AS moda_preco_2p,
            ROUND(AVG(hv.hvnd_preco), 2) AS media_preco_2p,
            ROUND(MEDIAN(hv.hvnd_preco), 2) AS mediana_preco_2p,
            MIN(hv.hvnd_data) AS primeira_venda_2p,
            MAX(hv.hvnd_data) AS ultima_venda_2p
        FROM hVendas hv
        JOIN carros c ON hv.hvnd_car_id = c.car_id
        JOIN modelos m ON c.car_mod_id = m.mod_id
        WHERE
            hv.hvnd_data >= TO_DATE('01/08/2014', 'DD/MM/YYYY')
            AND hv.hvnd_data < TO_DATE('01/04/2015', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    ),
    vendas_3p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_3p,
            ROUND(STATS_MODE(v.vnd_preco), 2) AS moda_preco_3p,
            ROUND(AVG(v.vnd_preco), 2) AS media_preco_3p,
            ROUND(MEDIAN(v.vnd_preco), 2) AS mediana_preco_3p,
            MIN(v.vnd_data) AS primeira_venda_3p,
            MAX(v.vnd_data) AS ultima_venda_3p
        FROM vendas v
        JOIN carros c ON v.vnd_car_id = c.car_id
        JOIN modelos m ON c.car_mod_id = m.mod_id
        WHERE
            v.vnd_data >= TO_DATE('01/04/2015', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    )
    SELECT 
        m.mod_id,
        m.mod_nome,
        NVL(v1.vendas_1p, 0) AS vendas_1p,
        NVL(v1.moda_preco_1p, 0) AS moda_preco_1p,
        NVL(v1.media_preco_1p, 0) AS media_preco_1p,
        NVL(v1.mediana_preco_1p, 0) AS mediana_preco_1p,
        NVL(TO_CHAR(v1.primeira_venda_1p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_1p,
        NVL(TO_CHAR(v1.ultima_venda_1p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_1p,
        
        NVL(v2.vendas_2p, 0) AS vendas_2p,
        NVL(v2.moda_preco_2p, 0) AS moda_preco_2p,
        NVL(v2.media_preco_2p, 0) AS media_preco_2p,
        NVL(v2.mediana_preco_2p, 0) AS mediana_preco_2p,
        NVL(TO_CHAR(v2.primeira_venda_2p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_2p,
        NVL(TO_CHAR(v2.ultima_venda_2p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_2p,
        
        CASE 
            WHEN v1.media_preco_1p IS NOT NULL AND v2.media_preco_2p IS NOT NULL 
            THEN ROUND(((v2.media_preco_2p - v1.media_preco_1p) / v1.media_preco_1p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_media_preco_2p,
        
        NVL(v3.vendas_3p, 0) AS vendas_3p,
        NVL(v3.moda_preco_3p, 0) AS moda_preco_3p,
        NVL(v3.media_preco_3p, 0) AS media_preco_3p,
        NVL(v3.mediana_preco_3p, 0) AS mediana_preco_3p,
        NVL(TO_CHAR(v3.primeira_venda_3p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_3p,
        NVL(TO_CHAR(v3.ultima_venda_3p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_3p,
        
        CASE 
            WHEN v2.media_preco_2p IS NOT NULL AND v3.media_preco_3p IS NOT NULL 
            THEN ROUND(((v3.media_preco_3p - v2.media_preco_2p) / v2.media_preco_2p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_media_preco_3p,
        
        CASE 
            WHEN v1.media_preco_1p IS NOT NULL AND v3.media_preco_3p IS NOT NULL 
            THEN ROUND(((v3.media_preco_3p - v1.media_preco_1p) / v1.media_preco_1p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_total,
    
        NVL(v1.vendas_1p, 0) + NVL(v2.vendas_2p, 0) + NVL(v3.vendas_3p, 0) AS total_vendas
    FROM modelos m
    LEFT JOIN vendas_1p v1 ON m.mod_id = v1.mod_id
    LEFT JOIN vendas_2p v2 ON m.mod_id = v2.mod_id
    LEFT JOIN vendas_3p v3 ON m.mod_id = v3.mod_id;