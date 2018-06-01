--GA_MAIN_HITS_APP_INFO--
--行銷平台--

SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),'_',cast(VISITID as string)))) as GA_MAIN_NO,
	   FullvisitorID as FULL_VISITOR_ID,
	   visitID as VISIT_ID,
	   h.hitNumber as HIT_NUMBER,
	   h.appInfo.name as NAME, 
	   h.appInfo.version as VERSION, 
	   h.appInfo.id as ID, 
	   h.appInfo.installerId as INSTALLER_ID, 
	   h.appInfo.appInstallerId as APP_INSTALLER_ID, 
	   h.appInfo.appName as APP_NAME, 
	   h.appInfo.appVersion as APP_VERSION, 
	   h.appInfo.appId as APP_ID, 
	   h.appInfo.screenName as SCREEN_NAME, 
	   h.appInfo.landingScreenName as LANDING_SCREEN_NAME, 
	   h.appInfo.exitScreenName as EXIT_SCREEN_NAME, 
	   h.appInfo.screenDepth as SCREEN_DEPTH
FROM `ts-official-website.164284491.ga_sessions_*`,
	   UNNEST(hits) as h
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'