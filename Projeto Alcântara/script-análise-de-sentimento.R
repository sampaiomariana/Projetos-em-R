#Análise de sentimentos utilizando os dados coletados do Twitter
#Todos os dados foram coletados via script R


library(syuzhet)
library(stringr)
library(tidytext)
library(pander)
library(wordcloud)
library(tm)

dados_twitter <- read.csv2("dadoswordcloud.csv",stringsAsFactors = FALSE)
View(dados_twitter)

is.character(dados_twitter)

#Transformando os dados em character 

dados_twitter <- as.character(dados_twitter)
class(dados_twitter)

#Conferir a transformação
is.character(dados_twitter)

sentimento <- get_nrc_sentiment(dados_twitter,language = "portuguese", lowercase = TRUE )

sentimento

#Utilizar apenas positivo e negativo

positive_text <- which(sentimento$positive > 0)
dados_twitter[positive_text]

negative_text <- which(sentimento$negative > 0)
dados_twitter[negative_text]

#Pander apenas com positivo e negativo
pander::pandoc.table(sentimento[, 9:10])

barplot(
  sort(colSums(prop.table(sentimento[, 9:10]))), 
  horiz = FALSE, 
  cex.names = 0.7, 
  las = 1, 
  col = c( "darkred", "darkgreen"),
  main = "Análise de Sentimentos", ylab="Porcentagem"
)
legend("topleft",
       c("Negative","Positive"),
       fill = c("darkred","darkgreen")
)

#Pander com todos os sentimentos
pander::pandoc.table(sentimento[, 1:8], split.table = Inf)

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

token <- get_tokens(sent,pattern = "\\W", lowercase = TRUE)
token

#Stopwords

