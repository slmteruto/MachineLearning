# 시각화 
# package
# plyr   
# dplyr 

#############################################################################################################
# plyr, dplyr
#############################################################################################################
install.packages("plyr")
library(plyr)

# 데이터 병합
x <- data.frame(id=c(1, 2, 3, 4, 5, 6), height=c(160, 171, 173, 162, 165, 170))
y <- data.frame(id=c(5, 4, 1, 3, 2, 7), weight=c(55, 73, 60, 57, 80, 91))

xy <- join(x, y, by="id", type="left")
xy 

xy <- join(x, y, by="id", type="right")
xy 

xy <- join(x, y, by="id", type="full")
xy 

xy <- join(x, y, by="id", type="inner")
xy 

# 다중 키일 경우
x <- data.frame(key1=c(1, 1, 2, 2, 3), key2=c('a', 'b', 'c', 'd', 'e'), 
                val=c(10, 20, 30, 40, 50))

y <- data.frame(key1=c(3, 2, 2, 1, 1), key2=c('e', 'd', 'c', 'b', 'a'), 
                val=c(500, 400, 300, 200, 100))

xy <- join(x, y, by=c("key1", "key2"))
xy

# 기술 통계량 : tapply(), ddply()
# tapply() : 집단 변수를 대상으로 한번에 하나의 통계치를 구할 때 사용
# ddply() : 한번에 여러 개의 통계치를 구할 때 사용 

head(iris)
unique(iris$Species) # 중복된거 빼고 하나씩만 불러옴 / Levels이 나온것을 보니 factor형임을 알수있음 

tapply(iris$Sepal.Length, iris$Species, mean) # 각 품종별로 sepal.length 평균을 알수있다
tapply(iris$Sepal.Length, iris$Species, sd)

ddply(iris, .(Species), summarize, avg=mean(Sepal.Length)) 
# ddply는 iris$Species 라 입력안하고 .(Species)라 입력해도됨 # summarize : 통계 요약본, ddply 자체가 따로 통계를 할수없어서 써줘야한다고 하셨다 ....
ddply(iris, .(Species), summarize, avg=mean(Sepal.Length), 
      std=sd(Sepal.Length), max=max(Sepal.Length), min=min(Sepal.Length))

##########################################################################################################
# dplyr
##########################################################################################################
install.packages("dplyr")
help(package=dplyr)

library(dplyr)

exam <- read.csv("data/csv_exam.csv")
exam

# filter()    : 행 추출 -> subset()
# select()    : 열 추출 -> data[, c("열이름", "열이름")]
# arrange()   : 정렬 -> order(), sort()
# mutate()    : 열 추가 -> transform()
# summarize() : 통계치 산출 -> aggregate()
# groupby()   : 집단별로 나누기 
# left_join() : 데이터 합치기(열)
# bind_rows() : 데이터 합치기(행)

### filter
#-----------

# 1반 학생들의 데이터 추출
exam[exam$class==1,]
exam %>% filter(class==1)   # %>% : 일단 모든 데이터를 가져와서 그다음 단계를 하겠다 라는 의미

# 2반이면서 영어점수가 80점 이상인 데이터 추출
exam[exam$class==2 & exam$english>=80,]
exam %>% filter(class==2 & english>=80)

# 1, 3, 5반에 해당하는 데이터 추출
exam %>% filter(class==1 | class==3 | class==5)
exam %>% filter(class %in% c(1, 3, 5)) # in 은 or, = 역할 

### select()
#---------------

# 수학 점수만 추출
exam[, 3]
exam %>% select(math)

# 반, 수학, 영어점수 추출
exam %>% select(class, math, english)

# 수학 점수를 제외한 나머지 컬럼 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출 / 연속적으로 코드를 이어나갈수있는 dplyr의 특징 
exam %>% filter(class==1) %>% select(math)

exam %>% select(id, math) %>% head

### arrange()
#--------------
exam %>% arrange(math)  # 수학점수 기준으로 오름차순 
exam %>% arrange(desc(math))  # 수학점수 기준으로 내림차순 
exam %>% arrange(class, math)

### mutate()
#--------------
exam$sum <- exam$math + exam$english + exam$science
head(exam)

exam <- exam %>% mutate(total=math+english+science, mean=(math+english+science)/3) 
# mutate는 원본을 바꾸지 않음 별도의 객체에 저장됨/ <-으로 지정해줘야 추가된다 
exam

