--GA_MAIN_HITS_EVENT_INFO--
--行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) as GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID,
	   visitID as VISIT_ID,
	   h.hitNumber as HIT_NUMBER,
	   h.eventInfo.eventCategory as EVENT_CATEGORY, 
	   h.eventInfo.eventAction as EVENT_ACTION, 
	   h.eventInfo.eventLabel as EVENT_LABEL, 
	   h.eventInfo.eventValue as EVENT_VALUE
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) as h
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'