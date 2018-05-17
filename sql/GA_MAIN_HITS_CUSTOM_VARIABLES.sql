--GA_MAIN_HITS_CUSTOM_VARIABLES--
--行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) AS GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID ,visitID as VISIT_ID ,h.hitNumber as HIT_NUMBER ,
	   hcv.index AS INDEX, 
	   hcv.customVarName AS CUSTOM_VAR_NAME, 
	   hcv.customVarValue AS CUSTOM_VAR_VALUE
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) AS h,
	   UNNEST(h.customVariables) AS hcv
WHERE _TABLE_SUFFIX BETWEEN '20180327' and '20180327'