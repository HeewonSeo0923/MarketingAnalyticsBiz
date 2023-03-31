## 회귀모형 적합 
car.df <- read.csv("ToyotaCorolla.csv")

# use first 1000 rows of data
car.df <- car.df[1:1000, ]

# select variables for regression
selected.var <- c(3, 4, 7, 8, 9, 10, 12, 13, 14, 17, 18)

# partition data
set.seed(1) # set seed for reproducing the partition
train.index <- sample(c(1:1000), 600)
train.df <- car.df[train.index, selected.var]
valid.df <- car.df[-train.index, selected.var]

# use lm() to run a linear regression of Price on all 11 predictors in the
# training set.
# use . after ~ to include all the remaining columns in train.df as predictors.
car.lm <- lm(Price ~ ., data = train.df)

# use options() to ensure numbers are not displayed in scientific notation.
options(scipen = 999)
summary(car.lm)

## 회귀모형 예측 정확도  
library(forecast)

# use predict() to make predictions on a new set.
car.lm.pred <- predict(car.lm, valid.df)
options(scipen=999) # 소숫점 없애기 
some.residuals <- valid.df$Price[1:20] - car.lm.pred[1:20]   # 원래 - 예측값 
data.frame("Predicted" = car.lm.pred[1:20], "Actual" = valid.df$Price[1:20], "Residual" = some.residuals)
options(scipen=999, digits = 3)

# use accuracy() to compute common accuracy measures.
accuracy(car.lm.pred, valid.df$Price)

## 예측 오차 Residuals 분포 
library(forecast)
car.lm.pred <- predict(car.lm, valid.df)
all.residuals <- valid.df$Price - car.lm.pred
hist(all.residuals, breaks = 25, xlab = "Residuals", main = "")

## 전역탐색
# use regsubsets() in package leaps to run an exhaustive search.
# unlike with lm, categorical predictors must be turned into dummies manually.
library(leaps)

# create dummies for fuel type
Fuel_Type <- as.data.frame(model.matrix(~ 0 + Fuel_Type, data=train.df))

# replace Fuel_Type column with 2 dummies
train.df1 <- cbind(train.df[,-4], Fuel_Type[,-1])
head(train.df1)
search <- regsubsets(Price ~ ., data = train.df1, nbest = 1, nvmax = dim(train.df1)[2],
                     method = "exhaustive")
sum <- summary(search)

# show models
sum$which
# show metrics
sum$rsq
sum$adjr2


## Forward Selection
# create model with no predictors for bottom of search range
car.lm.null <- lm(Price~1, data = train.df)

# use step() to run forward selection
car.lm.step <- step(car.lm.null,   
                    scope=list(lower=car.lm.null, upper=car.lm), direction =  
                      "forward")

summary(car.lm.step) 

## Backward Elimination
car.lm.step <- step(car.lm, direction = "backward")
summary(car.lm.step) 

## Stepwise Selection
car.lm.step <- step(car.lm, direction = "both")
summary(car.lm.step) 

