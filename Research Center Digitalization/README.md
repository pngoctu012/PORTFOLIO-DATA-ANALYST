Research Center Digitalization
--------------------------------------------------------
**1. Introduction**

Đây là một dự án chuyển đổi số cho trung tâm nghiên cứu phân bón cho cây trồng. Ở dự án này, tôi chịu trách nhiệm chính trong việc tham gia xây dựng dashboard theo dõi và quản lý ngân sách cho trung tâm.

Dự án này bao gồm 4 phase chính:

*Phase 1 – Documentation Analysis:* Reviewed and decomposed user-provided documentation into structured data tables for storage and Power BI integration. Prepared initial dashboard demos to visualize key data points.

*Phase 2 – Requirement Gathering & UI Design:* Collaborated directly with end users to define KPIs, charts, views, slicers and metrics through brainstorming sessions. Designed and refined UI prototypes based on user feedback.

*Phase 3 – Data Standardization & User Training:* Worked with the data engineering team to map data across Bronze, Silver and Golden layers in Azure Synapse. Conducted user training sessions to ensure proper data entry aligned with mapped structures.

*Phase 4 – Testing (SIT & UAT):* Developed and executed SIT test scripts to validate data flow from Source Image to Golden Layer. Guided users in performing UAT, managing defect logging, and writing UAT test scenarios.

----------------------------------------------------------------
**2. Phase 1 – Documentation Analysis**

Ở giai đoạn này tôi sẽ nhận các file tài liệu về ngân sách của Trung tâm nghiên cứu để phân tích và tách ra thành các bảng dữ liệu có cấu trúc để đưa lên PowerBI. 
Theo đó, tôi tách các file tài liệu thành các bảng sau:

**2.1. Bảng KhoanMucNganSach**

Đây là bảng với dạng cây hierarchy dùng để lưu lại các đầu mục trong báo cáo ngân sách theo tháng của Trung tâm nghiên cứu. Bao gồm các cột:
- item_id: là mã khoản mục, format theo dạng năm - mã

- name: là tên khoản mục

- parent_id: là tên khoản mục cha

- level1 - namelevel1: là mã và tên của khoản mục ở level 1 trong cây hierarchy.

- level2 - namelevel2: là mã và tên của khoản mục ở level 2 trong cây hierarchy.

- level3 - namelevel3: là mã và tên của khoản mục ở level 3 trong cây hierarchy.

- level4 - namelevel4: là mã và tên của khoản mục ở level 4 trong cây hierarchy.
 
- level5 - namelevel5: là mã và tên của khoản mục ở level 5 trong cây hierarchy. 

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

**2.2. Bảng GiaiNgan**

Đây là bảng được dùng để ghi nhận các hạch toán giải ngân của Trung tâm nghiên cứu về các chi phí sản xuất và chi phí đầu tư vào khoa học công nghệ. Bao gồm các cột:
- posting_id: là mã hạch toán

- posting_date: là ngày hạch toán

- voucher_no: là số chứng từ

- voucher_date: là ngày chứng từ

- payment_voucher_no: là số chứng từ thanh toán (UNC/PC)

- payment_voucher_date: là ngày chứng từ thanh toán

- account_code: là mã tài khoản kế toán

- doc_type: là loại chứng từ

- description: là mô tả

- amount: là số tiền giải ngân

- item_id: là mã khoản mục ngân sách

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ)

|posting_id|posting_date|voucher_no|voucher_date|payment_voucher_no|payyment_voucher_date|account_code|doc_type|description|amount|item_id|source_type|
|----------|------------|----------|------------|------------------|---------------------|------------|--------|-----------|------|-------|-----------|
|1|31/08/2025|2521000233|31/08/2025|nan|nan|2412000094|AA|KC VAT DV tháng 8 HÐ 01/HDDV-NCPT/PVCFC-MNM|12038248|2025 - 2.2.1.2.5|KHCN|

**2.3. Bảng GiaiNgan_Luong**

Đây là bảng được dùng để ghi nhận các hạch toán của Trung tâm nghiên cứu về các chi phí giải ngân liên quan tới lương như tiền lương, bảo hiểm xã hội,... Ở đây, tôi tách chi phí giải ngân lương ra thành một bảng riêng vì nó được ghi nhận theo từng tháng còn các chi phí khác thì được ghi nhận theo từng ngày. Bao gồm các cột:

