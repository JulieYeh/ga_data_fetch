  --GA_MAIN_TRAFFIC_SOURCE--
 --官網--
 
 SELECT ROW_NUMBER() over() TRAFFIC_SOURCE_NO,
        TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        trafficsource.adContent as AD_CONTENT,
        trafficsource.campaign as CAMPAIGN,
        trafficsource.campaigncode as CAMPAIGN_CODE,
        trafficsource.isTrueDirect as IS_TRUE_DIRECT,
        trafficsource.keyword as KEYWORD,
        trafficsource.medium as MEDIUM,
        trafficsource.ReferralPath as REFERRAL_PATH,
        trafficsource.source as SOURCE
FROM `ts-official-website.{resourceid}.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'