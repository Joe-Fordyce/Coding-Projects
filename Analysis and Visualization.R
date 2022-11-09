
#ANALYSIS AND VISUALIZATION 

complete <- read.csv('complete_dataset.csv')
complete$X <- NULL
View(complete)

#Create new features and adjust old features
complete$Pitching_Salary <- gsub("\\$","", complete$Pitching_Salary)
complete$Pitching_Salary <- as.numeric(gsub(",","", complete$Pitching_Salary))

complete$Batting_Salary <- gsub("\\$","", complete$Batting_Salary)
complete$Batting_Salary <- as.numeric(gsub(",","", complete$Batting_Salary))


complete$Wins <- as.numeric(complete$Wins)
complete$Losses <- as.numeric(complete$Losses)
complete$WL <- complete$Wins/(complete$Wins + complete$Losses)


#Estimated win percentage based on WAA
est_win <- (complete$Batting_WAA + complete$Pitching_WAA) + ((complete$Wins+complete$Losses)/2)
est_losses <- (complete$Wins+complete$Losses) - est_win

complete$Est_WL <- est_win/(complete$Wins+complete$Losses)

complete$WL_Error <- abs(complete$WL - complete$Est_WL)

mean(complete$WL_Error)


#Time Analysis
aggregate(complete$Pitching_WAA ~ complete$Season, complete, mean)
aggregate(complete$Batting_WAA ~ complete$Season, complete, mean)
aggregate(complete$Pitching_Salary ~ complete$Season, complete, mean)
aggregate(complete$Batting_Salary ~ complete$Season, complete, mean)

overTime <- data.frame(aggregate(complete$Pitching_WAA ~ complete$Season, complete, mean), 
                       aggregate(complete$Batting_WAA ~ complete$Season, complete, mean),
                       aggregate(complete$Pitching_Salary ~ complete$Season, complete, mean),
                       aggregate(complete$Batting_Salary ~ complete$Season, complete, mean))

overTime$complete.Season.1 <- NULL
overTime$complete.Season.2 <- NULL
overTime$complete.Season.3 <- NULL


names(overTime)[names(overTime)=='complete.Season'] <- 'Season'
names(overTime)[names(overTime)=='complete.Pitching_WAA'] <- 'Pitching WAA'
names(overTime)[names(overTime)=='complete.Batting_WAA'] <- 'Batting WAA'
names(overTime)[names(overTime)=='complete.Pitching_Salary'] <- 'Pitching Salary'
names(overTime)[names(overTime)=='complete.Batting_Salary'] <- 'Batting Salary'

overTime

#Line Plots
plot(aggregate(complete$Pitching_WAA ~ complete$Season, complete, mean), type = 'l')
plot(aggregate(complete$Batting_WAA ~ complete$Season, complete, mean), type = 'l')

#Correlation Analysis of pitching and batting relative to one another
complete$PB <- complete$Pitching_WAA/complete$Batting_WAA
complete$PB <- ifelse(complete$PB == 'Inf',0, complete$PB)
cor(complete$PB, complete$Wins)
complete$BP <- complete$Batting_WAA/complete$Pitching_WAA
complete$BP <- ifelse(complete$BP =='-Inf',0,complete$BP)
cor(complete$BP, complete$Wins)

#DROP 2020 OUTLIER FOR THE REST OF THE ANALYSIS
complete <- complete[complete$Season != '2020',]

#Linear Regression for WAA and Wins
hist(complete$Wins)
plot(complete$Wins~complete$Batting_WAA, xlab = 'Batting WAA', ylab='Wins')
abline(lm(complete$Wins~complete$Batting_WAA))
plot(complete$Wins~complete$Pitching_WAA, xlab = 'Pitching WAA', ylab = 'Wins')
abline(lm(complete$Wins~complete$Pitching_WAA))


WAA_Test <- lm(complete$Wins ~ complete$Batting_WAA+complete$Pitching_WAA)
summary(WAA_Test)

#Normalize Batting Salary
max <- max(complete$Batting_Salary)
min <- min(complete$Batting_Salary)
complete$Batting_salary_scaled <- (complete$Batting_Salary - min) / (max - min)
complete$Batting_salary_scaled

#Normalize Pitching Salary
max_pitch <- max(complete$Pitching_Salary)
min_pitch <- min(complete$Pitching_Salary)
complete$Pitching_salary_scaled <- (complete$Pitching_Salary - min_pitch) / (max_pitch - min_pitch)
complete$Pitching_salary_scaled


#Linear Regression - Salary and Wins 
Salary <- lm(complete$Wins ~ complete$Pitching_salary_scaled+complete$Batting_salary_scaled)
Salary
summary(Salary)
vif(Salary)

plot(complete$Batting_salary_scaled, complete$Wins, xlab = 'Batting Salary', ylab = 'Wins')
plot(complete$Pitching_salary_scaled, complete$Wins, xlab = 'Pitching Salary', ylab = 'Wins')


#Scatter Plots
plot(complete$Batting_WAA, complete$Batting_Salary, xlab = 'Batting WAA', ylab = 'Batting Salary')
plot(complete$Pitching_WAA, complete$Pitching_Salary, xlab = 'Pitching WAA', ylab = 'Pitching Salary')

plot(complete$Batting_WAA, complete$Wins, xlab = 'Batting WAA', ylab = 'Wins')
plot(complete$Pitching_WAA, complete$Wins, xlab = 'Pitching WAA', ylab = 'Wins')


save.image('Analysis and Visualization.rda')
