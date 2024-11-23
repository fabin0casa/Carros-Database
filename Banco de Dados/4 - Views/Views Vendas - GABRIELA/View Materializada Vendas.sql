-- GABRIELA

CREATE MATERIALIZED VIEW vendas_analise_materializada AS
    SELECT 
        -- Informa��es gerais da venda
        vnd_id AS venda_id,
        vnd_data AS data_venda,
        EXTRACT(YEAR FROM vnd_data) AS ano,
        EXTRACT(MONTH FROM vnd_data) AS mes,
        EXTRACT(DAY FROM vnd_data) AS dia,
        vnd_dia_semana AS dia_semana,
        
        -- Informa��es de localidade e tempo
        vnd_estado AS estado,
        vnd_zona AS zona,               -- Ex: hor�rio de ver�o ou n�o
        vnd_fuso_horario AS fuso_horario,
    
        -- Informa��es financeiras
        vnd_mmr AS valor_mercado,       -- Valor de mercado (MMR) do carro
        vnd_preco AS preco_venda,       -- Pre�o de venda real
        ROUND(vnd_preco - vnd_mmr, 2) AS diferenca_preco, -- Diferen�a entre pre�o de venda e valor de mercado
        
        -- M�tricas financeiras
        CASE 
            WHEN vnd_preco > vnd_mmr THEN 'Acima do MMR'
            WHEN vnd_preco < vnd_mmr THEN 'Abaixo do MMR'
            ELSE 'Igual ao MMR'
        END AS classificacao_preco,
        
        -- Resumo de estat�sticas de vendas
        COUNT(vnd_id) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data)) AS total_vendas_ano,
        COUNT(vnd_id) OVER(PARTITION BY vnd_estado) AS total_vendas_estado,
        COUNT(vnd_id) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data), vnd_estado) AS total_vendas_ano_estado,
        
        -- Estat�sticas de pre�o por ano e estado
        AVG(vnd_preco) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data)) AS preco_medio_ano,
        AVG(vnd_preco) OVER(PARTITION BY vnd_estado) AS preco_medio_estado,
        AVG(vnd_preco) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data), vnd_estado) AS preco_medio_ano_estado,
        
        -- Classifica��o por dia da semana para an�lise de padr�o
        COUNT(vnd_id) OVER(PARTITION BY vnd_dia_semana) AS total_vendas_dia_semana,
        AVG(vnd_preco) OVER(PARTITION BY vnd_dia_semana) AS preco_medio_dia_semana
    
    FROM 
        vendas
    
    ORDER BY 
        ano, 
        estado, 
        dia_semana;
        