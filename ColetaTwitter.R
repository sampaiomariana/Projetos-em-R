
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

api_key <- "cgReO4KR4CoKTFV66PM0wRLqF"
api_key_secret <- "UaubaOtnTqZ4jyCZULt7vkh9MCEiR0IxVqPXoKD0hkdMHe5iSM"
token_acesso <- "1228324028382949376-UrS2fjCveaqmLRNhSaH6RDUKwZqVjI"
token_acesso_secreto <- "dMO78Mn6kiASAvmX6fhyHaZHfkzOJruauOJKWdj5h3bit"

#Autenticacão

setup_twitter_oauth(api_key, api_key_secret, token_acesso,token_acesso_secreto)

searchTwitteR("AEB")
AEB <- searchTwitter("AEB", lang = "pt", n = 2500)
AEB <- AEB %>% twListToDF()
view(AEB)
trends <- availableTrendLocations()
head(trends)
view(trends)
world <- getTrends(1)
view(world)
Brasilia <- getTrends(455819)
view(Brasilia)

#Busca por hashtag

AEB_TAG <- searchTwitter("#AEB", lang = "pt", n = 2500)
AEB_TAG <- AEB_TAG %>% twListToDF()
view(AEB_TAG)

SPACE_X <- searchTwitter("#SpaceX", lang = "pt", n = 2500)
SPACE_X <- SPACE_X %>% twListToDF()
view(SPACE_X)

#Tweets da conta da @espacial_aeb

tweets_aeb <- searchTwitter("@espacial_aeb", n = 200)
head(tweets_aeb)

#Informacoes do usuArio

myuser <- getUser("espacial_aeb")
myuser$name
myuser$getDescription()
myuser$getCreated()
myuser$followersCount
myuser$favoritesCount
myuser$friendsCount
myuser$id
myuser$lastStatus
myuser$location


#Inforamcoes direto da conta da @espacial_aeb

timeline <- userTimeline("espacial_aeb", n = 100, maxID = NULL, sinceID = NULL,
                         includeRts = TRUE, excludeReplies = FALSE)
head(timeline)
timeline <- timeline %>% twListToDF()
view(timeline)
str(timeline)
summary(timeline)
timeline$text


#Acesso aos dados do retweeters
#Post sobre : Encomenda Tecnológica (ETEC) é um instrumento...
retweeters(id = "1268866631742230530", n = 20)
resultado <- showStatus("1268866631742230530")
retweeters(resultado$getId())

#Chamamento Público AEB | Saiba mais sobre a importância
retweeters(id = "1268599125702033409")
resultado2 <- showStatus("1268599125702033409")
retweeters(resultado2$getId())
retweeters(resultado2$getIsRetweet())
retweeters(resultado2$getLatitude())
retweeters(resultado2$getLongitude())

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

#Novos Dados

userTimeline("espacial_aeb", n = 100 , maxID = NULL, sinceID = NULL,
             includeRts = TRUE, excludeReplies = FALSE)
mentions(n = 25, "espacial_aeb")
user_aeb <- getUser ("espacial_aeb")
print(user_aeb)
user_aeb$id
user_aeb$favoritesCount
user_aeb$followersCount
user_aeb$followRequestSent
user_aeb$lang
user_aeb$lastStatus
user_aeb$initialize()
user_aeb$location
user_aeb$statusesCount
user_aeb$verified

users_aeb <- lookupUsers("espacial_aeb")
head(users_aeb)
