--GA_MAIN_DEVICE--
--官網--

SELECT  TO_HEX(SHA256(Concat(cast(FullvisitorID as string),"_",cast(VISITID as string)))) as GA_MAIN_NO ,
        "Official_Web" as DATASOURCE,
        FullvisitorID as FULL_VISITOR_ID,
        VISITID as VISIT_ID,
        device.browser as BROWSER ,
        device.browsersize as BROWSER_SIZE,
        device.browserversion as BROWSER_VERSION,
        device.devicecategory as DEVICE_CATEGORY,
        device.mobiledeviceinfo as MOBILE_DEVICE_INFO,
        device.mobiledevicemarketingname as MOBILE_DEVICE_MARKETING_NAME,
        device.mobiledevicemodel as MOBILE_DEVICE_MODEL,
        device.mobileinputselector as MOBILE_INPUT_SELECTOR,
        device.operatingsystem as OPERATING_SYSTEM,
        device.operatingsystemversion as OPERATING_SYSTEM_VERSION,
        device.mobiledevicebranding as MOBILE_DEVICE_BRANDING,
        device.language as LANGUAGE
FROM `ts-official-website.118166279.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20180114' and '20180114'