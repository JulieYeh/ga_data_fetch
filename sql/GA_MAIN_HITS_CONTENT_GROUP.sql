--GA_MAIN_HITS_CONTENT_GROUP--
--行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) as GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID,
	   visitID as VISIT_ID,
	   h.hitNumber as HIT_NUMBER,
	   h.contentGroup.contentGroup1 as CONTENT_GROUP_1,
	   h.contentGroup.contentGroup2 as CONTENT_GROUP_2,
	   h.contentGroup.contentGroup3 as CONTENT_GROUP_3,
	   h.contentGroup.contentGroup4 as CONTENT_GROUP_4,
	   h.contentGroup.contentGroup5 as CONTENT_GROUP_5,
	   h.contentGroup.previousContentGroup1 as PREVIOUS_CONTENT_GROUP_1,
	   h.contentGroup.previousContentGroup2 as PREVIOUS_CONTENT_GROUP_2,
	   h.contentGroup.previousContentGroup3 as PREVIOUS_CONTENT_GROUP_3,
	   h.contentGroup.previousContentGroup4 as PREVIOUS_CONTENT_GROUP_4,
	   h.contentGroup.previousContentGroup5 as PREVIOUS_CONTENT_GROUP_5,
	   h.contentGroup.contentGroupUniqueViews1 as UNIQUE_VIEWS_1,
	   h.contentGroup.contentGroupUniqueViews2 as UNIQUE_VIEWS_2,
	   h.contentGroup.contentGroupUniqueViews3 as UNIQUE_VIEWS_3,
	   h.contentGroup.contentGroupUniqueViews4 as UNIQUE_VIEWS_4,
	   h.contentGroup.contentGroupUniqueViews5 as UNIQUE_VIEWS_5
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) as h
WHERE _TABLE_SUFFIX BETWEEN '20180327' and '20180327'