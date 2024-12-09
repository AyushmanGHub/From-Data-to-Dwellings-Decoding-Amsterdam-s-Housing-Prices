library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(readr)

df <- read_csv("C:/Users/ayush/Downloads/Amsterdam House Price Ananlysis and prediction/HousingPrices-Amsterdam-August-2021.csv")
df$Price
data <- data.frame(
  Price = df$Price,
  Area = df$Area,           
  Rooms = df$Room,
  Longitude = df$Lon,    
  Latitude = df$Lat   
)

ui <- fluidPage(
  titlePanel("From Data to Dwellings:Decoding Amsterdam’s Housing Prices"),
  theme = shinytheme("darkly"),
  tags$style(".green-text { color: green; }"),
  
  tabsetPanel(
    # Introduction Section
    tabPanel("Introduction",
             fluidPage(
               br(),
               h4("This project aims to analyze and predict the trendshousing prices in Amsterdam using data from August 2021. 
                The primary goal is to identify trends affecting housing prices. By examining features such as 
                property area, number of rooms, and geographic location (longitude and latitude), this project 
                will use exploratory data analysis (EDA) to visualize relationships and assess their impact on 
                prices. The goal is to evaluate whether these features can be used to find trends in house prices and."),
               h3(span("This Shiny app allows you to explore insights into the Amsterdam housing market using 
                interactive visualizations and analytics.",class = "green-text")),
               h2("Dataset Variables:"),
               h4("This dataset provides comprehensive information on housing prices in Amsterdam, Netherlands, from August 2021. 
                 The dataset comprises 100 records, each representing a housing listing, with the following features:"),
               h4("• Address: The full address of the property."),
               h4("• Zip Code: The postal code associated with the listing."),
               h4("• Price (€): The price of the property in Euros."),
               h4("• Area (m²): The total area of the property in square meters."),
               h4("• Rooms: The number of rooms in the property."),
               h4("• Longitude: The geographic longitude of the property."),
               h4("• Latitude: The geographic latitude of the property.")
             )
    ),
    
    # Histogram of Features
    tabPanel("Histogram of Features",
             sidebarLayout(
               sidebarPanel(
                 selectInput("featureselector", "Select a Feature:",
                             choices = c("Price", "Area", "Rooms", "Longitude", "Latitude"),
                             selected = "Price")
               ),
               mainPanel(
                 plotOutput("HistPlot", width = "100%"),
                 br(),
                 tags$style(".blue-text { color: blue; }"),
                 h4(
                   "The analysis of this dataset reveals valuable insights into key features such as ",
                   span("Price, Area, Rooms, and Location", class = "blue-text"),".These features significantly influence housing prices, 
                   and their properties provide crucial information for understanding market dynamics.By examining the distribution, skewness, 
                   and other statistical properties of these variables."
                 
                 )
               )
             )
    ),
    
    # Scatter Plot of Features
    tabPanel("Scatter Plot of Features",
             sidebarLayout(
               sidebarPanel(
                 selectInput("dualfeatureSelector", "Select a Feature to View Scatter Plot:",
                             choices = c("Price vs Area", "Price vs Rooms", "Price vs Latitude", "Price vs Longitude", "Area vs Rooms"),
                             selected = "Price vs Area")
               ),
               mainPanel(
                 plotOutput("featureHistogram", width = "90%"),
                 br(),
                 tags$style(".blue-text { color: blue; }"),
                 h4("Scatter plots in this analysis provide a visual representation of the", span(" relationships and correlations between key variables through
                 slope of trend line.", class = "blue-text"), "Simply they show how change in one variable correspond to change in another. 
                  A strong correlation in a scatter plot suggests that one variable significantly influences the other, whereas weaker correlations may 
                indicate more complex relationships."
                 )
                 
               )
             )
    ),
    
# Multi-Variate Plots of House Locations and Price

    tabPanel(
      "Multi-Variate Plots",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "plotType",
            "Select a Plot to View:",
            choices = c(
              "House Locations (Longitude, Latitude, Price, Area)",
              "Rooms vs Area by Price",
              "Latitude vs Longitude by Price"
            ),
            selected = "House Locations (Longitude, Latitude, Price, Area)"
          )
        ),
        mainPanel(
          plotOutput("interactivePlot", width = "90%", height = "500px"),
          br(),
          tags$style(".blue-text { color: blue; }"),
          h4(
            "The interactive visualizations offer deeper insights into the housing market by allowing users to explore key relationships dynamically. 
            These plots provide a comprehensive view of how physical attributes and location influence property prices, enabling data-driven insights."
          )
        )
      )
    ),
    
    # Conclusion Section
    tabPanel("Conclusion and Discussion",
             fluidPage(
               br(),
               h4("This project successfully analyzed and predicted housing prices in Amsterdam by examining a comprehensive dataset from August 2021. 
        Through", span(" univariate, bivariate, and multivariate data analyses",class = "blue-text"),", we identified significant trends and correlations between various features such as area, number of rooms, and geographic location."),
               tags$h3("Key Points:"),
               tags$ul(
                 tags$li(h4("Area and number of rooms are the strongest features that strongly affect the price.")),
                 tags$li(h4("Rooms and Area are highly correlated.")),
                 tags$li(h4("Location (latitude and longitude) plays a secondary role in price.")),
                 tags$li(h4("A linear regression model could be a good fit based on the correlations."))
               ),
               br(),
               h2(span("About the Author", class="green-text")),
               h4("This application has been developed as a integral component of the Visualization Course by Ayushman Anupam, 
               a Master of Data Science student at Chennai Mathematical Institute, under the guidance of Prof. Sourish Das.")
               
             )
    )
  )
)

# Server logic
server <- function(input, output) {
  
  # Panel 1: Histogram of Features
  output$HistPlot <- renderPlot({
    selected_feature <- input$featureselector
    
    if (selected_feature == "Price") {
        ggplot(data, aes_string(x = "Price")) +
        geom_histogram(aes(y = ..density..), binwidth = 100000, fill = "purple", color = "black", alpha = 0.7) +
        geom_density(color = "red", size = 1) +
        ggtitle("Probability Distribution of House Prices") +
        labs(x = "Price (Euros)", y = "Density") +
        theme_minimal()+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } 
    
    else if (selected_feature == "Area") {
        ggplot(data, aes_string(x = "Area")) +
        geom_histogram(aes(y = ..density..), binwidth =20,fill ="darkgreen",color ="black", alpha = 0.7,bins = 50) +
        geom_density(color = "red", size = 1) +
        ggtitle("Probability Distribution of House Area") +
        labs(x = "Area (in Sq meter)", y = "Density") +
        xlim(-10, NA) + 
        theme_minimal()+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } 
    
    else if (selected_feature == "Rooms") {
        ggplot(data, aes_string(x = "Rooms")) +
        geom_histogram(aes(y = ..density..),fill = "blue",color = "black",alpha= 0.7,bins= 30) +
        geom_density(color = "red", size = 1, adjust = 3) +
        ggtitle("Probability Distribution ") +
        labs(x = "Number of rooms", y = "Density") +
        xlim(0,15 ) + 
        theme_minimal()+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } 
    else if (selected_feature == "Longitude") {
      ggplot(data, aes_string(x = "Longitude")) +
        geom_histogram(aes(y = ..density..),binwidth = 0.01,fill = "blue",color = "black",alpha= 0.7) +
        geom_density(color = "red", size = 1, adjust = 3) +
        ggtitle("Histogram of Longitude") +
        labs(x = "Longitude", y = "Density") +
        theme_minimal()+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } 
    
    else if (selected_feature == "Latitude") {
      ggplot(data, aes_string(x = "Latitude")) +
        geom_histogram(aes(y = ..density..),binwidth = 0.005,fill = "blue",color = "black",alpha= 0.7) +
        geom_density(color = "red", size = 1, adjust = 3) +
        ggtitle("Histogram of Latitude") +
        labs(x = "Latitude", y = "Density") +
        theme_minimal()+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    }
  })
  
  # Panel 2: Scatter Plot of Features
  output$featureHistogram <- renderPlot({
    selected_plot <- input$dualfeatureSelector
    
    if (selected_plot == "Price vs Area") {
      ggplot(data, aes(x = Area, y = Price)) +
        geom_point(color = "blue", alpha = 0.7) +
        geom_smooth(method = "lm", col = "red", se = FALSE)+
        theme_minimal() +
        labs(title = "Price vs Area", x = "Area (m²)", y = "Price (€)")+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } 
    
    else if (selected_plot == "Price vs Rooms") {
        ggplot(data, aes(x = Rooms, y = Price)) +
        geom_point(color = "green", alpha = 0.7) +
        geom_smooth(method = "lm", col = "red", se = FALSE)+
        theme_minimal() +
        labs(title = "Price vs Number of Rooms", x = "Rooms", y = "Price (€)")+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } else if (selected_plot == "Price vs Latitude") {
      ggplot(data, aes(x = Latitude, y = Price)) +
        geom_point(color = "red", alpha = 0.7) +
        geom_smooth(method = "lm", col = "blue", se = FALSE)+
        theme_minimal() +
        labs(title = "Price vs Latitude", x = "Latitude", y = "Price (€)")+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } else if (selected_plot == "Price vs Longitude") {
      ggplot(data, aes(x = Longitude, y = Price)) +
        geom_point(color = "purple", alpha = 0.7) +
        geom_smooth(method = "lm", col = "red", se = FALSE)+
        theme_minimal() +
        labs(title = "Price vs Longitude", x = "Longitude", y = "Price (€)")+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } else if (selected_plot == "Area vs Rooms") {
      ggplot(data, aes(x = Area, y = Rooms)) +
        geom_point(color = "orange", alpha = 0.7) +
        geom_smooth(method = "lm", col = "red", se = FALSE)+
        theme_minimal() +
        labs(title = "Area vs Number of Rooms", x = "Area (m²)", y = "Rooms")+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    }
  })
  
  # Panel 3: Interactive Plot of House Locations and Price
  output$interactivePlot <- renderPlot({
    # Define plot types
    if (input$plotType == "House Locations (Longitude, Latitude, Price, Area)") {
      # Scatter plot of Longitude and Latitude, sized by Area, colored by Price
      ggplot(data, aes(x = Longitude, y = Latitude, color = Price, size = Area)) +
        geom_point(alpha = 0.7) +
        scale_color_gradient(low = "blue", high = "red") +
        theme_minimal() +
        labs(
          title = "House Locations with Price and Area",
          x = "Longitude",
          y = "Latitude",
          color = "Price (€)",
          size = "Area (m²)"
        )+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
      
    } else if (input$plotType == "Rooms vs Area by Price") {
      # Scatter plot of Rooms vs Area, colored by Price
      ggplot(data, aes(x = Rooms, y = Area, color = Price)) +
        geom_point(alpha = 0.7, size = 3) +
        scale_color_gradient(low = "blue", high = "red") +
        theme_minimal() +
        labs(
          title = "Rooms vs Area Colored by Price",
          x = "Number of Rooms",
          y = "Area (m²)",
          color = "Price (€)"
        )+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    } else if (input$plotType == "Latitude vs Longitude by Price") {
      # Scatter plot of Latitude vs Longitude, colored by Price
      ggplot(data, aes(x = Latitude, y = Longitude, color = Price)) +
        geom_point(alpha = 0.7, size = 3) +
        scale_color_gradient(low = "blue", high = "red") +
        theme_minimal() +
        labs(
          title = "Latitude vs Longitude Colored by Price",
          x = "Latitude",
          y = "Longitude",
          color = "Price (€)"
        )+
        theme(panel.background = element_rect(fill = "white", color = "grey", size = 2),         
              plot.background = element_rect(fill = "white", color = "blue", size = 2))
    }
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

