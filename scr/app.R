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
library(shinythemes)

# Load the data
data <- read.csv("crime_data.csv", stringsAsFactors = FALSE)
data <- data %>% arrange(State, City)
first <- data$State[1]
#mc <- length(unique(data$City))
mc <- 15
#Global vars for prediction
new_year <- 0
prediction_flag <- 0
#Create the dataframe for the new results
predictions <- data.frame(City=0, year=0, violent_per_100k=0, homs_per_100k=0,
                          rape_per_100k=0, rob_per_100k=0, agg_ass_per_100k=0,
                          violent_int=0, violent_slope=0, homs_int=0, homs_slope=0,
                          rape_int=0, rape_slope=0, rob_int=0, rob_slope=0,
                          agg_ass_int=0, agg_ass_slope=0)




# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("darkly"),
   
   # Application title
   titlePanel("Crime Data Browser"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        tags$div(title="Click here to select the state",
                 selectInput('state', 'State:', data$State, selected = "")),
        tags$div(title="Click here to select the city",
                 selectInput('city', 'City:', data$City, selected = "")),
        
        tags$div(title="Slide here to select the year range. Place both 
                 the year sliders on the same year to show the country-wide sorted data in that year",
                 sliderInput('year_range', "Year:",  min = 1975, max = 2015, value=c(1975, 2015))),
        tags$hr(),
        tags$h4("Sort the data:"),
        tags$div(title="Slide here to select the number of cities",
                 sliderInput('city_number', "Number of cities to be shown:",  min = 1, max = mc, step=1, value=4)),
        radioButtons("arrange_type", "Arrange type:", c("Ascending"="a", "Descending"="d")),
        helpText("Place both the year sliders on the same year to show the country-wide sorted data in that year"),
        tags$hr(),
        tags$h4("Add predictions:"),
        tags$div(title="Enter a new year bigger than 2015 and press Add to
                 get the predictions. Press Remove to remove the prediction results",textInput("nyear", "New year:")),
        actionButton("add", "Add"),
        actionButton("remove", "Remove"),
        helpText("To have the predicted values, enter a new year and press the add 
                          button. The remove the predicted values press the Remove button") 
        
        
                    

        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    tabPanel("Total crimes", plotlyOutput("total_plot"), HTML("<br>"), plotlyOutput("total_plot_avg")),
                    tabPanel("Assault", plotlyOutput("assault_plot"), HTML("<br>"), plotlyOutput("assault_plot_avg")),
                    tabPanel("Homocide", plotlyOutput("homocide_plot"), HTML("<br>"), plotlyOutput("homocide_plot_avg")),
                    tabPanel("Rape", plotlyOutput("rape_plot"), HTML("<br>"), plotlyOutput("rape_plot_avg")),
                    tabPanel("Robbery", plotlyOutput("robbery_plot"), HTML("<br>"), plotlyOutput("robbery_plot_avg"))
                    
        )
        

 
        
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # Add Button reaction
 observeEvent(input$add, {
    
    # Check if input is a valid number
    if ( !is.na(as.numeric(input$nyear)) && (as.numeric(input$nyear)>2015)) {
        prediction_flag <<- TRUE
        #cat(file=stderr(), "pr:", prediction_flag)
        # Start regression
        #Create the dataframe for the new results
        predictions <<- data.frame(City=0, year=0, violent_per_100k=0, homs_per_100k=0,
                            rape_per_100k=0, rob_per_100k=0, agg_ass_per_100k=0,
                            violent_int=0, violent_slope=0, homs_int=0, homs_slope=0,
                            rape_int=0, rape_slope=0, rob_int=0, rob_slope=0,
                            agg_ass_int=0, agg_ass_slope=0)
        
        # Save the near year
        new_year <<- as.numeric(input$nyear)
        
        
        
        city_list <- unique(data$City)
        
        for (i in 1:length(city_list)) {
              filtered_data <- data %>% filter(City==city_list[i])
              
              # Predicting homs_per_100k
              lm_numeric_x <- lm(homs_per_100k ~ year, data=filtered_data)
              h_intercept <- coef(lm_numeric_x)[[1]]
              h_slope <- coef(lm_numeric_x)[[2]]
              pred_homs<- new_year*h_slope+h_intercept
              if (pred_homs<0) pred_homs <- 0.0 
              
              # Predicting rape_per_100k
              lm_numeric_x <- lm(rape_per_100k ~ year, data=filtered_data)
              ra_intercept <- coef(lm_numeric_x)[[1]]
              ra_slope <- coef(lm_numeric_x)[[2]]
              pred_rape <- new_year*ra_slope+ra_intercept
              if (pred_rape<0) pred_rape <- 0.0
              
              # Predicting rob_per_100k
              lm_numeric_x <- lm(rob_per_100k ~ year, data=filtered_data)
              ro_intercept <- coef(lm_numeric_x)[[1]]
              ro_slope <- coef(lm_numeric_x)[[2]]
              pred_rob <- new_year*ro_slope+ro_intercept
              if (pred_rob<0) pred_rob <- 0.0
              
              
              # Predicting agg_ass_per_100k
              lm_numeric_x <- lm(agg_ass_per_100k ~ year, data=filtered_data)
              a_intercept <- coef(lm_numeric_x)[[1]]
              a_slope <- coef(lm_numeric_x)[[2]]
              pred_agg_ass <- new_year*a_slope+a_intercept
              if (pred_agg_ass<0) pred_agg_ass <- 0.0
              
              # Predicting violent_per_100k
              lm_numeric_x <- lm(violent_per_100k ~ year, data=filtered_data)
              v_intercept <- coef(lm_numeric_x)[[1]]
              v_slope <- coef(lm_numeric_x)[[2]]
              pred_violent <- new_year*v_slope+v_intercept
              if (pred_violent<0) pred_violent <- 0.0
              
              #Storing the results
              predictions[i, 2:17] <<- c(new_year, pred_violent, pred_homs,
                              pred_rape, pred_rob, pred_agg_ass, v_intercept, v_slope,
                              h_intercept, h_slope,ra_intercept, ra_slope,ro_intercept, ro_slope,
                              a_intercept, a_slope)
              predictions[i, 1] <<- filtered_data$City[1]
              

              #Update the year slider
              updateSliderInput(session = session, inputId ='year_range', max = new_year, value=c(1975, new_year))
              
      }
    } else {
              showModal(modalDialog(
                 title = "Error",
                 paste0("Enter a year bigger than  2015"),
                 easyClose = TRUE))
    }
  })
  
  # Remove Button reaction
  observeEvent(input$remove, {
    prediction_flag <<- FALSE
    #Delete the text input
    updateTextInput(session = session, "nyear", value="")
    
    #Update the year slider
    updateSliderInput(session = session, inputId ='year_range', max = 2015, value=c(1975, 2015))
  })
  
  # make sure the bar chart has available data
  observe({
    
      
    if (input$year_range[1]>"2015" && as.numeric(input$year_range[1])<new_year) {
      
      
      #Return the year slider to the previous
      updateSliderInput(session = session, inputId ='year_range', value=c(2015, new_year))
      
      showModal(modalDialog(
        title = "Error",
        paste0("No data points available!"),
        easyClose = TRUE))
    }
  
  })
    
  #State combobox reaction
  choices_states <- reactive({
    choices_states <- data %>%
      filter(State==input$state)
  })
  
  observe({
    updateSelectInput(session = session, inputId = "city", choices = unique(choices_states()$City))
  })
  
  
 
  # Filtering the dataframe based on the year slider values
  filtered_crime_data <- reactive(
    data %>%
      filter(City == input$city,
             State ==input$state,
             year >= input$year_range[1],
             year <= input$year_range[2])
    
    
  )
  
  filtered_crime_data_avg <- reactive(
    data %>%
      filter(State ==input$state,
             year >= input$year_range[1],
             year <= input$year_range[2]) %>%
      group_by(year) %>%
      summarize(avg_violent=mean(violent_per_100k),
                avg_agg_ass=mean(agg_ass_per_100k),
                avg_rob=mean(rob_per_100k),
                avg_rape=mean(rape_per_100k),
                avg_homs=mean(homs_per_100k))
    
    
  )
  
  # This function plots the average state data for each crime category
  plot_average <- function(category, label, tiptext, color) {
    
    cat <- enquo(category)
    if (input$year_range[1] != input$year_range[2] && prediction_flag==FALSE) {      
      
      pt <- filtered_crime_data_avg() %>%
        ggplot(aes(year, !!cat, group=1, text = paste('Year: ', year,
                                                            paste('<br>', tiptext), !!cat)))+
        geom_line(aes(group=1), colour=color)+
        geom_point(colour=color)+
        ylab(paste(label," per 100K"))+
        xlab("Year")+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw()+ggtitle(paste(label," in ", input$state))
      
      
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    }
  }
  
  # Average total crimes
  output$total_plot_avg<- renderPlotly({
    
    plot_average(avg_violent, "Average total crimes", "Total crimes per 100K: ", "black")      

          
  }  
      
      
  )
  
  
  # Average assault crimes
  output$assault_plot_avg<- renderPlotly({
    
    plot_average(avg_agg_ass, "Average assault crimes", "Assault crimes per 100K: ", "#000099")
    

  }  
  
  
  )
  
  
  # Average robbery crimes
  output$robbery_plot_avg<- renderPlotly({
    
    plot_average(avg_rob, "Average robbery crimes", "Robbery crimes per 100K: ", "brown")
    
  
  }  
  
  
  )  
  
  
  # Average rape crimes
  output$rape_plot_avg<- renderPlotly({
    
    plot_average(avg_rape, "Average rape crimes", "Rape crimes per 100K: ", "purple")
    
 
  }  
  
  
  )
  
  # Average homocide crimes
  output$homocide_plot_avg<- renderPlotly({
    
    plot_average(avg_homs, "Average homocide crimes", "Homocide crimes per 100K: ", "darkgreen")
    
 
  }  
  
  
  )
  
  ###########################################################################
  # This function plots the line plot and bar charts  for each crime category
 
 plot_data <- function(category, catslope, catint, label, tiptext, color) {  
   cat <- enquo(category)
   if (input$year_range[1] == input$year_range[2]) {
    # plot bar chart
    if (input$arrange_type == "a") {
      
      
      # Check if you need the predicted values or not
      if (prediction_flag==TRUE && as.numeric(input$year_range[1])==new_year) {
        
        data1 <- predictions %>% 
          arrange(!!cat)
        
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(!!cat)  
      }
      
      data2 <- data1[1:input$city_number[1],]
      
      
      pt <- data2 %>%
        ggplot(aes(fct_reorder(City, !!cat),
                   !!cat, text = paste('City: ', City,
                                                  paste('<br>', tiptext), !!cat)))+
        geom_bar(stat="identity", fill = color)+
        xlab("City")+
        ylab(paste(label," per 100K"))+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw() 
      # Add title
      if (prediction_flag==TRUE && as.numeric(input$year_range[1])==new_year) {
        
        pt <- pt+ggtitle("Predicted values")
      }
      
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      
    } else {  # descending bar plot
      
      
      # Check if you need the predicted values or not
      if (prediction_flag==TRUE && as.numeric(input$year_range[1])==new_year) {
        
        data1 <- predictions %>% 
          arrange(desc(!!cat))
        
      } else {
        
        data1 <- data %>%
          filter(year == input$year_range[1]) %>%
          arrange(desc(!!cat))  
      }
      
      
      
      data2 <- data1[1:input$city_number[1],]
      
      pt <- data2 %>%
        ggplot(aes(fct_reorder(City, !!cat, .desc=TRUE),
                   !!cat, text = paste('City: ', City,
                                       paste('<br>', tiptext), !!cat)))+
        geom_bar(stat="identity", fill = color)+
        xlab("City")+
        ylab(paste(label," per 100K"))+
        theme(axis.title  = element_text(size = rel(2.5)))+
        theme_bw()
      
      # Add title
      if (prediction_flag==TRUE && as.numeric(input$year_range[1])==new_year) {
        
        pt <- pt+ggtitle("Predicted values")
      }
      
      ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
      
      
    }
    
    
  } else {  # line plot
    
    pt <- filtered_crime_data() %>%
      ggplot(aes(year, !!cat, group=1, text = paste('Year: ', year,
                                                    paste('<br>', tiptext), !!cat)))+
      geom_line(aes(group=1), colour=color)+
      geom_point(colour=color)+
      ylab(paste(label," per 100K"))+
      xlab("Year")+
      theme(axis.title  = element_text(size = rel(2.5)))+
      theme_bw() 
    
    # plot the regression line in prediction mode
    if (prediction_flag==TRUE) {
      filtered_pred <- predictions %>%
        filter(City == input$city)
      pt <- pt+ geom_abline(intercept = filtered_pred[,catint],
                            slope = filtered_pred[,catslope], linetype=3, color="red")
      # plot the ew point in prediction mode
      if (as.numeric(input$year_range[2])==new_year) {
        pt <- pt+ geom_point(data=filtered_pred, aes(year, !!cat), color="red")
      }
      
    }
    
    ggplotly(pt, tooltip="text") %>% config(displayModeBar = F)
    
    
    
  }
 }
  #################################################################################
  
  # Total crimes 
  output$total_plot<- renderPlotly({
    plot_data(violent_per_100k, "violent_slope", "violent_int", "Total crimes",
              "Total crimes per 100K: ", "black")
    
   }

  )
  
  # Assault
  output$assault_plot<- renderPlotly({
    plot_data(agg_ass_per_100k, "agg_ass_slope", "agg_ass_int", "Assault crimes",
              "Assault crimes per 100K: ", "#000099")
    }

  )
  
  # Homocide
  output$homocide_plot<- renderPlotly({
    plot_data(homs_per_100k, "homs_slope", "homs_int", "Homocide crimes",
              "Homocide crimes per 100K: ", "darkgreen")
    }
  
  
  )
  
 
  #Rape
  output$rape_plot<- renderPlotly({
    
    plot_data(rape_per_100k, "rape_slope", "rape_int", "Rape crimes",
              "Rape crimes per 100K: ", "purple")
    }
    

  )
  
  #Robbery
  output$robbery_plot<- renderPlotly({
    plot_data(rob_per_100k, "rob_slope", "rob_int", "Robbery crimes",
              "Robbery crimes per 100K: ", "brown")
    }
    
  )
  
  
# output$table <- renderTable(
#    data2()
#  )
  #cat(file=stderr(), "pr:", prediction_flag)  
  


}

# Run the application 
shinyApp(ui = ui, server = server)

