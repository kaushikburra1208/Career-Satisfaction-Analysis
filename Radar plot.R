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
load_package('radarchart')
load_package('ellipse')

### Load CSV Files ##
survey_results_public <- read.csv("survey_results_public.csv")
radar_plot_data <- read.csv("radar_plot_data.csv")


sqldf("SELECT country, count(country) AS country_count
      FROM radar_plot_data GROUP BY country")

radar_plot_data <- sqldf(paste("SELECT Country, avg(JobSatisfaction) AS JobSatisfaction FROM radar_plot_data ",
                               "WHERE country != 'NA' AND COUNTRY !=''",
                               "GROUP BY country ORDER BY JobSatisfaction desc LIMIT 15"))

radar_plot_data$JobSatisfaction = radar_plot_data$JobSatisfaction /max(radar_plot_data$JobSatisfaction)




chartJSRadar(radar_plot_data)

