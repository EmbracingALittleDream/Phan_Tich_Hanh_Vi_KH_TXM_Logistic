-- LẤY SỐ KHÁCH HÀNG MỚI, KHÁCH HÀNG CŨ THEO ĐƠN HÀNG

USE LogisticsDB
GO

-- Số lượng tài khoản đã thực hiện thanh toán cho các mặt hàng họ đã đặt trong tháng
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
	AND created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'


-- Số lượng tài khoản đã thực hiện thanh toán cho các mặt hàng họ đã đặt trong tháng nhưng tài khoản của họ được tạo trong cùng tháng
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
	AND created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at >= '2026-01-01'
AND created_at < '2026-02-01'


-- Số lượng tài khoản đã thực hiện thanh toán cho các mặt hàng họ đã đặt trong tháng nhưng tài khoản của họ đã tạo từ trước
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
	AND created_at >= '2026-01-01'
	AND created_at < '2026-02-01'
)
AND role = 'CUSTOMER'
AND status = 'HOAT_DONG'
AND created_at < '2026-01-01'

-- Số lượng khách hàng đã thực hiện thanh toán cho đơn hàng họ đã đặt trong tháng theo kênh
WITH CTE AS (
	SELECT *,
			case
				when lower(trim("source")) in (
					'zalo hotline',
					'group zalo',
					'zalo',
					'zalo duy nhân',
					'zalo tt'
				) then 'Group Zalo'

				when lower(trim("source")) = 'tiktok'
					then 'TikTok'

				when lower(trim("source")) in (
					'fb',
					'facebook',
					'meta',
					'face',
					'f',
					'fb tân phong',
					'facebook (thi dương)',
					'facbook',
					'whatsapp',
					'wa'
				) then 'FaceBook'

				when lower(trim("source")) in (
					'sale',
					'sale tự tìm kiếm'
				) then 'Sale'

				when lower(trim("source")) in (
					'website',
					'web',
					'google'
				) then 'Google'

				when lower(trim("source")) in (
					'được giới thiệu',
					'kh giới thiệu',
					'đạilý',
					'đại lý',
					'tele',
					'thanh x',
					'Ð?ilý'
				) then 'Khach Hang Gioi thieu'

				WHEN source IS NULL THEN 'Khong Xac Dinh Duoc Kenh'

				else
        			"source"
			end	as source_chuan_hoa	
	FROM customer
	WHERE account_id IN (
	SELECT account_id
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
	)
)

SELECT 
	source_chuan_hoa,
	COUNT(account_id) AS counter
FROM CTE 
GROUP BY source_chuan_hoa;

-- Số lượng khách hàng mới theo nguồn
WITH CTE AS (
	SELECT *,
		case
			when lower(trim("source")) in (
				'zalo hotline',
				'group zalo',
				'zalo',
				'zalo duy nhân',
				'zalo tt'
			) then 'Group Zalo'

			when lower(trim("source")) = 'tiktok'
				then 'TikTok'

			when lower(trim("source")) in (
				'fb',
				'facebook',
				'meta',
				'face',
				'f',
				'fb tân phong',
				'facebook (thi dương)',
				'facbook',
				'whatsapp',
				'wa'
			) then 'FaceBook'

			when lower(trim("source")) in (
				'sale',
				'sale tự tìm kiếm'
			) then 'Sale'

			when lower(trim("source")) in (
				'website',
				'web',
				'google'
			) then 'Google'

			when lower(trim("source")) in (
				'được giới thiệu',
				'kh giới thiệu',
				'đạilý',
				'đại lý',
				'tele',
				'thanh x',
				'Ð?ilý'
			) then 'Khach Hang Gioi thieu'

			WHEN source IS NULL THEN 'Khong Xac Dinh Duoc Kenh'

			else
        		"source"
		end	as source_chuan_hoa
	FROM customer
	WHERE account_id IN (
		SELECT account_id
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
	)
)

SELECT 
	source_chuan_hoa,
	COUNT(account_id) AS counter
FROM CTE 
GROUP BY source_chuan_hoa;

-- Số lượng khách hàng cũ theo kênh
WITH CTE AS (
	SELECT *,
		case
			when lower(trim("source")) in (
				'zalo hotline',
				'group zalo',
				'zalo',
				'zalo duy nhân',
				'zalo tt'
			) then 'Group Zalo'

			when lower(trim("source")) = 'tiktok'
				then 'TikTok'

			when lower(trim("source")) in (
				'fb',
				'facebook',
				'meta',
				'face',
				'f',
				'fb tân phong',
				'facebook (thi dương)',
				'facbook',
				'whatsapp',
				'wa'
			) then 'FaceBook'

			when lower(trim("source")) in (
				'sale',
				'sale tự tìm kiếm'
			) then 'Sale'

			when lower(trim("source")) in (
				'website',
				'web',
				'google'
			) then 'Google'

			when lower(trim("source")) in (
				'được giới thiệu',
				'kh giới thiệu',
				'đạilý',
				'đại lý',
				'tele',
				'thanh x',
				'Ð?ilý'
			) then 'Khach Hang Gioi thieu'

			WHEN source IS NULL THEN 'Khong Xac Dinh Duoc Kenh'

			else
        		"source"
		end	as source_chuan_hoa
	FROM customer
	WHERE account_id IN (
		SELECT account_id
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
		AND created_at < '2026-06-01'
	)
)

SELECT 
	source_chuan_hoa,
	COUNT(account_id) AS Counter
FROM CTE 
GROUP BY source_chuan_hoa

