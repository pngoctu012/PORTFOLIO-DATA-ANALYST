SMART FACTORY PROJECT
-------------------------------------------------
**1. Description**

This project was conducted for a chemical fertilizer manufacturing plant, focusing on data standardization and storage to enable third-party access via Power BI. The project consisted of two main modules: Production Planning and Plant Maintenance.
My responsibilities included mapping data tables according to business requirements and developing comprehensive test scenarios to ensure data accuracy and consistency across systems. 
---------------------------------------------------
I was assigned to perform data mapping for the table AGG_PMS_TABLE, which consolidates key information including procurement plans, purchase orders, and contract details. The data is analyzed across multiple dimensions such as time, requesting department, requester, executing unit, functional unit, and overall maintenance.
The AGG_PMS_TABLE is an aggregated table derived from four source tables:
- AGG_REQ_PURCHS

- AGG_REGISTRATION

- AGG_PURCHASE_ORDER

- AGG_PO_CONTRACT

Data Filtering Rules:
- Only records with order statuses other than (-1: Canceled, 7: Voided) are retrieved — including cases where multiple statuses coexist.

- Status codes include: -1: Canceled, 0: Draft, 1: Returned, 2: In Process, 3: Rejected, 4: Approved, 5: Completed, 6: On Hold, 7: Voided.

Data Mapping Priority:
- When performing JOIN operations, data source priority was established for each field. For instance, the field REG_DEPT_ID is primarily sourced from the previous year’s procurement plan, and if unavailable, it is retrieved from the Purchase Request table in the following order of precedence: gld.AGG_REGISTRATION → gld.AGG_REQ_PURCHS.

Contract Value Handling Rules:
- If multiple purchase order details share the same contract, the TOTAL_PRICE value is assigned to the record with the largest estimated budget.

- If a single purchase order detail is linked to multiple contracts, data from each contract is concatenated into a single string, with each value separated by line breaks.
Specifically, the following fields are concatenated: ContractNo, PO Number, SignedDate, Sum(GTHD), and Sum(GTKT) — grouped by Order Number and YCMS.

Bảng AGG_PMS_TABLE: 
|REG_TITLE|REG_PLAN_YEAR|REG_DEPT_ID|REG_DEPT_NAME|TECHNICAL_CODE|ORDER_NUMBER|FIELD_GROUP_ID|FIELD_GROUP_NAME|FIELD_ID|FIELD_NAME|ORDER_TITLE|PART_NUMBER|PART_NAME|BDTT|COST_ESTIMATE|IMPLEMENT_DEPT_ID|IMPLEMENT_DEPT_NAME|PRIORITY_ID|PRIORITY_NAME|BIDDING_TYPE_ID|BIDDING_TYPE_NAME|ORDER_TYPE_ID|ORDER_TYPE_NAME|ORDER_PURPOSE_ID|ORDER_PURPOSE_NAME|COST_PLAN|COST_ORDER|COST_BDTT_COST|AUTHOR_ID|AUTHOR_NAME|REQPURCHS_DEPARTMENTFUNCTIONIDS|REQPURCHS_DT_ORDERNUMBER|SERIAL_NUMBER|REQPURCHS_TITLE|REQPURCHS_IS_PLAN|REQPURCHS_PLAN_ITEM_NM|INDEX_STR|SUBMIT_DATE|ORDER_STATUS_CODE|TOTAL_VND|OVERALL_TEXT|PHASE_NAME|STEP_NAME|PROCESS_USER|PO_NUMBER|CONTRACT_NO|SIGNED_DATE|DELIVERY_DATE|CONTRACTOR_NAME|PAY_AMT|TOTAL_PRICE|INDICATOR|DEP_FNC_NM|REGSUBMIT_DATE|PR_STATUS|
|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|
|Kế hoạch mua sắm năm 2025|2025|BF487916-2FA6-480F-A87E-9D688F793A0F|Ban Dự án BIGDATA|BD-325|25-BIGDATA-016|C314D66E-553D-446A-8C0C-148988BA23D2|Phục vụ Hoạt động Dự án BigData|F5BEC65A-B55A-4C19-92E5-CD4890525723|NULL|đăng ký chính chủ cho Fanpage 2 Nông|NULL|NULL|TRUE|2000000000|BF487916-2FA6-480F-A87E-9D688F793A0F|Ban Dự án BIGDATA|F03A0994-88E9-4A63-B033-42FB39D03B2A|Ưu tiên 1_a|F03A0994-88E9-4A63-B033-42FB39D03B2A|Mua sắm hàng hoá/Thuê dịch vụ thông thường|C6B4132D-6967-4251-B798-FAD3C529A3E6|Vật tư thay thế|B932FD43-7ADA-405E-B60C-9059FC5DADC9|Dài hạn (LongLead)|NULL|1710000000|NULL|2ED89CC5-0980-40C1-A04F-8A9F7B56F684|Phạm Nguyễn Viễn Linh|"ae130fc6-ee1d-4726-9d6d-0d99c02eb995"|24-MKT-031|0021/24/TDV-PMKT|đăng ký chính chủ cho Fanpage 2 Nông|1|NULL|dang ky chinh chu cho Fanpage 2 Nong 25-BIGDATA-016|2025-07-22T15:43:36.4100000|4|45218088|Chưa LCNCC|Thực hiện HĐ|Bảo hành / Bảo trì|Nguyễn Thị Vân Anh|910/2021/HĐ DV-BIGDATA/PVCFC-NMA|910/2021/HĐ DV-BIGDATA/PVCFC-NMA|2023-11-07T00:00:00.000Z|2025-05-19T00:00:00.000Z|CÔNG TY TNHH MỘT THÀNH VIÊN XÂY DỰNG BẢO KHANG|834589548|100000000|1|Ban Kỹ thuật An toàn và CNTT|2023-04-17T21:10:24.7670000|4|

