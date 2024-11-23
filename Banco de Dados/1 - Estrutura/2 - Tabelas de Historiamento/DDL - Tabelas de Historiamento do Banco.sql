
-- Tabela para o historiamento de CARROS

CREATE TABLE hcarros ( 
    hcar_id         NUMBER(6) 
        CONSTRAINT ck_hcar_nn_01 NOT NULL, 
    hcar_vin        CHAR(17), 
    hcar_odometro   NUMBER(6), 
    hcar_condicao   NUMBER(2), 
    hcar_ano        NUMBER(4), 
    hcar_mod_id     NUMBER(6) 
        CONSTRAINT ck_hcar_nn_02 NOT NULL, 
    hcar_cor_id_ext NUMBER(6) 
        CONSTRAINT ck_hcar_nn_03 NOT NULL, 
    hcar_cor_id_int NUMBER(6) 
        CONSTRAINT ck_hcar_nn_04 NOT NULL,
    hcar_dt_entrada date
);

ALTER TABLE hcarros ADD CONSTRAINT pk_hcar PRIMARY KEY (hcar_id, hcar_dt_entrada);

create trigger tr_hcar
before update or delete on carros
for each row
begin
    insert into hcarros 
    values (:old.car_id, 
            :old.car_vin, 
            :old.car_odometro, 
            :old.car_condicao,
            :old.car_ano, 
            :old.car_mod_id, 
            :old.car_cor_id_ext, 
            :old.car_cor_id_int, 
            sysdate);
end;
/


-- Tabela para o historiamento de CORES

CREATE TABLE hcores ( 
    hcor_id   NUMBER(6) 
        CONSTRAINT ck_hcor_nn_01 NOT NULL, 
    hcor_nome VARCHAR2(30),
    hcor_dt_entrada date
);

ALTER TABLE hcores ADD CONSTRAINT pk_hcor PRIMARY KEY (hcor_id, hcor_dt_entrada);

create trigger tr_hcor
before update or delete on cores
for each row
begin
    insert into hcores 
    values (:old.cor_id, 
            :old.cor_nome,  
            sysdate);
end;
/

-- Tabela para o historiamento de VENDAS

CREATE TABLE hVendas (
    hvnd_id            NUMBER(6) NOT NULL,  
    hvnd_mmr           NUMBER(6),           
    hvnd_preco         NUMBER(7),           
    hvnd_dia_semana    VARCHAR2(10),        
    hvnd_data          DATE,                
    hvnd_fuso_horario  VARCHAR2(10),        
    hvnd_zona          CHAR(3),             
    hvnd_estado        CHAR(2),             
    hvnd_vdr_id        NUMBER(6) NOT NULL,  
    hvnd_car_id        NUMBER(6) NOT NULL,  
    hvnd_dt_entrada     DATE NOT NULL        
);

ALTER TABLE hVendas ADD CONSTRAINT pk_hvnd PRIMARY KEY (hvnd_id, hvnd_dt_entrada);

CREATE TRIGGER tr_hvnd
BEFORE UPDATE OR DELETE ON vendas
FOR EACH ROW
BEGIN
    INSERT INTO hVendas (
        hvnd_id, hvnd_mmr, hvnd_preco, hvnd_dia_semana, hvnd_data,
        hvnd_fuso_horario, hvnd_zona, hvnd_estado, hvnd_vdr_id, hvnd_car_id, hvnd_dt_entrada
    )
    VALUES (
        :old.vnd_id, :old.vnd_mmr, :old.vnd_preco, :old.vnd_dia_semana, :old.vnd_data,
        :old.vnd_fuso_horario, :old.vnd_zona, :old.vnd_estado, :old.vnd_vdr_id, :old.vnd_car_id, 
        SYSDATE
    );
END;
/

-- Tabela para o historiamento de VENDEDORES

CREATE TABLE hVendedores (
    hvdr_id         NUMBER(6) NOT NULL, 
    hvdr_nome       VARCHAR2(50),       
    hvdr_dt_entrada  DATE NOT NULL       
);

ALTER TABLE hVendedores ADD CONSTRAINT pk_hvdr PRIMARY KEY (hvdr_id, hvdr_dt_entrada);

CREATE TRIGGER tr_hvdr
BEFORE UPDATE OR DELETE ON vendedores
FOR EACH ROW
BEGIN
    INSERT INTO hVendedores (hvdr_id, hvdr_nome, hvdr_dt_entrada)
    VALUES (:old.vdr_id, 
            :old.vdr_nome, 
            SYSDATE);
END;
/

-- Tabela para o historiamento de MARCAS

CREATE TABLE hmarcas ( 
    hmar_id         NUMBER(6) 
        CONSTRAINT ck_hmar_nn_01 NOT NULL, 
    hmar_nome        VARCHAR(50), 
    hmar_dt_entrada date
);

ALTER TABLE hmarcas ADD CONSTRAINT pk_hmar PRIMARY KEY (hmar_id, hmar_dt_entrada);

create trigger tr_hmar
before update or delete on marcas
for each row
begin
    insert into hmarcas 
    values (:old.mar_id, 
            :old.mar_nome,  
            sysdate);
end;
/

-- Tabela para o historiamento de TRANSMISSÕES

CREATE TABLE htransmissoes ( 
    htrs_id         NUMBER(6) 
        CONSTRAINT ck_htrs_nn_01 NOT NULL, 
    htrs_tipo        VARCHAR2(10), 
    htrs_dt_entrada date
);

ALTER TABLE htransmissoes ADD CONSTRAINT pk_htrs PRIMARY KEY (htrs_id, htrs_dt_entrada);

create trigger tr_htrs
before update or delete on transmissoes
for each row
begin
    insert into htransmissoes 
    values (:old.trs_id, 
            :old.trs_tipo,  
            sysdate);
end;
/

-- Tabela para o historiamento de MODELOS


CREATE TABLE hmodelos ( 
    hmod_id     NUMBER(6) 
        CONSTRAINT ck_hmod_nn_01 NOT NULL, 
    hmod_nome   VARCHAR2(50), 
    hmod_body   VARCHAR2(50), 
    hmod_trim   VARCHAR2(50), 
    hmod_mar_id NUMBER(6) 
        CONSTRAINT ck_hmod_nn_02 NOT NULL, 
    hmod_trs_id NUMBER(6) 
        CONSTRAINT ck_hmod_nn_03 NOT NULL,
    hmod_dt_entrada date
);


ALTER TABLE hmodelos ADD CONSTRAINT pk_hmod PRIMARY KEY (hmod_id, hmod_dt_entrada);

-- Trigger para historiamento da tabela MODELOS

create trigger tr_hmod
before update or delete on modelos
for each row
begin
    insert into hmodelos 
    values (:old.mod_id, 
            :old.mod_nome,
            :old.mod_body,
            :old.mod_trim,
            :old.mod_mar_id,
            :old.mod_trs_id,
            sysdate);
end;
/

