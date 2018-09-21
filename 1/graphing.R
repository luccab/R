# installing package responsible to read the excel
library(readxl)
# reading the excel and passing the column types for each column,
# saving everything on 'test' as a dataFrame
datasetforCS112 <- read_excel("~/CS112/datasetforCS112.xlsx", col_types = c("numeric", "text", "text", "date", "date", "date", "date", "numeric", "numeric", "numeric", "numeric"))
test <- data.frame(datasetforCS112)
test

#summary(datasetforCS112)
str(datasetforCS112)
#head(datasetforCS112, 10)
#head(test, 10)
#nrow(test)

# taking the initial of my name "Luc" 
# Each letter position on the Alphabet:
# L -> 12
# u -> 21
# c -> 3
# Since it was asking for a 3 number variable to put in the seed
# I took the last number of the letters position on the alphabet

# setting the seed, so random values of anyone that set the seed
# to the same variable will be the same values
set.seed(213)
# sample(interval, X) generates X values between the interval that you
# pass to the function, setting a third variable 'replace' to true
# will make it possible to generate repeated values between the interval
# for example-> 
sample(c(0:1), 2, replace = TRUE)
# (you can set it to FALSE and run a few times, you will
# see that the values will be always '0' and '1', they will not repeat)

# !!!!! unique(as.numeric(format(test$approval.date, "%Y")))

# generating my questions and printing them
my_questions_are_these <- sort(sample(c(1:10), 3, replace = FALSE))
my_questions_are_these
# questions: 4, 6 and 7

# 4. Approximately how many projects are approved each year?

# converting to data the column approval.date from the dataset
# test. Although it was already setted to be received as date 
# when importing the dataset (I am formatting to only contain 
# Year, month and day; so it does not contain the timezone
# as it will be unecessary; also this line can be used to convert
# strings to date)
test$approval.date <- as.Date(test$approval.date, "%Y-%m-%d")
test$approval.date

approvalDate <- test$approval.date

# formatting the approval date to only show the year it was approved
# as a number. Storing all of those years in 'years'
years <- as.numeric(format(test$approval.date, "%Y"))
# table builds a table that counts the ocurrence of each variable.
# So we are essentially counting the number of times each year
# appears
table(years)

# creating a DataFrame with Years and Frequency, 
# where years are all the Years that appears and 
# Frequency the number of times they appear.
# So with that we know how many projects
# were approved each year.
projectsPerYear <- as.data.frame(table(years))
projectsPerYear

# If want to get a mean of the number of projects approved each year
# we can sum the frequency of all of them (essentially counting 
# the number of projects approved between those years) and 
# divide this value to the number of years -> so we get
# the average per year of how many projects are approved
# per year
sum(projectsPerYear$Freq)/length(unique(years))
# The average per year is 234.6364
# To know how many was approved each year we can print
# either 'table(years)' or projectsPerYear

# Here we can also do a barplot of how many projects were
# approved each year 
barplot(table(years), main="Number of projects approved each year")
#projects <- subset(test, years = unique(years), select = approval.date) 
#projects
unique(years)

# 6. What fraction of projects have completion dates that are different from
# revised completion dates?

# Taking all the completion date, setting it to date and 
# formatting it to yyyy-mm-dd
completionDate <- as.Date(test$original.completion.date, "%Y-%m-%d")
# Taking all the revised completion date, setting it to date and 
# formatting it to yyyy-mm-dd
revisedCompletionDate <- as.Date(test$revised.completion.date, "%Y-%m-%d")

completionDate 
revisedCompletionDate

# Starting variables to count how many were the same
# and how many were different
differentDates = 0
equalDates = 0
notAvailables = 0
equal <- data.frame()
equal

# Showing the example of 2 equal dates
# "2017-10-31" V
completionDate[88]
# "2017-10-31" V
revisedCompletionDate[88]
# Showing that identical will return true when they are indeed equal
identical(completionDate[88], revisedCompletionDate[88])
# will return false when one is Not available
identical(completionDate[88], NA)
identical(NA, completionDate[88])
# will return false when they are different
# "2018-12-31" V
revisedCompletionDate[7]
identical(completionDate[88], revisedCompletionDate[7])


