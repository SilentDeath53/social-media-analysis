install.packages("rtweet")   # For accessing the Twitter API
install.packages("tidytext") 
library(rtweet)
library(tidytext)

# Authenticate with your Twitter API credentials
create_token(
  app = "your_app_name",
  consumer_key = "your_consumer_key",
  consumer_secret = "your_consumer_secret",
  access_token = "your_access_token",
  access_secret = "your_access_secret"
)

# Search for tweets based on a specific query or hashtag
tweets <- search_tweets(q = "#example", n = 1000)

sentiment <- tweets %>%
  select(text) %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment)

library(ggplot2)
ggplot(sentiment, aes(x = sentiment, y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Sentiment", y = "Count") +
  ggtitle("Sentiment Analysis of Tweets")
