#Acesso aos twetts 

library(twitteR)
library(tidyverse)
library(tidytext)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(dplyr)

#Validação dos objetos 

consumer_key <- ""
consumer_key_secret <- ""
token_acesso <- ""
token_acesso_secreto <- ""


#Autenticação

setup_twitter_oauth(consumer_key, consumer_key_secret, token_acesso,token_acesso_secreto)

searchTwitteR("covid")
?searchTwitteR
covid <- searchTwitter("covid", lang = "pt", n = 2500)

#Executando e transformando em Data frame 

covid <- covid %>% twListToDF()
view(covid)

#Tweets de conta que tenha acesso público

tweets_A <- searchTwitter("@", n = 200)
head(tweets_A)

#Informações do usuário

myuser <- getUser("A")

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

timeline <- userTimeline("A", n = 200)
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

