--GA_IDENTIFY--
--APP+WEB--

SELECT
  Distinct
  DATE,
 FULLVISITORID,
source,
Medium,
referralPath,
campaign,
adContent,
VISITID,
hitNumber,  
  IDFA_AAID,
  ''GA_COOKIE,  
  CUSTNO,
  '' NBUUID,
  ''AS Q_NO,
  '' AS PAGEPATH,
  SCREEN_NAME,
  APP,
  '' AS WEB
FROM
  `ts-official-website.118166279.APP_IDENTIFY`
UNION ALL
SELECT
  DATE,
 FULLVISITORID,
source,
Medium,
referralPath,
campaign,
adContent,
VISITID,
hitNumber,
  '' AS IDFA_AAID,
  GA_COOKIE,
  CUSTNO,
  NBUUID,
  Q_NO,
  PAGEPATH,
  '' AS SCREEN_NAME,
  ''AS APP,
  WEB
FROM
  `ts-official-website.118166279.Web_All_Identify`
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'