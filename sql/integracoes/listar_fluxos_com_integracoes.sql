-- Descrição: Lista fluxos, etapas e integrações associadas
-- Uso: Auditoria de integrações por etapa
-- Autor: Lucas
-- Data: 2026-04

SELECT 
    f.COD_FORM       AS 'Código Fluxo',
    f.DES_TITULO     AS 'Nome',
    f.COD_VERSAO     AS 'Versão',
    e.TITULO_ETAPA   AS 'Atividade',
    e.COD_ETAPA      AS 'Código Atividade',
    i.NOME_INTEGRACAO AS 'Integração',
    CASE 
        WHEN e.COD_INTEGRACAO_APROVA IS NOT NULL THEN 'Aprovação'
        WHEN e.COD_INTEGRACAO_REJEITA IS NOT NULL THEN 'Rejeição'
        WHEN e.COD_INTEGRACAO_ROTINA_PAGINA IS NOT NULL THEN 'Carregamento Atividade'
        ELSE ''
    END AS 'Tipo'
FROM etapa e
JOIN formulario f 
    ON e.COD_FORM = f.COD_FORM
   AND e.COD_VERSAO = f.COD_VERSAO 
JOIN integracao i 
    ON e.COD_INTEGRACAO_ROTINA_PAGINA = i.COD_INTEGRACAO
    OR e.COD_INTEGRACAO_APROVA = i.COD_INTEGRACAO
    OR e.COD_INTEGRACAO_REJEITA = i.COD_INTEGRACAO
WHERE f.IDE_STATUS = 'A';