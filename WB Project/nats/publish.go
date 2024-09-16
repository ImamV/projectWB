package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"

	"github.com/nats-io/nats.go"
)

type order struct {
	Space string
	Point json.RawMessage
}

func main() {

	file, _ := ioutil.ReadFile("model.json")

	var i order

	err := json.Unmarshal(file, &i)
	if err != nil {
		fmt.Println("Problem with JSON")
	}

	nc, _ := nats.Connect(nats.DefaultURL, nats.Token("mytoken"))
	ec, _ := nats.NewEncodedConn(nc, nats.JSON_ENCODER)

	sendCH := make(chan *order)
	err = ec.BindSendChan("order", sendCH)
	if err != nil {
		fmt.Println("Problem with send to nats chan")
	}

	sendCH <- &i

	nc.Drain()
	nc.Close()

}
