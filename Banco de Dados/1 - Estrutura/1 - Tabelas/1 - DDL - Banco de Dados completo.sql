-- Tabelas

CREATE TABLE carros ( 
    car_id         NUMBER(6) 
        CONSTRAINT ck_car_nn_01 NOT NULL, 
    car_vin        CHAR(17), 
    car_odometro   NUMBER(6), 
    car_condicao   NUMBER(2), 
    car_ano        NUMBER(4), 
    car_mod_id     NUMBER(6) 
        CONSTRAINT ck_car_nn_02 NOT NULL, 
    car_cor_id_ext NUMBER(6) 
        CONSTRAINT ck_car_nn_03 NOT NULL, 
    car_cor_id_int NUMBER(6) 
        CONSTRAINT ck_car_nn_04 NOT NULL 
);

CREATE TABLE cores ( 
    cor_id   NUMBER(6) 
        CONSTRAINT ck_cor_nn_01 NOT NULL, 
    cor_nome VARCHAR2(30) 
);

CREATE TABLE marcas ( 
    mar_id   NUMBER(6) 
        CONSTRAINT ck_mar_nn_01 NOT NULL, 
    mar_nome VARCHAR2(50) 
);

CREATE TABLE modelos ( 
    mod_id     NUMBER(6) 
        CONSTRAINT ck_mod_nn_01 NOT NULL, 
    mod_nome   VARCHAR2(50), 
    mod_body   VARCHAR2(50), 
    mod_trim   VARCHAR2(50), 
    mod_mar_id NUMBER(6) 
        CONSTRAINT ck_mod_nn_02 NOT NULL, 
    mod_trs_id NUMBER(6) 
        CONSTRAINT ck_mod_nn_03 NOT NULL
);

CREATE TABLE transmissoes ( 
    trs_id   NUMBER(6) 
        CONSTRAINT ck_trs_nn_01 NOT NULL, 
    trs_tipo VARCHAR2(10) 
);

CREATE TABLE vendas ( 
    vnd_id           NUMBER(6) 
        CONSTRAINT ck_vnd_nn_01 NOT NULL, 
    vnd_mmr          NUMBER(6), 
    vnd_preco        NUMBER(7), 
    vnd_dia_semana   VARCHAR2(10), 
    vnd_data         DATE, 
    vnd_fuso_horario VARCHAR2(10), 
    vnd_zona         CHAR(3), 
    vnd_estado       CHAR(2), 
    vnd_vdr_id       NUMBER(6) 
        CONSTRAINT ck_vnd_nn_02 NOT NULL, 
    vnd_car_id       NUMBER(6) 
        CONSTRAINT ck_vnd_nn_03 NOT NULL 
);

CREATE TABLE vendedores ( 
    vdr_id   NUMBER(6) 
        CONSTRAINT ck_vdr_nn_01 NOT NULL, 
    vdr_nome VARCHAR2(50) 
);

-- Chaves primárias

ALTER TABLE carros ADD CONSTRAINT pk_car PRIMARY KEY ( car_id );

ALTER TABLE cores ADD CONSTRAINT pk_cor PRIMARY KEY ( cor_id );

ALTER TABLE marcas ADD CONSTRAINT pk_mar PRIMARY KEY ( mar_id );

ALTER TABLE modelos ADD CONSTRAINT pk_mod PRIMARY KEY ( mod_id );

ALTER TABLE transmissoes ADD CONSTRAINT pk_trs PRIMARY KEY ( trs_id );

ALTER TABLE vendas ADD CONSTRAINT pk_vnd PRIMARY KEY ( vnd_id );

ALTER TABLE vendedores ADD CONSTRAINT pk_vdr PRIMARY KEY ( vdr_id );

-- Chaves estrangeiras

ALTER TABLE carros 
    ADD CONSTRAINT fk_car_cor_ext FOREIGN KEY ( car_cor_id_ext ) 
        REFERENCES cores ( cor_id );

ALTER TABLE carros 
    ADD CONSTRAINT fk_car_cor_int FOREIGN KEY ( car_cor_id_int ) 
        REFERENCES cores ( cor_id );

ALTER TABLE carros 
    ADD CONSTRAINT fk_car_mod FOREIGN KEY ( car_mod_id ) 
        REFERENCES modelos ( mod_id );

ALTER TABLE modelos 
    ADD CONSTRAINT fk_mod_mar FOREIGN KEY ( mod_mar_id ) 
        REFERENCES marcas ( mar_id );

ALTER TABLE modelos 
    ADD CONSTRAINT fk_mod_trs FOREIGN KEY ( mod_trs_id ) 
        REFERENCES transmissoes ( trs_id );

