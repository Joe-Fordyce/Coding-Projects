
rm(list=ls())

library(ggplot2)
library(xml2)
library(car)
library(dplyr)


#Loop for seasons 2005 - 2009, and arrange into a dataframe

my_df <- list()

for (i in 5:9){
  
  
  url <- paste('https://en.wikipedia.org/wiki/200',i,'_Major_League_Baseball_season#Standings', sep = '')
  page <- read_html(url)
  
  team_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td/a'))
  Teams <- team_scrape[1:30]
  
  win_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[2]'))
  Wins <- win_scrape[1:30]
  
  loss_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[3]'))
  Losses <- loss_scrape[1:30]
  Losses <- gsub('\n','',Losses)
  
  full <- data.frame(Teams, Wins, Losses)
  
  my_df[[i]] <- full
  
}

#2005 - 2009 Cleanup and Seasons
my_df <- my_df[5:9]

half <- do.call(rbind.data.frame, my_df)
half$Season <- '2005'
half$Season[31:60] <- '2006'
half$Season[61:90] <- '2007'
half$Season[91:120] <- '2008'
half$Season[121:150] <- '2009'
half

half$Teams[half$Teams == 'Los Angeles Angels of Anaheim'] <- 'Los Angeles Angels'
half$Teams[half$Teams == 'Tampa Bay Devil Rays'] <- 'Tampa Bay Rays'

#Scraping 2011 through 2019
#Will need to scrape 2010, 2020, and 2021 seperately 
#Be sure to merge them to maintain correct order

my_df_2 <- list()

for (i in 1:9){
  
  
  url <- paste('https://en.wikipedia.org/wiki/201',i,'_Major_League_Baseball_season#Standings', sep = '')
  page <- read_html(url)
  
  team_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td/a'))
  Teams <- team_scrape[1:30]
  
  win_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[2]'))
  Wins <- win_scrape[1:30]
  
  loss_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[3]'))
  Losses <- loss_scrape[1:30]
  Losses <- gsub('\n','',Losses)
  
  full_2 <- data.frame(Teams, Wins, Losses)
  
  my_df_2[[i]] <- full_2
  
}

#2011 through 2019 Cleanup and add Seasons

my_df_2

half2 <- do.call(rbind.data.frame, my_df_2)

half2$Season <- '2011'
half2$Season[31:60] <- '2012'
half2$Season[61:90] <- '2013'
half2$Season[91:120] <- '2014'
half2$Season[121:150] <- '2015'
half2$Season[151:180] <- '2016'
half2$Season[181:210] <- '2017'
half2$Season[211:240] <- '2018'
half2$Season[241:270] <- '2019'

half2$Teams[half2$Teams == 'Los Angeles Angels of Anaheim'] <- 'Los Angeles Angels'
half2$Teams[half2$Teams == 'Tampa Bay Devil Rays'] <- 'Tampa Bay Rays'



#2005-2009 and 2011-2019 fully scraped and cleaned
#Need 2010, 2020, and 2021, then full merge with First Dataset


#2010

url <- paste('https://en.wikipedia.org/wiki/2010_Major_League_Baseball_season#Standings', sep = '')
page <- read_html(url)

team_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td/a'))
Teams <- team_scrape[1:30]

win_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[2]'))
Wins <- win_scrape[1:30]

loss_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[3]'))
Losses <- loss_scrape[1:30]
Losses <- gsub('\n','',Losses)

part_2010 <- data.frame(Teams, Wins, Losses)

part_2010$Season <- '2010'


#2020

url <- paste('https://en.wikipedia.org/wiki/2020_Major_League_Baseball_season#Standings', sep = '')
page <- read_html(url)

team_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td/a'))
Teams <- team_scrape[1:30]

win_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[2]'))
Wins <- win_scrape[1:30]

loss_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[3]'))
Losses <- loss_scrape[1:30]
Losses <- gsub('\n','',Losses)

part_2020 <- data.frame(Teams, Wins, Losses)

part_2020$Season <- '2020'


#2021

url <- paste('https://en.wikipedia.org/wiki/2021_Major_League_Baseball_season#Standings', sep = '')
page <- read_html(url)

team_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td/a'))
Teams <- team_scrape[1:30]

win_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[2]'))
Wins <- win_scrape[1:30]

loss_scrape <- xml_text(xml_find_all(page, '//table[@class="wikitable"]/tbody/tr/td[3]'))
Losses <- loss_scrape[1:30]
Losses <- gsub('\n','',Losses)

part_2021 <- data.frame(Teams, Wins, Losses)

part_2021$Season <- '2021'

#Merge half, half2, and parts together in correct order

first <- rbind(half, part_2010)

#FULLY SCRAPED DATA FROM WIKIPEDIA
full_wiki <- rbind(first, half2, part_2020, part_2021)

#Match Names
full_wiki$Teams[full_wiki$Teams == 'Los Angeles Angels of Anaheim'] <- 'Los Angeles Angels'
full_wiki$Teams[full_wiki$Teams == 'Tampa Bay Devil Rays'] <- 'Tampa Bay Rays'
full_wiki$Teams[full_wiki$Teams == 'Florida Marlins'] <- 'Miami Marlins'

full_wiki


#First Dataset - from baseballreference

Year_2005 <- read.csv('2005-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2006 <- read.csv('2006-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2007 <- read.csv('2007-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2008 <- read.csv('2008-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2009 <- read.csv('2009-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2010 <- read.csv('2010-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2011 <- read.csv('2011-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2012 <- read.csv('2012-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2013 <- read.csv('2013-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2014 <- read.csv('2014-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2015 <- read.csv('2015-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2016 <- read.csv('2016-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2017 <- read.csv('2017-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2018 <- read.csv('2018-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2019 <- read.csv('2019-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2020 <- read.csv('2020-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")
Year_2021 <- read.csv('2021-BaseballReference.csv', na.strings = '', fileEncoding =  "UTF-8-BOM")


#Merge
Years_2005_2021 <- rbind(Year_2005,Year_2006,Year_2007,Year_2008,Year_2009,Year_2010,Year_2011,Year_2012,Year_2013,Year_2014,Year_2015,Year_2016,Year_2017,Year_2018,Year_2019,Year_2020,Year_2021)

#Match Names
Years_2005_2021$Teams[Years_2005_2021$Teams == 'Los Angeles Angels of Anaheim'] <- 'Los Angeles Angels'
Years_2005_2021$Teams[Years_2005_2021$Teams == 'Tampa Bay Devil Rays'] <- 'Tampa Bay Rays'
Years_2005_2021$Teams[Years_2005_2021$Teams == 'Florida Marlins'] <- 'Miami Marlins'
Years_2005_2021

complete <- merge(Years_2005_2021, full_wiki)
complete <- data.frame(complete[order(complete$Season),])

write.csv(complete, 'complete_dataset.csv')

save.image('WebScrape and Data Integration.rda')
