--Joao Salvador
-- Top 100 vendedores que mais venderam

select * from (

    select vdr_nome "Nome do Vendedor", count(*) "Total de Vendas" from vendedores vdr 
    join vendas vnd on vdr_id = vnd_vdr_id
    group by vdr_nome 
    order by "Total de Vendas" desc
    
) where rownum <= 100;

-- Total de vendas por faixa de preço

select 
    case
        when vnd_preco < 20000 then 'Menos de $20,000.00'
        when vnd_preco  between 20000 and 50000 then '$20,000.00 - $50,000.00'
        when vnd_preco between 50000 and 100000 then '50,000.00 - 100,000.00'
        else 'Acima de $100,000.00'
    end "Faixa de Preço",
    count(*) "Total de Vendas"
from vendas 
group by 
    case
        when vnd_preco < 20000 then 'Menos de $20,000.00'
        when vnd_preco  between 20000 and 50000 then '$20,000.00 - $50,000.00'
        when vnd_preco between 50000 and 100000 then '50,000.00 - 100,000.00'
        else 'Acima de $100,000.00'
    end 
order by "Total de Vendas" desc;