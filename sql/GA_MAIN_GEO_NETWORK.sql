--GA_MAIN_GEO_NETWORK--
--官網--

 SELECT TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        GEONETWORK.continent as CONTINENT,
        GEONETWORK.subcontinent as SUB_CONTINENT,
        GEONETWORK.country as COUNTRY,
        GEONETWORK.region as REGION,
        GEONETWORK.city as CITY,
        GEONETWORK.cityid as CITY_ID,
        GEONETWORK.latitude as LATITUDE,
        GEONETWORK.longitude as LONGGITUDE,
        GEONETWORK.networkdomain as NETWORK_DOMAIN,
        GEONETWORK.networklocation as NETWORK_LOCATION
FROM `ts-official-website.{resourceid}.ga_sessions_*`,
        UNNEST(customdimensions) as customdimensions
WHERE _TABLE_SUFFIX BETWEEN '{start_date}' and '{end_date}'