## object
# num
a <- 1

# text
b <- "R is awesome!"

# function
c <- sum(c(1, 3, 5, 7, 9))

# data
d <- read.csv("BostonHousing.csv")

## vector
# num
a <- c(1, 2, 3, 4,5)

# text
b <- c('사과', '딸기', '포도', '복숭아', '자두')

# plus vector
a2 <- append(a, 6)

# delete vector
b2 <- b[-2]

## Data Frame
# append vector to data frame
df <- data.frame(a,b)

# naming
df <- data.frame(ID = a, 과일 = b)

# choose data
df$과일

# delete row
df1 <- df[-1,]

# delete column
df2 <- df[,-1]

## Boston-Housing data
df <- read.csv('BostonHousing.csv')

df

df[1:10, 1]

df[1:10, ]

df[5, 1:10]

df[5, c(1:2, 4, 8:10)]

df[,1]

df$MEDV

df$MEDV[1:10]

mean(df$MEDV)

sd(df$MEDV)

summary(df$MEDV)

df1 <- subset(df, subset=(MEDV<20))

df2 <- subset(df, subset=(MEDV==20))

df3 <- rbind(df1, df2)

df4 <- subset(df, select=RM)

df5 <- subset(df, select=MEDV)

df6 <- cbind(df4, df5)
