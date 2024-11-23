-- GABRIELA

-- Consulta 1

SELECT 
    ano,
    estado,
    COUNT(venda_id) AS vendas_acima_mmr,
    ROUND(AVG(preco_venda), 2) AS preco_medio_acima_mmr
FROM 
    vendas_analise_materializada
WHERE 
    classificacao_preco = 'Acima do MMR'
GROUP BY 
    ano, estado
ORDER BY 
    ano, estado;


-- Consulta 2

SELECT 
    dia_semana,
    COUNT(venda_id) AS total_vendas,
    ROUND(AVG(preco_venda), 2) AS preco_medio_dia_semana,
    ROUND(AVG(diferenca_preco), 2) AS diferenca_preco_media
FROM 
    vendas_analise_materializada
GROUP BY 
    dia_semana
ORDER BY 
    total_vendas;