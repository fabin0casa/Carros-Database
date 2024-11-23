-- JOAO SALVADOR 

-- 1 - Analise dos vendedores por periodo

select 
    v."Nome do Vendedor",
    v."Vendas 1P",
    v."Vendas 2P",
    v."Vendas 3P",
    v."Taxa 1P - 2P",
    v."Taxa 2P - 3P",
    v."Taxa 1P - 3P",
    v."M�dia de Vendas"
from
    vendedores v
where
    v."Vendas 1P" != 0
order by
    v."Vendas 3P" desc;
    
-- 2 - Marcas e modelos mais vendidos por cada vendedor

select
    v."Nome do Vendedor",
    v."Top Modelo (Ult. 8 meses)",
    v."Total Modelos (Ult. 8 meses)",
    v."Top Marca (Ult. 8 meses)",
    v."Total Marcas (Ult. 8 meses)",
    v."Total de Vendas"

from
    vendedores v
order by
    v."Total de Vendas" desc;