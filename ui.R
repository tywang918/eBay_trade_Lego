library(shiny)

sets = c("4184: Black Pearl","4195: Queen Annes Revenge","2507: Fire Temple","10232: Palace Cinema","70810: MetalBeard's Sea Cow","10193: Medieval Market Village")   
numbers = c('4184','4195','2507','10232','70810','10193')
names = c("Black Pearl","Queen Annes Revenge","Fire Temple","Palace Cinema","MetalBeard's Sea Cow","Medieval Market Village") 
Sets = data.frame(sets = sets, numbers = numbers, names = names,stringsAsFactors = FALSE)

predicates <- c("Auctions","Buy it now","New","Used","Free Shipping","Best Offer","Sold")
query <- c("&LH_Auction=1","&LH_BIN=1","&LH_ItemCondition=11","&LH_ItemCondition=12","&LH_FS=1","&LH_BO=1","&LH_Sold=1")
query_map <- data.frame(predicates = predicates, query = query,stringsAsFactors = FALSE)


shinyUI(fluidPage(
  
  
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    
                    h1 {
                    font-family: 'Lobster', cursive;
                    font-weight: 500;
                    line-height: 1.1;
                    font-size: 54px;
                    color: #04B404;
                    }
                    
                    body {
                    #background-color: #A93C43;
                    background-image: url('http://img14.deviantart.net/c9d0/i/2012/237/c/7/lego_wallpaper_hulk_by_zarzamorita-d5ccy2e.jpg');
                    }
                    
                    "))
    ),
  
  headerPanel("Cheap Lego From eBay"),
  
  # Application title

  sidebarLayout(
    sidebarPanel(
      selectInput("set", "Select a Lego set:", Sets$sets),
      hr(),
      radioButtons("type", "Type of the listing", c("Auctions","Buy it now")),
      hr(),
      conditionalPanel(
        condition="input.type == 'Buy it now'",
        checkboxInput("best_offer", "Best Offer", FALSE)
      ),
      radioButtons("condition", "Condition of the listing", c("New","Used")),
      hr(),
      checkboxInput("free_shipping", "Free Shipping", FALSE),
      hr(),
      actionButton("go", "Search")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Results:"),
      h4("Scraping is slow...Please be patient."),
      

      tableOutput("table")
    )
  )
))
