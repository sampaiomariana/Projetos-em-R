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

#Replace/Substituir 

grupo03 <- c("Alcântara", "Alcantara", "lançamentos","lançamento","avançar","avanços","avançou","avanço")
grupo03

grupo03 %>% str_replace_all("lançamentos", "lançamento")
grupo03 %>% str_replace_all("avanços|avançou|avançar", "avanço")

#REGEX

# \\s (espaço)
grupo_check <- c("A AEB","A AEB","A AEB")
grupo_check
grupo04 <- c("  A AEB", "A   AEB  ", "  A      AEB")
grupo04
identical(grupo_check,grupo04)
grupo04 <- grupo04 %>% str_replace_all("\\s{2,}", " ") %>% 
  str_trim
grupo04
identical(grupo_check,grupo04)


# \\D -> não dígito e \\d -> dígitos 0-9

grupo05 <- c("AEB 25 anos", "AEB 26 anos", "AEB 27 anos")
grupo05 %>% str_remove_all("\\d")
grupo05 %>% str_remove_all("\\D") %>% 
  as.numeric() %>%
  mean

# . -> qualquer coisa
grupo06 <- c(" 5.55", "25 anos AEB.")
grupo06
grupo06 %>% str_subset("\\D\\.") # \\D -> não dígito
grupo06 %>% str_subset("\\d\\.") # \\d -> dígito
grupo06 %>% str_subset("\\.") # \\D -> não dígito


# Capturando por grupo de captura 
grupo03
grep("lançament[o|os]", grupo03)
grep("Alc[â|a]ntara", grupo03)
grep("avanç[ar|os|ou|o]", grupo03)
grupo03

grupo03
grep("[a-z]", grupo03,value = TRUE)
grep("[0-9]", grupo03,value = TRUE)
grupo06
grep("[a-z]", grupo06)
grep("[a-z]", grupo06,value = TRUE)
grep("[0-9]$", grupo06)
grep("[0-9]$", grupo06,value = TRUE)
