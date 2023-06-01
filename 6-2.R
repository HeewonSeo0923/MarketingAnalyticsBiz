df <- read.csv("Cereals.csv", fileEncoding = "euc-kr")

# 산점도 생성
plot(df$rating ~ df$calories, xlab ="calories", ylab ="rating", col="darkorchid4")

# 상관계수 계산 
cor(df$rating, df$calories)

# 주성분 분석
df1 <- data.frame(df$rating,df$calories)
pcs <- prcomp(df1)
summary(pcs)

#주성분 회전- 기존 변수가 주성분에 기여하는 가중치계산
pcs$rot

#데이터 원본을 주성분의 선형식으로 계산
scores <- pcs$x
df2 <- data.frame(df1,scores)

#모든 수치형 변수에 대한 주성분 분석
pcs <- prcomp(na.omit(df[,-c(1:3)]))
summary(pcs)

#스크리도표 시각화
screeplot(pcs,type="line")

#원변수 가중치 검토
pcs$rot[,1:5]

#모든 수치형 변수에 대한 주성분 분석 – 표준편차가 1이 되도록 정규화
pcs.n <- prcomp(na.omit(df[,-c(1:3)]), scale.= TRUE)
summary(pcs.n)

#스크리도표 시각화
screeplot(pcs.n,type="line")

#원변수 가중치 검토
pcs.n$rot[,1:5]
