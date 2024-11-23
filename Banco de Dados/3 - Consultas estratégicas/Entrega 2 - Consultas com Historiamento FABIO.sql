--Fábio

--Variação de vendas pelo dia da semana.
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
        hVendas

    UNION ALL

    SELECT 
        vnd_dia_semana AS dia_da_semana,
        vnd_preco AS preco
    FROM 
        Vendas
) vendas_comb
GROUP BY 
    dia_da_semana
ORDER BY 
    rank_vendas;


--Desempenho dos vendedores ao longo dos meses, e mostrando a diferença média do preço pelo mmr

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
        hVendas hv
    JOIN 
        vendedores vdr ON hv.hvnd_vdr_id = vdr.vdr_id

    UNION ALL

    SELECT 
        vdr.vdr_nome AS vendedor,
        TO_CHAR(v.vnd_data, 'YYYY-MM') AS mes_ano,
        v.vnd_preco AS preco,
        v.vnd_mmr AS mmr
    FROM 
        Vendas v
    JOIN 
        vendedores vdr ON v.vnd_vdr_id = vdr.vdr_id
) vendas_comb
GROUP BY 
    vendedor, mes_ano
ORDER BY 
    mes_ano, total_vendas DESC;
 