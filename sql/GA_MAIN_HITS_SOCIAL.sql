--GA_MAIN_HITS_SOCIAL--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        hits.hitnumber as HIT_NUMBER,
        hits.social.hasSocialSourceReferral as HAS_SOCIAL_SOURCE_REFERAL,
        hits.social.socialinteractionaction as SOCIAL_INTERACTION_ACTION,
        hits.social.socialINTERACTIONNETWORK as SOCIAL_INTERACTION_NETWORK,
        hits.social.socialINTERACTIONNETWORKaction as SOCIAL_INTERACTION_NETWORK_ACTION,
        hits.social.socialinteractions as SOCIAL_INTERACTIONS,
        hits.social.socialinteractionTARGET as SOCIAL_INTERACTION_TARGET,
        hits.social.socialnetwork as SOCIAL_NETWORK,
        hits.social.uniquesocialinteractions as UNIQUE_SOCIAL_INTERACTIONS
FROM `ts-official-website.{resourceid}.ga_sessions_*`,
        UNNEST(hits) as hits
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'