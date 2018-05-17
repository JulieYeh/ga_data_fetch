--GA_MAIN_HITS_CONTENT_INFO--
---行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) as GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID,
	   visitID as VISIT_ID,
	   h.hitNumber as HIT_NUMBER,
	   h.exceptionInfo.description as CONTENT_DESCRIPTION
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) as h
WHERE _TABLE_SUFFIX BETWEEN '20180327' and '20180327'
