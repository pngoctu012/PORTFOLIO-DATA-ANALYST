Research Center Digitalization
--------------------------------------------------------
# **1. Introduction**

This project focused on the digital transformation of a research center specializing in crop fertilizers. In this project, I was primarily responsible for developing a budget monitoring and management dashboard for the center.

The project was divided into three main phases:

*Phase 1 – Documentation Analysis:*
Reviewed and converted user-provided documents into structured data tables for storage and Power BI integration. Created initial dashboard prototypes to visualize essential financial and operational data.

*Phase 2 – Requirement Gathering & UI Design:*
Collaborated closely with end users to define KPIs, charts, filters, and key metrics through multiple brainstorming sessions. Designed and iteratively refined UI prototypes based on user feedback to enhance usability and insight delivery.

*Phase 3 – Data Standardization & User Training:*
Worked alongside the data engineering team to standardize and map data across Bronze, Silver, and Gold layers in Azure Synapse. Conducted user training sessions to ensure accurate data entry and proper use of the dashboard according to the established data model.

----------------------------------------------------------------
# **2. Phase 1 – Documentation Analysis**

In this phase, I received the research center’s budget documents for analysis and decomposed them into structured data tables for Power BI integration.
Accordingly, I separated the documents into the following tables:

## **2.1. Table KhoanMucNganSach**

This table follows a hierarchical tree structure used to store the budget report items by month for the Research Center. It includes the following columns:
- item_id: The unique code of each budget item, formatted as year–code.

- name: The name of the budget item.

- parent_id: The name of the parent item.

- level1 – namelevel1: The code and name of the item at Level 1 in the hierarchy.

- level2 – namelevel2: The code and name of the item at Level 2 in the hierarchy.

- level3 – namelevel3: The code and name of the item at Level 3 in the hierarchy.

- level4 – namelevel4: The code and name of the item at Level 4 in the hierarchy.

- level5 – namelevel5: The code and name of the item at Level 5 in the hierarchy. 

