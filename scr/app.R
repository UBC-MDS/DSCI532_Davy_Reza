#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)

# Load the data
data <- read.csv("crime_data.csv", stringsAsFactors = FALSE)
data <- data %>% arrange(State, City)
first <- data$State[1]
#mc <- length(unique(data$City))
mc <- 15


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Crime Data Browser"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        tags$div(title="Click here to select the state",
                 selectInput('state', 'State:', data$State, selected = "")),
        tags$div(title="Click here to select the city",
                 selectInput('city', 'City', data$City, selected = "")),
        tags$div(title="Slide here to select the year range",
                 sliderInput('year_range', "Year (Until 2015):",  min = 1975, max = 2015, value=c(1975, 2015))),
        tags$div(title="Slide here to select the number of cities",
                 sliderInput('city_number', "Number of cities to be shown:",  min = 2, max = mc, step=1, value=4)),
        radioButtons("arrange_type", "Arrange type:", c("Ascending"="a", "Descending"="d"))
        #helpText("Please select the State and City and the year range and then press the button")
        #actionButton("update", "Show historical data")
                    

        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    tabPanel("Total crimes", plotlyOutput("total_plot")),
                    tabPanel("Assault", plotlyOutput("assault_plot")),
                    tabPanel("Homocide", plotlyOutput("homocide_plot")),
                    tabPanel("Rape", plotlyOutput("rape_plot")),
                    tabPanel("Robbery", plotlyOutput("robbery_plot"))
                    
        )
        

 
        
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
   
  
  
  choices_states <- reactive({
    choices_states <- data %>%
      filter(State==input$state)
  })
  
  observe({
    updateSelectInput(session = session, inputId = "city", choices = unique(choices_states()$City))
  })
  
  
  
  
  filtered_crime_data <- reactive(
    data %>%
      filter(City == input$city,
             State ==input$state,
             year >= input$year_range[1],
             year <= input$year_range[2])
    
  )
  
  output$total_plot<- renderPlotly(
    
    
    if (input$year_range[1] == input$year_range[2]) {
      
      if (input$arrange_type == "a") {
      
      data1 <- data %>%
        filter(year == input$year_range[1]) %>%
        arrange(violent_per_100k)
      
 
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        ggplot(aes(fct_reorder(City, violent_per_100k),
                   violent_per_100k, text = paste('City: ', City,
                                                  '<br>Total crimes per 100K: ', violent_per_100k)))+
        geom_bar(stat="identity", fill = "#000099")+
        xlab("City")+
        ylab("Total crimes per 100K")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(violent_per_100k))
        
        
        data2 <- data1[1:input$city_number[1],]
        
        pt <- data2 %>%
          ggplot(aes(fct_reorder(City, violent_per_100k, .desc=TRUE),
                     violent_per_100k, text = paste('City: ', City,
                                                    '<br>Total crimes per 100K: ', violent_per_100k)))+
          geom_bar(stat="identity", fill = "#000099")+
          xlab("City")+
          ylab("Total crimes per 100K")+
          theme(axis.title  = element_text(size = rel(2.5)))+
          theme_bw()
        ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
        
        
      }
        
      
    } else {
    
      pt <- filtered_crime_data() %>%
        ggplot(aes(year, violent_per_100k, group=1, text = paste('Year: ', year,
                                                        '<br>Total crimes per 100K: ', violent_per_100k)))+
        geom_line(aes(group=1), colour="#000099")+
        geom_point(colour="#000099")+
        ylab("Total crimes per 100K")+
        xlab("Year")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      
      }
  )
  
  output$assault_plot<- renderPlotly(
    
    if (input$year_range[1] == input$year_range[2]) {
      
      if (input$arrange_type == "a") {
      
      data1 <- data %>%
        filter(year == input$year_range[1]) %>%
        arrange(agg_ass_per_100k) 
      
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        filter(year == input$year_range[1]) %>%
        ggplot(aes(fct_reorder(City, agg_ass_per_100k), agg_ass_per_100k,
                                                     text = paste('City: ', City,
                                                     '<br>Assualt per 100K: ', agg_ass_per_100k)))+
        geom_bar(stat="identity", fill = "#000099")+
        xlab("City")+
        ylab("Assualt per 100K")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(agg_ass_per_100k)) 
        
        data2 <- data1[1:input$city_number[1],]
        
        pt <- data2 %>%
          filter(year == input$year_range[1]) %>%
          ggplot(aes(fct_reorder(City, agg_ass_per_100k, .desc=TRUE),
                     agg_ass_per_100k, text = paste('City: ', City,
                                                    '<br>Assualt per 100K: ', agg_ass_per_100k)))+
          geom_bar(stat="identity", fill = "#000099")+
          xlab("City")+
          ylab("Assualt per 100K")+
          theme(axis.title  = element_text(size = rel(2.5)))+
          theme_bw() 
        ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
        
      }
      
      
    } else {
    pt <- filtered_crime_data() %>%
      ggplot(aes(year, agg_ass_per_100k, group=1, text = paste('Year: ', year,
                                                      '<br>Assualt per 100K: ', agg_ass_per_100k)))+
      geom_point(colour="#000099")+
      geom_line(aes(group=1), colour="#000099")+
      ylab("Assualt per 100K")+
      xlab("Year")+
      theme(axis.title  = element_text(size = rel(2.5)))+
      theme_bw()
    ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    
    }
  )
  
  output$homocide_plot<- renderPlotly(
    
    if (input$year_range[1] == input$year_range[2]) {
      
      if (input$arrange_type == "a") {
      
      data1 <- data %>%
        filter(year == input$year_range[1]) %>%
        arrange(homs_per_100k) 
      
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        filter(year == input$year_range[1]) %>%
        ggplot(aes(fct_reorder(City, homs_per_100k), homs_per_100k,
                                               text = paste('City: ', City,
                                               '<br>Homocide per 100k: ', homs_per_100k)))+
        geom_bar(stat="identity", fill = "#000099")+
        xlab("City")+
        ylab("Homocide per 100k")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(homs_per_100k)) 
        
        data2 <- data1[1:input$city_number[1],]
        
        pt <- data2 %>%
          filter(year == input$year_range[1]) %>%
          ggplot(aes(fct_reorder(City, homs_per_100k, .desc=TRUE), homs_per_100k,
                     text = paste('City: ', City,
                                  '<br>Homocide per 100k: ', homs_per_100k)))+
          geom_bar(stat="identity", fill = "#000099")+
          xlab("City")+
          ylab("Homocide per 100k")+
          theme(axis.title  = element_text(size = rel(2.5)))+
          theme_bw() 
        ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
        
      }
      
      
    } else {
    pt <- filtered_crime_data() %>%
      ggplot(aes(year, homs_per_100k, group=1, text = paste('Year: ', year,
                                                   '<br>Homocide per 100k: ', homs_per_100k)))+
      geom_point(colour="#000099")+
      geom_line(aes(group=1), colour="#000099")+
      ylab("Homocide per 100k")+
      xlab("Year")+
      theme(axis.title  = element_text(size = rel(2.5)))+
      theme_bw()
    ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    }
  )
  
  output$rape_plot<- renderPlotly(
    
    if (input$year_range[1] == input$year_range[2]) {
      
      if (input$arrange_type == "a") {
        
      data1 <- data %>%
        filter(year == input$year_range[1]) %>%
        arrange(rape_per_100k) 
      
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        filter(year == input$year_range[1]) %>%
        ggplot(aes(fct_reorder(City, rape_per_100k), rape_per_100k,
                   text = paste('City: ', City,
                                '<br>Rape per 100k: ', rape_per_100k)))+
        geom_bar(stat="identity", fill = "#000099")+
        xlab("City")+
        ylab("Rape per 100k")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(rape_per_100k)) 
        
        data2 <- data1[1:input$city_number[1],]
        
        pt <- data2 %>%
          filter(year == input$year_range[1]) %>%
          ggplot(aes(fct_reorder(City, rape_per_100k, .desc=TRUE), rape_per_100k,
                     text = paste('City: ', City,
                                  '<br>Rape per 100k: ', rape_per_100k)))+
          geom_bar(stat="identity", fill = "#000099")+
          xlab("City")+
          ylab("Rape per 100k")+
          theme(axis.title  = element_text(size = rel(2.5)))+
          theme_bw() 
        ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
        
      }
      
      
    } else {
    pt <- filtered_crime_data() %>%
      ggplot(aes(year, rape_per_100k, group=1, text = paste('Year: ', year,
                                                   '<br>Rape per 100k: ', rape_per_100k)))+
      geom_point(colour="#000099")+
      geom_line(aes(group=1), colour="#000099")+
      ylab("Rape per 100k")+
      xlab("Year")+
      theme(axis.title  = element_text(size = rel(2.5)))+
      theme_bw()
    ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    }
  )
  
  output$robbery_plot<- renderPlotly(
    
    if (input$year_range[1] == input$year_range[2]) {
      
      if (input$arrange_type == "a") {
      
      data1 <- data %>%
        filter(year == input$year_range[1]) %>%
        arrange(rob_per_100k) 
      
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        filter(year == input$year_range[1]) %>%
        ggplot(aes(fct_reorder(City, rob_per_100k), rob_per_100k,
                   text = paste('City: ', City,
                                '<br>Robbery per 100k: ', rob_per_100k)))+
        geom_bar(stat="identity", fill = "#000099")+
        xlab("City")+
        ylab("Robbery per 100k")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(rob_per_100k)) 
        
        data2 <- data1[1:input$city_number[1],]
        
        pt <-data2 %>%
          filter(year == input$year_range[1]) %>%
          ggplot(aes(fct_reorder(City, rob_per_100k, .desc=TRUE), rob_per_100k,
                     text = paste('City: ', City,
                                  '<br>Robbery per 100k: ', rob_per_100k)))+
          geom_bar(stat="identity", fill = "#000099")+
          xlab("City")+
          ylab("Robbery per 100k")+
          theme(axis.title  = element_text(size = rel(2.5)))+
          theme_bw() 
        ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
        
      }
      
      
    } else {
    pt <- filtered_crime_data() %>%
      ggplot(aes(year, rob_per_100k, group=1, text = paste('Year: ', year,
                                                  '<br>Robbery per 100k: ', rob_per_100k)))+
      geom_point(colour="#000099")+
      geom_line(aes(group=1), colour="#000099")+
      ylab("Robbery per 100k")+
      xlab("Year")+
      theme(axis.title  = element_text(size = rel(2.5)))+
      theme_bw()
    ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    
    }
  )
  
  
# output$table <- renderTable(
#    data2()
#  )
  
  


}

# Run the application 
shinyApp(ui = ui, server = server)

