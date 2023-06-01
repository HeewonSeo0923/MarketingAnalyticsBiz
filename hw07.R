

# 데이터 불러오기

df <- read.csv("ksnack.csv")
df
df <- df[,c(1,10:16)] #과자명과 내용량 대비 영양성분 정보 사용



# 행 이름을 개체명으로 변경

row.names(df) <- df[,1]



# 유클리디안 거리 계산

d <- dist(df[,-1], method = "euclidean")

round(d,digit=2)



# 데이터 정규화

norm.df <- data.frame(sapply(df[,-1], scale))



# 행 이름을 개체명으로 변경

row.names(norm.df) <- df[,1]



# 유클리디안 거리 계산

d.norm <- dist(norm.df, method = "euclidean")

round(d.norm,digit=2)



#완전연결법(최장거리)

hc2 <- hclust(d.norm, method = "complete")

plot(hc2, hang = -1, ann = FALSE,family = "AppleGothic")




# 군집 수 지정 및 군집 번호 확인

memb <- cutree(hc2, k = 3)

df$memb <- memb



# 군집 중심 계산

centers <- aggregate(. ~ memb, data = norm.df, FUN = mean)

round(centers,digit=2)



#K-means clustering

km <- kmeans(norm.df, 3)



#show cluster membership

km_m <- data.frame(km$cluster)



#군집의 중심

km_c <- data.frame(round(km$centers, digit=2))



#plot an empty scatter plot

plot(c(0), xaxt='n', ylab="", type="l", ylim=c(min(km$centers), max(km$centers)), xlim=c(0,7))



#label x-axes

axis(1, at=c(1:8), labels=names(df[,-1]))



#plot centroids

lines(km$centers[1,], lty=1, lwd=2, col="honeydew4")

lines(km$centers[2,], lty=2, lwd=2, col="mediumspringgreen")

lines(km$centers[3,], lty=3, lwd=2, col="slategray1")



#name clusters

text(x=0.5, y=km$centers[,1],labels=paste("Cluster",c(1:3)))

km_c
km_m