|item_id|name|parent_id|level1|level2|level3|level4|level5|name_level1|name_level2|name_level3|name_level4|name_level5|attribute_code|
|-------|----|---------|------|------|------|------|------|-----------|-----------|-----------|-----------|-----------|--------------|
|2025 - 1| KINH PHÍ QUẢN LÝ HOẠT ĐỘNG|nan| 2025 - 1 | 2025 - 1   | 2025 - 1     | 2025 - 1       | 2025 - 1         | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG   | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG| KINH PHÍ QUẢN LÝ HOẠT ĐỘNG   | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG |nan|
| 2025 - 1.1       | Tiền lương và các chế độ | 2025 - 1       | 2025 - 1 | 2025 - 1.1 | 2025 - 1.1   | 2025 - 1.1     | 2025 - 1.1       | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG   | Tiền lương và các chế độ | Tiền lương và các chế độ | Tiền lương và các chế độ | Tiền lương và các chế độ |nan|
| 2025 - 1.1.1     | Lương        | 2025 - 1.1     | 2025 - 1 | 2025 - 1.1 | 2025 - 1.1.1 | 2025 - 1.1.1   | 2025 - 1.1.1     | KINH PHÍ QUẢN LÝ HOẠT ĐỘNG   | Tiền lương và các chế độ  | Lương    | Lương                | Lương    |nan|
| 2025 - 2.1.1.1   | Hoạt động 1: Nghiên cứu về các dòng vi sinh vật và điều kiện sản xuất sản phẩm                                                                                                                                                                    | 2025 - 2.1.1   | 2025 - 2 | 2025 - 2.1 | 2025 - 2.1.1 | 2025 - 2.1.1.1 | 2025 - 2.1.1.1   | KINH PHÍ NGHIÊN CỨU KHOA HỌC | Kinh phí thực hiện các đề tài, nhiệm vụ KHCN | MỤC TIÊU 1: Nghiên cứu đa dạng hóa sản phẩm theo chiến lược của Công ty                                                      | Hoạt động 1: Nghiên cứu về các dòng vi sinh vật và điều kiện sản xuất sản phẩm                                               | Hoạt động 1: Nghiên cứu về các dòng vi sinh vật và điều kiện sản xuất sản phẩm                                                                                                                                                                    |TC01|
| 2025 - 2.2.1.2   | Hoạt động 2: Thí nghiệm, khảo nghiệm đánh giá thêm và hoàn thiện bộ giải pháp dinh dưỡng cho các sản phẩm đã kinh doanh                                                                                                                           | 2025 - 2.2.1   | 2025 - 2 | 2025 - 2.2 | 2025 - 2.2.1 | 2025 - 2.2.1.2 | 2025 - 2.2.1.2   | KINH PHÍ NGHIÊN CỨU KHOA HỌC | Kinh phí Hỗ trợ phát triển KH&CN             | MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu | Hoạt động 2: Thí nghiệm, khảo nghiệm đánh giá thêm và hoàn thiện bộ giải pháp dinh dưỡng cho các sản phẩm đã kinh doanh      | Hoạt động 2: Thí nghiệm, khảo nghiệm đánh giá thêm và hoàn thiện bộ giải pháp dinh dưỡng cho các sản phẩm đã kinh doanh                                                                                                                           |TC04|
| 2025 - 2.2.1.2.1 | Thuê dịch vụ hỗ trợ triển khai công tác thí nghiệm/khảo nghiệm tại địa điểm hợp tác NCKH (Viện Sinh học Nhiệt đới TP.HCM)                                                                                                                         | 2025 - 2.2.1.2 | 2025 - 2 | 2025 - 2.2 | 2025 - 2.2.1 | 2025 - 2.2.1.2 | 2025 - 2.2.1.2.1 | KINH PHÍ NGHIÊN CỨU KHOA HỌC | Kinh phí Hỗ trợ phát triển KH&CN             | MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu | Hoạt động 2: Thí nghiệm, khảo nghiệm đánh giá thêm và hoàn thiện bộ giải pháp dinh dưỡng cho các sản phẩm đã kinh doanh      | Thuê dịch vụ hỗ trợ triển khai công tác thí nghiệm/khảo nghiệm tại địa điểm hợp tác NCKH (Viện Sinh học Nhiệt đới TP.HCM)                                                                                                                         |TC04|
| 2025 - 2.2.1.3   | Hoạt động 3: Mua sắm tài liệu chuyên môn                                                                                                                                                                                                          | 2025 - 2.2.1   | 2025 - 2 | 2025 - 2.2 | 2025 - 2.2.1 | 2025 - 2.2.1.3 | 2025 - 2.2.1.3   | KINH PHÍ NGHIÊN CỨU KHOA HỌC | Kinh phí Hỗ trợ phát triển KH&CN             | MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu | Hoạt động 3: Mua sắm tài liệu chuyên môn                                                                                     | Hoạt động 3: Mua sắm tài liệu chuyên môn                                                                                                                                                                                                          |TC04|
| 2025 - 2.2.1.4   | Hoạt động 4: Tổ chức họp hội đồng xét duyệt, nghiệm thu đề tài, kết quả khảo nghiệm                                                                                                                                                               | 2025 - 2.2.1   | 2025 - 2 | 2025 - 2.2 | 2025 - 2.2.1 | 2025 - 2.2.1.4 | 2025 - 2.2.1.4   | KINH PHÍ NGHIÊN CỨU KHOA HỌC | Kinh phí Hỗ trợ phát triển KH&CN             | MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu | Hoạt động 4: Tổ chức họp hội đồng xét duyệt, nghiệm thu đề tài, kết quả khảo nghiệm                                          | Hoạt động 4: Tổ chức họp hội đồng xét duyệt, nghiệm thu đề tài, kết quả khảo nghiệm                                                                                                                                                               |TC04|

## **2.2. Table GiaiNgan**

This table is used to record the disbursement transactions of the Research Center related to production expenses and investments in science and technology. It includes the following columns:

- posting_id: The transaction posting code.

- posting_date: The posting date.

- voucher_no: The voucher number.

- voucher_date: The voucher date.

- payment_voucher_no: The payment voucher number (UNC/PC).

- payment_voucher_date: The payment voucher date.

- account_code: The accounting account code.

- doc_type: The document type.

- description: A brief description of the transaction.

- amount: The disbursed amount.

