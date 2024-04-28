package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
)

type Response struct {
	AppName  string `json:"appName"`
	Language string `json:"language"`
	Version  string `json:"version"`
	Message  string `json:"message"`
	PodID    string `json:"podID"`
}

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

	response := Response{
		AppName:  appName,
		Language: language,
		Version:  version,
		Message:  message,
		PodID:    podID,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}


func postHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		var data map[string]interface{}
		err := json.NewDecoder(r.Body).Decode(&data)
		if err != nil {
			http.Error(w, "Failed to decode JSON data", http.StatusBadRequest)
			return
		}
		defer r.Body.Close()

		// Here you can process the received data as needed
		fmt.Printf("Received data: %+v\n", data)

		response := struct {
			Message string `json:"message"`
		}{
			Message: "Data received successfully",
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(response)
	} else {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/post", postHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}