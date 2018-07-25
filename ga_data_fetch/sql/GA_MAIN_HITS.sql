--GA_MAIN_HITS--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        HITS.hitnumber as HIT_NUMBER,
        HITS.hour as HOUR,
        HITS.isEntrance as IS_ENTRANCE,
        HITS.isEXIT as IS_EXIT,
        HITS.isInteraction AS IS_INTERACTION,
        HITS.minute as MINUTE,
        HITS.TIME as TIME,
        HITS.REFerer as REFERER,
        hits.type as TYPE
FROM `ts-official-website.{resourceid}.ga_sessions_*`,
        UNNEST(hits) as hits
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'