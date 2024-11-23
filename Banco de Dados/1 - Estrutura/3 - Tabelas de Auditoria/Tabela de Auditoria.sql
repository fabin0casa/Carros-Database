 -- Criando a tabela para a auditoria dos dados

CREATE TABLE AUDITORIA
(	
    "AUD_ID" NUMBER(6,0), 
    "AUD_TABELA" VARCHAR2(30), 
    "AUD_ROWID" VARCHAR2(20), 
    "AUD_OPERACAO" CHAR(1), 
    "AUD_COLUNA" VARCHAR2(30), 
    "AUD_VALOR_ANTIGO" VARCHAR2(255), 
    "AUD_VALOR_NOVO" VARCHAR2(255), 
    "AUD_USU_BD" VARCHAR2(30), 
    "AUD_USU_SO" VARCHAR2(255), 
    "AUD_DATA" DATE
);

-- Criando uma sequence e um trigger para preencher os valores de aud_id

create sequence aud_seq nocache;

create trigger aud_tg_seq
before insert on auditoria
for each row
begin 
    :new.aud_id := aud_seq.nextval;
end;
/


-- Criando uma procedure para inserir todos os dados na tabela de auditoria

CREATE PROCEDURE PROC_AUDITORIA (
    P_AUD_TABELA IN VARCHAR,
    P_AUD_ROWID IN VARCHAR,
    P_AUD_OPERACAO IN CHAR,
    P_AUD_COLUNA IN VARCHAR,
    P_AUD_VALOR_ANTIGO IN VARCHAR,
    P_AUD_VALOR_NOVO IN VARCHAR,
    P_AUD_USU_BD IN VARCHAR, 
    P_AUD_USU_SO IN VARCHAR, 
    P_AUD_DATA IN DATE
)
IS
BEGIN
    INSERT INTO AUDITORIA VALUES (null,
                                  P_AUD_TABELA,
                                  P_AUD_ROWID,
                                  P_AUD_OPERACAO,
                                  P_AUD_COLUNA,
                                  P_AUD_VALOR_ANTIGO,
                                  P_AUD_VALOR_NOVO,
                                  P_AUD_USU_BD,
                                  P_AUD_USU_SO,
                                  P_AUD_DATA);
END;
/

-- Dando permiss�o para o uso da procedure para o usu�rio 
GRANT EXECUTE ON PROC_AUDITORIA TO FABIO;
