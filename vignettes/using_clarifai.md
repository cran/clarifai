---
title: "Using clarifai"
author: "Gaurav Sood"
date: "2015-11-10"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Using clarifai}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

## Using clarifai

### Installation

To get the current development version from GitHub:


```r
# install.packages("devtools")
devtools::install_github("soodoku/clarifai")
```

#### Load up the lib:

```r
library(clarifai)
```

#### Authentication

Start by setting Client ID and secret, which you can get from [https://developer.clarifai.com/](https://developer.clarifai.com/)

```r
secret_id(c("client_id", "secret"))
```

Next, get the token (the function also sets it):

```r
get_token()
```

#### Get Information

Get information about your application:

```r
get_info()
```

```
## Status message:  All images in request have completed successfully.
```

#### Get Tags

We are now all set. Let's play. Get tags of a remote image:

![Metro North](http://www.clarifai.com/img/metro-north.jpg)

```r
res <- tag_image_urls("http://www.clarifai.com/img/metro-north.jpg")
head(res)
```

```
##                                       img_url           tags
## 1 http://www.clarifai.com/img/metro-north.jpg          train
## 2 http://www.clarifai.com/img/metro-north.jpg       railroad
## 3 http://www.clarifai.com/img/metro-north.jpg        station
## 4 http://www.clarifai.com/img/metro-north.jpg           rail
## 5 http://www.clarifai.com/img/metro-north.jpg transportation
## 6 http://www.clarifai.com/img/metro-north.jpg       platform
##               probs
## 1 0.999398589134216
## 2 0.998031497001648
## 3 0.997042655944824
## 4 0.995042085647583
## 5 0.995012819766998
## 6 0.994919180870056
```

Get tags for a local image:

```r
path <- system.file("inst/extdata/", package = "clarifai")
filep <- paste0(path, "/metro-north.jpg")
tag_images(filep)
```

Provide feedback about tags for an image, including suggesting new tags, suggesting that some tags be removed etc. 

#### Provide Feedback


```r
feedback(file_path="path_to_image", feedback_type="add_tags", feedback_value="suggested_tag")

## $status_code
## [1] "OK"

## $status_msg
## [1] "Feedback successfully recorded. "
```