### summarize()
#-----------------
exam %>% summarise(mean_math=mean(math)) # 수학 평균만 보고싶을때 

### group_by()
#---------------
exam %>% group_by(class) %>% 
  summarise(mean_math=mean(math), sum_math=sum(math), median_mat=median(math), n=n())  
# tibble : 데이터프레임과 같은것이지만 더 빠르게 계산을 진행할수있는 것 # n : 전체 개수 세어주는 함수 

### left_join()
#-----------------
test1 <- data.frame(id=c(1, 2, 3, 4, 5), midterm = c(60, 70, 80, 90, 85))
test2 <- data.frame(id=c(1, 2, 3, 4, 5), midterm = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by="id")
total

test3 <- data.frame(class=c(1, 2, 3, 4, 5), teacher=c("kim", "lee", "park", "choi", "jung"))
exam_new <- left_join(exam, test3, by="class")
head(exam_new, 10)

### bind_rows()
#-----------------
group1 <- data.frame(id=c(1, 2, 3, 4, 5), test = c(60, 70, 80, 90, 85))
group2 <- data.frame(id=c(6, 7, 8, 9, 10), test = c(70, 83, 65, 95, 80))
group_all <- bind_rows(group1, group2)
group_all

########################################################################################################
# 실습
########################################################################################################
install.packages("ggplot2")
library(ggplot2)

str(ggplot2::mpg)  # ggplot2 는 :: 사용  # mpg : 각자동차의 연비 나타내는거 
head(ggplot2::mpg, 50)
class(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg) # mpg라는 변수에 입력
mpg
class(mpg)

# 데이터 파악
head(mpg)
tail(mpg)
names(mpg)
class(mpg)
dim(mpg)
str(mpg)
View(mpg)

# 기본 시각화
boxplot(mpg$displ)
hist(mpg$displ)
plot(mpg$displ) # 산포도

# 배기량이 4이하인 차량의 모델명, 배기량, 생산년도를 출력
mpg %>% filter(displ <= 4) %>% select(model, displ, year)


mpg$test <- ifelse(mpg$displ >= 5, "h", "l")
mpg %>% group_by(test) %>% summarise(displ_mean=mean(displ))

# 쌤
select(filter(mpg, displ<=4), model, displ, year)
mpg %>% filter(displ <= 4) %>% select(model, displ, year)

# 통합연비 파생변수를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 출력
# 통합연비 : total <- (도시연비(cty) + 고속도로연비(hwy)) / 2
mpg2 <- mpg %>% mutate(total=(cty+hwy)/2) %>% arrange(desc(total)) %>% head(3)
mpg2

# 쌤
mpg$total <- (mpg$cty + mpg$hwy)/2

# 회사별로 "suv"차량(class)의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 출력
mpg %>% filter(class == "suv") %>% mutate(total=(cty+hwy)/2) %>% group_by(manufacturer) %>% summarise(total_mean=mean(total)) %>% arrange(desc(total_mean)) %>% head(5)

