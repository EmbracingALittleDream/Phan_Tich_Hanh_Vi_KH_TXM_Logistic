USE LogisticsDB
GO

WITH CTE AS (
	SELECT 
		customer_id,
		created_at,
		LEAD(created_at) OVER(
			PARTITION BY customer_id
			ORDER BY created_at
		) AS next_order_date
	FROM orders
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment
		WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
		AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
	)
),
NCTE AS (
	SELECT 
		customer_id,
		AVG(
			DATEDIFF(DAY, created_at, next_order_date) * 1.0
		) AS avg_days_between_orders,
		MAX(created_at) AS NgayDHGanNhat,
		MIN(created_at) AS NgayDHXaNhat
	FROM CTE 
	GROUP BY customer_id
),
NNCTE AS (
	SELECT 
		*,
		DATEDIFF(DAY, NgayDHGanNhat, '2026-08-01') AS ChenhLech,
		CASE
			WHEN avg_days_between_orders IS NULL THEN (0 * 1.0)
			ELSE avg_days_between_orders
		END AS adbo_standard
	FROM NCTE
),
Segnment AS (
	SELECT	
		customer_id,
		NgayDHXaNhat,
		NgayDHGanNhat,
		ChenhLech,
		adbo_standard,
		CASE
			WHEN adbo_standard < 10 THEN 'day < 10'
			WHEN ((adbo_standard >= 10) AND (adbo_standard <= 30)) THEN '10 <= day <= 30'
			WHEN ((adbo_standard > 30) AND (adbo_standard <= 60)) THEN '30 < day <= 60'
			WHEN ((adbo_standard > 60) AND (adbo_standard <= 90)) THEN '60 < day <= 90'
			ELSE 'day > 90'
		END AS dummy_adbo
	FROM NNCTE
),
TABLE_SEGMENT AS (
	SELECT *,
		CASE
			WHEN ((dummy_adbo = 'day < 10') AND (ChenhLech BETWEEN 0 AND 30)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = 'day < 10') AND (ChenhLech BETWEEN 31 AND 60)) THEN 'AT RISK'
			WHEN ((dummy_adbo = 'day < 10') AND (ChenhLech > 60)) THEN 'CHURN'
			WHEN ((dummy_adbo = 'day > 90') AND (ChenhLech BETWEEN 0 AND 60)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = 'day > 90') AND (ChenhLech > 60)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = '60 < day <= 90') AND (ChenhLech BETWEEN 0 AND 60)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = '60 < day <= 90') AND (ChenhLech BETWEEN 61 AND 90)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = '60 < day <= 90') AND (ChenhLech > 90)) THEN 'AT RISK'
			WHEN ((dummy_adbo = '10 <= day <= 30') AND (ChenhLech BETWEEN 0 AND 30)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = '10 <= day <= 30') AND (ChenhLech BETWEEN 31 AND 60)) THEN 'AT RISK'
			WHEN ((dummy_adbo = '10 <= day <= 30') AND (ChenhLech > 60)) THEN 'CHURN'
			WHEN ((dummy_adbo = '30 < day <= 60') AND (ChenhLech BETWEEN 0 AND 30)) THEN 'AT RISK'
			WHEN ((dummy_adbo = '30 < day <= 60') AND (ChenhLech BETWEEN 31 AND 60)) THEN 'ACTIVE'
			WHEN ((dummy_adbo = '30 < day <= 60') AND (ChenhLech BETWEEN 61 AND 90)) THEN 'AT RISK'
			WHEN ((dummy_adbo = '30 < day <= 60') AND (ChenhLech > 90)) THEN 'CHURN'
		END AS dummy_segment
	FROM Segnment
)

SELECT 
	customer_id,
	NgayDHXaNhat,
	NgayDHGanNhat,
	ChenhLech,
	adbo_standard AS avg_days_between_orders,
	dummy_segment
FROM TABLE_SEGMENT
WHERE dummy_segment = 'CHURN';

