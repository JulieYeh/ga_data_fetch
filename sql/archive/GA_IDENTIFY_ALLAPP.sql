--GA_IDENTIFY--
--APP全部--

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
  SELECT * FROM `ts-official-website.118166279.CARDAILY`
  UNION ALL
  SELECT * FROM `ts-official-website.118166279.TSMobileBank`
)
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'