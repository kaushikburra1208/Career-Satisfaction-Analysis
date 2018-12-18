### Function Set Workspace ###
set_workspace <- function(dir_path){
  dir.create(dir_path) # Create Directory
  setwd(dir_path) #Set Working Directory
  print(paste("Working Directory Set to : ",dir_path)) # Print Message
}
### Function To Check/Install/Load Package ###
load_package <- function(package_name) {
  # Check If Package Is Installed
  if(is.element(package_name, installed.packages()[,1])){
    library (package_name, character.only=TRUE)  # If Yes Load Package
  }
  else {
    install.packages(package_name) # Install Package
    library (package_name, character.only=TRUE)  # Load Package
  }
}
### Set Workspace ###
set_workspace("C:/Users/burra/Desktop/Final project");

### Load Requied Libraries ###
load_package('dplyr')
load_package('tidyr')
load_package('sqldf')
load_package('ggplot2')
load_package('ggthemes')
load_package('gridExtra')
load_package('grid')
load_package('readr')
load_package('ellipse')


### Load CSV Files ##
survey_results_public <- read.csv("survey_results_public.csv")
data1 <- read_delim("gender.csv", "\t", 
                    escape_double = FALSE, trim_ws = TRUE)


sqldf("SELECT Gender, count(Gender) AS Gender_count
      FROM data1 GROUP BY Gender")

data1 <- sqldf(paste("SELECT Gender, avg(JobSatisfaction) AS JobSatisfaction, avg(CareerSatisfaction) AS CareerSatisfaction FROM data1 ",
                     "WHERE Gender != 'NA' AND Gender !=''",
                     
                     "GROUP BY Gender ORDER BY JobSatisfaction and CareerSatisfaction desc LIMIT 10"))

data1$JobSatisfaction = data1$JobSatisfaction /max(data1$JobSatisfaction)
data1$CareerSatisfaction = data1$CareerSatisfaction /max(data1$CareerSatisfaction)




library(ggplot2)
library(grid)
library(gridExtra)
CareerSatisfactionPlot <- ggplot(data1,aes(CareerSatisfaction,fill=Gender))+geom_bar()
JobSatisfactionPlot <- ggplot(data1,aes(JobSatisfaction,fill=Gender))+geom_bar()
grid.arrange(CareerSatisfactionPlot,JobSatisfactionPlot,ncol=2,top = "Fig 1")


