#Acesso aos twetts 

library(twitteR)
library(tidyverse)
library(tidytext)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(dplyr)

#Validação dos objetos 

consumer_key <- "4mNZxoJQOLXldjjx3sM8Qw8uR"
consumer_key_secret <- "AJipsbBGPUlXB9OYHHUw896wCrJCunCMANpXg9s5MVGghojrvY"
token_acesso <- "1228324028382949376-47MgWasiIzm5tZWDuk9fCpuEbAu8tp"
token_acesso_secreto <- "ZfOiwOWc9jPJ1ngdR4TP4oXbZYgw2JUBHIJ7k9uAO3KlP"


#Autenticação

setup_twitter_oauth(consumer_key, consumer_key_secret, token_acesso,token_acesso_secreto)

searchTwitteR("AEB")
?searchTwitteR
AEB <- searchTwitter("AEB", lang = "pt", n = 2500)

#Executando e transformando em Data frame 

AEB <- AEB %>% twListToDF()
view(AEB)

#Tweets da conta da @espacial_aeb

tweets_aeb <- searchTwitter("@espacial_aeb", n = 200)
head(tweets_aeb)

#Informações do usuário

myuser <- getUser("espacial_aeb")

#Funções possiveis 

myuser$getClass()

#Caractertisticas da conta 

myuser$getDescription()
myuser$getCreated()
myuser$getVerified()
myuser$getProfileImageUrl()
myuser$getName()
myuser$getScreenName()
myuser$getLocation()

#Seguidores 

myuser$getFollowersCount()
myuser$getFollowRequestSent()
myuser$getFriendsCount()
myuser$getFavoritesCount()

#Retornam erro 404
#myuser$getFollowerIDs()
#myuser$getFollowers()

timeline <- userTimeline("espacial_aeb", n = 200)
head(timeline)

#WordCloud

tweeter <- vector(mode = "character", length = length(tweets))
?vector

for (i in 1: length(tweets)){
  tweeter[i] <- tweets[[i]]$getScreenName()
}

tweeter.frequencia <- table(tweeter)

wordcloud(names(tweeter.frequencia), tweeter.frequencia, min.freq = 3, max.words = Inf, random.order = TRUE, random.color = FALSE, rot.per = .1,
          colors = "black", ordered.colors = FALSE, use.r.layout = FALSE, fixed.asp = TRUE)

#Explorando a wordcloud

for(i in 1:length(tweets)){
  tweeter[i] <- tweets[[i]]$getUrls()
}
tweeter.frequencia <- table(tweeter)

wordcloud(names(tweeter.frequencia), tweeter.frequencia, min.freq = 3, max.words = Inf, random.order = TRUE, random.color = TRUE, rot.per = .1,
          colors = "black", ordered.colors = TRUE, use.r.layout = TRUE, fixed.asp = TRUE)


#Tweets da conta do @mctic

tweets_mctic <- searchTwitteR("mctic", n = 200)
head(tweets_mctic)

#Informações do usuário

myuser <- getUser("mctic")
myuser$created
myuser$description

#Data Mining 

availableTrendLocations() %>% View()
getTrends("455819") %>% view
?getTrends()
searchTwitteR("#CLA")
searchTwitteR("#Alcantara")
searchTwitteR("#AEB")
searchTwitteR("#FAB")

retweets <- strip_retweets(tweets_aeb)
retweets <- retweets %>% twListToDF()
view(retweets)
?strip_retweets()

