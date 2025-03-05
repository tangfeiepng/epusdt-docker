-- orders表 - 只在表不存在时创建
CREATE TABLE IF NOT EXISTS orders (
    id                   int auto_increment         primary key,
    trade_id             varchar(32)    not null comment 'epusdt订单号',
    order_id             varchar(32)    not null comment '客户交易id',
    block_transaction_id varchar(128)   null comment '区块唯一编号',
    actual_amount        decimal(19, 4) not null comment '订单实际需要支付的金额，保留4位小数',
    amount               decimal(19, 4) not null comment '订单金额，保留4位小数',
    token                varchar(50)    not null comment '所属钱包地址',
    status               int default 1  not null comment '1：等待支付，2：支付成功，3：已过期',
    notify_url           varchar(128)   not null comment '异步回调地址',
    redirect_url         varchar(128)   null comment '同步回调地址',
    callback_num         int default 0  null comment '回调次数',
    callback_confirm     int default 2  null comment '回调是否已确认？ 1是 2否',
    created_at           timestamp      null,
    updated_at           timestamp      null,
    deleted_at           timestamp      null,
    constraint orders_order_id_uindex         unique (order_id),
    constraint orders_trade_id_uindex         unique (trade_id) 
);

-- 为orders表添加索引（如果不存在）
SELECT COUNT(1) INTO @index_exists 
FROM information_schema.statistics 
WHERE table_schema = DATABASE() 
AND table_name = 'orders' 
AND index_name = 'orders_block_transaction_id_index';

SET @create_index_stmt = IF(@index_exists = 0, 
    'CREATE INDEX orders_block_transaction_id_index ON orders (block_transaction_id)',
    'SELECT "索引orders_block_transaction_id_index已存在，跳过创建"');
PREPARE stmt FROM @create_index_stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- wallet_address表 - 只在表不存在时创建
CREATE TABLE IF NOT EXISTS wallet_address (
    id         int auto_increment         primary key,
    token      varchar(50)   not null comment '钱包token',
    status     int default 1 not null comment '1:启用 2:禁用',
    created_at timestamp     null,
    updated_at timestamp     null,
    deleted_at timestamp     null
) comment '钱包表';

-- 为wallet_address表添加索引（如果不存在）
SELECT COUNT(1) INTO @index_exists 
FROM information_schema.statistics 
WHERE table_schema = DATABASE() 
AND table_name = 'wallet_address' 
AND index_name = 'wallet_address_token_index';

SET @create_index_stmt = IF(@index_exists = 0, 
    'CREATE INDEX wallet_address_token_index ON wallet_address (token)',
    'SELECT "索引wallet_address_token_index已存在，跳过创建"');
PREPARE stmt FROM @create_index_stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 向wallet_address表插入数据（只在表为空时插入）
SELECT COUNT(*) INTO @record_count FROM wallet_address;

SET @insert_data_stmt = IF(@record_count = 0,
    "INSERT INTO wallet_address (id,token, status, created_at, updated_at) VALUES 
    (1,'TUcYeZnAvmXJPDBH3yUAFRBk2qlSYT1Qmo', 1, NOW(), NOW()),
    (2,'TAqxueEFU4JQ6PBBrjK9RMAvSNReLrLm9w', 1, NOW(), NOW())",
    'SELECT "wallet_address表已有数据，跳过插入"');
PREPARE stmt FROM @insert_data_stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;