stop <- stopwords::data_stopwords_nltk$pt
remover <- c ("faça","mas","https","eu","só","caso","mais","vira","podia","de","ver","falar","quem","é","e","O","A","hfbbk",
              "t","co","fetq","jbxevuux"," h","f","u","kkkkkkk","robertorocha_ma","vc","poderia","ser","pelo","qual","o","para",
              "deixar","não","a","cada","diria","uns","baita","etc","em","izzynobre","g","hima","feh","mexe","tanto","vamos","dar",
              "lusosaylor","aqui","por","coloca","procura","nesse","no","na","uma","um","o","falando","teremos","este","esta","cara",
              "do","ouvindo","isso","ri","bastante","podia","ser","já","esse","pr","com","mude","astro_pontes","jairbolsonaro",
              "damaresalves","mribeiromec","gilsonmachadont","bolsonarosp","grande","rasteja","trilha","mortes","excemento",
              "sorriso","sardonico","patetico","ministro_pateta"," secomvc","bom","que","como","diz","falta","seu","face","abraço",
              "numa","qualquer","hahhahahahhah","pq","tmj","certeza","parabéns","coisas","da","encerrar","ma"," lq","qg","fsh",
              "todo","fd","fe","xys","s","moscas","meu","d","tpc","znvbq","pra","aperte","play","descubra","a","cidade"," rsiscc",
              "ym","aí","vai","caminho","imagina","kadaappm","mesmo","kkkk","gu_rebel","cardoso","mesmo","você","kkkkkkkkk",
              "kkkkkkkkkkkkk","ainda","nem","foram","seus","tomatosmat"," foy","gt","xhe","foy","cyma","aldeyamentos","y",
              "aquylombamentos","nós", "as","outra","ela","fazer","bem","queria","podemos","passar","frente","galera","vender",
              "akakaka","muyta","vyajy","nada","novo","sob","sol","ao","se","nunca","dia","mctic"," mapa_brasil","disso","dfdanielfreitas",
              " mfriasoficial","espacial_aeb","oi","spacetoday","agora","pior","acredita","nisso","pessoal","posso","beneficiado","quando",
              "vi","pois","hdrn","olfbwe"," cwg","sabe","fizeram","até","ele","pela","ficará","às","luffybenhv","makakakakaka","pros","gryngo",
              "invadido","saindo","pela","saindo","interceptada","fez","deforma","viu","demais","blogdoluispablo","mpvlhqvioc","considerada",
              " aznru","elonmusk","jdoriajr","vem","povo","flow","sabemos","nas","pode","vir","vaifilhao","lucas_m_fonseca",
              "j","mvf","n","certamente","importante","meio","volta","os","o","a","as","no","nas","na","rfpgtkobyq","ou","tem","chance",
              "govbr","kqfwrk","hh","aluisiomendesma","edilaziojunior_","deppedrolucasf","depandrefufuca","pp","uusqe","zik","giokxadiw",
              "sn","outras","uso","sabia","minha","conta","tinha","gente","dois","maços","fosse"," vaichevettao","cutucada","filhão"," seehcgientaosaidaqui",
              " kkkkkkkkkkkk ","ycmajfwcvh","traz","servida","olha","mentira","parar","","sr","r","junto","partir","dos","à","fim",
              "for","enquanto","questionamento","usndeqexx","vkwe","qfrey","entre","sobre","carne","madeira","apoio","for","temos",
              "faltam","estava","será","segundo","aliás","br","abtmwrdhbs","bbc","wvbog","prevê","fechou",
              "estar","nos","enquadrar","deles","estar","faz","pelos","pretende","suas","segundo","texto",
              "recomenda","abtmwrdhbs","temos","faltam","reportagem","faz","pelos","pretende","estar","deles",
              "nos","afundar","menos","usar","causa","veja","pro","coisa","nínguem","veio","essa","espera",
              "onde","jesus","outro","serão","temos","signifique","nos","manhã","amanhã","ter","feito","marcos",
              "depois","hora","usar","causa","gfpxtj","ligados","reverta","pede","recomendado","congelem",
              "dossiê","pede","muita","inocência","pedir","acho","menos","fagqd","ceder","quero","alcântara",
              "maranhão","fica","fonte","desse","além","afirmou","diferente","tão","inimigo","pontes","chegar","tempo",
              "pagar","quer","aos","jaw","estão","dando","ontem","alguém","fevereiro","vivem","querer","segunda",
              "então","vcs","enviou","tão","ano","partes","tirar","b","olhem","simplescidade","dessa","desse","foi","odeiam","tirar",
              "coloquem","também","recepção","foi","nosso","kimpkat","ypvb","esqueceu","narendramodi","toda","maranhão","kyk","retirada","errado",
              "interesse","das","ia","via","cd","vx","ducq","estão","operamundi","fala","recebido","rolar","kamalaharris","joebiden","chegou","humanos","maranhao","alcantara",
              "após","tá","hoje","loucura","anos","disse","são","quinta","desde","década","está","disse","muito","nesta","estado","aq","durante","tu","jxybqbuab",
              "jdprqw","youtube","lpfuo","ulyx","yiip","nessa","jrbqphp","várias","destes","ej","iodd","qhd","egu","mynsbj","rdsbvkm","ñ","visto","lembram","jqm","favor","mercê",
              "nesta","durante","deve","deu","certo","vão","tudo","sua","pouco","tipo","março","nossa","nossos","assim",
              "eles","sem","lá","algum","seria","deu","sugere","era","aconteceu","livre","participou","dttixava","kuwh","w","pb","kuwh",
              "dc","fb","ficarmos","recebe","jkbr","mg","ljk","mira","possível","taxou","fazia","yvbzef","cpn","tornou",
              "forma","rever","precisa","tornou","lava","fa","wrosariocgu","esportegovbr","terezacrisms","mapa_brasil","cooxvn",
              "rv","veycivmvmp","carlosbolsonaro","mec_comunicacao","fa","minsaude","bidê","pedindo","querem","inúteis","contra",
              "igwrt","wz","wrkj","z","própria","feitos","incluindo","votou","adiante","tirou","acontecer","equipe","zhl","hcq","nfv","somos",
              "cuja","zhl","mto","existe","isv","região","assistir","foco","ato","imaginar","tirou","isro","tirou","né","todos","todos",
              "local","há","cguonline","apoiar","continuar","tal","nfv","esteve","né","sonho","acontecer","cuja","assistir","tirou","todos",
              "fins","quase","aovivo","pendentes","tem","fato","legal","grupo","sendo","doar","sul","usa","casacivilbr","dizer","última",
              "outros","alguns","num","alto","rja","dá","participa","estarei","muitos","site","titula","moram","dias","governoma","inpemct","imb",
              "ler","lugar","irá","voltar","quase","fins","vivo","fato","yqe","posse","gritando","rumo","logo","fora","desta","parceria","boa",
              "lab","sei","zap","iqp","apenas","entra","pai","yre","secomvc","tissly","força","pessoas","inpemct","unidos","entregou","entregar",
              "mundo","0001f1f7","100","0001f680","0001f916","0001f44f","0001f923","125","sim","afinal","0001f1e7","tia","fácil","nhttps","0001f601","0001f1f8",
              "fe0f","tbt","vez","lua","alan"
)

texto <- removeWords(token,c(stop,remover))
texto

texto_1 <- stripWhitespace(texto)
texto_1

words <- str_split(texto_1, pattern = "\\s+")
words

class(words)
words <- unlist(words)
words

wordcloud(words,min.freq = 2,random.order = FALSE, scale = c(4,1), colors = rainbow(8))
