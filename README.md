Trong thư mục Table_Data chứa các file SQL dùng để tạo bảng và thêm các bộ dữ liệu logistic thực vào bảng

Trong thư mục Analyze chứa các file SQL dùng để truy vấn:
1. Khám phá dữ liệu (EDA)
2. Thống kê khách hàng mới -- khách hàng cũ theo tháng và theo nguồn
3. Thống kê và phân tích tỷ lệ chuyển đổi trạng thái từ người dùng mới tạo tài khoản trở thành khách hàng mới
4. Thống kê và phân nhóm các khách hàng thành 3 nhóm: Active, At Risk, Churn (tạo cột mới có kiểu dữ liệu định tính)
5. Phân tích khả năng rời bỏ dịch vụ của khách hàng

Trong thư mục Report chứa file Google Sheet dùng để lưu trữ các giá trị thống kê được thu thập từ các câu lệnh truy vấn SQL

Trong thư mục Visualization chứ các 2 file PowerBi và 1 file LaTeX dùng để trực quan hóa dữ liệu nhanh 
1. Funnel_Analysis_For_New_Customer là file trực quan hóa dữ liệu phân tích tỷ lệ chuyển đổi trạng thái bằng cây phân loại và diễn giải ý nghĩa
2. Phân_Tích_KH_Roi_Bo_DV là file PowerBi dùng để trực quan hóa dữ liệu khách hàng rời bỏ dịch vụ theo kênh, theo tháng
3. TrucQuanHoaDuLieu_TXM_Logistic là file PowerBI dùng để trực quan hóa các số liệu thống kê khách hàng cũ -- khách hàng mới theo nguồn, theo tháng

