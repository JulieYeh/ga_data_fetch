--GA_MAIN_HITS_CUSTOM_DIMENSIONS--
--行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) AS GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID ,
	   visitID as VISIT_ID ,
	   h.hitNumber as HIT_NUMBER ,
	   hcd.index AS INDEX, 
	   hcd.value AS VALUE
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) AS h,
	   UNNEST(h.customDimensions) AS hcd
WHERE _TABLE_SUFFIX BETWEEN '20180327' and '20180327'