# For loop that will pass through all the completion dates 
# and check if it is equal from the revised completion dates
# Looping from 1 to the length of completionDate, so it 
# passes through all the dates
for (a in 1:length(completionDate)) {
  
  # Since we want to know if completion and revised completion are equal
  # we need to see first if the dates are available. So if one of them
  # are not available we can not compute it to calculate
  # the number of projects with completion dates different
  # from revised completion dates
  # So this 'if' looks at the 2 dates an it will only pass in case
  # both are not null (they are available) and then it will go
  # to further analysis to see if they are the same or not
  if (!is.na(completionDate[a]) & !is.na(revisedCompletionDate[a])) {
  
  # If checking if completion and revised completino date are not
  # identical
  if (!identical(completionDate[a], revisedCompletionDate[a])){
    # If they are not identical we add one to the value of different dates
      differentDates <- differentDates + 1
    
  }
  else {
    # If they are identical we add one to the value of equalDates
    equal <- rbind(equal, as.numeric(format(completionDate[a], "%Y")))
    equalDates <- equalDates +1
  }
    
  }
  # counting one more not available if either of the dates are not available
  if (is.na(completionDate[a]) | is.na(revisedCompletionDate[a])){ 
    notAvailables <- notAvailables + 1
    }
  
  
  # Adding 1 to 'a' so it can loop again but in the next completion and revised
  # completion dates
  a <- a + 1
  
}

# Here we can see that indeed the loop was correct
# since identical + non identical dates + not available dates = total dates
length(completionDate)
# 5184 ^
equalDates + differentDates + notAvailables
notAvailables
equalDates
differentDates
# 5184 ^

# Calculating the percentages of different dates
# we get the number of different dates and divide by the total numbers
# of dates 
percentageOfDifferentData <- (differentDates/(equalDates+differentDates)) * 100
percentageOfDifferentData
# This gives us a percentage of different date of 92.88%
# meaning that 92.88% of projects have completion dates 
# different from revised completion dates.

# Here we can also draw a plot that can be used to 
# analyze over time how we evolved and in this case
# we are actually doing a better job and completing
# more projects in their completion date
barplot(table(equal), main="Number of projects with completion date = their revised completion date per year")


# 7. What does R’s “quantile” function tell you about the distributions of project
# budgets?

projectBudget <- test$project.budget
projectBudget
quantile(projectBudget)

"
The quantiles, explicitly tell us that 
0% of the data is below 0.0055, 
25% is below 0.25, 
50% is below 0.5963619, 
75% is below 0.98 and 
100% is bellow 47.03.
"
# Getting 20 percentiles from the data, so we can better 
# see where the data is concentrated 
quantile(projectBudget, probs = seq(0, 1, 0.05))

library(ggplot2)
str(projectBudget)
# We can also draw a plot to observe the distribution of project budget and the
# count for groups of budgets, to easily see the concentration
ggplot(as.data.frame(projectBudget), aes(x = projectBudget )) + geom_histogram()+ labs(x = "Project Budget") + labs(title="Count based on groups of project budgets")


"
But if we specify the quantile function to give us a sequence in
5% intervals instead of 25%, we can see that 80% of the data is 
below 1. And also that 95% is below 2.25, and that we have an outlier
of 47.03. It does not form a normal distribution but the histogram
or the density function will be skewed to the right. In most of the
cases on right skewed distributions the mean will be higher than the
median(as we can see on the histogram, this is the case here). So the 
project budget is mostly concentrated under 2.4, there is only
5% above 2.4.

"

# Here we are drawing in blue the median and in red the mean.
ggplot(as.data.frame(projectBudget), aes(x = projectBudget )) + geom_histogram() +
  geom_vline(aes(xintercept=median(projectBudget)),
             color="blue", size=1) + geom_vline(aes(xintercept=mean(projectBudget)),
                                                color="red", size=1)
