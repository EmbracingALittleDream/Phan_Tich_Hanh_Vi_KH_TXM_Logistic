USE LogisticsDB
GO


SELECT 
	account_id, -- Mã id của tài khoản
	created_at, -- Ngày tạo tài khoản
	role,		-- Chức vụ
	status,		-- Trạng thái của tài khoản
	name		-- Tên của người dùng tài khoản
FROM account

SELECT 
	source,		-- Kênh khách hàng tiếp cận
	account_id	-- Má id tài khoản của khách hàng
FROM customer

SELECT 
	order_id,				-- Mã id của đơn hàng
	customer_id,			-- Mã id khách hàng thực hiện đặt hàng
	staff_id,				-- Mã id của nhân viên chăm sóc khách hàng
	created_at,				-- Thời gian nhân viên sale tạo đơn hàng trên hệ thống
	exchange_rate,			-- Tỷ giá
	final_price_order,		-- Gía chốt đơn hàng
	order_code,				-- Mã code của đơn hàng
	order_type,				-- Loại giao dịch của đơn hàng
	status,					-- Trạng thái của đơn hàng
	route_id,				-- Mã id của tuyến vận chuyển (tuyến mẹ)
	operational_route_id,	-- Mã id chi tiết cho tuyến vận chuyển (tuyến con)
	flow_type				-- 
FROM orders

SELECT 
	payment_id,			-- Mã id thanh toán giao dịch
	action_at,			-- Thời gian phiếu thanh toán được tạo
	collected_amount,	-- Số tiền khách hàng chuyển
	payment_code,		-- Mã code của thanh toán giao dịch
	status,				-- Trạng thái thanh toán giao dịch
	customer_id,		-- Mã id của khách hàng thực hiện thanh toán
	order_id,			-- Mã id của đơn hàng được thanh toán
	staff_id,			-- Mã id của nhân viên thực hiện tạo phiếu thanh toán cho khách hàng
	purpose,			-- Mục đích thanh toán đơn hàng
	paid_time			-- Thời gian khách hàng thanh toán giao dịch
FROM payment


/* EDA */

SELECT 
	order_id,				-- Mã id của đơn hàng
	customer_id,			-- Mã id khách hàng thực hiện đặt hàng
	staff_id,				-- Mã id của nhân viên chăm sóc khách hàng
	created_at,				-- Thời gian nhân viên sale tạo đơn hàng trên hệ thống
	exchange_rate,			-- Tỷ giá
	final_price_order,		-- Gía chốt đơn hàng
	order_code,				-- Mã code của đơn hàng
	order_type,				-- Loại giao dịch của đơn hàng
	status,					-- Trạng thái của đơn hàng
	route_id,				-- Mã id của tuyến vận chuyển (tuyến mẹ)
	operational_route_id,	-- Mã id chi tiết cho tuyến vận chuyển (tuyến con)
	flow_type				-- 
FROM orders
ORDER BY customer_id

/* 
-- Một khách hàng có thể đặt nhiều đơn hàng và mỗi đơn hàng mà khách hàng đặt có mã id riêng 
--> Khách hàng -- (0,n) -- tập mối kết hợp -- (1,1) -- Đơn hàng

-- Một nhân viên có thể chăm sóc nhiều khách hàng và một khách hàng chỉ được chăm sóc bởi một nhân viên
--> Nhân viên -- (0,n) -- tập mối kết hợp -- (1,1) -- Khách hàng
*/

SELECT 
	payment_id,			-- Mã id thanh toán giao dịch
	customer_id,		-- Mã id của khách hàng thực hiện thanh toán
	order_id,			-- Mã id của đơn hàng được thanh toán
	staff_id,			-- Mã id của nhân viên thực hiện tạo phiếu thanh toán cho khách hàng
	collected_amount,	-- Số tiền khách hàng chuyển
	payment_code,		-- Mã code của thanh toán giao dịch
	status,				-- Trạng thái thanh toán giao dịch
	purpose,			-- Mục đích thanh toán đơn hàng
	action_at,			-- Thời gian phiếu thanh toán được tạo
	paid_time			-- Thời gian khách hàng thanh toán giao dịch
FROM payment
ORDER BY customer_id


/* 
-- Một khách hàng có thể thanh toán nhiều đơn hàng và mỗi lần thanh toán có id riêng cho từng id đơn đặt hàng 
--> Khách hàng -- (0,n) -- tập mối kết hợp -- (1,1) -- Thanh toán

-- Một đơn đặt hàng có thể có nhiều lần thanh toán và mỗi lần thanh toán có mã id riêng cho cùng 1 đơn hàng
--> Đơn hàng -- (0,n) -- tập mối kết hợp -- (1,n) -- Thanh toán 
*/

-- Miền giá trị của thuộc tính định tính role 
SELECT DISTINCT role
FROM account

-- Miền giá trị của thuộc tính định tính status
SELECT DISTINCT status
FROM account

-- Miền giá trị của thuộc tính định tính order_type
SELECT DISTINCT order_type
FROM orders

-- Miền giá trị của thuộc tính định tính status
SELECT DISTINCT status
FROM orders

-- Miền giá trị của thuộc tính định tính status
SELECT DISTINCT status
FROM payment

-- Miền giá trị của thuộc tính định tính purpose
SELECT DISTINCT purpose
FROM payment

-- Miền giá trị của thuộc tính định tính source
SELECT DISTINCT source
FROM customer