-- Code cải thiện để phân tích tỷ lệ rời bỏ
SELECT *
FROM (
	SELECT 
		customer_id,
		NgayDHXaNhat,
		NgayDHGanNhat,
		adbo_standard,
		TGKhongHD,
		CASE
				WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
				WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD > 60)) THEN 'CHURN'
				WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD > 60)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD > 90)) THEN 'AT RISK'
				WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
				WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD > 60)) THEN 'CHURN'
				WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'AT RISK'
				WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'ACTIVE'
				WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'AT RISK'
				WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD > 90)) THEN 'CHURN'
			END AS dummy_segment
	FROM (
		SELECT *,
				CASE
					WHEN adbo_standard < 10 THEN 'day < 10'
					WHEN ((adbo_standard >= 10) AND (adbo_standard <= 30)) THEN '10 <= day <= 30'
					WHEN ((adbo_standard > 30) AND (adbo_standard <= 60)) THEN '30 < day <= 60'
					WHEN ((adbo_standard > 60) AND (adbo_standard <= 90)) THEN '60 < day <= 90'
					ELSE 'day > 90'
				END AS dummy_adbo
		FROM (
			SELECT 
				customer_id,
				NgayDHXaNhat,
				NgayDHGanNhat,
				CASE
					WHEN avg_days_between_orders IS NULL THEN (0 * 1.0)
					ELSE avg_days_between_orders
				END AS adbo_standard,
				DATEDIFF(DAY, NgayDHGanNhat, '2026-08-01') AS TGKhongHD
			FROM (
				SELECT 
					customer_id,
					MAX(created_at) AS NgayDHGanNhat,
					MIN(created_at) AS NgayDHXaNhat,
					AVG(
						DATEDIFF(DAY, created_at, next_order_date) * 1.0
					) AS avg_days_between_orders
				FROM (
					SELECT 
						customer_id,
						created_at,
						LEAD(created_at) OVER(
								PARTITION BY customer_id
								ORDER BY created_at
							) AS next_order_date
					FROM orders
					WHERE customer_id IN (
						SELECT customer_id
						FROM payment
						WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
						AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
					)
				) AS T
				GROUP BY customer_id
			) AS T1
		) AS T2
	) AS T3
) AS T4

-- Phân loại khách hàng theo kênh
WITH CTE AS (
		SELECT 
		C.source,
		S.*,
		CASE
			WHEN LOWER(TRIM("source")) IN (
						'zalo hotline',
						'group zalo',
						'zalo',
						'zalo duy nhân',
						'zalo tt'
					) THEN 'Group Zalo'

			WHEN LOWER(TRIM("source")) = 'tiktok' THEN 'TikTok'

			WHEN LOWER(TRIM("source")) IN (
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
					) THEN 'FaceBook'

			WHEN LOWER(TRIM("source")) IN (
						'sale',
						'sale tự tìm kiếm'
					) THEN 'Sale'

			WHEN LOWER(TRIM("source")) IN (
						'website',
						'web',
						'google'
					) THEN 'Google'

			WHEN LOWER(TRIM("source")) IN (
						'được giới thiệu',
						'kh giới thiệu',
						'đạilý',
						'đại lý',
						'tele',
						'thanh x',
						'Ð?ilý'
					) THEN 'Khach Hang Gioi thieu'

			WHEN source IS NULL THEN 'Khong Xac Dinh Duoc Kenh'

			ELSE 'source'
		END AS source_chuan_hoa
	FROM customer AS C
	JOIN (
		SELECT *
		FROM (
			SELECT 
				customer_id,
				NgayDHXaNhat,
				NgayDHGanNhat,
				adbo_standard,
				TGKhongHD,
				CASE
						WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
						WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD > 60)) THEN 'CHURN'
						WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD > 60)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD > 90)) THEN 'AT RISK'
						WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
						WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD > 60)) THEN 'CHURN'
						WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'AT RISK'
						WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'ACTIVE'
						WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'AT RISK'
						WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD > 90)) THEN 'CHURN'
					END AS dummy_segment
			FROM (
				SELECT *,
						CASE
							WHEN adbo_standard < 10 THEN 'day < 10'
							WHEN ((adbo_standard >= 10) AND (adbo_standard <= 30)) THEN '10 <= day <= 30'
							WHEN ((adbo_standard > 30) AND (adbo_standard <= 60)) THEN '30 < day <= 60'
							WHEN ((adbo_standard > 60) AND (adbo_standard <= 90)) THEN '60 < day <= 90'
							ELSE 'day > 90'
						END AS dummy_adbo
				FROM (
					SELECT 
						customer_id,
						NgayDHXaNhat,
						NgayDHGanNhat,
						CASE
							WHEN avg_days_between_orders IS NULL THEN (0 * 1.0)
							ELSE avg_days_between_orders
						END AS adbo_standard,
						DATEDIFF(DAY, NgayDHGanNhat, '2026-08-01') AS TGKhongHD
					FROM (
						SELECT 
							customer_id,
							MAX(created_at) AS NgayDHGanNhat,
							MIN(created_at) AS NgayDHXaNhat,
							AVG(
								DATEDIFF(DAY, created_at, next_order_date) * 1.0
							) AS avg_days_between_orders
						FROM (
							SELECT 
								customer_id,
								created_at,
								LEAD(created_at) OVER(
										PARTITION BY customer_id
										ORDER BY created_at
									) AS next_order_date
							FROM orders
							WHERE customer_id IN (
								SELECT customer_id
								FROM payment
								WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
								AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
							)
						) AS T
						GROUP BY customer_id
					) AS T1
				) AS T2
			) AS T3
		) AS T4
	) AS S
	ON S.customer_id = C.account_id
)