Code Mapping:
with 
statuscount as --Xác định số lượng trạng  theo ordernumber 
(
    Select 
         ORDER_NUMBER,
         COUNT(DISTINCT ORDER_STATUS_CODE) AS 'countstatus'
    From 
        dbo.AGG_PURCHASE_ORDER 
    Group by 
        ORDER_NUMBER
), 
AGG_PURCHASE_ORDER as 
(
    Select a.*
    from dbo.AGG_PURCHASE_ORDER a 
    join statuscount b on a.ORDER_NUMBER = b.ORDER_NUMBER 
    where (b.countstatus >= 2 AND a.ORDER_STATUS_CODE not in ('-1','7'))   -- Nếu chỉ có 1 trạng thái thì lấy tất cả, kể cả -1
    OR (b.countstatus = 1) -- and a.OrderNumber = '25-MKT-037')
),
rankedData as ---Xếp hạng thứ  tự theo dự toán -> xác định order có dự toán cao nhất 
(
    Select 
        REG.REG_TITLE 
       ,REG.REG_PLAN_YEAR 
       ,case when REG.ORDER_NUMBER IS NOT NULL AND REG.TECHNICAL_CODE IS NOT NULL THEN REG.TECHNICAL_CODE ELSE PO.TECHNICAL_CODE END TECHNICAL_CODE
       ,CASE WHEN PO.ORDER_NUMBER IS NOT NULL THEN PO.ORDER_NUMBER WHEN REG.ORDER_NUMBER IS NOT NULL THEN REG.ORDER_NUMBER 
            ELSE NULL END ORDER_NUMBER
       ,PR.REQPURCHS_SE_NM AS 'SERIAL_NUMBER'
       ,case when REG.ORDER_NUMBER IS NOT NULL AND REG.[REG_DEPT_ID] IS NOT NULL THEN REG.[REG_DEPT_ID] ELSE PR.REQPURCHS_DEP_ID END REG_DEPT_ID 
       ,case when REG.ORDER_NUMBER IS NOT NULL AND REG.REG_DEPT_NAME IS NOT NULL THEN REG.REG_DEPT_NAME ELSE PR.DEP_NM END REG_DEPT_NAME  -- Tên Đơn vị yêu cầu
       ,case when REG.ORDER_NUMBER is not null AND REG.[AUTHOR_ID] IS NOT NULL then REG.[AUTHOR_ID] 
            when PO.ORDER_NUMBER is not null then PR.REQPURCHS_AUTH_ID 
            else null end AUTHOR_ID -- mÃ  
       ,case when REG.ORDER_NUMBER is not null AND REG.[AUTHOR_NAME] IS NOT NULL then REG.[AUTHOR_NAME] 
            when PO.ORDER_NUMBER is not null then PR.USR_REQUEST_NM  
            else null end AUTHOR_NAME -- Tên người yêu cầu 
       ,REG.SUBMIT_DATE AS 'REGSUBMIT_DATE'
       ,case when REG.ORDER_NUMBER is not null and REG.[FIELD_GROUP_ID] is not null then REG.[FIELD_GROUP_ID] else PR.REQPURCHS_FIELD_GRP_ID END FIELD_GROUP_ID
       ,case when REG.ORDER_NUMBER is not null and REG.[FIELD_GROUP_NAME] is not null then REG.[FIELD_GROUP_NAME] else PR.FGRP_NM end FIELD_GROUP_NAME
       ,case when REG.ORDER_NUMBER is not null and REG.[FIELD_ID] is not null then REG.[FIELD_ID] else PR.REQPURCHS_FIELD_ID END FIELD_ID 
       ,case when REG.ORDER_NUMBER is not null and REG.[FIELD_NAME] is not null then REG.[FIELD_NAME] else PR.FD_NM END FIELD_NAME 
       ,case when REG.ORDER_NUMBER is not null and REG.[ORDER_TITLE] is not null then REG.[ORDER_TITLE] else PO.ORDER_TITLE END ORDER_TITLE
       ,case when REG.ORDER_NUMBER is not null and REG.[PART_NUMBER] is not null then cast(REG.[PART_NUMBER] as nvarchar(500)) else cast(PO.PART_NUMBER as nvarchar(500)) END PART_NUMBER
       ,case when REG.ORDER_NUMBER is not null and REG.[PART_NAME] is not null then REG.[PART_NAME] else PO.PART_NAME END PART_NAME
       ,REG.BDTT
       ,REG.COST_ESTIMATE
       ,REG.[COST_PLAN]
       ,REG.[COST_ORDER]
       ,REG.[COST_BDTT_COST] 
       ,case when REG.ORDER_NUMBER is not null and REG.[PRIORITY_ID] is not null then REG.[PRIORITY_ID] else PR.REQPURCHS_PRIO_ID END PRIORITY_ID
       ,case when REG.ORDER_NUMBER is not null and REG.[PRIORITY_NAME] is not null then REG.[PRIORITY_NAME] else PR.PRIOR_NM END PRIORITY_NAME
       ,case when REG.ORDER_NUMBER is not null and REG.[BIDDING_TYPE_ID] is not null then REG.[BIDDING_TYPE_ID] else PO.BIDDING_TYPE_ID END BIDDING_TYPE_ID
       ,case when REG.ORDER_NUMBER is not null and REG.[BIDDING_TYPE_NAME] is not null then REG.[BIDDING_TYPE_NAME] else PO.BIDDING_TYPE_NAME END BIDDING_TYPE_NAME
       ,case when REG.ORDER_NUMBER is not null and REG.[ORDER_TYPE_ID] is not null then REG.[ORDER_TYPE_ID] else PR.REQPURCHS_ORDERTYPEID END ORDER_TYPE_ID
       ,case when REG.ORDER_NUMBER is not null and REG.[ORDER_TYPE_NAME] is not null then REG.[ORDER_TYPE_NAME] else PR.ORDTYP_NM END ORDER_TYPE_NAME 
       ,case when REG.ORDER_NUMBER is not null and REG.[ORDER_PURPOSE_ID] is not null then REG.[ORDER_PURPOSE_ID] else PR.REQPURCHS_DT_ORDERPURPOSEID END ORDER_PURPOSE_ID 
       ,case when REG.ORDER_NUMBER is not null and REG.[ORDER_PURPOSE_NAME] is not null then REG.[ORDER_PURPOSE_NAME] else PR.OS_ORDERPURPOSE END ORDER_PURPOSE_NAME
       ,case when REG.ORDER_NUMBER is not null and REG.[IMPLEMENT_DEPT_ID] is not null then REG.[IMPLEMENT_DEPT_ID] else PR.REQPURCHS_DEPARTMENTIMPLEMENTID END IMPLEMENT_DEPT_ID
       ,case when REG.ORDER_NUMBER is not null and REG.[IMPLEMENT_DEPT_NAME]is not null then REG.[IMPLEMENT_DEPT_NAME] else PR.DEP_IMP_NM END IMPLEMENT_DEPT_NAME 
       ,PR.REQPURCHS_DEPARTMENTFUNCTIONIDS 
       ,PR.DEP_FNC_NM 
       ,PR.REQPURCHS_DT_ORDERNUMBER 
       ,PR.REQPURCHS_TITLE 
       ,PR.REQPURCHS_IS_PLAN --AS 'Kế hoạch/Phát sinh' 
       ,PR.REQPURCHS_PLAN_ITEM_NM  
       ,PO.INDEX_STR 
       ,PO.SUBMIT_DATE 
       ,PO.ORDER_STATUS_CODE
       ,PO.TOTAL_VND 
       ,PO.OVERALL_TEXT 
       ,PO.PHASE_NAME 
       ,PO.STEP_NAME 
       ,PO.PROCESS_USER 
       ,poc.CONTRACT_NO
       ,poc.TOTAL_PRICE
       ,poc.PO_NUMBER
       ,poc.SIGNED_DATE
       ,poc.DELIVERY_DATE 
       ,poc.CONTRACTOR_NAME
       ,poc.PAY_AMT 
       ,PO.INDICATOR
        ,PR.PR_STATUS 
       ,ROW_NUMBER() OVER (
            PARTITION BY poc.CONTRACT_NO
            ORDER BY PO.TOTAL_VND DESC
        ) AS rn 
    from 
    AGG_PURCHASE_ORDER PO
    full join 
        (Select REG_TITLE, REG_PLAN_YEAR, ORDER_NUMBER, BDTT,PRIORITY_ID, PRIORITY_NAME,BIDDING_TYPE_ID,BIDDING_TYPE_NAME,ORDER_TYPE_ID,
                ORDER_TYPE_NAME, ORDER_PURPOSE_ID,ORDER_PURPOSE_NAME,IMPLEMENT_DEPT_ID,IMPLEMENT_DEPT_NAME,SUBMIT_DATE,TECHNICAL_CODE,
                REG_DEPT_ID ,REG_DEPT_NAME, AUTHOR_ID, AUTHOR_NAME, FIELD_GROUP_ID,FIELD_GROUP_NAME, FIELD_ID, FIELD_NAME, ORDER_TITLE
                ,PART_NUMBER, PART_NAME,
                SUM(COST_ESTIMATE) AS COST_ESTIMATE, 
                SUM(cast([COST_PLAN] as float)) AS COST_PLAN, 
                SUM([COST_ORDER]) AS COST_ORDER, 
                SUM(COST_BDTT_COST) AS COST_BDTT_COST
        from dbo.AGG_REGISTRATION REG
        group by REG_TITLE, REG_PLAN_YEAR, ORDER_NUMBER, BDTT,PRIORITY_ID, PRIORITY_NAME,BIDDING_TYPE_ID,BIDDING_TYPE_NAME,ORDER_TYPE_ID,
                ORDER_TYPE_NAME, ORDER_PURPOSE_ID,ORDER_PURPOSE_NAME,IMPLEMENT_DEPT_ID,IMPLEMENT_DEPT_NAME,SUBMIT_DATE,TECHNICAL_CODE,
                REG_DEPT_ID ,REG_DEPT_NAME, AUTHOR_ID, AUTHOR_NAME, FIELD_GROUP_ID,FIELD_GROUP_NAME, FIELD_ID, FIELD_NAME, ORDER_TITLE
                ,PART_NUMBER, PART_NAME
                ) REG on REG.ORDER_NUMBER = PO.ORDER_NUMBER 
    left join dbo.AGG_PO_CONTRACT poc on PO.ORDER_NUMBER = poc.ORDER_NUMBER 
    left join dbo.AGG_REQ_PURCHS PR on PO.REQ_PUR_DETAIL_ID = PR.REQPURCHS_DT_ID
), 
Subfinal as ---TH1: Nhiều đơn hàng - 1 HD 
(
    Select rankedData.*,
        CASE 
        WHEN rn = 1 THEN TOTAL_PRICE
        ELSE 0
    END AS Display_TOTAL_PRICE, 
    CASE 
        WHEN rn = 1 THEN PAY_AMT
        ELSE 0
    END AS Display_PAY_AMT
    from rankedData
),
final as 
( ---TH2: 1 đơn hàng, YCMS -> nhiều hợp đồng 
select REG_TITLE 
       ,REG_PLAN_YEAR 
       ,TECHNICAL_CODE
       ,ORDER_NUMBER
       ,SERIAL_NUMBER
       ,REG_DEPT_ID 
       ,REG_DEPT_NAME  -- Tên Đơn vị yêu cầu
       ,AUTHOR_ID -- mÃ  
       ,AUTHOR_NAME -- Tên người yêu cầu 
       ,REGSUBMIT_DATE
       ,FIELD_GROUP_ID
       ,FIELD_GROUP_NAME
       ,FIELD_ID 
       ,FIELD_NAME 
       ,ORDER_TITLE
       ,PART_NUMBER
       ,PART_NAME
       ,BDTT
       ,[COST_PLAN]
       ,[COST_ORDER]
       ,[COST_BDTT_COST] 
       ,PRIORITY_ID
       ,PRIORITY_NAME
       ,BIDDING_TYPE_ID
       ,BIDDING_TYPE_NAME
       ,ORDER_TYPE_ID
       ,ORDER_TYPE_NAME 
       ,ORDER_PURPOSE_ID 
       ,ORDER_PURPOSE_NAME
       ,IMPLEMENT_DEPT_ID
       ,IMPLEMENT_DEPT_NAME 
       ,REQPURCHS_DEPARTMENTFUNCTIONIDS 
       ,DEP_FNC_NM 
       ,REQPURCHS_DT_ORDERNUMBER 
       ,REQPURCHS_TITLE 
       ,REQPURCHS_IS_PLAN --AS 'Kế hoạch/Phát sinh' 
       ,REQPURCHS_PLAN_ITEM_NM 
       ,INDEX_STR 
       ,SUBMIT_DATE 
       ,ORDER_STATUS_CODE
       ,TOTAL_VND 
       ,OVERALL_TEXT 
       ,PHASE_NAME 
       ,STEP_NAME 
       ,PROCESS_USER 
       ,COST_ESTIMATE
       ,PR_STATUS
       ,INDICATOR
       ,STRING_AGG(PO_NUMBER, CHAR(13) + CHAR(10)) 
        WITHIN GROUP (ORDER BY CONTRACT_NO) as 'PO_NUMBER'
        ,STRING_AGG(SIGNED_DATE, CHAR(13) + CHAR(10)) 
            WITHIN GROUP (ORDER BY CONTRACT_NO) as 'SIGNED_DATE'
        ,STRING_AGG(DELIVERY_DATE, CHAR(13) + CHAR(10)) 
        WITHIN GROUP (ORDER BY CONTRACT_NO) as 'DELIVERY_DATE'
        ,STRING_AGG(CONTRACTOR_NAME, CHAR(13) + CHAR(10)) 
        WITHIN GROUP (ORDER BY CONTRACT_NO) as 'CONTRACTOR_NAME'
        ,STRING_AGG(CONTRACT_NO, CHAR(13) + CHAR(10)) 
        WITHIN GROUP (ORDER BY CONTRACT_NO) as 'CONTRACT_NO'
      ,SUM(Display_PAY_AMT) AS 'PAY_AMT'    
       ,SUM(Display_TOTAL_PRICE) as 'TOTAL_PRICE'
from subfinal 
 group by 
        REG_TITLE 
       ,REG_PLAN_YEAR 
       ,TECHNICAL_CODE
       ,ORDER_NUMBER
       ,SERIAL_NUMBER
       ,REG_DEPT_ID 
       ,REG_DEPT_NAME  -- Tên Đơn vị yêu cầu
       ,AUTHOR_ID -- 
       ,AUTHOR_NAME -- Tên người yêu cầu 
       ,REGSUBMIT_DATE
       ,SUBMIT_DATE
       ,FIELD_GROUP_ID
       ,FIELD_GROUP_NAME
       ,FIELD_ID 
       ,FIELD_NAME 
       ,ORDER_TITLE
       ,PART_NUMBER
       ,PART_NAME
       ,BDTT
       ,[COST_PLAN]
       ,[COST_ORDER]
       ,[COST_BDTT_COST] 
       ,PRIORITY_ID
       ,PRIORITY_NAME
       ,BIDDING_TYPE_ID
       ,BIDDING_TYPE_NAME
       ,ORDER_TYPE_ID
       ,ORDER_TYPE_NAME 
       ,ORDER_PURPOSE_ID 
       ,ORDER_PURPOSE_NAME
       ,IMPLEMENT_DEPT_ID
       ,IMPLEMENT_DEPT_NAME 
       ,REQPURCHS_DEPARTMENTFUNCTIONIDS 
       ,DEP_FNC_NM 
       ,REQPURCHS_DT_ORDERNUMBER 
       ,REQPURCHS_TITLE 
       ,REQPURCHS_IS_PLAN --AS 'Kế hoạch/Phát sinh' 
       ,REQPURCHS_PLAN_ITEM_NM 
       ,INDEX_STR 
       ,SUBMIT_DATE 
       ,ORDER_STATUS_CODE
       ,TOTAL_VND 
       ,OVERALL_TEXT 
       ,PHASE_NAME 
       ,STEP_NAME 
       ,PROCESS_USER 
       ,COST_ESTIMATE
       ,INDICATOR
       ,PR_STATUS
) 
Select * from final 

