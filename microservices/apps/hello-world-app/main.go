package main

import (
    "fmt"
    "log"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {

    appName := "hello-world-app"
    version := "1.1.0"
    language := "golang"
    message := fmt.Sprintf("Server started appName: %s, Version: %s, Language: %s\n", appName, version, language)
    fmt.Fprintf(w, message)
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
