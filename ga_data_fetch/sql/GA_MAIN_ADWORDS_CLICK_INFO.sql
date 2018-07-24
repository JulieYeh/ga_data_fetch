--GA_MAIN_ADWORDS_CLICK_INFO--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        trafficsource.AdwordsClickInfo.ADGroupID as AD_GROUP_ID,
        trafficsource.AdwordsClickInfo.AdNetworkType as AD_NETWORK_TYPE,
        trafficsource.AdwordsClickInfo.CampaignID as CAMPAIGN_ID,
        trafficsource.AdwordsClickInfo.CREATIVEID AS CREATIVE_ID,
        trafficsource.AdwordsClickInfo.CRITERIAID AS CRITERIA_ID,
        trafficsource.AdwordsClickInfo.CRITERIAPARAMETERS AS CRITERIA_PARAMETERS,
        trafficsource.AdwordsClickInfo.CUSTOMERID AS CUSTOMERID,
        trafficsource.AdwordsClickInfo.GCLID AS GCL_ID,
        trafficsource.AdwordsClickInfo.ISVIDEOAD AS IS_VIDEO_AD,
         trafficsource.AdwordsClickInfo.PAGE AS PAGE,
        trafficsource.AdwordsClickInfo.SLOT AS SLOT
FROM `ts-official-website.118166279.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'