#Acesso Youtube 

#@author: Mariana de Sampaio
#@date: 18/08/2020

#Identificação do vídeo

#Live
#KMsOwY4QHvY - Assinatura do Termo de parceria entre AEB e UnB
#lUalFY7B_Rw - Assinatura de acordo de cooperação AEB - MundoGeo

#AEB Talks 
#74Jujb0owSc - Frente Parlamentar Mista para o PEB
#_8XAoL_bCJE - Medicina Espacial
#f8Dgm27SxB8 - Future of Space Sector and Opportunities for Brazil
#zEmCz3RYxiw - A importância do Direito Espacial nas relações internacionais 
#zjcMHx67RtI - Como a física espacial pode colaborar para um mundo melhor 
#tvhRYuAQ4QA - Startups no setor espacial: fontes de financiamento

#Webinar 
#x8KKXz1elP0 - Workshop Petróleo e Espaço

#Fórum da Indústria Espacial Brasileira 
#kUKPTAc99sc


library(vosonSML)
library(tidyverse)

#Para ter acesso aos dados públicos 
#API key secret 

api_key <- "#########"

#Autenticação

youtubeAuth <- Authenticate ("youtube", api_key)
video_key <- c ('KMsOwY4QHvY','lUalFY7B_Rw','x8KKXz1elP0','kUKPTAc99sc','74Jujb0owSc','_8XAoL_bCJE','f8Dgm27SxB8','zEmCz3RYxiw','zjcMHx67RtI','tvhRYuAQ4QA' )
youtubeData <- youtubeAuth%>%
  Collect(video_key,writeTofile = TRUE, verbose = TRUE, maxComments = 1000)
  ?Collect
str(youtubeData)
view(youtubeData)

#CSV
write.csv(youtubeData, file = 'youtubecomments.csv', row.names = FALSE)
write.table(youtubeData,'youtubedata.txt', sep = '\t')
data <- read.csv(file.choose(), header = T)

#Informações do vídeo
GetYoutubeVideoIDs(urls = video_key )
?unnest()

#worcloud 
write.csv(youtubeData, file = 'wordcloud.csv', row.names = FALSE)
wordcloud_file <- read.csv2('wordcloud.csv',header = T)
view(wordcloud_file)
wordcloud_file2 <- tolower(wordcloud_file)
wordcloud_file2