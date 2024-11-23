--FABIO

-- Consulta 1

SELECT 
    nome_marca,
    crescimento_1p_para_2p AS crescimento_vendas_1p_2p,
    crescimento_2p_para_3p AS crescimento_vendas_2p_3p,
    qtd_vendas_totais,
    lucro_bruto_total
FROM 
    mv_marcas
WHERE 
    crescimento_1p_para_2p != 'indefinido' AND crescimento_2p_para_3p != 'indefinido'
ORDER BY 
    crescimento_1p_para_2p DESC,
    crescimento_2p_para_3p DESC;
  
-- Consulta 2  
  
SELECT 
    nome_marca,
    lucro_bruto_1p,
    lucro_bruto_2p,
    lucro_bruto_3p,
    lucro_bruto_total,
    qtd_vendas_totais,
    media_preco AS preco_medio,
    estado_que_mais_vendeu
FROM 
    mv_marcas
ORDER BY 
    lucro_bruto_total DESC;