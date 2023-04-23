data <- read.csv("C:/Users/Filipa Costa/Downloads/protecao_civil-master/protecao_civil-master/data/anpc-2016.csv")
summary(data)


plot(summary(as.factor(data$Natureza)))
#Como a granularidade da Natureza é muito baixa, temos de a aumentar. Logo agrupamos em 
#7 categorias


data <- read.csv("C:/Users/Filipa Costa/Downloads/DatAttack-UP-23-master/DatAttack-UP-23-master/data_with_incidentes.csv")


##quantidade na
sum(is.na(data))/nrow(data)*100 #0.003%
#logo, podemos simplesmente eliminar as linhas
data<-na.omit(data)

###Granularidade de recursos

png("plot_mterr.png", width = 3*3, height = 3*2, res = 300, units = 'in')
plot(as.factor(data$NumeroMeiosTerrestresEnvolvidos), ylab=(TeX('Observações')), xlab=(TeX('Quantidade de recursos mobilizadas')), main=(TeX('Meios Terrestres')))
dev.off()
#6 ou mais
png("plot_oterr.png", width = 3*3, height = 3*2, res = 300, units = 'in')
plot(as.factor(data$NumeroOperacionaisTerrestresEnvolvidos), ylab=(TeX('Observações')), xlab=(TeX('Quantidade de recursos mobilizadas')), main=(TeX('Operacionais Terrestres')))
dev.off()
#13 ou mais
png("plot_maer.png", width = 3*3, height = 3*2, res = 300, units = 'in')
plot(as.factor(data$NumeroMeiosAereosEnvolvidos), ylab=(TeX('Observações')), xlab=(TeX('Quantidade de recursos mobilizadas')), main=(TeX('Meios Aéreos')))
dev.off()
#variável não tem dados suficientes
png("plot_oaer.png", width = 3*3, height = 3*2, res = 300, units = 'in')
plot(as.factor(data$NumeroOperacionaisAereosEnvolvidos), ylab=(TeX('Observações')), xlab=(TeX('Quantidade de recursos mobilizadas')), main=(TeX('Operacionais Aéreos')))
dev.off()
#variável nao tem dados suficientes

#dividir em bins NumeroMeiosTerrestresEnvolvidos
data[data$NumeroMeiosTerrestresEnvolvidos>=6,]$NumeroMeiosTerrestresEnvolvidos=6

#dividir em bins NumeroOperacionaisTerrestresEnvolvidos
data[data$NumeroOperacionaisTerrestresEnvolvidos>=13,]$NumeroOperacionaisTerrestresEnvolvidos=13


###Ver recursos ao longo do tempo

#### Initial examination of the data ##############################################

time <- as.POSIXct(data$DataOcorrencia, format = "%d/%m/%Y %H:%M:%S", tz="Europe/Lisbon")
Year <- as.numeric(format(time, '%Y'));
Month <- as.numeric(format(time, '%m'));
Day <- as.numeric(format(time, '%d'));
Weekday <- as.numeric(format(time, '%u'));
Hour <- as.numeric(format(time, '%H'));

#################################Para analisar por ano, mês etc....

dataa<-cbind(data$DataOcorrencia, data$NumeroMeiosTerrestresEnvolvidos)
View(dataa)


#boxplots por ano, mês, dia da semana e dia para ver as variancias
nivel_terr<-data$NumeroMeiosTerrestresEnvolvidos
nivel_auto<-data$NumeroOperacionaisTerrestresEnvolvidos

#por mês
data_hour_extended <- as.data.frame(cbind(Year,Month,Day,Weekday, Hour, nivel_terr, nivel_auto))
par(mfrow=c(1,1),mai = c(0.7, 0.7, 0.1, 0.1))

png("plot_mterr_box.png", width = 3*3, height = 3*2, res = 300, units = 'in')