# 쌤 
mpg %>% group_by(manufacturer) %>%  filter(class == "suv") %>% 
  mutate(total=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% head(5)

# 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 출력하시오.
mpg %>% group_by(manufacturer) %>% summarise(hwy_mean=mean(hwy)) %>% arrange(desc(hwy_mean)) %>% head(3)

# 쌤 
mpg %>% group_by(manufacturer) %>% summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% head(3)

# 어떤 회사에서 compact(경차) 차종(class)을 가장 많이 생산하는지 알아보려고 한다.
# 각 회사별 경차 차종 수를 내림차순으로 정렬해 출력
mpg %>% filter(class == "compact") %>% group_by(manufacturer) %>% summarise(n=n()) %>% arrange(desc(n))

# 쌤 
mpg %>% filter(class == "compact") %>% 
  group_by(manufacturer) %>%
  summarise(count=n()) %>% 
  arrange(desc(count))

# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터에 병합하여 출력하시오.
# c:CNG = 2.35, d:Disel = 2.38, e:ethanol = 2.11, p:Premium = 2.76, r:Regular = 2.22
fuel <- data.frame(fl=c("c", "d", "e", "p", "r"), fl_price = c(2.35, 2.38, 2.11, 2.76, 2.22)) 
mpg <- left_join(mpg, fuel, by="fl")
mpg

# 쌤
select(mpg, manufacturer, fl)
unique(mpg$fl)
fuel <- data.frame(fl=c("c", "d", "e", "p", "r"), 
                   prince_fl=c(2.35, 2.38, 2.11, 2.76, 2.22), stringsAsFactors = F) # factor를 vector로 바꿔주기 
fuel
str(fuel) # factor로 되어있는 것을 볼수있음 

mpg <- left_join(mpg, fuel, by="fl")
head(mpg)

# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름으로 파생변수 생성. 이때 기준은 20
# 쌤 
mpg$test <- ifelse(mpg$total>=20, "pass", "fail")
head(mpg)

# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
# 쌤
table(mpg$test)

# 통합 연비 등급을 A, B, C 세 등급으로 나누는 파생변수 추가 : grade
# 30이상이면 A, 20~29이면 B, 20미만이면 C등급으로 분류
mpg$grade <- ifelse(mpg$total>=30, "A", ifelse(mpg$total>=20, "B", "C"))
table(mpg$grade)
mpg

##########################################################################################################################
# 미국 동북중부 437개 지역의 인구 통계 정보를 담은 데이터
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
str(midwest)

# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가
midwest %>% mutate(ratio_child = (poptotal-popadults)/poptotal * 100)

# 미성년 인구 백분율이 가장 높은 상위 5개 지역의 미성년 인구 백분율을 출력
midwest %>% arrange(desc(ratio_child)) %>% select(county, ratio_child) %>% head(5)

# 분류표의 기준에 따라 미성년 비율 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 알아보자.
# 미성년 인구 백분율이 40이상이면 "large", 30이상이면 "middle" 그렇지 않으면 "small"
midwest %>% mutate(grade=ifelse(ratio_child>=40, 'large', ifelse(ratio_child>=30, 'middle', 'small')))

# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, country, 아시아인 인구 백분율을 출력하시오.




#####################################################################################
#### 데이터 전처리

# 순서 : 데이터 탐색 -> 결측치 처리 -> 이상치 처리 - Feature Engineering

# 데이터 탐색
#   1) 변수 확인
#       - 변수의 유형(범주형, 연속형, 문자형, 숫자형...)
#       - 단 변수일 경우 : 평균, 최빈값, 중간값, 분포
#       - 다 변수(2개)일 경우 : 관계, 차이 검정
#       - 다 변수(3개 이상)일 경우 : 관계, 차이 검정

# 결측치 처리
#   1) 삭제
#   2) 다른값으로 대체(평균, 최빈값, 중간값)
#   3) 예측값 : 선형 회귀분석, 로지스틱 회귀분석등을 이용

# 이상치 처리
#   1) 이상치 탐색
#       - 시각적 확인 : 산포도, 박스도표
#       - 통계적 확인 : 표준 잔차, leverage, Cook's D,...
#   2) 처리 방법
#       - 삭제
#       - 다른 값으로 대체
#       - 리샘플링(케이스별로 분리)

# Feature Engineering
#   1) Scaling : 단위 변경 / 값 차이가 많이날 경우 
#   2) Binning : 연속형 변수를 범주형 변수로 변환
#   3) Transform : 기존 존재하는 변수의 성질을 이용해 다른 변수를 만드는 방법 / 질적 자료형을 양적 자료형으로 바꿈
#   4) Dummy : 범주형 변수를 연속형 변수로 변환(Binning의 반대) / 데이터를 숫자로 바꿔서 학습하기 좋게 사용 

#########################################################################################################################

### 변수명 바꾸기
#------------------
df_raw <- data.frame(var1=c(1, 2, 3), var2 = c(2, 3, 2))
df_raw

# 방법1 : 내장함수 
df_new1 <- df_raw
names(df_new1) <- c("v1", "v2")
df_new1

# 방법2 : 패키지(dplyr)
library(dplyr)
df_new2 <- df_raw
df_new2 <- rename(df_new2, v1=var1, v2=var2)
df_new2

### 결측치 처리
#------------------

# resident : 1~5까지의 값을 갖는 명목변수로 거주시를 나타낸다.
# gender : 1~2까지의 값을 갖는 명목변수로 남/여를 나타낸다.
# job : 1~3까지의 값을 갖는 명목변수로 직업을 나타낸다.
# age : 양적변수(비율) : 2~69
# position : 1~5까지의 값을 갖는 명목변수(서열)로 직위를 나타낸다.
# price : 양적변수(비율) : 2.1 ~ 7.9
# survey : 만족도 조사 : 1~5 : 명목변수(서열)

dataset1 <- read.csv("data/dataset.csv", header=T)

View(dataset1)
head(dataset1)
str(dataset1)

y <- dataset1$price
plot(y)

attach(dataset1) # 붙여서 쓴다는 의미 앞으로는 컬럼 이름만 써도 나타남 
price

# detach(dataset1) # 떼어짐 컬럼이름만 쓰면 안나옴 
# price

# 결측치 확인
summary(price) # NA's 총 30개의 결측치가 있음을 확인할 수 있다

# 결측치 제거
sum(price, na.rm=T) # 결측치 제거 전에는 결과값 NA로 나타남 # na.rm = T : 결측치는 빼고 합계 내기

price2 <- na.omit(price) # na.omit : 결측치 삭제
sum(price2)

# 결측치 대체 
data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)

