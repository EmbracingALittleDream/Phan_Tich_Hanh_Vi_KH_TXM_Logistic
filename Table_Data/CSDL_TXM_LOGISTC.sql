/* =========================================================
   0. CREATE DATABASE
   ========================================================= */

CREATE DATABASE LogisticsDB;
GO

USE LogisticsDB;
GO


/* =========================================================
   1. ACCOUNT
   ========================================================= */

CREATE TABLE dbo.account
(
    account_id BIGINT NOT NULL,
    created_at DATETIMEOFFSET(3) NOT NULL,

    email NVARCHAR(255) NULL,
    is_verify BIT NULL,

    name NVARCHAR(255) NULL,
    password NVARCHAR(255) NULL,
    phone NVARCHAR(255) NULL,

    role NVARCHAR(50) NULL,
    status NVARCHAR(30) NULL,

    username NVARCHAR(255) NULL,
    avatar_url NVARCHAR(MAX) NULL,
    google_id NVARCHAR(255) NULL,

    phone_verified BIT NULL,
    profile_completion_level INT NULL,

    CONSTRAINT PK_account
        PRIMARY KEY (account_id)
);
GO


/* =========================================================
   2. CUSTOMER
   ========================================================= */

CREATE TABLE dbo.customer
(
    balance DECIMAL(38,2) NULL,

    customer_code NVARCHAR(255) NOT NULL,

    source NVARCHAR(255) NULL,

    total_weight DECIMAL(38,2) NULL,

    account_id BIGINT NOT NULL,

    total_amount DECIMAL(38,2) NULL,

    total_orders INT NULL,

    gender NVARCHAR(20) NULL,

    cps_customer_id NVARCHAR(255) NULL,

    cps_synced_at DATETIMEOFFSET(3) NULL,

    cps_sync_hash NVARCHAR(255) NULL,

    CONSTRAINT PK_customer
        PRIMARY KEY (account_id)
);
GO


/* =========================================================
   3. ORDERS
   ========================================================= */

CREATE TABLE dbo.orders
(
    order_id BIGINT NOT NULL,

    check_required BIT NULL,

    created_at DATETIMEOFFSET(3) NOT NULL,

    exchange_rate DECIMAL(38,2) NULL,

    final_price_order DECIMAL(38,2) NULL,

    leftover_money DECIMAL(38,2) NULL,

    order_code NVARCHAR(255) NOT NULL,

    order_type NVARCHAR(50) NULL,

    pinned_at DATETIMEOFFSET(3) NULL,

    price_before_fee DECIMAL(38,2) NULL,

    price_ship DECIMAL(38,2) NULL,

    status NVARCHAR(50) NULL,

    address_id BIGINT NULL,

    customer_id BIGINT NOT NULL,

    destination_id BIGINT NULL,

    route_id BIGINT NULL,

    staff_id BIGINT NULL,

    voucher_applied_id BIGINT NULL,

    payment_after_auction DECIMAL(38,2) NULL,

    note NVARCHAR(MAX) NULL,

    is_insuranced BIT NULL,

    declared_value DECIMAL(38,2) NULL,

    insurance_fee DECIMAL(38,2) NULL,

    insurance_payment_id BIGINT NULL,

    snap_insurance_rate_pct DECIMAL(10,2) NULL,

    snap_insured_compensation_pct DECIMAL(10,2) NULL,

    snap_no_ins_ship_pct DECIMAL(10,2) NULL,

    snap_no_ins_max_amount DECIMAL(38,2) NULL,

    snap_claim_window_days INT NULL,

    sla_max_working_days INT NULL,

    reported_lost_at DATETIMEOFFSET(3) NULL,

    confirmed_lost_at DATETIMEOFFSET(3) NULL,

    ship_web_included_in_payment BIT NULL,

    inspection_fee DECIMAL(38,2) NULL,

    quantity_check_fee DECIMAL(38,2) NULL,

    quantity_check_required BIT NULL,

    service_type NVARCHAR(50) NULL,

    foreign_warehouse_location_id BIGINT NULL,

    domestic_warehouse_location_id BIGINT NULL,

    cancel_reason NVARCHAR(MAX) NULL,

    operational_route_id BIGINT NULL,

    crm_opportunity_id NVARCHAR(255) NULL,

    crm_order_draft_id NVARCHAR(255) NULL,

    crm_review_status NVARCHAR(255) NULL,

    company_id NVARCHAR(100) NULL,

    flow_type NVARCHAR(50) NULL,

    is_internal_only BIT NULL,

    CONSTRAINT PK_orders
        PRIMARY KEY (order_id)
);
GO


/* =========================================================
   4. PAYMENT
   ========================================================= */

CREATE TABLE dbo.payment
(
    payment_id BIGINT NOT NULL,

    action_at DATETIMEOFFSET(3) NOT NULL,

    amount DECIMAL(38,2) NULL,

    collected_amount DECIMAL(38,2) NULL,

    content NVARCHAR(MAX) NULL,

    deposit_percent DECIMAL(10,2) NULL,

    is_merged_payment BIT NULL,

    payment_code NVARCHAR(255) NOT NULL,

    payment_type NVARCHAR(255) NULL,

    qr_code NVARCHAR(255) NULL,

    status NVARCHAR(50) NULL,

    customer_id BIGINT NOT NULL,

    order_id BIGINT NULL,

    staff_id BIGINT NULL,

    purpose NVARCHAR(100) NULL,

    collect_weight DECIMAL(38,2) NULL,

    paid_time DATETIMEOFFSET(3) NULL,

    snap_exchange_rate DECIMAL(38,2) NULL,

    CONSTRAINT PK_payment
        PRIMARY KEY (payment_id)
);
GO