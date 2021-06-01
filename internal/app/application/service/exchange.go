package service

import "github.com/airdb/scf-go/internal/app/domain/valueobject"

// IExchange is interface of bitcoin exchange
type IExchange interface {
	Ticker(p valueobject.Pair) valueobject.Ticker
	Ohlc(p valueobject.Pair, t valueobject.Timeunit) []valueobject.CandleStick
}
