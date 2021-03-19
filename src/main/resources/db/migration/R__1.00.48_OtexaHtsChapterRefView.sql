DROP VIEW IF EXISTS [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
GO

CREATE VIEW [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
AS
    SELECT mapping.CAT_ID
        , mapping.HTS
        , mapping.CHAPTER
        , CONCAT(c.[CHAPTER], ' - ', c.[CHAPTER_DESCRIPTION]) as 'LONG_CHAPTER'
        , mapping.SOURCE
    FROM OTEXA_HTS_CHAPTER_REF mapping
    INNER JOIN OTEXA_CHAPTER_REF c
    ON mapping.CHAPTER = c.CHAPTER
GO
