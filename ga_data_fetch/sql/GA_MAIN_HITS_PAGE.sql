--GA_MAIN_HITS_PAGE--
--官網--

 SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        hits.hitnumber as HIT_NUMBER,
        hits.page.pagepath as PAGE_PATH,
        hits.page.pagepathlevel1 as PAGE_PATH_LEVEL1,
        hits.page.pagepathlevel2 as PAGE_PATH_LEVEL2,
        hits.page.pagepathlevel3 as PAGE_PATH_LEVEL3,
        hits.page.pagepathlevel4 as PAGE_PATH_LEVEL4,
        hits.page.hostname as HOSTNAME,
        hits.page.pagetitle as PAGE_TITLE,
        hits.page.searchkeyword as SEARCH_KEYWORD,
        hits.page.searchcategory as SEARCH_CATEGORY
FROM `ts-official-website.118166279.ga_sessions_*`,
        UNNEST(hits) as hits     
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'