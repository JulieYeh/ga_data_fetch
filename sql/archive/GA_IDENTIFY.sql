--GA_IDENTIFY--
--全部--

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
		(
			SELECT DISTINCT DATE, CUSTNO, 
			 FULLVISITORID,
			source,
			Medium,
			referralPath,
			campaign,
			adContent,
			VISITID,
			hitNumber,

			GA_COOKIE, NBUUID,Q_NO, PAGEPATH , WEB
			FROM
			(
			SELECT DATE, CUST_NO AS CUSTNO,  FULLVISITORID,
			source,
			Medium,
			referralPath,
			campaign,
			adContent,
			VISITID,
			hitNumber,
			 GA_COOKIE, NBUUID, Q_NO, PAGEPATH, WEB 
			FROM (
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
				)
			UNION ALL
			SELECT DATE,CUSTNO, FULLVISITORID,
			source,
			Medium,
			referralPath,
			campaign,
			adContent,
			VISITID,
			hitNumber,
			 GA_COOKIE, '' AS NBUUID, '' AS Q_NO, PAGEPATH, WEB  
			FROM `ts-official-website.118166279.Old_MKP_Identify`
			UNION ALL
			SELECT DATE, CUSTNO,  FULLVISITORID,
			source,
			Medium,
			referralPath,
			campaign,
			adContent,
			VISITID,
			hitNumber,
			 GA_COOKIE, NBUUID, '' AS Q_NO, PAGEPATH, WEB FROM 
			 	(
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
			 	)
			)
		)
		UNION ALL
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
  (
	SELECT DISTINCT DATE, FULLVISITORID,
	source,
	Medium,
	referralPath,
	campaign,
	adContent,
	VISITID,
	hitNumber, IDFA_AAID, CUSTNO, APP, SCREEN_NAME
	FROM
	(
	  SELECT * FROM (
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
	  				)
	  UNION ALL
	  SELECT * FROM (
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
	  				)
	)
)