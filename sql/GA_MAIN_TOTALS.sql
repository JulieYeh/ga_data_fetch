--GA_MAIN_TOTALS--

 SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        totals.bounces as BOUNCES,
        totals.hits as HITS,
        totals.newvisits as NEW_VISITS,
        totals.pageviews as PAGEVIEWS,
        totals.screenviews as SCREENVIEWS,
        totals.sessionqualitydim as SESSION_QUALITY_DIM,
        totals.timeonscreen as TIME_ON_SCREEN,
        totals.timeonsite as TIME_ON_SITE,
        totals.totaltransactionrevenue as TOTAL_TRANSACTION_REVENUE,
        totals.transactions as TRANSACTIONS,
        totals.visits as VISITS
    FROM `ts-official-website.118166279.ga_sessions_*`
    WHERE _TABLE_SUFFIX BETWEEN '20180114' and '20180114'