ggplot(data_hour_extended,aes(as.factor(Month),nivel_terr))+geom_boxplot()+
ggtitle("Meios Terrestres") +
  theme_bw() +
  labs(
    x = "Month",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

dev.off()

png("plot_oterr_box.png", width = 3*3, height = 3*2, res = 300, units = 'in')

ggplot(data_hour_extended,aes(as.factor(Month),nivel_auto))+geom_boxplot()+
  ggtitle("Operacionais Terrestres") +
  theme_bw() +
  labs(
    x = "Month",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

dev.off()

#analisar "outliers"
(nrow(data[data_hour_extended$Month==7 & data_hour_extended$nivel_terr==6,])+
  nrow(data[data_hour_extended$Month==7 & data_hour_extended$nivel_terr==5,])+
  nrow(data[data_hour_extended$Month==7 & data_hour_extended$nivel_terr==4,]))/nrow(data[data_hour_extended$Month==7,])
#mês 7, outliers são 9%.

##########Construção data sem outliers
data1<-cbind(data,Month)
data_terr_sem_out <- subset(data1, !(data_hour_extended$Month==3 & data_hour_extended$nivel_terr==6))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==4 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==6))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==5 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=2))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==5 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==0))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==6 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=2))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==6 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==0))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==10 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=2))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==10 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==0))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==11 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=2))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==11 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==0))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==12 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=2))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==12 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos==0))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==7 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=4))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==8 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=4))
data_terr_sem_out <- subset(data_terr_sem_out, !(data_terr_sem_out$Month==9 & data_terr_sem_out$NumeroMeiosTerrestresEnvolvidos>=4))

