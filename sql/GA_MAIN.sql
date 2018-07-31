--GA_MAIN--
--官網--
SELECT
        TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        userID as USER_ID,
        visitNumber as VISIT_NUMBER,
        visitStartTime as VISIT_START_TIME,
        date as DATE,
        SocialEngagementType as SOCIAL_ENGAGEMENT_TYPE,
        CHANNELGROUPING as CHANNEL_GROUPING    
FROM `ts-official-website.{resourceid}.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'
