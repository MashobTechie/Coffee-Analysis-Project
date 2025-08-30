# Load the dataset
coffee_data <- read.csv("./Data/Coffee.csv")

# Get the structure of the dataframe
str(coffee_data)

# Get a summary of the dataframe
summary(coffee_data)

# Show the first few rows of the dataframe
head(coffee_data)

# Convert character columns to factor type
coffee_data$Ship.Mode <- as.factor(coffee_data$Ship.Mode)
coffee_data$Segment <- as.factor(coffee_data$Segment)
# Add other categorical variables here

# Remove the duplicate 'Region' column
coffee_data <- coffee_data[, !duplicated(colnames(coffee_data))]

# Convert Sales to a numeric variable
coffee_data$Sales <- gsub(",", "", coffee_data$Sales)
coffee_data$Sales <- as.numeric(coffee_data$Sales)

# Convert date columns to date format
coffee_data$Order.Date <- as.Date(coffee_data$Order.Date, format = "%m/%d/%Y")
coffee_data$Ship.Date <- as.Date(coffee_data$Ship.Date, format = "%d/%m/%Y")

# Check the new structure to confirm the changes
str(coffee_data)
