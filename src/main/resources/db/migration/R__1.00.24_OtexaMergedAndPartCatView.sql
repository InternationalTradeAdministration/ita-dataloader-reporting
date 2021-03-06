CREATE OR ALTER VIEW [dbo].[OTEXA_MERGED_CAT_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[MERG_CAT] as 'MERGED_CATEGORY'
    , details.[Description]
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_MERGED_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'MERGED_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[MERG_CAT] as 'MERGED_CATEGORY'
    , details.[Description]
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , CASE 
        WHEN hdr.[HEADER_DESCRIPTION] = 'Current Month' THEN details.[VAL]
        ELSE details.[VAL] / details.[SYEF]
        END as 'DATA_VALUE'
    , 'UNITS' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_MERGED_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'MERGED_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
WHERE hdr.[HEADER_TYPE] = 'SME'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[MERG_CAT] as 'MERGED_CATEGORY'
    , details.[Description]
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] * details.[SYEF] AS 'DATA_VALUE'
    , 'SME' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_MERGED_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'MERGED_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
WHERE hdr.[HEADER_TYPE] = 'UNITS'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO



CREATE OR ALTER VIEW [dbo].[OTEXA_PART_CAT_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[PART_CAT] as 'PART_CATEGORY'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_PART_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'PART_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[PART_CAT] as 'PART_CATEGORY'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , CASE 
        WHEN hdr.[HEADER_DESCRIPTION] = 'Current Month' THEN details.[VAL]
        ELSE details.[VAL] / details.[SYEF]
        END as 'DATA_VALUE'
    , 'UNITS' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_PART_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'PART_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'SME'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CAT_ID] as 'Category ID'
    , details.[PART_CAT] as 'PART_CATEGORY'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] * details.[SYEF] AS 'DATA_VALUE'
    , 'SME' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_PART_CAT] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'PART_CAT'
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'UNITS'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
