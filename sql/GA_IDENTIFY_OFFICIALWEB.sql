--GA_IDENTIFY--
--官網--


  SELECT
    DISTINCT
    A.DATE,
    A.FullvisitorID,
    A.trafficSource.source,
    A.trafficSource.Medium,
    A.trafficSource.referralPath,
    A.trafficSource.campaign,
    A.trafficSource.adContent ,
    A.VISITID,
    hits.hitNumber,
    E.value AS GA_COOKIE,
    B.value as CUST_NO,
    C.value as NBUUID,
    D.value as Q_NO,
    hits.page.pagePath as PAGEPATH,
    '官網' AS WEB
  FROM
    `ts-official-website.118166279.ga_sessions_*` A,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
       LEFT JOIN 
   (  SELECT
   DATE,
    fullvisitorID,
    customDimensions.value AS value
  FROM
    `ts-official-website.118166279.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 1
    AND REGEXP_CONTAINS(customDimensions.value, r"[a-zA-Z]") = FALSE
    AND customDimensions.value <>'' )   
   B
   ON A.fullvisitorID = B.fullvisitorID AND A.DATE = B.DATE
          LEFT JOIN 
   (  SELECT
    DATE,
    fullvisitorID,
    customDimensions.value AS value
  FROM
    `ts-official-website.118166279.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 4
    AND customDimensions.value <>''
    AND customDimensions.value <>'string')   
   C
   ON A.fullvisitorID = C.fullvisitorID AND A.DATE = C.DATE
             LEFT JOIN 
   (  SELECT
    DATE,
    fullvisitorID,
    customDimensions.value AS value
  FROM
    `ts-official-website.118166279.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 5
    AND customDimensions.value <>'' )   
   D
   ON A.fullvisitorID = D.fullvisitorID AND A.DATE = D.DATE
  LEFT JOIN 
   (  SELECT
    DATE,
    fullvisitorID,
    customDimensions.value AS value
  FROM
    `ts-official-website.118166279.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.customDimensions) AS customDimensions
  WHERE
    customDimensions.value IS NOT NULL
    AND customDimensions.value <> 'ros'
    AND customDimensions.index = 2
    AND customDimensions.value <>''
    )   
   E
   ON A.fullvisitorID = E.fullvisitorID AND A.DATE = E.DATE
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'