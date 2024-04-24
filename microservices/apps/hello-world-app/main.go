package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
)

func handler(w http.ResponseWriter, r *http.Request) {

    appName := "hello-world-app"
    language := "golang"
	var message string
	var version string

	if vers, ok := os.LookupEnv("VERSION"); ok {
		version = vers
	} else {
		version = "SOFTWARE_VERSION_NOT_DEFINED"
	}

	if msg, ok := os.LookupEnv("MESSAGE"); ok {
		message = msg
	} else {
		message = "MESSAGE-NOT-DEFINED"
	}

    text := fmt.Sprintf("Server started | appName: %s, Language: %s, Message: %s, Version: %s\n", appName, language, message, version)
    fmt.Fprintf(w, text)
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
