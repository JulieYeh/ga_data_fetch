--GA_IDENTIFY--
--行動銀行--

SELECT
    DISTINCT
    A.Date,
    A.FULLVISITORID,
    A.trafficSource.source,
    A.trafficSource.Medium,
    A.trafficSource.referralPath,
    A.trafficSource.campaign,
    A.trafficSource.adContent,
    A.VISITID,
    hits.hitNumber,
    B.IDFA_AAID,
    C.CUSTNO,
    hits.appInfo.screenName AS SCREEN_NAME,
    '行動銀行' AS APP
  FROM
    `ts-official-website.164554307.ga_sessions_*` A,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
LEFT JOIN
(SELECT
    DISTINCT 
    FULLVISITORID,
    customDimensions.value AS IDFA_AAID
FROM
    `ts-official-website.164554307.ga_sessions_*` ,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
WHERE customDimensions.index = 1)B
ON A.FULLVISITORID = B.FULLVISITORID
LEFT OUTER JOIN 
  (
  SELECT
      DISTINCT 
      FULLVISITORID,     
      customDimensions.value AS CUSTNO
  FROM
      `ts-official-website.164554307.ga_sessions_*` ,
      UNNEST(hits) AS hits,
      UNNEST(hits.customDimensions) AS customDimensions
  WHERE customDimensions.index = 2
  )C
ON B.FULLVISITORID = C.FULLVISITORID
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'