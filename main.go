// @Author fcihpy
// @Date 2025/3/28 13:27:00
// @Desc
//

package main

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	ginMode := os.Getenv("GIN_MODE")
	if ginMode == "" {
		ginMode = "debug"
	}
	gin.SetMode(ginMode)

	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"msg":  "OK",
			"code": http.StatusOK,
			"data": "hello world",
		})
	})
	r.Run(":8085") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")

	log.Println("server started......")
	time.Sleep(time.Second * 10)
}
