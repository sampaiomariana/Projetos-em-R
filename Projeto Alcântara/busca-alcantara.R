#Modelo de script para realizar buscas por temas de interesse.
#Busca destinada a encontrar tweets com o termo Alcântara e dentro desta buscar por temas que sejam de interesse do PDI-CEA

#@author: Mariana de Sampaio
#@date: 21/06/2021


library(tm)
library(stringr)
library(rtweet)
library(RColorBrewer)
library(cluster)
library(fpc)
library(ggplot2)


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

Alcantara <- search_tweets("Alcantara", n = 30000 ,include_rts = FALSE, lang = "pt",token = twitter_token)


#Coleta da massa de dados com o termo Alcantara

write_as_csv(Alcantara,"Dados1.csv", prepend_ids = TRUE,na = "", fileEncoding = "UTF-8")


#Essas palavras foram escolhidas ao analisar o arquivo bruto inicial que foi obtido.
#Limpeza de dados 
retirar <- c("Thiago Alcantara", "Priscila Alcantara","Priscilla","Priscilla Alcantara","Thiago Alcantara","Thiago","cantora", "jogador", "lu_alcantara", "aale_alcantara", "JB__Alcantara", "L_A_L_Alcantara","Alcantara_crf", "iSportsBrasi",
             "@alcantara", "São Pedro de Alcântara", "@lu_alcantara_83","@Jeo_alcantar", "@", "@iSportsBrasil","Alcantara_lil")

#-------------------------------------------------------------------------------------
#Dados mais filtrados 
#-------------------------------------------------------------------------------------

TextMining1 <- agrep(pattern = "Alcantara", Alcantara$text, ignore.case = FALSE,value = TRUE, fixed = TRUE )

len_dados <- str_length(TextMining1)

busca01 <- str_detect(TextMining1, "Alcantara")

textos01 <- str_subset(TextMining1, "Alcantara")


write.csv(textos01,"Alcantara.csv", fileEncoding = "UTF-8")

#Busca usando nomes relacionados a Alcantara 

#-------------------------------------------------------------------------------------
#Bolsonaro

#-------------------------------------------------------------------------------------


busca02 <- str_detect(TextMining1, "Bolsonaro")

textos02 <- str_subset(TextMining1, "Bolsonaro")

write.csv(textos02,"bolsonaro_base.csv", fileEncoding = "UTF-8")

#-------------------------------------------------------------------------------------
#Lançamento

#-------------------------------------------------------------------------------------
busca03 <- str_detect(TextMining1, "lançamento")
textos03 <- str_subset(Alcantara$text, "lançamento")


write.csv(textos03,"lançamento_base.csv", fileEncoding = "UTF-8")

#-------------------------------------------------------------------------------------
#Foguete

#-------------------------------------------------------------------------------------
busca04 <- str_detect(TextMining1,"foguete")
textos04 <- str_subset(Alcantara$text, "foguete")


write.csv(textos04,"foguete_base.csv", fileEncoding = "UTF-8")

#-------------------------------------------------------------------------------------

#AEB

#-------------------------------------------------------------------------------------
busca05 <- str_subset(TextMining1,"AEB")
textos05 <- str_subset(Alcantara$text, "AEB")

write.csv(textos05,"AEB.csv", fileEncoding = "UTF-8")


#-------------------------------------------------------------------------------------
#Agência Espacial Brasileira

#-------------------------------------------------------------------------------------

busca06 <- str_subset(TextMining1,"Agência Espacial Brasileira")
textos06 <- str_subset(Alcantara$text, "Agência Espacial Brasileira")


write.csv(textos06,"AEB2.csv", fileEncoding = "UTF-8")



#-------------------------------------------------------------------------------------
#Maranhão

#-------------------------------------------------------------------------------------

busca07 <- str_subset(TextMining1,"Maranhão")
textos07 <- str_subset(Alcantara$text, "Maranhão")


write.csv(textos07,"Maranhao.csv", fileEncoding = "UTF-8")


#-------------------------------------------------------------------------------------
#Acordo de Salvaguardas Tecnológicas

#-------------------------------------------------------------------------------------

busca08 <- str_subset(TextMining1,"Acordo de Salvaguardas Tecnológicas")
textos08 <- str_subset(Alcantara$text, "Acordo de Salvaguardas Tecnológicas")


write.csv(textos08,"AST.csv", fileEncoding = "UTF-8")