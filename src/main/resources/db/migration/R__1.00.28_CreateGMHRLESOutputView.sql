CREATE OR ALTER VIEW [dbo].[GMHR_LES_OUTPUT_VIEW]
AS 
SELECT 'LES' as ID,
les.[Period ID] as [Period ID],
RIGHT(les.[Period ID], 2) as [PP Covered],
les.Cntry,
les.[Country Name],
leslookup.[DAS/ED/Office],
les.Post,
les.[Sub Post],
les.Agy,
les.Bur,
les.[Bureau Name],
les.[Budget FY],
les.Appropriation,
les.[Bgn FY],
les.[End FY],
les.Allotment,
les.[Op Allow],
les.[Function],
les.[Object] as BOC,
boc.[Detailed Description],
boc.[General Description],
boc.[LES Ann/Non Ann],
boc.[Sub Group],
les.Project,
CASE WHEN Project = '4055410' OR Project='4055510' or Project='4055610' THEN 'SUSA' END as SUSA,
RIGHT(les.Project,3) as Fund,
les.[Prop ID],
les.[Benf Org],
les.Obligation,
les.Currency,
les.[Exchange Rate],
les.[Employee ID],
les.Name,
les.[Position Number],
les.[Position Title],
les.[OPS Working Title],
les.[Salary Plan],
payplan.Source,
payplan.Defination,
payplan.[Employee Type],
les.Grade,
les.Step,
FORMAT(CONVERT(INTEGER, CONCAT(les.grade, les.Step)),'0000') as [Grade and Step],
les.[Annual Salary],
les.[Worked Hours],
les.Amount,
les.[Amount in USE],
les.[Adjusted Amount],
les.[Adjusted Amount in USE],
les.[Amount in USE] + les.[Adjusted Amount in USE] as [Total in USE],
les.[Fiscal Hours YTD],
les.[Fiscal Total YTD],
les.[Fiscal Total YTD in USE],
les.[PP Begin Date],
les.[PP End Date],
les.[Payroll Status],
les.[Run Date],
les.[Service Center]
FROM GMHR_LES_FLAT_FILE les, BOC_LOOKUP_TABLE boc, LES_COUNTRY_NAME_LOOKUP leslookup, GM_HR_PAYPLAN_LOOKUP payplan
WHERE payplan.[Pay Plan]=les.[Salary Plan] AND leslookup.[Country Name 1]=les.[Country Name] AND CONVERT(VARCHAR(MAX),boc.BOC)  = les.[Object]
GO