library(forecast)
Amtrak.data <- read.csv("Amtrak.csv")

#시계열 자료 형식으로 객체 생성
tsdata <- ts(Amtrak.data$Ridership,start = c(1991, 1), end = c(2004, 3), freq = 12)

#선그래프 시각화

plot(tsdata, xlab = "Year", ylab = "Ridership (in 000s)", ylim = c(1300, 2300), col="violetred3")

# 선형 추세 모형 적합 및 추세선 추가
lm.trend <- tslm(tsdata ~ trend)
summary(lm.trend)

plot(tsdata, xlab = "Year", ylab = "Ridership (in 000s)", ylim = c(1300, 2300), col="violetred3")
lines(lm.trend$fitted, lwd = 2)

# 다항(비선형) 추세 모형 적합 및 추세선 추가
lm.trend2 <- tslm(tsdata ~ trend+I(trend^2))
summary(lm.trend2)

plot(tsdata, xlab = "Year", ylab = "Ridership (in 000s)", ylim = c(1300, 2300), col="violetred3")
lines(lm.trend2$fitted, lwd = 2)

# 계절변동 예측 가변수 생성(1월 기준)  
lm.season <- tslm(tsdata ~ season)
summary(lm.season)

# 시계열 추세와 계절변동  
lm.all <- tslm(tsdata ~ trend+I(trend^2)+season)
summary(lm.all)


# stl()함수 – 시계열데이터 원본, 계절성, 추세, 잔차 그래프
plot(stl(tsdata,"periodic"))

