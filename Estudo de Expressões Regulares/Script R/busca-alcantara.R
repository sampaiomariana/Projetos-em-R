#Modelo de script para realizar buscas por temas de interesse.
#Busca destinada a encontrar tweets com o termo Alcântara e dentro desta buscar por temas que sejam de interesse do PDI-CEA

#@author: Mariana de Sampaio
#@date: 21/07/2021

library(tm)
library(stringr)
library(rtweet)
library(RColorBrewer)
library(cluster)
library(fpc)
library(ggplot2)
require(tidyverse)

api_key <- "cgReO4KR4CoKTFV66PM0wRLqF"
api_key_secret <- "UaubaOtnTqZ4jyCZULt7vkh9MCEiR0IxVqPXoKD0hkdMHe5iSM"
token_acesso <- "1228324028382949376-Ana0i4Balpfy1LKY8a1JuKfYPk9bx9"
token_acesso_secreto <- "ccUFa37jl46yXg62FoeBLXm3qjqgc7vkRd92YrAGJpTbS"

twitter_token <- create_token(
  app = "Analise_Dados_Mariana",
  consumer_key = api_key,
  consumer_secret = api_key_secret,
  access_token = token_acesso,
  access_secret = token_acesso_secreto,
  set_renv = FALSE
)

Alcantara <- search_tweets("Alcântara|alcantara", 
                           n = 30000 ,include_rts = FALSE, lang = "pt",token = twitter_token)
View(Alcantara)

dados00 <- Alcantara %>% dplyr::select(created_at,user_id,screen_name,
                                  text,favorite_count,retweet_count,hashtags,urls_t.co,location)
View(dados00)

#Separando a hashtag

dados00 <- unnest(dados00,cols = c(hashtags))
View(dados00)

data_top <- dados00 %>% filter(is.na(hashtags)==F) %>%
  group_by(hashtags) %>% summarise(count=n()) %>%
    arrange(-count) %>% filter(row_number()< 21) %>% 
      arrange(count) %>% mutate(hashtags = factor(hashtags,levels = hashtags))

View(data_top)

##REGEX

coleta00 <- str_detect(Alcantara, pattern = "base de alc[antara]|[ântara]")
coleta00


coleta <- search_tweets("base de alcantara", n = 1000, include_rts = F, retryonratedlimit=F,lang = "pt")
View(coleta)
dados <- coleta %>% dplyr::select(created_at,user_id,screen_name,
                                  text,favorite_count,retweet_count,hashtags,urls_t.co,location)
View(dados)

#CSV
write_as_csv(dados,"dados.csv")

coleta <- unnest(dados,cols = c(hashtags))
data_top01 <- coleta %>% filter(is.na(hashtags)==F) %>%
  group_by(hashtags) %>% summarise(count=n()) %>%
  arrange(-count) %>% filter(row_number()< 21) %>% 
  arrange(count) %>% mutate(hashtags = factor(hashtags,levels = hashtags))

View(data_top01)

coleta01 <- str_detect(dados$text, pattern = "base")
coleta01
teste02 <- str_subset(dados,'b[ase]')
teste02
View(teste02)
head(teste02)





## Testes com expressões regulares para retirar os outliers 

str_view(Alcantara$text,"^AEB$")
str_view(Alcantara$text,"^empresa$")
Alcantara$text %>% str_detect("empres[a]|[as]")
Alcantara$text %>% str_detect("AST|fiema|FIEMA")
Alcantara$text %>% str_detect("lançament[o]|[os]")


#Coleta da massa de dados com o termo Alcantara

write_as_csv(Alcantara,"Dados1.csv", prepend_ids = TRUE,na = "", fileEncoding = "UTF-8")

