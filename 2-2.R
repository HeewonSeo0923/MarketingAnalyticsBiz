# HW01

# read csv file
df <- read.csv("WestRoxbury.csv")

# Categorial Varivable to Dummy Variable
df$REMODEL.Recent <- ifelse(df$REMODEL=="Recent",1,0)
df$REMODEL.Old <- ifelse(df$REMODEL=="Old", 1, 0)

# summary
summary(df)

# check NA and make new variable
x <- sample(rownames(df), 10)

df[x,]$BEDROOMS <- NA

summary(df)

med <- median(df$BEDROOMS, na.rm = TRUE)

df[x,]$BEDROOMS <- med

summary(df)

set.seed(1)

train.rows <- sample(rownames(df), dim(df)[1]*0.6)

vaild.rows <- setdiff(rownames(df), train.rows)

train.data <- df[train.rows, ]
vaild.data <- df[vaild.rows, ]

## 학습데이터(50%), 검증데이터(30%), 평가데이터 (20%) # 훈련데이터 행 번호 랜덤 추출 후 train.rows에 할당
train.rows <- sample(rownames(df), dim(df)[1]*0.5)
# 훈련데이터를 제외한 행 번호 중, 일부를 랜덤 추출 후 valid.rows에 할당
valid.rows <- sample(setdiff(rownames(df), train.rows), dim(df)[1]*0.3)
# 훈련데이터와 검증데이터를 모두 제외한 행 번호를 test.rows에 할당
test.rows <- setdiff(rownames(df), union(train.rows, valid.rows))
# 전체데이터를 훈련데이터, 검증데이터, 평가데이터로 분할
train.data <- df[train.rows, ] 
valid.data <- df[valid.rows, ] 
test.data <- df[test.rows, ]


