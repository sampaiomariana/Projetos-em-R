#Script de tratamento de dados para wordcloud 

library(tm)
library(stringr)
library(wordcloud)

#Verificar o diretório
getwd()
#Ler o arquivo
texto <- readLines("dadoswordcloud.csv", encoding = "UTF-8")
View(texto)
#Unindo as linhas
texto_unido <- paste(texto, collapse =" ")

texto_unido

#Tratamento de texto 

#Removendo pontuações
texto_unido_2 <- gsub(pattern = "\\W", replace = " ", texto_unido)

#Removendo números
texto_unido_3 <- gsub(pattern = "\\d", replace = " ", texto_unido_2)
texto_unido_3

#Letras minúsculas
texto_unido_4 <- tolower(texto_unido_3)
texto_unido_4


texto_unido_5 <- removeWords(texto_unido_4,c("faça","mas","https","eu","só","caso","mais","vira","podia","de","ver","falar","quem","é","e","O","A","hfbbk",
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
                                             "mundo","ah","mané","deixa","linha","vocês","jeffsncjcw","allex_rgs","jucfjay","estará","porém","daí",
                                             "me","teste","corja","ai","ta","fos","ptz","boas","xwtw","dlh","cox","qeg","yep","kfc","cjoj"
))
texto_unido_5

texto_unido_6 <- stripWhitespace(texto_unido_5)
texto_unido_6

#Separando os termos
#Ficam salvos como uma lista, indicado por [[1]]

words <- str_split(texto_unido_6,pattern = "\\s+")
words

#Transformando em caracter
#Classe como lista
class(words)
words <- unlist(words)
words
#A classe passa a ser de character
class(words)
#Com a random.order = false as palavras mais citadas estarão no centro da wordcloud
wordcloud(words, min.freq = 1,random.order = FALSE, scale = c(4,.8), colors = rainbow(8) )

write.csv(words,file = "words.csv")
