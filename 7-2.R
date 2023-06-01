# 예측 성능 평가를 위한 forecast 패키지 이용
library(tidyverse)
library(forecast)

# 데이터불러오기
df <- read_csv("ToyotaCorolla.csv")
df
# 랜덤하게 6:4 비율로 학습데이터와 검증데이터로 분할
set.seed(1)
train.rows <- sample(rownames(df), nrow(df)*0.6)
valid.rows <- sample(setdiff(rownames(df), train.rows), nrow(df)*0.4)

train.df <- df[train.rows,-c(1,2,8,11)]
valid.df <- df[valid.rows,-c(1,2,8,11)]

# 선형 회귀 분석 모형 적용
reg <- lm(Price~., data=train.df)
pred_t <- predict(reg,train.df) # 학습데이터를 이용한 예측값 계산
pred_v <- predict(reg,valid.df) # 검증데이터를 이용한 예측값 계산 

# 예측 성능 평가
accuracy(pred_t, train.df$Price)# 학습데이터
accuracy(pred_v, valid.df$Price)# 검증데이터

library(caret)

df <- read.csv("ownerExample.csv")

df$Pred.C <- ifelse(df$Probability>0.5,'owner','nonowner')
confusionMatrix(as.factor(df$Pred.C), as.factor(df$Class))

df$Pred.C <- ifelse(df$Probability>0.25,'owner','nonowner')
confusionMatrix(as.factor(df$Pred.C), as.factor(df$Class))

df$Pred.C <- ifelse(df$Probability>0.75,'owner','nonowner')
confusionMatrix(as.factor(df$Pred.C), as.factor(df$Class))

# ROC 곡선 그리기
library(pROC)
r <- roc(df$Class,df$Probability)
plot.roc(r)

# ROC 곡선아래 넓이 계산
auc(r)

