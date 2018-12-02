df <- read.csv(“tweetsFromId.csv”)
df1 <- df[complete.cases(df),]
df1$Id = 1
df2 <- tapply(df1$Id, df1$UserId, sum)
Df2 <- as.data.frame.table(df2)
names(df2) <- c(“UserId”, “numOfTweets”)
// Data Cleaning
df1bkup <- df1
Df1bkup <- gsub("http.*","",df1$Text)
df1$Text <- df1bkup // putting back the texts in the data frame
df1bkup <- df1$Text
df1bkup <- gsub(“https.*”,””,df1bkup)
df1$Text <- df1bkup
Df1bkup <- df1$Text
df1bkup <- gsub("#.*","",df1bkup)
df1$Text <- df1bkup
df1bkup <- df1$Text
df1bkup <- gsub("@.*","",df1bkup)
df1$Text <- df1bkup

text.df <- df1$Text  //text.df would be "character"
emotion.df <- get_nrc_sentiment(text.df)
finalbkup <- df1
finalbkup <- cbind(finalbkup, emotion.df)
df1Text <- finalbkup$Text
sent.value <- get_sentiment(df1Text)
sign(sent.value) // convert values to 1, -1 and 0
finalbkup <- cbind(finalbkup, sent.value) 


18464266        791
102            25073877       1011
44             15952856       1850


15952856        954
225             25073877       1011
268             32871086       1345
810           2353605901       2921

