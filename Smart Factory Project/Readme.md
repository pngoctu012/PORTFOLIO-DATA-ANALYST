SMART FACTORY PROJECT
-------------------------------------------------
**1. Description**

This project was conducted for a chemical fertilizer manufacturing plant, focusing on data standardization and storage to enable third-party access via Power BI. The project consisted of two main modules: Production Planning and Plant Maintenance.
My responsibilities included mapping data tables according to business requirements and developing comprehensive test scenarios to ensure data accuracy and consistency across systems. 

---------------------------------------------------
**2. Table Detail Information**

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

Code Mapping: [Here](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/Smart%20Factory%20Project/AGG_PMS_TABLE.sql)

---------------------------------------------------
**3. Test SIT**

In this phase, I was responsible for developing test scripts to validate column-level data mapping between the SOURCE IMAGE and GLD layers. The testing process focused on verifying:

- Record count: Ensuring all expected records were successfully loaded.

- Transformation logic: Validating applied operations such as JOINs, SUM, AVG, and other aggregation rules.

- Data type and format: Checking consistency across numeric, date, and text fields.

- Business rules: Confirming that only data meeting specific criteria (e.g., status = “active”) was correctly loaded into the target layer.

Test script: [Here](https://docs.google.com/spreadsheets/d/16DCfRiaeK_pfVdzqQhOuTIa6ndcsp-8cR-9BZ2z_F1o/edit?gid=0#gid=0)

----------------------------------------------------------
**4. Test UAT**

In this phase, I developed test scenarios based on user business requirements and vendor report validation to ensure dashboards and visualizations aligned with real operational logic.
The testing scope covered verification of measures, KPIs, filters, drill-down functions, and time-period logic to confirm their accuracy and consistency with business rules.

- Vendor Responsibilities:
Since the semantic model and visualizations (including measures such as Revenue, Margin, Count, etc.) were built by the vendor, they were responsible for testing and validating the business logic.

- SVT Team Responsibilities:
The internal SVT team focused on ensuring the accuracy and completeness of the GLD layer, providing the validated data source for the vendor’s testing and reporting.

Test script: [Here](https://docs.google.com/spreadsheets/d/16DCfRiaeK_pfVdzqQhOuTIa6ndcsp-8cR-9BZ2z_F1o/edit?gid=1554758116#gid=1554758116)
