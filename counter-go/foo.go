package main
import (
	"fmt"
	"time"
)

func main() {
	i:=0
	for {
		i=i+1
		fmt.Println(i);
		time.Sleep(time.Second)
	}
}
