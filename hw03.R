## 0. Prepare
df <- read.csv("BostonHousing.csv")

df

# 변수 500개 선택 
house.df <- df[1:500,]

# 제시 조건 제외 변수 제외시키기 
selected.var <- c(1, 2,  4, 5, 6, 7, 8, 9, 11, 12, 13)

# 데이터 분할 
set.seed(1)
train.index <- sample(c(1:500), 300)
train.df <- house.df[train.index, selected.var]
valid.df <- house.df[-train.index, selected.var]

house.lm <- lm(MEDV ~., data = train.df)
options(scipen = 999)
summary(house.lm)

## 1. Exhaustive Search
library(leaps)
search <- regsubsets(MEDV ~ ., data = train.df, nbest = 1, nvmax = dim(train.df)[2],
                     method = "exhaustive")
sum <- summary(search)

sum$which
sum$rsq
sum$adjr2

## 2. forward Selection
house.lm.null <- lm(MEDV~1, data = house.df)

# use step() to run forward selection
house.lm.step <- step(house.lm.null,   
                    scope=list(lower=house.lm.null, upper=house.lm), direction =  
                      "forward")

summary(house.lm.step) 

## 3. Backward Elimination
house.lm.step <- step(house.lm, direction = 'backward')
summary(house.lm.step)

## 4. Stepwise Selection
house.lm.step <- step(house.lm, direction = 'both')
summary(house.lm.step)

