---
title: "Analyzing Politician Instagram Accounts Using clarifai"
author: "Gaurav Sood"
date: "2015-11-10"
vignette: >
  %\VignetteIndexEntry{Analyzing Politician Instagram Accounts Using clarifai}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

## Analyzing Politician Instagram Accounts Using clarifai


```r
library(instaR)
```

To use the instagram API, go to [https://instagram.com/developer/](https://instagram.com/developer/) and click on manage client and then register a client. Choose a name etc. For website and redirect URL, write in localhost:1410. This will give you client ID and secret. Plug these in as follows:


```r
my_oauth <- instaOAuth(app_id="1f1f8228974248ba804b4c02fb3c082f", app_secret="a8a727a6b21e488988207686c88ec49e")
save(my_oauth, file="my_oauth")
```

Now it is time to load clarifai:


```r
library(clarifai)
```

Clarifai ships with instagram handles of politicians. Load the file using:


```r
filepath <- system.file("inst/extdata/congress.csv", package = "clarifai")
pols <- read.csv(filepath)
```

Next, download data from instagram: 


```r
# getUserMedia(pols$instagram[1], token=my_oauth)

res <- list()
for (i in 1:nrow(pols)) {
	# Not all politicians have instagram accounts. 
	if (pols$instagram[i]!="") {
		# Not all have public posts
		res[[i]] <- tryCatch(getUserMedia(pols$instagram[i], token=my_oauth), error=function(err) NA)
	} else { 
		res[[i]] <- NA 
	}
}
# rbind
res2 <- do.call(rbind, res) # nrow = 8088 (may change for runs in the future)
```

Merge it with some pols data


```r
# Get pols data ready
small_pols <- pols[,c("first_name", "last_name", "party", "instagram", "dw_nominate")]
small_pols_2 <- subset(small_pols, instagram!="") # take out no username/NA

# Merge 
res2[, c("first_name", "last_name", "party", "instagram", "dw_nominate")] <- 
small_pols_2[match(res2$username, small_pols_2$instagram),]

# write.csv(res2, file="res2.csv", row.names=F)
```

Now, get image labels from clarifai: 


```r
labs <- list()
# Not implemented optimally. 
# You can push all images at once. And that is the best than 8k requests.
for (i in 1:nrow(res2)) {
	labs[[i]] <- tryCatch(tag_image_urls(res2$image_url[i]), error=function(err) NA)	
} 

labs_df <- do.call(rbind, labs)
```

Next merge the labels back into the data: 


```r
# Merge 
labs_df[,names(res2)] <- res2[match(labs_df$img_url, res2$image_url),]

# write.csv(labs_df, file="labs_df.csv", row.names=F)
# This data frame is available in the extdata folder
```

Let us analyze data. Popular tags: 


```r
head(table(labs_df$tags)[order(-table(labs_df$tags))], 40)
```


```r
## people    politics       adult         men       group  government    business       women    portrait      leader 
##       1592        1137        1132         999         910         795         793         773         763         670 
##   clothing  politician   education      speech    election     indoors     meeting        room competition        many 
##        554         472         456         435         433         426         360         352         347         345 
```

Do Republican instagram accounts have more photos with military tags than Democrats? 


```r
table(grepl("military", labs_df$tags), labs_df$party)
```


```r
##           D     R
##  FALSE 19806 16030
##  TRUE     94    90
```

How about women?


```r
table(grepl("women", labs_df$tags), labs_df$party)
```


```r
##           D     R
##  FALSE 19458 15853
##  TRUE    442   267
```


```r
table(grepl("men", labs_df$tags), labs_df$party)
```

See also for men: 


```r
##            D     R
##  FALSE 18265 14978
##  TRUE   1635  1142
```

Protest?


```r
table(grepl("protest", labs_df$tags), labs_df$party)
```


```r
##           D     R
##  FALSE 19734 16024
##  TRUE    166    96
```
