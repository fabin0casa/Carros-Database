-- JOAO SALVADOR 

create materialized view vendedores as
    select 
        vp.vendedor_nome "Nome do Vendedor",
        vp.vendas_p1 "Vendas 1P",
        vp.vendas_p2 "Vendas 2P",
        vp.vendas_p3 "Vendas 3P",
        d.primeira_venda "Primeira Venda",
        d.ultima_venda "�ltima Venda",
        c.nome_marca "Top Marca (Ult. 8 meses)",
        c.total_marcas "Total Marcas (Ult. 8 meses)",
        c.nome_modelo "Top Modelo (Ult. 8 meses)",
        c.total_modelos "Total Modelos (Ult. 8 meses)",
        c.maior_ano "Carro Mais Novo Vendido (Ult. 8 meses)",
        c.maior_quilometragem "Maior Quilom.(Ult. 8 meses)",
        c.menor_quilometragem "Menor Quilom.(Ult. 8 meses)",
        e.taxa_1p_2p "Taxa 1P - 2P",
        e.taxa_2p_3p "Taxa 2P - 3P",
        e.taxa_1p_3p "Taxa 1P - 3P",
        e.media_vendas "M�dia de Vendas",  
        e.total_vendas "Total de Vendas"
    from 
        vendas_por_periodo vp
        join datas d on d.vendedor_id = vp.vendedor_id
        join carros c on c.vendedor_id = vp.vendedor_id
        join estatisticas e on e.vendedor_id = vp.vendedor_id;