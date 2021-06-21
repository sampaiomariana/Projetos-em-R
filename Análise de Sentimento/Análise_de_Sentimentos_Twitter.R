#Análise de sentimentos utilizando os dados coletados do Twitter
#Todos os dados foram coletados via script R

#@author: Mariana de Sampaio
#@date: 05/04/2021

library(syuzhet)
library(stringr)
library(tidytext)


dados_twitter <- read.csv2("dados.csv",stringsAsFactors = FALSE)
View(dados_twitter)

is.character(dados_twitter)

#Transformando os dados em character 

dados_twitter <- as.character(dados_twitter)
class(dados_twitter)

#Conferir a transformação
is.character(dados_twitter)

sentimento <- get_nrc_sentiment(dados_twitter,language = "portuguese", lowercase = TRUE )

sentimento

#Summary para ter uma noção ampla do que foi dito

summary(sentimento)

op <- par(oma=c(5,7,1,1))
par(op)

barplot(colSums(sentimento),las = 3, ylab = "Quantidade", main = "Sentimento")

barplot(
  sort(colSums(prop.table(sentimento[,1:8]))),
  horiz = TRUE,
  cex.names = 0.7,
  las = 1,
  main = "Emoções",
  xlab = "Porcentagem"
  
)

#Separando em sentenças

sent <- get_sentences(dados_twitter, fix_curly_quotes = TRUE, as_vector = TRUE)
sent

sentimentos <- get_sentiment(
  sent,
  method = "syuzhet",
  path_to_tagger = NULL,
  cl = NULL,
  language = "portuguese",
  lexicon = TRUE,
  regex = "[^A-Za-zÂ´]+",
  lowercase = TRUE
)
sentimentos


#Análise de sentimentos separando em -1, 0 e 1.

sentimentos_vetor <- get_sentiment(sent,language = "portuguese", method = "bing")
sentimentos_vetor

#As medidas indicam como que a narrativa é estruturada no texto, indicando quando 
#os termos positivos e negativos foram ativados

summary(sentimentos_vetor)
sum(sentimentos_vetor)

#Estruturando a narrativa em um gráfico

plot_narrativa <- get_sentiment(sent)
plot(
  plot_narrativa,
  type = "l",
  main = "Exemplo de trajetória de trama",
  xlab = "Tempo narrativo",
  ylab = "Valência Emocional"
)
#Tempo narrativo são os tweets e a valência emocional indica as variações entre textos 
#positivos e negativos.

#Plot para demonstração de ruído 

plot(
  plot_narrativa,
  type = "h",
  main = "Exemplo de trajetória de trama",
  xlab = "Tempo narrativo",
  ylab = "Valência Emocional"
)

#Quanto mais aumentar o valor de bins , mais o gráfico se assemelha ao plot da narrativa
valores_percentuais <- get_percentage_values(sentimentos_vetor, bins = 10)
plot (
  valores_percentuais,
  type = "l",
  main = "Tweets baseados na porcentagem",
  xlab = "Tempo narrativo",
  ylab = "Valência Emocional",
  
)

#Separando os termos em tokens 

token <- get_tokens(texto,pattern = "\\W", lowercase = TRUE)
token


