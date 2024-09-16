CREATE TABLE wb_order
(
    order_uid          varchar PRIMARY KEY NOT NULL UNIQUE,
    track_number       varchar(128)        NOT NULL,
    entry              varchar(128)        NOT NULL,
    locale             varchar(128)        NOT NULL,
    internal_signature varchar(128)        NOT NULL,
    customer_id        varchar(128)        NOT NULL,
    delivery_service   varchar(128)        NOT NULL,
    shardkey           varchar(128)        NOT NULL,
    sm_id              bigint,
    date_created       timestamp           NOT NULL,
    oof_shard          varchar(128)        NOT NULL
);

CREATE TABLE delivery
(
    id        BIGSERIAL PRIMARY KEY UNIQUE,
    name      varchar(128) NOT NULL,
    phone     varchar(16)  NOT NULL,
    zip       varchar(128) NOT NULL,
    city      varchar(128) NOT NULL,
    address   varchar(256) NOT NULL,
    region    varchar(256) NOT NULL,
    email     varchar(128) NOT NULL,

    order_uid varchar      NOT NULL,
    UNIQUE (order_uid),
    CONSTRAINT fk_order FOREIGN KEY (order_uid) REFERENCES wb_order (order_uid)
);

CREATE TABLE payment
(
    transaction   varchar PRIMARY KEY NOT NULL UNIQUE,
    request_id    varchar,
    currency      varchar(128)        NOT NULL,
    provider      varchar(128)        NOT NULL,
    amount        bigint              NOT NULL,
    payment_dt    bigint              NOT NULL,
    bank          varchar(128)        NOT NULL,
    delivery_cost bigint              NOT NULL,
    goods_total   bigint              NOT NULL,
    custom_fee    bigint              NOT NULL,

    order_uid     varchar             NOT NULL,
    UNIQUE (order_uid),
    CONSTRAINT fk_order FOREIGN KEY (order_uid) REFERENCES wb_order (order_uid)
);

CREATE TABLE items
(
    chrt_id      bigint       NOT NULL,
    track_number varchar(256) NOT NULL,
    price        bigint       NOT NULL,
    rid          varchar,
    name         varchar(128) NOT NULL,
    sale         bigint       NOT NULL,
    size         varchar      NOT NULL,
    total_price  bigint       not null,
    nm_id        bigint,
    brand        varchar(256) NOT NULL,
    status       int          NOT NULL,

    order_uid    varchar      NOT NULL,
    constraint fk_order FOREIGN KEY (order_uid) REFERENCES wb_order (order_uid)
);

-- SELECT

SELECT wb_order.*,
       d.name          "delivery.name",
       d.phone         "delivery.phone",
       d.zip           "delivery.zip",
       d.city          "delivery.city",
       d.address       "delivery.address",
       d.region        "delivery.region",
       d.email         "delivery.email",
       p.transaction   "payment.transaction",
       p.request_id    "payment.request_id",
       p.currency      "payment.currency",
       p.provider      "payment.provider",
       p.amount        "payment.amount",
       p.payment_dt    "payment.payment_dt",
       p.bank          "payment.bank",
       p.delivery_cost "payment.delivery_cost",
       p.goods_total   "payment.goods_total",
       p.custom_fee    "payment.custom_fee",
       (SELECT array_to_json(array_agg(row_to_json(i.*)))
        FROM (SELECT chrt_id,
                     track_number,
                     price,
                     rid,
                     name,
                     sale,
                  size,
                  total_price,
                  nm_id,
                  brand,
                  status
              FROM items
              WHERE wb_order.order_uid = order_uid) i)
FROM wb_order
         JOIN delivery d ON wb_order.order_uid = d.order_uid
         JOIN payment p ON wb_order.order_uid = p.order_uid;


SELECT wb_order.*,
       d.name          "delivery.name",
       d.phone         "delivery.phone",
       d.zip           "delivery.zip",
       d.city          "delivery.city",
       d.address       "delivery.address",
       d.region        "delivery.region",
       d.email         "delivery.email",
       p.transaction   "payment.transaction",
       p.request_id    "payment.request_id",
       p.currency      "payment.currency",
       p.provider      "payment.provider",
       p.amount        "payment.amount",
       p.payment_dt    "payment.payment_dt",
       p.bank          "payment.bank",
       p.delivery_cost "payment.delivery_cost",
       p.goods_total   "payment.goods_total",
       p.custom_fee    "payment.custom_fee"
FROM wb_order
         LEFT JOIN delivery d ON wb_order.order_uid = d.order_uid
         LEFT JOIN payment p ON wb_order.order_uid = p.order_uid;


SELECT wb_order.*,
       d.name          "delivery.name",
       d.phone         "delivery.phone",
       d.zip           "delivery.zip",
       d.city          "delivery.city",
       d.address       "delivery.address",
       d.region        "delivery.region",
       d.email         "delivery.email",
       p.transaction   "payment.transaction",
       p.request_id    "payment.request_id",
       p.currency      "payment.currency",
       p.provider      "payment.provider",
       p.amount        "payment.amount",
       p.payment_dt    "payment.payment_dt",
       p.bank          "payment.bank",
       p.delivery_cost "payment.delivery_cost",
       p.goods_total   "payment.goods_total",
       p.custom_fee    "payment.custom_fee"
FROM wb_order
         JOIN delivery d ON wb_order.order_uid = d.order_uid
         JOIN payment p ON wb_order.order_uid = p.order_uid;