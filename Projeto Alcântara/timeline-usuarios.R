# Monitoramento de usuários no Twitter que mencionam algum conteúdo sobre Alcântara

# Monitoramento da conta do @brazilian_blog 
# Monitoramento da conta do Podcast @PebPodcast
# Monitoramento da conta do @Alcantaraspace
# Monitoramento da conta do @espacial_aeb

#@author: Mariana de Sampaio
#@date: 21/06/2021


library(twitteR)
library(dplyr)
library(tidytext)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(tm)
library(rtweet)
library(config)


api_key <- "#########"
api_key_secret <- "#########"
token_acesso <- "#########"
token_acesso_secreto <- "#########"

twitter_token <- create_token(
  app = "Analise_Dados_Mariana",
  consumer_key = api_key,
  consumer_secret = api_key_secret,
  access_token = token_acesso,
  access_secret = token_acesso_secreto,
  set_renv = FALSE
)

#Dado extraido da Timeline
Timeline <-get_timeline('@brazilian_blog', n = 200000,maxID = NULL,includeRts = TRUE,excludeReplies = FALSE, token =twitter_token)

Timeline_DF <- Timeline %>%
  select(text, created_at,screen_name,favorite_count,retweet_count,is_retweet,quoted_location,quoted_description)

write.csv(Timeline_DF,'timelinebrazilian_blog.csv')

#Dados do usuário
setup_twitter_oauth(api_key, api_key_secret, token_acesso, token_acesso_secreto)
myuser <- getUser("brazilian_blog")
myuser.df <- as.data.frame(myuser)

#CSV
write.csv(myuser.df,"myuserbrazilian_blog.csv")

#-----------------------------------------------------------------------------------------------------------------------
#@PebPodcast
#-----------------------------------------------------------------------------------------------------------------------

#Dado extraido da Timeline
Timeline <-get_timeline('@PebPodcast', n = 200000,maxID = NULL,includeRts = TRUE,excludeReplies = FALSE,token =twitter_token)

Timeline_DF <- Timeline %>%
  select(text, created_at,screen_name,favorite_count,retweet_count,is_retweet,quoted_location,quoted_description)

write.csv(Timeline_DF,'timelinePebPodcast.csv')

#Buscando dentro da base da Timeline da @espacial_aeb o que é dito sobre Alcântara

dados <- read.csv("timelinePebPodcast.csv")

#Dados do usuário

setup_twitter_oauth(api_key, api_key_secret, token_acesso, token_acesso_secreto)
myuser <- getUser("PebPodcast")
myuser.df <- as.data.frame(myuser)

#CSV
write.csv(myuser.df,"myuserPebPodcast.csv")


#-----------------------------------------------------------------------------------------------------------------------
#@Alcantaraspace
#-----------------------------------------------------------------------------------------------------------------------

#Dado extraido da Timeline
Timeline <-get_timeline('@Alcantaraspace', n = 700,maxID = NULL,includeRts = TRUE,excludeReplies = FALSE,token =twitter_token)

Timeline_DF <- Timeline %>%
  select(text, created_at,screen_name,favorite_count,retweet_count,is_retweet,quoted_location,quoted_description)

write.csv(Timeline_DF,'AlcantaraSpace.csv')


#Dados do usuário

setup_twitter_oauth(api_key, api_key_secret, token_acesso, token_acesso_secreto)
myuser <- getUser("Alcantaraspace")
myuser.df <- as.data.frame(myuser)

#CSV
write.csv(myuser.df,"myuserAlcantaraspace.csv")


#-----------------------------------------------------------------------------------------------------------------------
#@espacial_aeb
#-----------------------------------------------------------------------------------------------------------------------

#Dado extraido da Timeline
Timeline <-get_timeline('@espacial_aeb', n = 2000,maxID = NULL,includeRts = TRUE,excludeReplies = FALSE,token =twitter_token)

Timeline_DF <- Timeline %>%
  select(text, created_at,screen_name,favorite_count,retweet_count,is_retweet,quoted_location,quoted_description)

write.csv(Timeline_DF,'timelineaeb.csv')


#Dados do usuário

setup_twitter_oauth(api_key, api_key_secret, token_acesso, token_acesso_secreto)
myuser <- getUser("espacial_aeb")
myuser.df <- as.data.frame(myuser)

#CSV
write.csv(myuser.df,"myuserespacialaeb.csv")