my_na <- function(vec){
  # 제 1차 : 결측치를 제거하고 평균 계산
  print(mean(vec))
  print(mean(vec, na.rm=T))
  
  # 제 2차 : 결측치를 0으로 대체하고 평균 계산 / 결측치가 아니라면 vec값을 쓰고 결측치라면 0을 써라 
  data <- ifelse(!is.na(vec), vec, 0)
  print(mean(data))
  
  # 제 3 차 : 결측치를 평균으로 대체하고 평균 계산
  data2 <- ifelse(!is.na(vec), vec, round(mean(vec, na.rm=T), 2))
  print(mean(data2))
}

my_na(data)

### 이상치 처리
#-----------------

# 질적 자료
table(gender) # gender는 0, 1로 나뉘어져있는데 0과 5도 있음을 볼수있다. 0, 5는 이상치
pie(table(gender))

dataset1 <- subset(dataset1, gender==1 | gender==2) # subset : 특정 행만 뽑기 

detach(dataset1)
attach(dataset1) # 원본이 바뀌었기 때문에 다시..

table(gender) 
pie(table(gender))

# 양적 자료
summary(price) # NA 30개 있음 

length(price)
boxplot(price)

dataset2 <- subset(dataset1, price>=2 & price<=8) # 평균과 중앙값 등의 값들을 놓고 비교하여 잘라낼부분 잘라내기
length(dataset2$price)

plot(dataset2$price)
boxplot(dataset2$price)
stem(dataset2$price) # 값의 빈도를 나타냄 2.1, 2.3, 2.3

# age의 이상치 정제(20~69)

### Feature Engineering
View(dataset2)

# dataset2의 resident 컬럼에 1을 1.서울특별시로 지정하는데 컬럼을 resident2로 새로 지정 이하 동일
dataset2$resident2[dataset2$resident==1] <- "1.서울특별시"
dataset2$resident2[dataset2$resident==2] <- "2.인천광역시"
dataset2$resident2[dataset2$resident==3] <- "3.대전광역시"
dataset2$resident2[dataset2$resident==4] <- "4.대구광역시"
dataset2$resident2[dataset2$resident==5] <- "5.시구군"

View(dataset2)

# Binning
# 나이변수를 청년층(30세이하), 중년층(31~55세 이하), 장년층(56세~)으로 척도 변경

dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <=55] <- "중년층"
dataset2$age2[dataset2$age > 55] <- "장년층"

View(dataset2)

# 역코딩을 위한 코드 변경 : 1이 만족, 5가 불만족이였던걸 5가 만족, 1이 불만족으로 바꾸기
table(dataset2$survey)

survey <- dataset2$survey # survey 값만 뽑아오기
csurvey <- 6-survey # csurvey 컬럼 새로 만들어서 6-survey 한 값 넣기 
dataset2$survey <- csurvey # csurvey를 dataset2 survey의 값과 바꾸기 
head(dataset2)

# Dummy
#   거주유형 : 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
#   직업유형 : 자영업(1), 사무직(2), 서비스(3), 전문직(4), 기타
user_data <- read.csv("data/user_data.csv", header=T)
user_data

table(user_data$house_type)

