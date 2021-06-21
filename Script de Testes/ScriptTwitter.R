#Importando dados 
#Dados levantados em fevereiro
#Transformar os dados em um arquivo de texto
#h=T header = cabeçalho é o titulo da coluna

#Pacotes 
library(ggplot2)

#Visualização em data frame

datasetTwitter <- read.table("TwitterPosts.txt", h=T)
View(datasetTwitter)
head(datasetTwitter)

#Gráficos

qplot(Curtidas, Retwitte, data = datasetTwitter, geom = "point")
