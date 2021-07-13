#Estudo com Expressões Regulares

#@author: Mariana de Sampaio
#@date: 13/07/2021

require(tidyverse)

grupo01 <- c("Alcântara", "ALCÂNTARA", "Alcantara", "MA", "FIEMA", "Observatório", "AEB", "Agência Espacial Brasileira",
             "agência espacial brasileira", "aeb", "desenvolvimento", "CLA")
grupo01

#Detectar 

grupo01 %>% str_detect("A")
#OR
grupo01 %>% str_detect("A|a")
#OR
grupo01 %>% str_detect("O|o")
#AND
grupo01 %>% str_detect("A & a")

#Indexação 


grupo01 %>% str_subset("A")
#OR
grupo01 %>% str_subset("A|a")
#OR
grupo01 %>% str_subset("O|o")
#AND
grupo01 %>% str_subset("A & a")

#Remover


grupo02 <- c("Alcântara", "ALCÂNTARA", "Alcantara", "MA", "FIEMA", "Observatório","cantora", "AEB", "Agência Espacial Brasileira",
             "agência espacial brasileira", "aeb", "desenvolvimento", "CLA", "Thiago", "jogador", "jogador","cantora")
grupo02
grupo02 %>% str_remove_all("jogador")
grupo02 %>% str_remove("cantora")
grupo02 %>% str_remove("Thiago")