ggplot(data_terr_sem_out,aes(as.factor(Month),NumeroMeiosTerrestresEnvolvidos))+geom_boxplot()+
  ggtitle("Meios Terrestres") +
  theme_bw() +
  labs(
    x = "Month",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

##eliminando outliers surgem outros


#qual categoria que requere mais mobilização?

## Meios Terrestres
png("plot_mterr_nat.png", width = 3*3, height = 3*2, res = 300, units = 'in')
ggplot(data,aes(as.factor(Grouped),NumeroMeiosTerrestresEnvolvidos))+geom_boxplot()+
  ggtitle("Meios Terrestres") +
  theme_bw() +
  labs(
    x = "Natureza",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

dev.off()

### incêndios e operações

## Operacionais Terrestres

png("plot_oterr_nat.png", width = 3*3, height = 3*2, res = 300, units = 'in')

ggplot(data,aes(as.factor(Grouped),NumeroOperacionaisTerrestresEnvolvidos))+geom_boxplot()+
  ggtitle("Operacionais Terrestres") +
  theme_bw() +
  labs(
    x = "Natureza",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

dev.off()
##incêndios e operações

#####qual distrito requere mais mobilização?
## Meios Terrestres
ggplot(data,aes(as.factor(Distrito),NumeroMeiosTerrestresEnvolvidos))+geom_boxplot()+
  ggtitle("Meios Terrestres") +
  theme_bw() +
  labs(
    x = "Distrito",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )


## Operacionais Terrestres

ggplot(data,aes(as.factor(Distrito),NumeroOperacionaisTerrestresEnvolvidos))+geom_boxplot()+
  ggtitle("Meios Terrestres") +
  theme_bw() +
  labs(
    x = "Distrito",
    y = "Number of resources alocated"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

#similar em cada distrito


#incendios por distrito

counts <- table(data_new[data_new$Grouped=="Incêndios",]$Distrito)
data <- data.frame(
  category = c("AVEIRO", "BEJA", "BRAGA", "BRAGANÇA", "CASTELO BRANCO", "COIMBRA", "ÉVORA", "FARO", "GUARDA", "LEIRIA", "LISBOA", "PORTALEGRE", "PORTO", "SANTARÉM", "SETÚBAL", "VIANA DO CASTELO", "VILA REAL", "VISEU"),
  count <- c(
    counts[names(counts) == "AVEIRO"],
    counts[names(counts) == "BEJA"],
    counts[names(counts) == "BRAGA"],
    counts[names(counts) == "BRAGANÇA"],
    counts[names(counts) == "CASTELO BRANCO"],
    counts[names(counts) == "COIMBRA"],
    counts[names(counts) == "ÉVORA"],
    counts[names(counts) == "FARO"],
    counts[names(counts) == "GUARDA"],
    counts[names(counts) == "LEIRIA"],
    counts[names(counts) == "LISBOA"],
    counts[names(counts) == "PORTALEGRE"],
    counts[names(counts) == "PORTO"],
    counts[names(counts) == "SANTARÉM"],
    counts[names(counts) == "SETÚBAL"],
    counts[names(counts) == "VIANA DO CASTELO"],
    counts[names(counts) == "VILA REAL"],
    counts[names(counts) == "VISEU"]
  )
)

ggplot(data, aes(x = category, y = count, fill = category)) +
  geom_col(position = position_dodge())+
  ggtitle("Number of Incêndios records by region") +
  theme_bw() +
  labs(
    x = "Region",
    y = "Number of Incêndios"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

#Operações por distrito

#"CASTELO BRANCO"=0
counts <- table(data_new[data_new$Grouped=="Operações",]$Distrito)
data <- data.frame(
  category = c("AVEIRO", "BEJA", "BRAGA", "BRAGANÇA", "COIMBRA", "ÉVORA", "FARO", "GUARDA", "LEIRIA", "LISBOA", "PORTALEGRE", "PORTO", "SANTARÉM", "SETÚBAL", "VIANA DO CASTELO", "VILA REAL", "VISEU"),
  count <- c(
    counts[names(counts) == "AVEIRO"],
    counts[names(counts) == "BEJA"],
    counts[names(counts) == "BRAGA"],
    counts[names(counts) == "BRAGANÇA"],
    counts[names(counts) == "COIMBRA"],
    counts[names(counts) == "ÉVORA"],
    counts[names(counts) == "FARO"],
    counts[names(counts) == "GUARDA"],
    counts[names(counts) == "LEIRIA"],
    counts[names(counts) == "LISBOA"],
    counts[names(counts) == "PORTALEGRE"],
    counts[names(counts) == "PORTO"],
    counts[names(counts) == "SANTARÉM"],
    counts[names(counts) == "SETÚBAL"],
    counts[names(counts) == "VIANA DO CASTELO"],
    counts[names(counts) == "VILA REAL"],
    counts[names(counts) == "VISEU"]
  )
)

ggplot(data, aes(x = category, y = count, fill = category)) +
  geom_col(position = position_dodge())+
  ggtitle("Number of Operações records by region") +
  theme_bw() +
  labs(
    x = "Region",
    y = "Number of Operações"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )



#por weekday


png("plot_mterr_week.png", width = 3*3, height = 3*2, res = 300, units = 'in')
boxplot(nivel_terr~Weekday,data=data_hour_extended,col="red",ylab=(TeX('Meios Terrestres')))
dev.off()

png("plot_oterr_week.png", width = 3*3, height = 3*2, res = 300, units = 'in')
boxplot(nivel_auto~Weekday,data=data_hour_extended,col="red",ylab=(TeX('Operacionais Terrestres')))
dev.off()


##adicionar coluna mês, weekday e hora
data_new<-cbind(data,Month,Weekday, Hour)

#curso=encerrada é 98%, logo vamos apenas manter estas
sum(as.factor(data_new$EstadoOcorrencia)=="Encerrada")/nrow(data_new)

data_new<-data_new[as.factor(data_new$EstadoOcorrencia)=="Encerrada",]
#deletar a coluna "EstadoOcorrencia"
View(data_new)
data_new <- subset(data_new, select = -c(5))

##fazer a nivel de distrito
summary(as.factor(data_new$Concelho))
#a nivel de concelho, o que tem mais observações é Vila Nova de Gaia (3720)
#percentagem: 
#3720/nrow(data_new)*100 = 3% dos dados; os resultados podem nao ser os melhores

##Nos meses 1,2,3,4 temos muito poucas observações quando comparando aos restantes meses
summary(as.factor(data_new$Month))

counts <- table(data_new$Month)
data <- data.frame(
  category = c("1", "2","3","4","5","6","7","8","9","10","11","12"),
  count <- c(
    counts[names(counts) == 1],
    counts[names(counts) == 2],
    counts[names(counts) == 3],
    counts[names(counts) == 4],
    counts[names(counts) == 5],
    counts[names(counts) == 6],
    counts[names(counts) == 7],
    counts[names(counts) == 8],
    counts[names(counts) == 9],
    counts[names(counts) == 10],
    counts[names(counts) == 11],
    counts[names(counts) == 12]
  )
)

level_order <- c("1", "2","3","4","5","6","7","8","9","10","11","12") 

ggplot(data, aes(x = factor(category, level=level_order), y = count, fill = category)) +
  geom_col(position = position_dodge())+
  scale_fill_manual(values = c("red", "blue", "green", "yellow", "orange", "purple", "pink", "brown", "gray", "black", "magenta", "cyan")) +
  ggtitle("Number of records by Month") +
  theme_bw() +
  labs(
    x = "Month",
    y = "Number of Observations"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), plot.subtitle = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(face = "bold"), axis.title.y = element_text(face = "bold")
  )

#pelo gráfico vemos que podemos eliminar os meses 1,2,3,4


############Previsão

sample <- sample(c(TRUE, FALSE), nrow(data_new), replace=TRUE, prob=c(0.8,0.2))
train  <- data_new[sample, ]
test   <- data_new[!sample, ]

#linear regression
#pessoas
model_mterr <- lm(NumeroMeiosTerrestresEnvolvidos~Distrito+Grouped+as.factor(Month)+as.factor(Weekday),data=train)
summary(model_mterr)
#automoveis
model_oterr <- lm(NumeroOperacionaisTerrestresEnvolvidos~Distrito+Grouped+as.factor(Month)+as.factor(Weekday),data=train)
summary(model_oterr)

#evaluating on test set
rsq <- function (x, y) cor(x, y) ^ 2
rsq(predict(model_mterr,test), test$NumeroMeiosTerrestresEnvolvidos)
rsq(predict(model_oterr,test), test$NumeroOperacionaisTerrestresEnvolvidos)


########Classifier

library(caret)
library(DiagrammeR)
library(klaR)
library(rattle)

#10-fold cross validation to choose hyperparameters

classifier <- function(clf, CV = TRUE, tune_grid = NULL, X_train, y_train) {
  
  train_control <- trainControl(method = 'none')
  if (isTRUE(CV)) {
    train_control <- trainControl(method = "cv", number = 10, savePredictions = 'final')
  } 
  
  set.seed(92626)
  model <- train(x = X_train, y = as.factor(y_train),
                 method = clf, metric = 'Accuracy',
                 tuneGrid = tune_grid, trControl = train_control,
                 preProcess = NULL)
  
  if (!is.null(tune_grid)) {
    print(paste('------------------------ Best', clf ,'Model -------------------------'))
    print(model$bestTune)
  }
  return (model)
}


performance_meas <- function(predicted, real) {
  
  aux <- confusionMatrix(data = predicted, reference = real)
  
  print(aux$table)
  
  return (data.frame(
    value = c(aux$overall['Accuracy'])))
}


## Naive Bayes
tune_grid <- expand.grid(
  fL = c(0, 0.5, 1.0), 
  usekernel = TRUE, 
  adjust = c(0, 0.5, 1.0)
)

trainn<-cbind(train$Distrito, train$Grouped, train$Month, train$Weekday)
colnames(trainn)<-c("Distrito", "Grouped", "Month", "Weekday")
testt<-cbind(test$Distrito, test$Grouped, test$Month, test$Weekday)
colnames(testt)<-c("Distrito", "Grouped", "Month", "Weekday")

nb_model <- classifier('nb', tune_grid = tune_grid, X_train = trainn, y_train = train$NumeroMeiosTerrestresEnvolvidos)
nb_pred <- predict(nb_model, testt)
performance_meas(nb_pred, as.factor(test$NumeroMeiosTerrestresEnvolvidos))  # Accuracy = 0.74

nb_model_op <- classifier('nb', tune_grid = tune_grid, X_train = trainn, y_train = train$NumeroOperacionaisTerrestresEnvolvidos)
nb_pred_op <- predict(nb_model_op, testt)
performance_meas(nb_pred_op, as.factor(test$NumeroOperacionaisTerrestresEnvolvidos))  # Accuracy = 0.56

## Decision Tree

dtree_model <- classifier('rpart', X_train = trainn, y_train = train$NumeroMeiosTerrestresEnvolvidos)
dtree_pred <- predict(dtree_model, testt)
performance_meas(dtree_pred, as.factor(test$NumeroMeiosTerrestresEnvolvidos))  # Accuracy = 0.78

dtree_model_op <- classifier('rpart', X_train = trainn, y_train = train$NumeroOperacionaisTerrestresEnvolvidos)
dtree_pred_op <- predict(dtree_model_op, testt)
performance_meas(dtree_pred_op, as.factor(test$NumeroOperacionaisTerrestresEnvolvidos))  # Accuracy = 0.60

###Testar XGBoost mas pc nao aguenta XDD



