# Load the cleaned dataset
coffee_data <- read.csv("./Data/Coffee_Cleaned.csv")

# Convert categorical variables to factor again, since they might get reverted to character after saving
coffee_data$Region <- as.factor(coffee_data$Region)
coffee_data$Category <- as.factor(coffee_data$Category)

# Perform ANOVA test
# The formula `Sales ¬ Region ` tests if Sales are different across regions

anova_model <- aov(Sales ~ Region, data = coffee_data)

# 4. View the results of the ANOVA test
summary(anova_model)


