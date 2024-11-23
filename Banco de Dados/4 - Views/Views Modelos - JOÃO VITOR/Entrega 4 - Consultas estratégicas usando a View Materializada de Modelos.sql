-- JOAO VITOR

-- 1 - Modelos com Maior Taxa de Crescimento Total da M�dia de Pre�o�por�Marca

SELECT 
    ma.mar_id AS marca_id,
    ma.mar_nome AS marca_nome,
    m.mod_id AS modelo_id,
    m.mod_nome AS modelo_nome,
    mv.taxa_crescimento_total AS taxa_crescimento_total,
    mv.media_preco_1p,
    mv.media_preco_3p
FROM mv_modelos mv
JOIN C##JOAO.modelos m ON mv.mod_id = m.mod_id
JOIN C##JOAO.marcas ma ON m.mod_mar_id = ma.mar_id
WHERE mv.taxa_crescimento_total IS NOT NULL
ORDER BY mv.media_preco_3p desc;

-- 2 - 100 Modelos com Mais Vendas e Taxas de Crescimento da M�dia�de�Pre�o

SELECT 
    mod_id,
    vendas_1p,
    vendas_2p,
    vendas_3p,
    total_vendas
FROM mv_modelos
ORDER BY total_vendas DESC
FETCH FIRST 100 ROWS ONLY;