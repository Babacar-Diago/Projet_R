library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
#install.packages("shinythemes")
library(shinythemes)
# le fichier global permet de creer des variable globales accessible dans toute l'application
library(readxl)
# Ici on importe la base qui sera accessible à partir de baseCovidSN sur la partie serveur
baseCovidSN <- read_excel("BaseCovidSN.xlsx")
# base1 contient des variables Cas contact,Cas communautaires et Cas importes
base1 =  baseCovidSN %>% select(`Cas contact`,`Cas communautaires`,`Cas importes`,`Cas positifs`,,`Cas gueris`,`Deces`)
#C'est Alioune , j'ai fait un select pour avoir une partie de la base(BaseCovidSN), je l ai nommé base2 
#base2 permet de recupérer les variables suivant pour ploter avec plot2
base2 =  baseCovidSN %>% select(`Date`,`Cas importes`,`Cas contact`,`Cas communautaires`)

# creation des dataframes
dfGuerisDeces <- data.frame(
  group = c("cas gueris", "Cas Deces"),
  value = c(sum(baseCovidSN$`Cas gueris`),sum(baseCovidSN$`Deces`))
)

dfContactCommunautaireImporte <- data.frame(
  group = c("Cas Contact","cas Communautaire", "Cas Importes"),
  value = c(sum(baseCovidSN$`Cas contact`),sum(baseCovidSN$`Cas communautaires`),sum(baseCovidSN$`Cas importes`))
)