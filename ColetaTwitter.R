
library(twitteR)
library(tidyverse)
library(tidytext)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(dplyr)
library(igraph)
library(ggraph)
library(ggplot2)
library(dslabs)
library(RSQLite)

#Validação dos objetos 

api_key <- ""
api_key_secret <- ""
token_acesso <- ""
token_acesso_secreto <- ""

#Autenticacão

setup_twitter_oauth(api_key, api_key_secret, token_acesso,token_acesso_secreto)

searchTwitteR("A")
A <- searchTwitter("A", lang = "pt", n = 2500)
A <- A %>% twListToDF()
view(A)
trends <- availableTrendLocations()
head(trends)
view(trends)
world <- getTrends(1)
view(world)
Brasilia <- getTrends(455819)
view(Brasilia)

#Busca por hashtag

A_TAG <- searchTwitter("#covid", lang = "pt", n = 2500)
A_TAG <- A_TAG %>% twListToDF()
view(A_TAG)

SPACE_X <- searchTwitter("#SpaceX", lang = "pt", n = 2500)
SPACE_X <- SPACE_X %>% twListToDF()
view(SPACE_X)

#Dados que são puxados da minha conta 
#Minha timeline
minha_timeline <- homeTimeline(n = 25,maxID = NULL,sinceID = NULL)
minha_timeline <- minha_timeline %>% twListToDF()
view(minha_timeline)

#Lista de mentions 
minhas_menções <- mentions(n = 25, maxID = NULL,sinceID = NULL)
minhas_menções <- minhas_menções %>% twListToDF()
view(minhas_menções)

#Meus Retweets
meus_retweets <- retweetsOfMe(n = 25, maxID = NULL, sinceID = NULL )
meus_retweets <- meus_retweets %>% twListToDF()
view(meus_retweets)

#CSV
write.csv(timeline,"timeline.csv")
write.table(timeline,"timeline.txt", sep = "\t")


#Para fazer a importação do csv

timeline1 <- read.csv("timeline.csv",header = T)
view(timeline1)
str(timeline1)

#Manipulando o Data frame
dados <- timeline1
print(dados)
col1 <- timeline1[1]
print(col1)
col2 <- timeline1$screenName
print(col2)

#Deletando colunas 
timeline1$favorited <- NULL
timeline1$replyToSN <- NULL
timeline1$created <- NULL
timeline1$truncated <- NULL
timeline1$replyToSID <- NULL
timeline1$id <- NULL
timeline1$replyToUID <- NULL
timeline1$statusSource <- NULL
timeline1$screenName <- NULL
view(timeline1)

#Estatística
summary(timeline1$favoriteCount)
summary(timeline1$retweetCount)
#Verificando as Categorias
timeline1$UPS

#Gráfico
ggplot(data = timeline1,mapping = aes(isRetweet,favoriteCount))+  
  geom_point()

#CSV
write.csv(timeline1,"timeline1.csv")
write.table(timeline1,"timeline1.txt", sep = "\t")


