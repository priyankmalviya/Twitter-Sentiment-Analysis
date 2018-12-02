# Twitter-Sentiment-Analysis
The sentiment analysis was done by extracting tweets and preprocessing them in 'R' to remove the biased users from the data set.
Tweets were extracted using tweepy.
To get the biased users there was a two step process followed. In the first step tweets' data was grouped together on the basis
of twitter user id. Then the users with exceptionally high number of tweets were assumed as the biased one, assuming that only a biased user would make so many tweets in the space of one month.
In the second step, sentiment score for each user was calculated, mean and standard deviation of the score was also calculated. 
All the users whose sentiments score was more than double the sentiment score away from the standard deviation from the mean were considered as biased users. 
After removing the biased users in preprocessing, sentiment value was calculated using library syuzhet, and histogram of the sentiment value was plot to analyse the data and come up with some conclusions.