# 단독주택 + 다가구주택 묶어서 0으로, 아파트 + 오피스텔 묶어서 1로 처리하기
house_type2 <- ifelse(user_data$house_type==1 | user_data$house_type==2, 0, 1) # 단독주택1, 다가구주택2는 0으로 그외는 1로 처리 
user_data$house_type2 <- house_type2
head(user_data, 10)

View(user_data)

# 데이터의 구조 변경(wide type, long type) : melt(long), cast(wide)
# melt(long) : long포맷으로 바뀔때 , cast(wide) : wide 포맷으로 바뀔때
# reshape, reshape2, ...
library(reshape2)

str(airquality)
head(airquality)

View(airquality)

ml <- melt(airquality, id.vars=c("Month", "Day")) # airquality 바꿀건데 기준이 되는 변수는 Month와 Day # melt 데이터를 길게 펼쳐서 보여주는 것 
ml

m2 <- melt(airquality, id.vars=c("Month", "Day"), variable.name = "climate_var",
           value.name = "climate_val")   # variable.name : variable 컬럼 이름 바꾸기
m2

?dcast

dc1 <- dcast(m2, Month + Day ~ climate_var) # Month + Day : 기준 # ~ climate_var : 결과는 climate_var로 나타낼것 컬럼명이 Ozone, Solar.R, Wind, Temp 가됨  
head(dc1)

data <- read.csv("data/data.csv")
data
View(data)

wide <- dcast(data, Customer_ID ~ Date) # ~ Date : 결과는 날짜별로 나타낼것 / 날짜별, 아이디별 개수 알려줌 
wide

wide1 <- dcast(data, Customer_ID ~ Date, sum) # 날짜변, 아이디별의 buy 합계 구함 
wide1

long <- melt(wide, id="Customer_ID") # 아이디 순으로 나열후 variable에는 날짜별, value에는 아이디, 날짜별 개수 알려줌 
long

pay_data <- read.csv("data/pay_data.csv")
head(pay_data)
View(pay_data)

# user_id를 기준으로 product_type을 wide하게 펼쳐보시오.(결과는 합계로 집계)
product_price <- dcast(pay_data, user_id ~ product_type, sum)
product_price

#################################################################################################################################

### MySQL 연동
install.packages("rJava")
install.packages("DBI") # R과 database연결해주는 package
install.packages("RMySQL")

library(RMySQL) # DBI도 같이 로딩됨 

conn <- dbConnect(MySQL(), dbname='testdb', user="user1", password="1111", host="127.0.0.1")
conn

# 테이블 목록 확인
dbListTables(conn)

# 전체 데이터 개수 조회
result <- dbGetQuery(conn, "select * from tblscore") # dbGetQuery : 결과를 얻어오기 위한 
result
class(result)

# 테이블의 필드 목록
dbListFields(conn, "tblscore")

# DML
dbSendQuery(conn, "delete from tblscore")   # dbSendQuery : 결과를 보내기 위한 

result <- dbGetQuery(conn, "select * from tblscore") # 삭제됐는지 확인하기 
result

# 파일로부터 데이터를 읽어들여 DB에 저장 

#데이터 준비
score <- read.csv("data/score.csv", header=T)
score

#테이블에 바로 작성하겠다는 함수
dbWriteTable(conn, "tblscore", score, overwrite=T, row.names=F)

result <- dbGetQuery(conn, "select * from tblscore")
result



#db종료
dbDisconnect(conn)


#RMySQL 라이브러리 한것을 안내리고 밑에 있는걸 사용할 때 충돌이나기에
# 끊어주어야 한다
detach("package:RMySQL", unload=T)


############################################################################
# R에서 SQL문법을 쓸 수 있게 하는 패키지
#sqldf : R+SQL
#설치 install.packages("sqldf")

install.packages("sqldf")

library(sqldf)

head(iris)

#이런식으로 사용 가능하다.
sqldf("select * from iris limit 6")
sqldf("select * from iris order by species desc limit 10")
sqldf("select sum('Sepal.Length') from iris")  
#뭐야 쌍따옴표 따옴표 위치에 따라 왜 값이 달라
sqldf('select sum("Sepal.Length") from iris')
sqldf("select max('Sepal.Length') from iris")
sqldf("select distinct Species from iris")


#품종 별로 갯수 확인
sqldf("select Species, count(*) from iris group by Species")
