--GA_MAIN_CUSTOM_DIMENSIONS--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        customdimensions.index as INDEX,
        customdimensions.value as VALUE
FROM `ts-official-website.{resourceid}.ga_sessions_*`,
        UNNEST(customdimensions) as customdimensions
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'