df<-read.csv("performancedata.csv")



library(forecast)



tsdata<- ts(df$공연, start = c(2018,3), end = c(2023,3), frequency = 12)


lm.trend<-tslm(tsdata~trend)

summary(lm.trend)



par(family="AppleGothic")

plot(tsdata, xlab="Year", ylab="상대검색량", col="Coral1")

lines(lm.trend$fitted, lwd=2)



#비선형 추세 모형 적합 및 추세선 추가

lm.trend2<-tslm(tsdata~trend+I(trend^2))

summary(lm.trend2)



plot(tsdata, xlab="Year", ylab="상대검색량", col="Coral1")

lines(lm.trend2$fitted, lwd=2)



#계절 변동 예측 가변수 생성 (1월 기준)

lm.season<-tslm(tsdata~season)

summary(lm.season)


lm.all<-tslm(tsdata~trend+I(trend^2)+season)

summary(lm.all)


plot(stl(tsdata,"periodic"))
