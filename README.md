Trong thư mục Table_Data chứa các file SQL dùng để tạo bảng và thêm các bộ dữ liệu logistic thực vào bảng

Trong thư mục Analyze chứa các file SQL dùng để truy vấn:
1. Khám phá dữ liệu (EDA)
2. Thống kê khách hàng mới -- khách hàng cũ theo tháng và theo nguồn
3. Thống kê và phân tích tỷ lệ chuyển đổi trạng thái từ người dùng mới tạo tài khoản trở thành khách hàng mới
4. Thống kê và phân nhóm các khách hàng thành 3 nhóm: Active, At Risk, Churn (tạo cột mới có kiểu dữ liệu định tính)
5. Phân tích khả năng rời bỏ dịch vụ của khách hàng

Trong thư mục Report chứa file Google Sheet dùng để lưu trữ các giá trị thống kê được thu thập từ các câu lệnh truy vấn SQL

Trong thư mục Visualization chứ các 2 file PowerBi và 1 file LaTeX dùng để trực quan hóa dữ liệu nhanh 
1. Phân_Tích_KH_Roi_Bo_DV là file PowerBi dùng để trực quan hóa dữ liệu khách hàng rời bỏ dịch vụ theo kênh, theo tháng
2. TrucQuanHoaDuLieu_TXM_Logistic là file PowerBI dùng để trực quan hóa các số liệu thống kê khách hàng cũ -- khách hàng mới theo nguồn, theo tháng
3. HR_Dashboard.pbix là file chứa source hình ảnh trong PowerBI dùng để trực quan hóa số liệu nhân viên còn làm việc và nhân viên đã nghỉ việc
4. Business_Performance_Dashboard là file chứa source hình ảnh trong PowerBI dùng để trực quan hóa số liệu về đơn đặt hàng của công ty 

Trong thư mục Export_PDF_Visual chứa các file Dashboard có dạng pdf được xuất ra từ PowerBI 
1. HR_Dashboard_OnGoing là Dashboard thống kê số nhân viên đang còn làm việc ở Tiximax
2. HR_Dashboard_Off là Dashboard thống kê số nhân viên đã dừng làm việc ở Tiximax
3. Funnel_Analysis_For_New_Customer là file trực quan hóa dữ liệu phân tích tỷ lệ chuyển đổi trạng thái bằng cây phân loại và diễn giải ý nghĩa
4. Business_Performance_Dashboard thống kê các chỉ số về đơn đặt hàng bằng hình ảnh 1 cách tổng quan, chi tiết theo loại đơn đặt hàng, chi tiết theo ngày đặt hàng