- hr_posting_id: là mã hạch toán giải ngân lương

- item_id: là mã khoản mục ngân sách

- month: là tháng ghi nhận hạch toán

- amount: là số tiền giải ngân

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ) 

|hr_posting_id|item_id|month|amount|source_type|
|-------------|-------|-----|------|-----------|
|1|2025 - 1.1.1|1|1273710471|SXKD|

**2.4. Bảng KeHoach**
Đây là bảng được dùng để ghi nhận các kế hoạch của Trung tâm nghiên cứu về các chi phí sản xuất và chi phí đầu tư vào khoa học công nghệ. Bao gồm các cột:
- budget_id: là mã kế hoạch

- month: là tháng kế hoạch

- amount: là số tiền kế hoạch

- item_id: là mã khoản mục ngân sách

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ)

- status: là tình trạng là kế hoạch từ đầu năm hoặc là phát sinh trong năm (gồm 2 giá trị là "Phát sinh" và "Không phát sinh")

|budget_id|month|amount|item_id|source_type|status|
|---------|-----|------|-------|-----------|------|
|KH1|3|200000000|2025 - 2.1.1.1.1|KHCN|Không phát sinh|

**2.5. Bảng ThucHien**

Đây là bảng được dùng để ghi nhận các chi phí thực hiện được lấy theo giá trị hợp đồng của Trung tâm nghiên cứu về các chi phí sản xuất và chi phí đầu tư vào khoa học công nghệ. Bao gồm các cột:
- PO_number: là số hợp đồng

- item_id: là mã khoản mục ngân sách

- amount: là số tiền thực hiện

- contract_date: là ngày ký hợp đồng

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ)

|PO_number|item_id|amount|contract_date|source_type|
|---------|-----|------|-------|-----------|
|5100007397|2025 - 2.1.1.1.1|8040000|25/01/2025|KHCN|

**2.6. Bảng NguonVon**

Đây là bảng được dùng để ghi nhận số tiền nhận được từ công ty mẹ của Trung tâm nghiên cứu cho từng quý. Bao gồm các cột:
- capital_source_code: là mã nguồn vốn

- posting_date: là ngày hạch toán

- voucher_no: là số chứng từ

- voucher_date: là ngày chứng từ

- description: là mô tả nội dung

- account_code: là tài khoản kế toán

- amount: là số tiền được cấp

- year: là năm được cấp tiền

|capital_source_code|posting_date|voucher_no|voucher_date|description|account_code|amount|year|
|-------------------|------------|----------|------------|-----------|------------|------|----|
|NV1|13/01/2025|2512010002|13/01/2025|Nhận KP hoạt động quý 1-2025 theo QĐ 52|1121030202|5000000000|2025|

**2.7. Bảng TinhChatMucTieu**

Bởi vì các mục tiêu ở các năm có thể sẽ khác nhau nhưng đều mang cùng 1 tính chất, đây là lí do xuất hiện bảng này. Gồm các cột:
- attribute_code: là mã tính chất

- attribute_name: là tên tính chất

- department: là phòng ban chịu trách nhiệm

|attribute_code|attribute_name|department|
|--------------|--------------|----------|
|TC01|Mục tiêu 1: Đa dạng hoá sản phẩm|Phòng Nghiên cứu|
|TC02|Mục tiêu 2: Nghiên cứu về bộ giải pháp canh tác|Phòng Nông học|
|TC03|Mục tiêu 3: Nghiên cứu về công nghệ sau thu hoạch|Phòng Công nghệ sau thu hoạch|
|TC04|Mục tiêu 4: Tăng cường cơ sở vật chất - Hỗ trợ KHCN|Phòng Kế hoạch thương mại|

**2.8. Bảng union_bar_chart**

Đây là bảng được hình thành dựa vào yêu cầu theo dõi các chi phí theo mục tiêu và chi phí hoạt động. Bởi vì khoản mục chi phí hoạt động đang nằm ở level 2 trong cây hierarchy nhưng các mục tiêu lại nằm ở level 3 trong cây hierarchy nên không thể đưa vào chart được. Chính vì thế nên tôi đã brainstorm ra được giải pháp là tạo ra một cột node_type để đánh dấu cái nào là mục tiêu, cái nào là chi phí hoạt động. Gồm các cột:
- year: là năm ghi nhận các chi phí

