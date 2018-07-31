--GA_MAIN_trafficsource.AdwordsClickInfo.TARGETINGCriteriaboom--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        trafficsource.AdwordsClickInfo.TARGETINGCriteria.boomUserlistID as TARGETING_CRITERIA_BOOM_USERLIST_ID
FROM `ts-official-website.{resourceid}.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'