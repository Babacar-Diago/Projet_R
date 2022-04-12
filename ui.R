library(shiny)
library(shinydashboard)
library(shinythemes)

header <- dashboardHeader(
  title = "UVS",
  titleWidth = 200
  
)
sidebar <- dashboardSidebar(
  width = 200,
  sidebarMenu(id = "side",
              
              menuItem("Home",tabName = "statistique",icon = icon("home")),
              
              # Menu des courbes d'évolution
              menuItem("Courbe d'évolution", icon = icon("fas fa-chart-line"),
                       menuSubItem("Cas positif", tabName = "positifs"),
                       menuSubItem("cas guéris", tabName = "gueris"),
                       menuSubItem("décés", tabName = "deces")
              ),
              # Ici est la partie home par sarr 
              # le tabname permet de relier le menuItem et tabItem il faut un meme non de variable
              
              
              # fin partie statistique
              
              
              #Ceci vous permet d'acceder a la page contenant les infos sur l'évolution des cas importés, contact et communautaire
              menuItem("Evolution des CI, CC, CCM ",tabName = "CI_CC_CCM",icon = icon("fas fa-chart-line")),
              menuItem("Database ",tabName = "baseDonnees",icon = icon("fad fa-coins"))
  )
)
body <- dashboardBody(
  # le tabItems permet de regrouper tous les tabItem
  tabItems(
    # affichage statistique c'est ici que je dois afficher le corp de ma page 
    # une fois que je clic sur le menu statistique
    tabItem(
      tabName = "statistique",
      h3("Information  sur le Covid19 du premier Avril au 30  juin 2020"),
      fluidRow(
        box(
          title = " cas positif",
          status = "primary",
          width = 4,
          solidHeader = TRUE,
          collapsible = TRUE,
          textOutput("positive") # je cree une variable output positive qui va etre relier au niveau du serveur
          # pour afficher la somme des cas positive
        ),
        box(
          title = " Cas Gueris",
          width = 4,
          status = "success",
          solidHeader = TRUE,
          collapsible = TRUE,
          collapsed = FALSE,
          #background = "black",
          textOutput("gueris")  # je cree une variable output gueri qui va etre relier au niveau du serveur
          # pour afficher la somme des cas gueris
        ),
        box(
          title = " Cas Décès",
          width = 4,
          status = "danger",
          solidHeader = TRUE,
          collapsible = TRUE,
          textOutput("deces")  # je cree une variable output deces qui va etre relier au niveau du serveur
          # pour afficher la somme des cas decédés
        )
        
      ),
      fluidRow(
        box(
          title = " Cas Communautaire ",
          width = 4,
          status = "danger",
          solidHeader = TRUE,
          collapsible = TRUE,
          textOutput("communautaire")  # je cree une variable output communautaire qui va etre relier au niveau du serveur
          # pour afficher la somme des cas communautaire
        ),
        box(
          title = " Cas Contacts",
          status = "primary",
          width = 4,
          solidHeader = TRUE,
          collapsible = TRUE,
          textOutput("contact")  # je cree une variable contact deces qui va etre relier au niveau du serveur
          # pour afficher la somme des cas contact
        ),
        box(
          title = " Cas Importe",
          status = "warning",
          width = 4,
          solidHeader = TRUE,
          collapsible = TRUE,
          textOutput("importe")  # je cree une variable contact importe qui va etre relier au niveau du serveur
          # pour afficher la somme des cas importe
        )
      ), # fin fluidRow()
      fluidRow(column(
        width = 10,
        p("Les diagramme de camembert")
      )),
      fluidRow(
        column(
          width = 6,
          plotOutput("camembert")
        ),
        column(
          width = 6,
          plotOutput("camembert1")
        )
      ),
      fluidRow(column(
        width = 10,
        p("Les diagramme d'histogramme")
      )),
      fluidRow(
        column(
          width = 3,
          plotOutput("plot")
        ),
        column(
          width = 3,
          plotOutput("plotGueris")
        ),
        column(
          width = 3,
          plotOutput("plotCommunautaire")
        ),
        column(
          width = 3,
          plotOutput("plotImportes")
        )
      )
      
      
    ), # fin partie statistique
    
    #C est Alioune Toujours mon travail
    tabItem(tabName = "CI_CC_CCM",
            fluidRow(
              box(
                width = 6,
                plotOutput("camembert0"),
                p("Note : Les deux figures ci-dessus montrent l'évolution des cas communautaires ,importés et contacts en fonction de la date")
              ),
              box(
                
                title = " Courbe d'évolution des cas contacts , importés et communataires",
                solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("plot1")
              )
            )
            ),
    #plotOutput("plot1") cette fonction est appellé dans tabTtem pour visualiser les differents courbes 
    tabItem(tabName = "database" ),
    
    #Cas positif
    tabItem(
      tabName = "positifs",
      h3("Courbe d'évolution des cas positifs"),
      fluidRow(
        box(
          title = " cas positif",
          status = "primary",
          width = 7,
          solidHeader = TRUE,
          collapsible = TRUE,
          plotOutput("positiv") # je cree une variable output positive qui va etre relier au niveau du serveur
          # pour afficher la somme des cas positive
        ),
        #Onglet Résumé Statistique
        box(
          title = "Résumé Statistique",
          status = "primary",
          width = 5,
          solidHeader = TRUE,
          collapsible = TRUE,
          h1("Tableau descriptif"),
          hr(),
          #rendu fonction summary
          verbatimTextOutput("summaryCasPositif"),
          h2("structure des données"),
          hr(),
          #rendu fonction str
          verbatimTextOutput("strCasPositif")
        )
      )
    ),
    
    #Cas guéris
    tabItem(
      tabName = "gueris",
      h3("Courbe d'évolution des cas guéris"),
      fluidRow(
        box(
          title = " cas guéris",
          status = "primary",
          width = 7,
          solidHeader = TRUE,
          collapsible = TRUE,
          plotOutput("gueri") # je cree une variable output positive qui va etre relier au niveau du serveur
          # pour afficher la somme des cas positive
        ),
        #Onglet Résumé Statistique
        box(
          title = "Résumé Statistique",
          status = "primary",
          width = 5,
          solidHeader = TRUE,
          collapsible = TRUE,
          h1("Tableau descriptif"),
          hr(),
          #rendu fonction summary
          verbatimTextOutput("summaryCasGueris"),
          h2("structure des données"),
          hr(),
          #rendu fonction str
          verbatimTextOutput("strCasGueris")
        )
      )
    ),
    
    #Décés
    tabItem(
      tabName = "deces",
      h3("Courbe d'évolution des décès"),
      fluidRow(
        box(
          title = "Décès",
          status = "primary",
          width = 7,
          solidHeader = TRUE,
          collapsible = TRUE,
          plotOutput("dece") # je cree une variable output positive qui va etre relier au niveau du serveur
          # pour afficher la somme des cas positive
        ),
        #Onglet Résumé Statistique
        box(
          title = "Résumé Statistique",
          status = "primary",
          width = 5,
          solidHeader = TRUE,
          collapsible = TRUE,
          h1("Tableau descriptif"),
          hr(),
          #rendu fonction summary
          verbatimTextOutput("summaryNbDeces"),
          h2("structure des données"),
          hr(),
          #rendu fonction str
          verbatimTextOutput("strNbDeces")
        )
      )
    ),
    
    
    #-----------------  
    tabItem(
      tabName = "baseDonnees",
      fluidRow(
        box(
          title = "Notre Base de données",
          status = "primary",
          width = 12,
          solidHeader = TRUE,
          collapsible = TRUE,
          dataTableOutput("baseDonnees") # je cree une variable output positive qui va etre relier au niveau du serveur
          # pour afficher la somme des cas positive
        )
      )
    )
  )
)
shinyUI(dashboardPage(header,sidebar,body))