ALTER TABLE vendas 
    ADD CONSTRAINT fk_vnd_car FOREIGN KEY ( vnd_car_id ) 
        REFERENCES carros ( car_id );

ALTER TABLE vendas 
    ADD CONSTRAINT fk_vnd_vdr FOREIGN KEY ( vnd_vdr_id ) 
        REFERENCES vendedores ( vdr_id );

-- Comentários da tabela carros

COMMENT ON TABLE carros IS 
    'Tabela com todos os carros do banco';

COMMENT ON COLUMN carros.car_id IS 
    'Identificador único do carro';

COMMENT ON COLUMN carros.car_vin IS 
    'Identificador único de um veículo em especifico da vida real';

COMMENT ON COLUMN carros.car_odometro IS 
    'Quilometragem do carro';

COMMENT ON COLUMN carros.car_condicao IS 
    'Nível de condição do carro';

COMMENT ON COLUMN carros.car_ano IS 
    'Ano de fabricação do carro';

COMMENT ON COLUMN carros.car_mod_id IS 
    'Chave estrangeira do modelo do carro';

COMMENT ON COLUMN carros.car_cor_id_ext IS 
    'Chave estrangeira da cor exterior do carro';

COMMENT ON COLUMN carros.car_cor_id_int IS 
    'Chave estrangeira da cor interior do carro';


-- Comentários da tabela cores

COMMENT ON TABLE cores IS 
    'Tabela com as cores para o interior e exterior dos carros';

COMMENT ON COLUMN cores.cor_id IS 
    'Identificador único da cor do carro';

COMMENT ON COLUMN cores.cor_nome IS 
    'Cor interior do carro';

-- Comentários da tabela marcas

COMMENT ON TABLE marcas IS 
    'Tabela responsável por armazenar as marcas dos carros';

COMMENT ON COLUMN marcas.mar_id IS 
    'Identificador da Marca do carro';

COMMENT ON COLUMN marcas.mar_nome IS 
    'Nome da marca do carro';

-- Comentários da tabela modelos

COMMENT ON TABLE modelos IS 
    'Tabela referente aos modelos dos carros';

COMMENT ON COLUMN modelos.mod_id IS 
    'Identificador único do modelo do carro';

COMMENT ON COLUMN modelos.mod_nome IS 
    'Nome do modelo do carro';

COMMENT ON COLUMN modelos.mod_body IS 
    'Tipo de arquitetura do carro';

COMMENT ON COLUMN modelos.mod_trim IS 
    'Nível de acabamento do veículo';

COMMENT ON COLUMN modelos.mod_mar_id IS 
    'Chave estrangeira da tabela de marcas';

COMMENT ON COLUMN modelos.mod_trs_id IS 
    'Chave estrangeira da tabela de transmissões';

-- Comentários da tabela transmissões

COMMENT ON TABLE transmissoes IS 
    'Tabela com todas as transmissões possíveis para os veículos';

COMMENT ON COLUMN transmissoes.trs_id IS 
    'Identificador do Tipo de transmissão do carro';

COMMENT ON COLUMN transmissoes.trs_tipo IS 
    'Tipo de transmissão do carro';

-- Comentários da tabela vendas

COMMENT ON TABLE vendas IS 
    'Tabela com o registro de todas as vendas com os seus respectivos vendedores';

COMMENT ON COLUMN vendas.vnd_id IS 
    'Identificador único da venda';

COMMENT ON COLUMN vendas.vnd_mmr IS 
    'MMR do carro, o valor de mercado do carro';

COMMENT ON COLUMN vendas.vnd_preco IS 
    'Preço que o carro foi vendido';

COMMENT ON COLUMN vendas.vnd_dia_semana IS 
    'Dia da semana em que a venda foi feita';

COMMENT ON COLUMN vendas.vnd_data IS 
    'Data da venda';

COMMENT ON COLUMN vendas.vnd_fuso_horario IS 
    'Fuso horário do local em que a venda foi realizada';

COMMENT ON COLUMN vendas.vnd_zona IS 
    'Se a venda foi feita dentro do horário de verão ou não';

COMMENT ON COLUMN vendas.vnd_estado IS 
    'Estado americano de onde ocorreu a venda';

COMMENT ON COLUMN vendas.vnd_vdr_id IS 
    'Chave estrangeira do vendedor';

COMMENT ON COLUMN vendas.vnd_car_id IS 
    'Chave estrangeira do carro';

-- Comentários da tabela vendedores

COMMENT ON TABLE vendedores IS 
    'Tabela com todos os vendedores cadastrados';

COMMENT ON COLUMN vendedores.vdr_id IS 
    'Identificador único do vendedor';

COMMENT ON COLUMN vendedores.vdr_nome IS 
    'Nome do vendedor';

