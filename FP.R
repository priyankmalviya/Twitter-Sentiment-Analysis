
library(syuzhet)
df <- read.csv(“tweetsFromId.csv”)
df <- df[-c(3:7,9:13)]
df <- df[complete.cases(df),]
df.text <- df$text
df.text <- gsub("http.*","",df.text)
df.text <- gsub("https.*","",df.text)
df.text <- gsub("@.*","",df.text)
df.text <- gsub("\n"," ", df.text)

df$text <- df.text
df <- df[complete.cases(df),]

//start from 
abrams.df <- df.bkup[grep("[sS]tacey ?[aA]brams", df.bkup$Text, value = FALSE),]
kemp.df <- df.bkup[grep("[kK]emp", df.bkup$Text, value = FALSE),]
abrams.df$tweetid = 1
kemp.df$tweetid = 1
kemp.bias <- tapply(kemp.df$tweetid, kemp.df$userid, sum)
abrams.bias <- tapply(abrams.df$tweetid, abrams.df$userid, sum)
kemp.bias <- as.data.frame.table(kemp.bias)
abrams.bias <- as.data.frame.table(abrams.bias)

names(kemp.bias) <- c("userid", "tweetcount")
names(abrams.bias) <- c("userid", "tweetcount")

max(abrams.bias$tweetcount)
mean(abrams.bias$tweetcount)
sd(abrams.bias$tweetcount)

max(kemp.bias$tweetcount)
mean(kemp.bias$tweetcount)
sd(kemp.bias$tweetcount)


hist(abrams.bias$tweetcount, breaks = 100, col = "red")
denabrams <- density(abrams.bias$tweetcount)
plot(denabrams)

hist(kemp.bias$tweetcount, breaks = 100, col = "red")
denkemp <- density(kemp.bias$tweetcount)
plot(denkemp)

sortkemp <- kemp.bias[order(kemp.bias$tweetcount),]
sortabrams <- abrams.bias[order(abrams.bias$tweetcount),]


abrams.df$bias <- 2
abrams.df$bias[abrams.df$userid == 15952856] <- NA
abrams.df$bias[abrams.df$userid == 25073877] <- NA
abrams.df$bias[abrams.df$userid == 32871086] <- NA
abrams.df$bias[abrams.df$userid == 2353605901] <- NA

abrams.df <- abrams.df[complete.cases(abrams.df),]

#similarly we deleted for kemp biased tweets

abramstext.df <- abrams.df$text
abramstext.df <- as.character(abramstext.df)
emotionabrams.df <- get_nrc_sentiment(abramstext.df)
abrams.df <- cbind(abrams.df, emotionabrams.df)

sent.value <- get_sentiment(abramstext.df)
abrams.df <- cbind(abrams.df, sent.value)

kemptext.df <- kemp.df$text
kemptext.df <- as.character(kemptext.df)
emotionkemp.df <- get_nrc_sentiment(kemptext.df)
kemp.df <- cbind(kemp.df, emotionkemp.df)

sent.value <- get_sentiment(kemptext.df)
kemp.df <- cbind(kemp.df, sent.value)


abrams.bias1 <- tapply(abrams.df$sent.value, abrams.df$userid, sum)
abrams.bias1 <- as.data.frame.table(abrams.bias1)

names(abrams.bias1) <- c("userid", "sent.value")
max(abrams.bias1$sent.value)
min(abrams.bias1$sent.value)
mean(abrams.bias1$sent.value)
hist(abrams.bias1$sent.value, breaks = 100, col = "red")

kemp.bias1 <- tapply(kemp.df$sent.value, kemp.df$userid, sum)
kemp.bias1 <- as.data.frame.table(kemp.bias1)
names(kemp.bias1) <- c("userid", "sent.value")
max(kemp.bias1$sent.value)
min(kemp.bias1$sent.value)
mean(kemp.bias1$sent.value)
hist(kemp.bias1$sent.value, breaks = 100, col = "red")


//we did the whole on original data next to see the impact
kemporig.df <- read.xlsx("kempdf.xlsx", sheetName = "Sheet1")
abramsorig.df <- read.xlsx("abramsdf.xlsx", sheetName = "Sheet1")

abramsorigtext.df <- abramsorig.df$text
abramsorigtext.df <- as.character(abramsorigtext.df)
emotionorigabrams.df <- get_nrc_sentiment(abramsorigtext.df)
abramsorig.df <- cbind(abramsorig.df, emotionorigabrams.df)

sent.value <- get_sentiment(abramsorigtext.df)
abramsorig.df <- cbind(abramsorig.df, sent.value)



kemporigtext.df <- kemporig.df$text
kemporigtext.df <- as.character(kemporigtext.df)
emotionorigkemp.df <- get_nrc_sentiment(kemporigtext.df)
kemporig.df <- cbind(kemporig.df, emotionorigkemp.df)

sent.value <- get_sentiment(kemporigtext.df)
kemporig.df <- cbind(kemporig.df, sent.value)


abrams.norm <- tapply(abramsorig.df$sent.value, abramsorig.df$userid, sum)
abrams.norm <- as.data.frame.table(abrams.norm)

names(abrams.norm) <- c("userid", "sent.value")
max(abrams.norm$sent.value)
min(abrams.norm$sent.value)
mean(abrams.norm$sent.value)
hist(abrams.norm$sent.value, breaks = 100, col = "red")


kemp.norm <- tapply(kemporig.df$sent.value, kemporig.df$userid, sum)
kemp.norm <- as.data.frame.table(kemp.norm)

names(kemp.norm) <- c("userid", "sent.value")
max(kemp.norm$sent.value)
min(kemp.norm$sent.value)
mean(kemp.norm$sent.value)
hist(kemp.norm$sent.value, breaks = 100, col = "red")

}





