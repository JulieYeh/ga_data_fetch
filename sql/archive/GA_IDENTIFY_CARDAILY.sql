--GA_IDENTIFY--
--CARDAILY--

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
    '卡得利' AS APP
  FROM
    `ts-official-website.134469836.ga_sessions_*` A,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
LEFT JOIN
(SELECT
    DISTINCT
    date,
    FULLVISITORID,
    customDimensions.value AS IDFA_AAID
FROM
    `ts-official-website.134469836.ga_sessions_*` ,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
WHERE customDimensions.index = 1)B
ON A.FULLVISITORID = B.FULLVISITORID and A.DATE = B.DATE
LEFT OUTER JOIN 
  (
  SELECT
      DISTINCT 
      FULLVISITORID, 
      DATE,
      customDimensions.value AS CUSTNO
  FROM
      `ts-official-website.134469836.ga_sessions_*` ,
      UNNEST(hits) AS hits,
      UNNEST(hits.customDimensions) AS customDimensions
  WHERE customDimensions.index = 2
  )C
ON B.FULLVISITORID = C.FULLVISITORID AND B.DATE = C.DATE
UNION ALL 
SELECT
    DISTINCT 
    A.DATE,
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
    hits.appInfo.screenName SCREEN_NAME,
    '卡得利' AS APP
  FROM
    `ts-official-website.174707692.ga_sessions_*` A,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
LEFT JOIN
(SELECT
    DISTINCT 
    DATE,
    FULLVISITORID,
    customDimensions.value AS IDFA_AAID
FROM
    `ts-official-website.174707692.ga_sessions_*` ,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
WHERE customDimensions.index = 1)B
ON A.FULLVISITORID = B.FULLVISITORID AND A.DATE = B.DATE
LEFT OUTER JOIN 
  (
  SELECT
      DISTINCT 
      FULLVISITORID,
      DATE,
      customDimensions.value AS CUSTNO
  FROM
      `ts-official-website.174707692.ga_sessions_*` ,
      UNNEST(hits) AS hits,
      UNNEST(hits.customDimensions) AS customDimensions
  WHERE customDimensions.index = 2
  )C
ON B.FULLVISITORID = C.FULLVISITORID AND B.DATE = C.DATE
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'