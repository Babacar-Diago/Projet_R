library(shiny)
library(shinydashboard)
#source("./global.r",local=TRUE)
shinyServer <- function(input,output) {
  # partie sarr
  # je cree ici des variable qui seront accessible partout dans le serveur
  # je relie ma variable positive ici grace à ma base que j'ai déclarée sur le global
  casPositive <- reactive({
    sum(baseCovidSN$`Cas positifs`)
  })
  
  casTestes <- reactive({
    sum(baseCovidSN$`Cas testes`)
  })
  
  casGueris <- reactive({
    sum(baseCovidSN$`Cas gueris`)
  })
  casDeces <- reactive({
    sum(baseCovidSN$Deces)
  })
  casCommunautaire <- reactive({
    sum(baseCovidSN$`Cas communautaires`)
  })
  casContact <- reactive({
    sum(baseCovidSN$`Cas contact`)
  })
  casImporte <- reactive({
    sum(baseCovidSN$`Cas importes`)
  })
  
  # calcul des pourcentage
  pourcentageGueris <- reactive({
    round(casGueris() * 100 / (casGueris() + casDeces() ),2)
  })
  pourcentagePositive <- reactive({
    round(casPositive() * 100 / (casPositive() + casTestes() ),2)
  })
  pourcentageDeces <- reactive({
    round(casDeces() * 100 / (casGueris() + casDeces() ),2)
  })
  pourcentageCommunautaire <- reactive({
    round(casCommunautaire() * 100 / (casCommunautaire() + casContact() + casImporte()),2)
  })
  pourcentageContact <- reactive({
    round(casContact() * 100 / (casCommunautaire() + casContact() + casImporte()),2)
  })
  pourcentageImporte <- reactive({
    round(casImporte() * 100 / (casCommunautaire() + casContact() + casImporte()),2)
  })
  
  output$positive <- renderText({
    paste("Total = ",casPositive(),"    soit: ",pourcentagePositive()," % par rapport aux  cas testés")
  })
  #je relie aussi la variable gueris
  output$gueris <- renderText({
    paste("Total = ",casGueris(),"    soit: ",pourcentageGueris()," % par rapport aux cas  Décés")
  })
  # je relie ma variable deces
  output$deces <- renderText({
    paste("Total = ",casDeces()," soit: ",pourcentageDeces()," % par rapport aux cas  guéris")
  })
  
  output$communautaire <- renderText({
    paste("Total = ",casCommunautaire()," soit: ",pourcentageCommunautaire()," % par rapport aux cas contacts et importés")
  })
  output$contact <- renderText({
    paste("Total = ",casContact()," soit: ",pourcentageContact()," % par rapport aux cas communautaire et importés")
  })
  # je relie ma variable deces
  output$importe <- renderText({
    paste("Total = ",casImporte()," soit: ",pourcentageImporte()," % par rapport aux cas communautaire et contacts")
  })
  # fin partie sarr
  output$plot <- renderPlot({
    ggplot(
      base1,
      aes(`Cas positifs`)
      #stat = "count"
    ) + geom_histogram(fill="sky blue")+
      ggtitle("Proportion  des cas positifs")+
      xlab("jours") + ylab("Nombre de cas") 
  })
  output$plotGueris <- renderPlot({
    ggplot(
      base1,
      aes(`Cas gueris`)
      #stat = "count"
    ) + geom_histogram(fill="tomato3")+
      ggtitle("Proportion  des cas guéris")+
      xlab("jours") + ylab("Nombre de cas") 
    
  })
  output$plotCommunautaire <- renderPlot({
    ggplot(
      base1,
      aes(`Cas communautaires`)
      #stat = "count"
    ) + geom_histogram(fill="seagreen2")+
      ggtitle("Proportion des cas Communautaire")+
      xlab("jours") + ylab("Nombre de cas") 
  })
  
  output$plotImportes <- renderPlot({
    ggplot(
      base1,
      aes(`Cas importes`)
      #stat = "count"
    ) + geom_histogram(fill="steelblue",show.legend = TRUE)+
      ggtitle("Proportion des  cas importés")+
      xlab("jours") + ylab("Nombre de cas") 
  })
  # les diagramme de camembert
  output$camembert <- renderPlot({
    ggplot(dfGuerisDeces, aes(x="", y=value, fill=group))+
      geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0)+
      ggtitle("L'evolution des cas Positif et Gueris ")
  })
  
  output$camembert1 <- renderPlot({
    ggplot(dfContactCommunautaireImporte, aes(x="", y=value, fill=group))+
      geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0)+
      ggtitle("Proportion  des cas importés")+ggtitle("L'evolution des cas Communautaires, contacts et importes ")
  })
  output$camembert0 <- renderPlot({
    ggplot(dfContactCommunautaireImporte, aes(x="", y=value, fill=group))+
      geom_bar(width = 2, stat = "identity") +
      coord_polar("y", start=0)+
      ggtitle("Proportion  des cas importés")+
      ggtitle("Diagramme Circulaire des cas contacts , importes et Communautaires ")
  })
  
  
  #Le travail de Alioune Gueye , J'ai creer ceci:
  #ploter l'évolution des cas importés,contacts et communautaires en fonction de la variable date en abcisse
  #je l ai nommé plot1 
  output$plot1 <- renderPlot({
    ggplot(base2, aes(`Date`)) + 
      geom_line(aes(y = `Cas contact`), color = "green", size=1) + 
      geom_line(aes(y = `Cas communautaires`), color="indianred1", size=1)+
      geom_line(aes(y = `Cas importes`), color = "skyblue3", size=1)+
      scale_color_discrete(name = "Y series", labels = c("Cas contact", "Cas communautaires","Cas importes"))
  })

  
  #--------------------------
  #source("./courbesEvolution/serverCourbesEvolution.r",local=TRUE)
  #Fonction qui trace la courbe d'évolution des cas Positifs
  courbeEvolution_CasPositifs<-function(x, y){
    
    output$positiv <- renderPlot({
      
      plot(y~x , lwd=4 , type="l" , bty="n" , ylab="Nombre de cas positif" , col=rgb(0.2,0.4,0.6,0.8) )
      
    })
  }
  
  #Fonction qui trace la courbe d'évolution des cas guéris
  courbeEvolution_CasGeris<-function(x, y){
    
    output$gueri <- renderPlot({
      
      plot(y~x , lwd=4 , type="l" , bty="n" , ylab="Nombre de cas gueris", col=rgb(0.2,0.4,0.6,0.8) )
      
    })
  }
  
  
  #Fonction qui trace la courbe d'évolution des décès
  courbeEvolution_Deces<-function(x, y){
    
    output$dece <- renderPlot({
      
      plot(y~x , lwd=4 , type="l" , bty="n" , ylab="Nombre de deces" , col=rgb(0.2,0.4,0.6,0.8) )
      
    })
  }
  # Récupération des date dans la base de données pour tracer l'axe des abscisses des courbes d'évolution 
  x <- baseCovidSN$Date
  
  #-------------------------
  
  # Récupération des cas positifs dans la base de données
  yPositifs <- baseCovidSN$`Cas positifs`
  # Appel de la fonction définie dans serverCourbesEvolution
  courbeEvolution_CasPositifs(x, yPositifs)
  
  #------------------------
  
  # Récupération des cas guéris dans la base de données
  yGeris <- baseCovidSN$`Cas gueris`
  # Appel de la fonction définie dans serverCourbesEvolution
  courbeEvolution_CasGeris(x, yGeris)
  
  #------------------------
  
  # Récupération des décès dans la base de données
  yDeces <- baseCovidSN$Deces
  # Appel de la fonction définie dans serverCourbesEvolution
  courbeEvolution_Deces(x, yDeces)
  
  # affichage de la base de donnees 
  output$baseDonnees <- renderDataTable({
    baseCovidSN
  })
  
  #------------------------
  #résumé des données pour les cas positifs
  output$summaryCasPositif <- renderPrint({
    summary(baseCovidSN$`Cas positifs`)
  })
  
  #structure des données pour les cas positifs
  output$strCasPositif <- renderPrint({
    str(baseCovidSN$`Cas positifs`)
  })
  #------------------------
  #résumé des données pour les cas guéris
  output$summaryCasGueris <- renderPrint({
    summary(baseCovidSN$`Cas gueris`)
  })
  
  #structure des données pour les cas guéris
  output$strCasGueris <- renderPrint({
    str(baseCovidSN$`Cas gueris`)
  })
  #------------------------
  #résumé des données pour les Décès
  output$summaryNbDeces <- renderPrint({
    summary(baseCovidSN$Deces)
  })
  
  #structure des données pour les Décès
  output$strNbDeces <- renderPrint({
    str(baseCovidSN$Deces)
  })
  
}