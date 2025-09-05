# Load the cleaned dataset
coffee_data <- read.csv("./Data/Coffee_Cleaned.csv")

# Convert categorical variables to factor again, since they might get reverted to character after saving # nolint: line_length_linter.
coffee_data$Region <- as.factor(coffee_data$Region)
coffee_data$Category <- as.factor(coffee_data$Category)

# Perform ANOVA test
# The formula `Sales ¬ Region ` tests if Sales are different across regions

anova_model <- aov(Sales ~ Region, data = coffee_data)

# Perform an ANOVA test to see if Sales are different across Categories
anova_model_category <- aov(Sales ~ Category, data = coffee_data)
# View the results
summary(anova_model_category)
