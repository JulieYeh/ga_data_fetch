--GA_IDENTIFY--
--WEB全部--

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
FROM `ts-official-website.118166279.TS_WEB_Identify`
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
 GA_COOKIE, NBUUID, '' AS Q_NO, PAGEPATH, WEB FROM `ts-official-website.118166279.CreditLoan_Identify`
)
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'