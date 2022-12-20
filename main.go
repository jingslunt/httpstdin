package main

import (
	"fmt"
	"net/http"
	"os"
)

var stdin *os.File

func main() {
	var err error
	stdin, err = os.Open("/dev/stdin")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	defer stdin.Close()
	stdin.Seek(0, 0)
	buf := make([]byte, 1024*1024*1024)
	n, err := stdin.Read(buf)
	for {
		n, err := stdin.Read(buf)
		if n == 0 || err != nil {
			break
		}
	}
	http.HandleFunc("/metrics", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, string(buf[:n]))
	})

	http.ListenAndServe(":8080", nil)
}
