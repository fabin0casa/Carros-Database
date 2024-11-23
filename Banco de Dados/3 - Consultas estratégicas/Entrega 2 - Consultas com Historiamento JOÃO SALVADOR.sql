-- JOÃO SALVADOR NETO

-- Growth or decline rate of vehicle sales by brand

with 
    veiculos_historico as (
        
        select 
            ma.mar_id id_mar_historico, 
            ma.mar_nome "Marca Historico", 
            count(hvnd_id) "Total de Vendas Historico" 
        from 
            hvendas hv
            full join carros c on c.car_id = hv.hvnd_car_id
            full join modelos m on c.car_mod_id = m.mod_id
            full join marcas ma on ma.mar_id = m.mod_mar_id
        where 
            hv.hvnd_data between to_date('01/08/2014', 'DD/MM/YYYY') and to_date('01/04/2015', 'DD/MM/YYYY')
        group by 
            ma.mar_id, 
            ma.mar_nome
        
    ),
    
    veiculos_atual as (
    
        select 
            ma.mar_id id_mar_atual, 
            ma.mar_nome "Marca Corrente", 
            count(vnd_id) "Total de Venda Corrente" 
        from 
            vendas v
            full join carros c on c.car_id = v.vnd_car_id
            full join modelos m on c.car_mod_id = m.mod_id
            full join marcas ma on ma.mar_id = m.mod_mar_id
        group by 
            ma.mar_id, 
            ma.mar_nome
        
        
    )
    
select 
    nvl(vh."Marca Historico", 'sem marca') "Marcas 2P", 
    nvl(vh."Total de Vendas Historico", 0) "Total de Vendas 2P",  
    va."Marca Corrente",
    va."Total de Venda Corrente",
    to_char(nvl(ROUND(((va."Total de Venda Corrente" - vh."Total de Vendas Historico") / vh."Total de Vendas Historico") * 100, 0), 0), '999') || '%' "Taxas"
from 
    veiculos_atual va
    full join veiculos_historico vh on va.id_mar_atual = vh.id_mar_historico
order by 
    va."Total de Venda Corrente" desc;

-- Sales analysis of sellers from the first period to the current period

with 

    vendedores_p1 as (
    
        select 
            vdr.vdr_nome "Vendedores 1P", 
            count(vdr.vdr_id) "Total de Vendas 1P" 
        from vendedores vdr
            join hvendas hvnd on hvnd.hvnd_vdr_id = vdr.vdr_id
        where 
            hvnd.hvnd_data between to_date('01/01/2014', 'DD/MM/YYYY') and to_date('01/08/2014', 'DD/MM/YYYY')
        group by 
            vdr.vdr_nome
    ),
    
    vendedores_corrente as (
    
        select 
            vdr.vdr_nome "Nome Corrente", 
            count(vdr.vdr_id) "Total de Vendas Corrente" 
        from 
            vendedores vdr
            join vendas vnd on vnd.vnd_vdr_id = vdr.vdr_id
        group by 
            vdr.vdr_nome
    
    )
    
select
    vp1."Vendedores 1P",
    vp1."Total de Vendas 1P",
    vc."Total de Vendas Corrente",
    to_char(ROUND(((vc."Total de Vendas Corrente" - vp1."Total de Vendas 1P") / vp1."Total de Vendas 1P") * 100, 0), '999999') || '%' "Taxas"
from 
    vendedores_p1 vp1
    join vendedores_corrente vc on vc."Nome Corrente" = vp1."Vendedores 1P"
order by 
    vc."Total de Vendas Corrente" desc;