- item_id: The budget item code.

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

|posting_id|posting_date|voucher_no|voucher_date|payment_voucher_no|payyment_voucher_date|account_code|doc_type|description|amount|item_id|source_type|
|----------|------------|----------|------------|------------------|---------------------|------------|--------|-----------|------|-------|-----------|
|1|31/08/2025|2521000233|31/08/2025|nan|nan|2412000094|AA|KC VAT DV tháng 8 HÐ 01/HDDV-NCPT/PVCFC-MNM|12038248|2025 - 2.2.1.2.5|KHCN|

## **2.3. Table GiaiNgan_Luong**

This table is used to record the Research Center’s disbursement transactions related to salary expenses, such as wages, social insurance, etc. I separated salary disbursements into a dedicated table because they are recorded monthly, while other expenses are recorded daily. The table includes the following columns:

- hr_posting_id: The salary disbursement posting code.

- item_id: The budget item code.

- month: The month of the transaction record.

- amount: The disbursed amount.

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

|hr_posting_id|item_id|month|amount|source_type|
|-------------|-------|-----|------|-----------|
|1|2025 - 1.1.1|1|1273710471|SXKD|

## **2.4. Table KeHoach**

This table is used to record the Research Center’s planned budgets for production expenses and investments in science and technology. It includes the following columns:

- budget_id: The budget plan code.

- month: The planning month.

- amount: The planned amount.

- item_id: The budget item code.

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

- status: Indicates whether the plan was established at the beginning of the year or newly added during the year (“Phát sinh” – Newly added, “Không phát sinh” – Original plan).

|budget_id|month|amount|item_id|source_type|status|
|---------|-----|------|-------|-----------|------|
|KH1|3|200000000|2025 - 2.1.1.1.1|KHCN|Không phát sinh|

## **2.5. Table ThucHien**

This table is used to record the actual expenses based on contract values of the Research Center, covering both production costs and investments in science and technology. It includes the following columns:

- PO_number: The contract number.

- item_id: The budget item code.

- amount: The actual expense amount.

- contract_date: The contract signing date.

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

|PO_number|item_id|amount|contract_date|source_type|
|---------|-----|------|-------|-----------|
|5100007397|2025 - 2.1.1.1.1|8040000|25/01/2025|KHCN|

## **2.6. Table NguonVon**

This table is used to record the funds received from the parent company by the Research Center on a quarterly basis. It includes the following columns:

- capital_source_code: The capital source code.

- posting_date: The posting date.

- voucher_no: The voucher number.

- voucher_date: The voucher date.

- description: A description of the transaction.

- account_code: The accounting account code.

- amount: The amount of capital received.

|capital_source_code|posting_date|voucher_no|voucher_date|description|account_code|amount|
|-------------------|------------|----------|------------|-----------|------------|------|
|NV1|13/01/2025|2512010002|13/01/2025|Nhận KP hoạt động quý 1-2025 theo QĐ 52|1121030202|5000000000|

## **2.7. Table TinhChatMucTieu**

Because the objectives may vary from year to year but share the same characteristics, this table was created for that purpose. It includes the following columns:
- attribute_code: The attribute code.

- attribute_name: The attribute name.

- department: The responsible department.

|attribute_code|attribute_name|department|
|--------------|--------------|----------|
|TC01|Mục tiêu 1: Đa dạng hoá sản phẩm|Phòng Nghiên cứu|
|TC02|Mục tiêu 2: Nghiên cứu về bộ giải pháp canh tác|Phòng Nông học|
|TC03|Mục tiêu 3: Nghiên cứu về công nghệ sau thu hoạch|Phòng Công nghệ sau thu hoạch|
|TC04|Mục tiêu 4: Tăng cường cơ sở vật chất - Hỗ trợ KHCN|Phòng Kế hoạch thương mại|

## **2.8. Bảng union_bar_chart**

This table was created to meet the requirement of tracking expenses by both objectives and operational costs. Since operational cost items are located at Level 2 in the hierarchy tree while objectives are at Level 3, they could not be displayed together in the same chart. Therefore, I brainstormed a solution to introduce a node_type column to distinguish between objectives and operational costs. The table includes the following columns:
- year: The year in which the expenses are recorded.

