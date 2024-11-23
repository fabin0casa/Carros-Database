--FABIO

CREATE MATERIALIZED VIEW mv_marcas AS
SELECT 
    estatisticas_marcas.ranking_vendas,
    ma.mar_nome AS nome_marca,
    COALESCE(estatisticas_marcas.moda_preco, 0) AS moda_preco, 
    COALESCE(estatisticas_marcas.media_preco, 0) AS media_preco, 
    COALESCE(estatisticas_marcas.mediana_preco, 0) AS mediana_preco, 
    estatisticas_marcas.primeira_venda,
    estatisticas_marcas.ultima_venda,
    COALESCE(vendas_1p.lucro_bruto_1p, 0) AS lucro_bruto_1p, 
    COALESCE(vendas_2p.lucro_bruto_2p, 0) AS lucro_bruto_2p, 
    COALESCE(vendas_3p.lucro_bruto_3p, 0) AS lucro_bruto_3p, 
    COALESCE(vendas_1p.lucro_bruto_1p, 0) + COALESCE(vendas_2p.lucro_bruto_2p, 0) + COALESCE(vendas_3p.lucro_bruto_3p, 0) AS lucro_bruto_total, 
    COALESCE(vendas_1p.vendas_1p, 0) AS qtd_vendas_1p,
    COALESCE(vendas_2p.vendas_2p, 0) AS qtd_vendas_2p,
    COALESCE(vendas_3p.vendas_3p, 0) AS qtd_vendas_3p,
    COALESCE(vendas_1p.vendas_1p, 0) + COALESCE(vendas_2p.vendas_2p, 0) + COALESCE(vendas_3p.vendas_3p, 0) AS qtd_vendas_totais,
    CASE
        WHEN COALESCE(vendas_1p.vendas_1p, 0) = 0 THEN 'indefinido'
        ELSE ROUND(
            ((COALESCE(vendas_2p.vendas_2p, 0) - COALESCE(vendas_1p.vendas_1p, 0)) * 100.0) / COALESCE(vendas_1p.vendas_1p, 1), 2
        ) || '%' 
    END AS crescimento_1p_para_2p,
    CASE
        WHEN COALESCE(vendas_2p.vendas_2p, 0) = 0 THEN 'indefinido'
        ELSE ROUND(
            ((COALESCE(vendas_3p.vendas_3p, 0) - COALESCE(vendas_2p.vendas_2p, 0)) * 100.0) / COALESCE(vendas_2p.vendas_2p, 1), 2
        ) || '%' 
    END AS crescimento_2p_para_3p,
    estatisticas_marcas.estado_que_mais_vendeu
FROM 
    marcas ma
LEFT JOIN 
    vendas_1p ON vendas_1p.mar_id = ma.mar_id
LEFT JOIN 
    vendas_2p ON vendas_2p.mar_id = ma.mar_id
LEFT JOIN 
    vendas_3p ON vendas_3p.mar_id = ma.mar_id
LEFT JOIN 
    estatisticas_marcas ON estatisticas_marcas.mar_id = ma.mar_id
ORDER BY 
    estatisticas_marcas.ranking_vendas, ma.mar_nome;