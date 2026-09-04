-- LẤY SỐ ĐỂ PHÂN TÍCH PHỄU TỶ LỆ CHUYỂN ĐỔI KHÁCH HÀNG MỚI

USE LogisticsDB
GO

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 1
SELECT COUNT(account_id) AS SoKHTaoTKTh1
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-01-01'
AND created_at < '2026-02-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND created_at >= '2026-01-01'
AND created_at < '2026-02-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id NOT IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-01-01'
AND created_at < '2026-02-01'

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 2
SELECT COUNT(account_id) AS SoKHTaoTKTh2
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-02-01'
AND created_at < '2026-03-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id NOT IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-02-01'
	AND created_at < '2026-03-01'
)
AND created_at >= '2026-02-01'
AND created_at < '2026-03-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-02-01'
	AND created_at < '2026-03-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-02-01'
AND created_at < '2026-03-01'

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 3
SELECT COUNT(account_id) AS SoKHTaoTKTh3
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-03-01'
AND created_at < '2026-04-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-03-01'
	AND created_at < '2026-04-01'
)
AND created_at >= '2026-03-01'
AND created_at < '2026-04-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-03-01'
	AND created_at < '2026-04-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-03-01'
AND created_at < '2026-04-01'

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 4
SELECT COUNT(account_id) AS SoKHTaoTKTh4
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-04-01'
AND created_at < '2026-05-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id NOT IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-04-01'
	AND created_at < '2026-05-01'
)
AND created_at >= '2026-04-01'
AND created_at < '2026-05-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-04-01'
	AND created_at < '2026-05-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-04-01'
AND created_at < '2026-05-01'

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 5
SELECT COUNT(account_id) AS SoKHTaoTKTh5
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-05-01'
AND created_at < '2026-06-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-05-01'
	AND created_at < '2026-06-01'
)
AND created_at >= '2026-05-01'
AND created_at < '2026-06-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id NOT IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-05-01'
	AND created_at < '2026-06-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-05-01'
AND created_at < '2026-06-01'

-- Có bao nhiêu khách hàng tạo tài khoản trong tháng 6
SELECT COUNT(account_id) AS SoKHTaoTKTh6
FROM account
WHERE role = 'Customer'
AND status = 'HOAT_DONG'
AND created_at >=  '2026-06-01'
AND created_at < '2026-07-01'

-- Số tài khoản phát sinh hoặc không phát sinh đơn hàng
SELECT *
FROM account
WHERE account_id NOT IN (
	SELECT customer_id
	FROM orders
	WHERE created_at >= '2026-06-01'
	AND created_at < '2026-07-01'
)
AND created_at >= '2026-06-01'
AND created_at < '2026-07-01'
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'

-- Số tài khoản có phát sinh đơn hàng nhưng có thể có thanh toán hoặc không thanh toán cho đơn hàng đã đặt
SELECT *
FROM account
WHERE account_id IN (
	SELECT customer_id
	FROM orders
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
	AND created_at >= '2026-06-01'
	AND created_at < '2026-07-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-06-01'
AND created_at < '2026-07-01'

-- Lý do phát sinh đơn hàng nhưng không thanh toán
SELECT *
FROM orders
WHERE customer_id IN (
	SELECT account_id
	FROM account
	WHERE account_id IN (
		SELECT customer_id
		FROM orders
		WHERE customer_id NOT IN (
			SELECT customer_id
			FROM payment
			WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
			AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
		)
		AND created_at >= '2026-01-01'
		AND created_at < '2026-02-01'
	)
	AND role = 'CUSTOMER'
	AND status = 'HOAT_DONG'
	AND created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND order_type = 'KY_GUI'
AND status = 'DA_HUY'
ORDER BY order_type

/* 
-- Nhận xét:
-- Đối với đơn mua hộ trạng thái đơn hàng: đã hủy, chờ thanh toán, chờ xác nhận, đã xác nhận
-- Đối với đơn ký gửi trạng thái đơn hàng: đã hủy, chờ nhập kho nước ngoài
-- Đối với đơn đấu giá trạng thái đơn hàng: đã hùy
*/