- node_type: A column used to categorize items (values include: "Chi phí hoạt động", "MỤC TIÊU 1: Nghiên cứu đa dạng hoá sản phẩm theo chiến lược của công ty", "MỤC TIÊU 2: Nghiên cứu quy trình canh tác trên cây trồng", "MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu", "MỤC TIÊU 3: Nghiên cứu về công nghệ sau thu hoạch")

- amount: The expense amount.

- cost_type: The type of cost (values include: "Giải ngân", "Kế hoạch", "Thực hiện")

|year|node_type|amount|cost_type|
|----|---------|------|---------|
|2025|MỤC TIÊU 3: Nghiên cứu về công nghệ sau thu hoạch|18375000|Giải ngân|

## **2.9. Table union_du_phong**

This table was created to meet the requirement of tracking expense types related to contingency (reserve) items. Similar to the previous issue, the contingency costs for Production & Business (SXKD) and Science & Technology (KHCN) exist at different hierarchy levels, so they needed to be consolidated for chart visualization.

The table includes the following columns:
- year: The year in which the expenses are recorded.

- node_type: A column used to categorize items (only includes the value "Dự phòng")

- amount: The expense amount.

- cost_type: The type of cost (values include: "Giải ngân", "Kế hoạch", "Thực hiện")

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

|year|node_type|amount|cost_type|source_type|
|----|---------|------|---------|-----------|
|2025|Dự phòng|533117000|Kế hoạch|SXKD|

## **2.10. Table union_table**

This table was created to meet the requirement of tracking expenses by each budget item. However, the user requested to view monthly disbursement expenses (for all 12 months) together with annual planned, disbursed, and actual expenses within the same matrix. Therefore, I introduced the node_type column to categorize monthly and yearly expense types accordingly.

The table includes the following columns:
- item_id: The budget item code.

- node_type: A column used to categorize items (values include: "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", 'Giải ngân", "Kế hoạch", "Thực hiện")

- year: The year in which the expenses are recorded.

- amount: The expense amount.

- source_type: The type of cost source (two types: “SXKD” – Production & Business, and “KHCN” – Science & Technology).

|item_id|node_type|year|amount|source_type|
|-------|---------|----|------|-----------|
|2024 - 1.2.1.18|Giải ngân|2024|2200000|SXKD|

----------------------------------------------------------------
# **3. Phase 2 – Requirement Gathering & UI Design**

In this phase, I worked onsite at the client’s company to gather and clarify user requirements. Based on these discussions, I refined the dashboard UI to best align with the users’ needs and expectations.
You can refer to the client’s detailed requirements [Here](https://docs.google.com/spreadsheets/d/1I1sp5kQhfaQMg6ObeyzJdy1R5hwzAKTp7uh-C-FVrnc/edit?usp=sharing)

The finalized dashboard consists of two main pages:
*Overview Page:*
<img width="1422" height="798" alt="image" src="https://github.com/user-attachments/assets/cddef739-38a3-42bc-b67b-6249f0503a9c" />
<img width="1425" height="800" alt="image" src="https://github.com/user-attachments/assets/286a26f1-8b5a-4bf9-bfd0-02f1249c01ce" />

*Detail Page:*
<img width="1428" height="799" alt="image" src="https://github.com/user-attachments/assets/2e2c9d10-74ba-4aba-849c-4b264d8f8f3f" />

*Due to data confidentiality, I am unable to make the Power BI file publicly available.*

----------------------------------------------------------------
# **4. Phase 3 – Data Standardization & User Training**

In this phase, my main responsibility was to collaborate with the Data Engineering team to develop data entry templates that guide the client in inputting information according to their requirements. I also worked on data mapping to enable the Data Engineering team to integrate the data into the Bronze, Silver, and Gold layers.

You can refer to my data standardization file at [Here](https://docs.google.com/spreadsheets/d/1ntJxwTiVIoimatcvIdWPxkfUXc-mYf5gysx4Eb-OIj4/edit?usp=sharing)

You can refer to my mapping file at [Here](https://docs.google.com/spreadsheets/d/119ViW7jXaYFH2L2y14DkZTxuQQyINyGkce2lWPnb-fc/edit?usp=sharing)

