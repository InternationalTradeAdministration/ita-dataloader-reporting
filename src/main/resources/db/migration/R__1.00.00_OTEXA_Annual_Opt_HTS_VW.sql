CREATE VIEW [dbo].[OTEXA_ANNUAL_OPT_HTS_VW]
AS
SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]

UNION ALL

SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] / details.[SYEF] AS 'DATA_VALUE'
    , 'UNITS' as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'SME'

UNION ALL

SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] * details.[SYEF] AS 'DATA_VALUE'
    , 'SME' as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'UNITS'

GO
