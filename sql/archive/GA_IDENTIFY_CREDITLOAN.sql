--GA_IDENTIFY--
--信貸--

SELECT
  DISTINCT A.DATE,
  A.FULLVISITORID,
  A.trafficSource.source,
  A.trafficSource.Medium,
  A.trafficSource.referralPath,
  A.trafficSource.campaign,
  A.trafficSource.adContent,
  A.VISITID,
  hits.hitNumber,
  (CASE
      WHEN B.CUSTNO IS NOT NULL THEN B.CUSTNO
      ELSE D.CUSTNO END) AS CUSTNO,
  C.GA_COOKIE AS GA_cookie,
  E.NBUUID,
  hits.page.pagePath AS PAGEPATH,
  '信貸' AS WEB
FROM
  `ts-official-website.160476560.ga_sessions_*` A,
  UNNEST(hits) AS hits
LEFT JOIN (
  SELECT
    fullvisitorID,
    visitID,
    hits.hitnumber AS hitnumber,
    customDimensions.value AS CUSTNO
  FROM
    `ts-official-website.160476560.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 1
    AND REGEXP_CONTAINS(customDimensions.value, r"[a-zA-Z]") = FALSE
    AND customDimensions.value <>'' )B
ON
  A.FULLVISITORID = B.FULLVISITORID
  AND A.VISITID = B.VISITID
LEFT JOIN (
  SELECT
    fullvisitorID,
    visitID,
    hits.hitnumber,
    customDimensions.value AS GA_COOKIE
  FROM
    `ts-official-website.160476560.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 2
    AND REGEXP_CONTAINS(customDimensions.value, r"[a-zA-Z]") = FALSE
    AND customDimensions.value <>'' )C
ON
  A.FULLVISITORID = C.FULLVISITORID
  AND A.VISITID = C.VISITID
LEFT JOIN (
  SELECT
    fullvisitorID,
    visitID,
    hits.hitnumber,
    trafficSource.keyword AS CUSTNO
  FROM
    `ts-official-website.160476560.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    REGEXP_CONTAINS(trafficSource.keyword, r"[a-zA-Z]") = FALSE
    AND LENGTH(trafficSource.keyword) = 16 )D
ON
  A.FULLVISITORID = D.FULLVISITORID
  AND A.VISITID = D.VISITID
LEFT JOIN (
  SELECT
    fullvisitorID,
    visitID,
    hits.hitnumber,
    customDimensions.value AS NBUUID
  FROM
    `ts-official-website.160476560.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 4
    AND customDimensions.value <>'' )E
ON
  A.FULLVISITORID = E.FULLVISITORID
  AND A.VISITID = E.VISITID
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'