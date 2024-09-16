package model

import (
	"time"
)

type OrderModel struct {
	OrderUID          string    `db:"order_uid" json:"order_uid" validate:"required"`
	TrackNumber       string    `db:"track_number" json:"track_number" validate:"required,max=128"`
	Entry             string    `db:"entry" json:"entry" json:"entry" validate:"required,max=128"`
	Local             string    `db:"locale" json:"locale" validate:"required,max=128"`
	InternalSignature string    `db:"internal_signature" json:"internal_signature" validate:"omitempty,max=128"`
	CustomerID        string    `db:"customer_id" json:"customer_id" validate:"required,max=128"`
	DeliveryService   string    `db:"delivery_service" json:"delivery_service" validate:"required,max=128"`
	Shardkey          string    `db:"shardkey" json:"shardkey" validate:"required,max=128"`
	SmID              uint64    `db:"sm_id" json:"sm_id" validate:"required"`
	DateCreated       time.Time `db:"date_created" json:"date_created" validate:"required"`
	OofShard          string    `db:"oof_shard" json:"oof_shard" validate:"required,max=128"`

	Delivery DeliveryModel `db:"delivery" json:"delivery"`
	Payment  PaymentModel  `db:"payment" json:"payment"`
	Items    []ItemModel   `db:"items" validate:"required,dive,required" json:"items"`
}

type DeliveryModel struct {
	Name    string `db:"name" json:"name" validate:"required,max=128"`
	Phone   string `db:"phone" json:"phone" validate:"required,max=16" faker:"len=16"`
	Zip     string `db:"zip" json:"zip" validate:"required,max=128"`
	City    string `db:"city" json:"city" validate:"required,max=128"`
	Address string `db:"address" json:"address" validate:"required,max=256"`
	Region  string `db:"region" json:"region" validate:"required,max=256"`
	Email   string `db:"email" json:"email" validate:"required,max=128"`
}

type ItemModel struct {
	ChrtId      uint64 `db:"chrt_id" json:"chrt_id" validate:"required"`
	TrackNumber string `db:"track_number" json:"track_number" validate:"required,max=256"`
	Price       int64  `db:"price" json:"price" validate:"required"`
	Rid         string `db:"rid" json:"rid" validate:"required"`
	Name        string `db:"name" json:"name" validate:"required,max=128"`
	Sale        int64  `db:"sale" json:"sale" validate:"required"`
	Size        string `db:"size" json:"size" validate:"required"`
	TotalPrice  int64  `db:"total_price" json:"total_price" validate:"required"`
	NmID        uint64 `db:"nm_id" json:"nm_id" validate:"required"`
	Brand       string `db:"brand" json:"brand" validate:"required,max=256"`
	Status      int    `db:"status" json:"status" validate:"required"`
}

type PaymentModel struct {
	Transaction  string `db:"transaction" json:"transaction" validate:"required"`
	RequestID    string `db:"request_id" json:"request_id" validate:"required"`
	Currency     string `db:"currency" json:"currency" validate:"required,max=128"`
	Provider     string `db:"provider" json:"provider" validate:"required,max=128"`
	Amount       uint64 `db:"amount" json:"amount" validate:"required"`
	PaymentDt    uint64 `db:"payment_dt" json:"payment_dt" validate:"required"`
	Bank         string `db:"bank" json:"bank" validate:"required,max=128"`
	DeliveryCost uint64 `db:"delivery_cost" json:"delivery_cost" validate:"omitempty"`
	GoodsTotal   uint64 `db:"goods_total" json:"goods_total" validate:"required"`
	CustomFee    uint64 `db:"custom_fee" json:"custom_fee" validate:"omitempty"`
}
