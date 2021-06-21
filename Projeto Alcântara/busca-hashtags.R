#Monitoramento das hashtags 
#search_tweets  o pacote que retorna os dados dos últimos 6-9 dias

#@author: Mariana de Sampaio
#@date: 21/06/2021

require(rtweet)
require(dplyr)
require(reactable)
require(twitteR)
require(tm)
library(devtools)
library(curl)



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
#------------------------------------------------------------------------------------------
#Alcantara
#------------------------------------------------------------------------------------------

Alcantara <- search_tweets("#Alcantara", n = 5000 ,include_rts = FALSE, lang = "pt",token = twitter_token)

Vw_op1 <- Alcantara %>% 
  select(user_id,screen_name,created_at,text,favorite_count,retweet_count,urls_expanded_url)

Alcantara.df <-as.data.frame(Vw_op1)

write_as_csv(Vw_op1,"alcantara_tag.csv", prepend_ids = TRUE,na = "", fileEncoding = "UTF-8")


#------------------------------------------------------------------------------------------
#esquecealcantara
#------------------------------------------------------------------------------------------

esquece_alcantara <- search_tweets("#esquecealcantara", n = 5000 ,include_rts = FALSE, lang = "pt",token = twitter_token)

Vw_op2 <- esquece_alcantara %>% 
  select(user_id,screen_name,created_at,text,favorite_count,retweet_count,urls_expanded_url)

esquece_alcantara.df <-as.data.frame(Vw_op2)

write_as_csv(Vw_op2,"esquece_alcantara_tag.csv", prepend_ids = TRUE,na = "", fileEncoding = "UTF-8")

#------------------------------------------------------------------------------------------
#pdicea
#------------------------------------------------------------------------------------------

pdicea <- search_tweets("#pdicea", n = 5000 ,include_rts = FALSE, lang = "pt",token = twitter_token)

write_as_csv(pdicea,"pdicea_tag.csv", prepend_ids = TRUE,na = "", fileEncoding = "UTF-8")
