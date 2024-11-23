--Gabriela
--Análise de vendas por carro e vendedor

SELECT
    c.car_condicao AS condicao_carro,
    m.mod_nome AS modelo_carro,
    ce.cor_nome AS cor_exterior,
    COUNT(v.vnd_id) AS total_vendas,
    SUM(v.vnd_preco) AS total_revenue,
    AVG(v.vnd_preco) AS preco_medio
FROM
    carros c
    INNER JOIN vendas v ON c.car_id = v.vnd_car_id
    INNER JOIN modelos m ON c.car_mod_id = m.mod_id
    INNER JOIN cores ce ON c.car_cor_id_ext = ce.cor_id
GROUP BY
    c.car_condicao,
    m.mod_nome,
    ce.cor_nome
HAVING
    COUNT(v.vnd_id) > 10 -- Apenas para modelos e cores com mais de 10 vendas
ORDER BY
    condicao_carro,
    total_revenue DESC;



--Análise de cores e modelos em função da condição do carro

SELECT
    EXTRACT(YEAR FROM v.vnd_data) AS ano_venda,
    vdr.vdr_nome AS nome_vendedor,
    m.mod_nome AS modelo_carro,
    COUNT(v.vnd_id) AS total_vendas,
    SUM(v.vnd_preco) AS total_revenue,
    AVG(v.vnd_preco) AS preco_medio
FROM
    vendas v
    INNER JOIN carros c ON v.vnd_car_id = c.car_id
    INNER JOIN modelos m ON c.car_mod_id = m.mod_id
    INNER JOIN vendedores vdr ON v.vnd_vdr_id = vdr.vdr_id
GROUP BY
    EXTRACT(YEAR FROM v.vnd_data),
    vdr.vdr_nome,
    m.mod_nome
HAVING
    COUNT(v.vnd_id) > 5 -- Apenas vendedores e modelos com mais de 5 vendas
ORDER BY
    ano_venda DESC,
    total_revenue DESC;