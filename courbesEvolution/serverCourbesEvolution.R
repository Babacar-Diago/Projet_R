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