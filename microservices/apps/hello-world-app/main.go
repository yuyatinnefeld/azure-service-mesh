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
    var podID string

	if vers, ok := os.LookupEnv("VERSION"); ok {
		version = vers
	} else {
		version = "VERSION_NOT_DEFINED"
	}

	if msg, ok := os.LookupEnv("MESSAGE"); ok {
		message = msg
	} else {
		message = "MESSAGE_NOT_DEFINED"
	}

	if podid, ok := os.LookupEnv("MY_POD_NAME"); ok {
		podID = podid
	} else {
		podID = "PODID_NOT_DEFINED"
	}

	text := fmt.Sprintf("Server started | appName: %s, Language: %s, Version: %s, Message: %s, Pod ID: %s\n", appName, language, version, message, podID)
    fmt.Fprintf(w, text)
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