- node_type: là cột đánh dấu các đầu mục (gồm các giá trị: "Chi phí hoạt động", "MỤC TIÊU 1: Nghiên cứu đa dạng hoá sản phẩm theo chiến lược của công ty", "MỤC TIÊU 2: Nghiên cứu quy trình canh tác trên cây trồng", "MỤC TIÊU 4: Tăng cường cơ sở vật chất và nguồn lực triển khai các hoạt động hỗ trợ KHCN đáp ứng nhu cầu hoạt động nghiên cứu", "MỤC TIÊU 3: Nghiên cứu về công nghệ sau thu hoạch")

- amount: là số tiền

- cost_type: là loại chi phí (gồm các giá trị: "Giải ngân", "Kế hoạch", "Thực hiện")

|year|node_type|amount|cost_type|
|----|---------|------|---------|
|2025|MỤC TIÊU 3: Nghiên cứu về công nghệ sau thu hoạch|18375000|Giải ngân|

**2.9. Bảng union_du_phong**

Đây là bảng được hình thành dựa vào yêu cầu theo dõi các loại chi phí theo khoản mục dự phòng, tương tự như vấn đề ở trên, chi phí dự phòng cho CPSX và KHCN đều đang ở những level khác nhau nên cần gộp lại để đưa lên chart. Bao gồm các cột:
- year: là năm ghi nhận các chi phí

- node_type: là cột đánh dấu các đầu mục (chỉ gồm giá trị "Dự phòng")

- amount: là số tiền

- cost_type: là loại chi phí (gồm các giá trị: "Giải ngân", "Kế hoạch", "Thực hiện")

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ)

|year|node_type|amount|cost_type|source_type|
|----|---------|------|---------|-----------|
|2025|Dự phòng|533117000|Kế hoạch|SXKD|

**2.10. Bảng union_table**

Đây là bảng được hình thành dựa vào yêu cầu theo dõi các loại chi phí theo từng khoản mục. Tuy nhiên, yêu cầu của User là cần xem chi phí giải ngân theo 12 tháng đồng thời xem chi phí kế hoạch, giải ngân và thực hiện theo năm trên cùng một matrix nên tôi cần thể hiện lên cột node_type để phân loại chi phí giải ngân theo các tháng và các chi phí theo năm. Bao gồm các cột:
- item_id: là mã khoản mục ngân sách

- node_type: là cột đánh dấu các đầu mục (gồm các giá trị: "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", 'Giải ngân", "Kế hoạch", "Thực hiện")

- year: là năm ghi nhận các chi phí

- amount: là số tiền

- source_type: là loại nguồn chi phí (có 2 loại là "SXKD" - sản xuất kinh doanh và "KHCN" - khoa học công nghệ)

|item_id|node_type|year|amount|source_type|
|-------|---------|----|------|-----------|
|2024 - 1.2.1.18|Giải ngân|2024|2200000|SXKD|

----------------------------------------------------------------
**3. Phase 2 – Requirement Gathering & UI Design**
Ở giai đoạn này, tôi sẽ onsite tại công ty của khách hàng để khơi gợi yêu cầu của User, từ đó sẽ chỉnh sửa lại UI dashboard sao cho phù hợp với yêu cầu của User nhất.
Tham khảo các yêu cầu của khác hàng [Here](https://docs.google.com/spreadsheets/d/1I1sp5kQhfaQMg6ObeyzJdy1R5hwzAKTp7uh-C-FVrnc/edit?usp=sharing)

Dashboard sau khi đã chốt sẽ bao gồm 2 page là: 
*Trang tổng quan:*
<img width="1422" height="798" alt="image" src="https://github.com/user-attachments/assets/cddef739-38a3-42bc-b67b-6249f0503a9c" />
<img width="1425" height="800" alt="image" src="https://github.com/user-attachments/assets/286a26f1-8b5a-4bf9-bfd0-02f1249c01ce" />

*Trang chi tiết*
<img width="1428" height="799" alt="image" src="https://github.com/user-attachments/assets/2e2c9d10-74ba-4aba-849c-4b264d8f8f3f" />

----------------------------------------------------------------
**4. Phase 3 – Data Standardization & User Training**
Ở giai đoạn này, nhiệm vụ của tôi là làm việc với team Data Engineer để tạo ra các templates để hướng dẫn khách hàng nhập liệu theo ý muốn của mình và mapping để team DE kéo lên các bảng ở tầng Bronze, Silver và Golden.


