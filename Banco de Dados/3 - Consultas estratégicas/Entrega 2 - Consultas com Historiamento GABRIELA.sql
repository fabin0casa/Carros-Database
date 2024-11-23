-- GABI
    
-- Média dos preços de vendas ao longo do tempo, agrupado por marca, usando o histórico de vendas e o histórico de marcas.

SELECT 
    m.mar_nome, 
    ROUND(AVG(hv.hvnd_preco), 2) AS preco_medio, 
    EXTRACT(YEAR FROM hv.hvnd_dt_entrada) AS ano
FROM 
    hVendas hv
    JOIN carros c ON hv.hvnd_car_id = c.car_id
    JOIN modelos mo ON c.car_mod_id = mo.mod_id
    JOIN marcas m ON mo.mod_mar_id = m.mar_id
GROUP BY m.mar_nome, EXTRACT(YEAR FROM hv.hvnd_dt_entrada)
ORDER BY ano, m.mar_nome;

-- Exibe o número de vendas agrupadas por estado, comparando diferentes períodos históricos.

SELECT 
    hv.hvnd_estado, 
    COUNT(hv.hvnd_id) AS total_vendas, 
    EXTRACT(YEAR FROM hv.hvnd_dt_entrada) AS ano
FROM 
    hVendas hv
GROUP BY hv.hvnd_estado, EXTRACT(YEAR FROM hv.hvnd_dt_entrada)
ORDER BY ano, hv.hvnd_estado;