SELECT 
	source_chuan_hoa,
	COUNT(customer_id) AS count_customer
FROM CTE
WHERE dummy_segment = 'CHURN'
GROUP BY source_chuan_hoa;

-- 
WITH CTE AS (
	SELECT *
	FROM (
		SELECT 
			customer_id,
			NgayDHXaNhat,
			NgayDHGanNhat,
			adbo_standard,
			TGKhongHD,
			CASE
					WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
					WHEN ((dummy_adbo = 'day < 10') AND (TGKhongHD > 60)) THEN 'CHURN'
					WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = 'day > 90') AND (TGKhongHD > 60)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 0 AND 60)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = '60 < day <= 90') AND (TGKhongHD > 90)) THEN 'AT RISK'
					WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'AT RISK'
					WHEN ((dummy_adbo = '10 <= day <= 30') AND (TGKhongHD > 60)) THEN 'CHURN'
					WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 0 AND 30)) THEN 'AT RISK'
					WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 31 AND 60)) THEN 'ACTIVE'
					WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD BETWEEN 61 AND 90)) THEN 'AT RISK'
					WHEN ((dummy_adbo = '30 < day <= 60') AND (TGKhongHD > 90)) THEN 'CHURN'
				END AS dummy_segment
		FROM (
			SELECT *,
					CASE
						WHEN adbo_standard < 10 THEN 'day < 10'
						WHEN ((adbo_standard >= 10) AND (adbo_standard <= 30)) THEN '10 <= day <= 30'
						WHEN ((adbo_standard > 30) AND (adbo_standard <= 60)) THEN '30 < day <= 60'
						WHEN ((adbo_standard > 60) AND (adbo_standard <= 90)) THEN '60 < day <= 90'
						ELSE 'day > 90'
					END AS dummy_adbo
			FROM (
				SELECT 
					customer_id,
					NgayDHXaNhat,
					NgayDHGanNhat,
					CASE
						WHEN avg_days_between_orders IS NULL THEN (0 * 1.0)
						ELSE avg_days_between_orders
					END AS adbo_standard,
					DATEDIFF(DAY, NgayDHGanNhat, '2026-08-01') AS TGKhongHD
				FROM (
					SELECT 
						customer_id,
						MAX(created_at) AS NgayDHGanNhat,
						MIN(created_at) AS NgayDHXaNhat,
						AVG(
							DATEDIFF(DAY, created_at, next_order_date) * 1.0
						) AS avg_days_between_orders
					FROM (
						SELECT 
							customer_id,
							created_at,
							LEAD(created_at) OVER(
									PARTITION BY customer_id
									ORDER BY created_at
								) AS next_order_date
						FROM orders
						WHERE customer_id IN (
							SELECT customer_id
							FROM payment
							WHERE status IN ('DA_THANH_TOAN', 'DA_THANH_TOAN_SHIP')
							AND purpose IN ('THANH_TOAN_DON_HANG', 'THANH_TOAN_VAN_CHUYEN')
						)
					) AS T
					GROUP BY customer_id
				) AS T1
			) AS T2
		) AS T3
	) AS T4
),

COUNT_SEGMENT AS (
	SELECT *
	FROM CTE 
	WHERE NgayDHGanNhat >= '2026-07-01'
	AND NgayDHGanNhat < '2026-08-01'
)

SELECT *
FROM COUNT_SEGMENT
WHERE adbo_standard = (0 * 1.0)
ORDER BY dummy_segment