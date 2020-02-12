#하기 전 미리 업데이트
#update.packages()


############################################################
#변수 
############################################################

goods = "냉장고"
goods

#추천방식

#변수는 모든 데이터 저장 가능 (함수, 차트, 이미지 등등..)
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000.0



#데이터가 단순한 경우 = 이게 되는데 복잡해질 경우 = 이것이 대입안되는 경우가 있다.
# 그래서 R에서는 = 보단 <- 이것을 쓰는것을 권장한다. 



#데이터 타입 확인
class(goods.name)
class(goods.code)
class(goods.price)


mode(goods.name)


#p.34 도움말 활용
?sum
args(sum)

example(sum)


#####################################################################
# 데이터 타입

#자료구조
-----------
# 벡터, 매트릭스, 데이터프레임
# Array : 3차원 이상, 리스트
  
  
  
(v <- c(1,2,3,4,5))  #c 벡터로 만드는 함수
mode(v)
#####################################################################
#[vector]
class(c(1:5))
mode(c(1:5))

#두개의 값이 다르다

class(c(1,2,3,4, "5"))
#자동으로 형변환이 일어난다.

#순서대로 만드는 타입
seq(from = 1, to = 10, by = 2)  # 1부터 10까지 2씩 증가 seq(1, 10, 2) 라고 써도 됨


# rep()
rep(1:3, 3)
rep(1:3, each = 3)

x <- c(1,3,5,7)
y <- c(3,5)


union(x, y)  #합집합
setdiff(x,y) #차집합
intersect(x,y) #교집합

union(x, y); setdiff(x,y); intersect(x,y)


#벡터 컬럼명 지정
age <- c(30, 35, 40)

#names 컬럼에 이름 붙이는 함수
names(age) <- c("홍길동", "임꺽정", "신돌석")

#데이터 초기화 
age <- NULL
age 

#벡터 접근
a <- c(1:50)
a[10:45]  #10번째 부터 45번째 까지
a[10:length(a)-5] # 이렇게 하면 시작범위도 5를 빼고 종료지점에서도 5를 빼는 결과


b <- c(13, -5, 20:23, 12, -2:3)
b

b[1]
b[c(2,4)] #인덱스를 벡터로 
b[c(4,5:8,7)]  # 4번째, 5~8번째, 7번째 출력

b[-1] #파이썬에선 맨마지막을 의미하는 -1인데 R에서는 첫번째 데이터를 빼고 가져오라는 뜻
b[-c(2,4)]  # 2~4번째 데이터 빼고 가져오라는 뜻

#팩터 (factor)  범주형 데이터
gender <- c("man", "women", "women", "man", "man")
class(gender)

ngender <- as.factor(gender)  # factor로 바꾸는 것
class(ngender)

#factor인지 확인하는 함수 
is.factor(gender)  #False
is.factor(ngender) #True


table(ngender)

#기본 그래프를 그려주는 함수 
#plot(gender)  #y축을 어떻게 계산해야할지 몰라서 에러가 남
plot(ngender)


?factor
#factor만들기
ogender <- factor(gender, levels= c("women", "man"), ordered = True)
#(쓸 데이터, 레벨, 정렬할건지)
ogender

########################
#[매트릭스]
#1) 행과 열의 2차원 배열
#2) 동일한 데이터 타입만 저장 가능
#3) 함수 
  #matrix()
  #rbind() - 행을 합치는
  #cbind()  - 열을 합치는

m <- c(1:5)  #1차원

m <- matrix(c(1:5)) # 행 우선  5행 1열이 됨됨

m <- matrix(c(1:11), nrow=2) # 11행이던게 2행으로 변경 짝이 안맞아서 경고가 뜨긴하지만 실행은 된다.
m

m <- matrix(c(1:11), nrow=2, byrow=T)  #행과 열 교환
m


#행, 열을 합쳐 matrix 생성
x1 <- c(3,4, 50:52)
x2 <- c(30, 5, 6:8, 7, 8)  #두개 갯수가 맞지도 않지만 합치는데 지장없다.


mr <- rbind(x1, x2)
mr

mr <- cbind(x1, x2)
mr

#매트릭스 접근
mr[1,]  #1행, 모든열   (아무것도 안적으면 '모든' 이다)
mr[,4]  #모든행, 4열

mr[2,3]
mr[2,2:5]

# 활용
x <- matrix(c(1:9), nrow=3)
x


length(x)  # 모든 길이
nrow(x)    # 행의 길이
ncol(x)    # 열의 길이


apply(x, 1, max) # 쓸 데이터, 1: 행 // 2:열, 최댓값을 구하는 함수
#행별로 최댓값을 구하기

apply(x, 2, max) # 쓸 데이터, 2:열, 최댓값을 구하는 함수

apply(x, 1, mean) # 행별로 평균
apply(x, 2, mean) # 열별로 평균

colnames(x) <- c("one", "two", "three")
x


########################
#[dataframe]
no <- c(1,2,3)
name <- c("hong", "lee", "kim")
pay <- c(150, 250, 300)

emp <- data.frame(No=no, Name=name, Payment=pay)
emp



mat_emp <- matrix(c(no, name, pay))
mat_emp


#행조절
mat_emp <- matrix(c(no, name, pay), nrow=3)
mat_emp
colnames(mat_emp) <- c("No", "Name", "Payment")

mat_emp #아까 데이터프레임과 비슷하지만 차이는 모든 데이터가 문자열이다 

#데이터 불러오기 
txtemp = read.table("C:/academy/hs/Rwork/BasicProject/data/emp.txt")
txtemp

class(txtemp)


txtemp = read.table("C:/academy/hs/Rwork/BasicProject/data/emp.txt", header=T, sep=" ")
txtemp

class(txtemp)


#내가 작업하는 위치 + 상대위치
getwd()  # 내가 작업하는 위치
txtemp1 <- read.table("data/emp.txt", header=T)
txtemp1

#getwd()는 내가 작업하는 위치라면 
#setwd()는 내가 작업하는 위치를 지정을 할 수 있음.
setwd("C:/academy/hs/Rwork/BasicProject/data/")  #작업경로를 이걸로 변경
txtemp2 <- read.table("emp.txt", header=T)
txtemp2


#csv 불러오기

csvemp <- read.csv("emp2.csv")
csvemp
 
#오잉 x가 붙고 첫줄이 컬럼명이 되버렸네?

csvemp2 <- read.csv("emp2.csv",header = F, col.names=c("사번", "이름", "급여"))
csvemp2

#R studio가 아닐 시에 dataframe 그리드로 보는 방법
view(csvemp2) #view()라는 함수로 보면 된다.

#접근 방법 
csvemp2$사번   #이런식으로 접근
#결과를 보면 하나의 컬럼은 벡터로 이루어진다는것을 알 수 있다. 

csvemp2[, 1]
csvemp2[-1, -2]  #데이터 중에서 1행 빼고 2열 빼고

#데이터 프레임 구조 확인
str(csvemp2) #뭔가 이상한 결과가 있다.

#factor로 되어있는 부분인데 

csvemp3 <- read.csv("emp2.csv", header=F, col.names=c("사번", "이름", "급여"), stringsAsFactors=F)
#stringsAsFactors를 사용하면 문자열로 된것이 factor로 되는것을 막을 수 있다. 카테고리화 시키지 않을거라면 사용하자
#False로 주면 벡터로 된다. 
str(csvemp3)


#기본 통계값
summary(csvemp3) 


#apply() 사용
df <- data.frame(x=c(1:5), y=seq(2, 10, 2), z=c("a","b","c","d","e"))
df


apply(df, 2, sum) #문자가 있어서 안됨

#그래서 문자 아닌것을 뽑아내야함
apply(df[, c(1,2)], 2, sum)

#데이터의 일부를 추출해서 별도의 데이터 프레임 생성
x1 <- subset(df, x>=3)
x1 

xandy <- subset(df, x>=2 & y<=6)  #and연산자 사용 가능
xandy

#병합
height <- data.frame(id=c(1, 2), h=c(180, 175))
weight <- data.frame(id=c(1, 2), h=c(80, 75))

user <- merge(height, weight, by="id")  #by는 기준이 될 컬럼
user



###########################################################
#[array]
vec <- c(1:12)
arr <- array(vec, c(3,2,3))  #vec를 3행 2열 3면 으로 만들겠다.  
#굳이 2차원하는데 array를 쓸 필욘 없다.
arr


#arr접근
arr[,,1]  #1면에 접근하겠다는 뜻
arr[,,2]  #2면에 접근하겠다는 뜻

arr[2,2,]  #2행, 2열에 접근하겠다는 뜻




###########################################################
#[list] 
#1) key와 value가 한 쌍
#2) python에서의 dict와 유사
#3) list()

a <- 1 # 스칼라, 벡터
x1 <- data.frame(var1=c(1, 2, 3), var2=c("a", "b", "c"))  #dataframe
x2 <- matrix(c(1:12), ncol=2)  # 매트릭스
x3 <- array(1:20, dim=c(2, 5, 2)) #array #아까 만들땐 dim이 생략된거 뿐

#list는 위의 값들을 다 묶어버릴 수 있다. 

x4 <- list(f1=a, f2=x1, f3=x2, f4=x3)  #f는 키
x4

x4$f1
x4$f2

#list
list1 <- list("lee", "이순신", 95)
list1
list1[1]
list1[[1]]


#unlist
#리스트 형식을 벡터형태로 풀기
un <- unlist(list1)
un

#키와 같이 만드는 방법
list2 <- list(id="lee", name="이순신", age=30)
list2

#apply활용
a <- list(c(1:5))
b <- list(6:10)
a
b

c <- c(a,b)
c
class(c)

apply(c, max)  
#과연 2차원이 아닌 3차원에서 apply가 될까
#안됨 ㅎ

#lapply() list에서 쓰는 apply이다
lapply(c, max)
#결과값도 list임임

sapply(c, max)
#sapply()
#lapply랑 무슨차이일까
#결과는 같음
#리턴값 타입이 다름 
# 얘는 벡터임


#########################
##기타
#6.[날짜형]

Sys.Date() #현재날짜
Sys.time() #현재시간

a <- "20/1/31"   #형식은 날짜 같은데 문자열인 스칼라이다.
#is : 어떤 함수가 맞는지
#as : 어떤 함수인지 찾는것

as.Date(a) # 날짜형으로 바꿔줌
#근데 문제가 생김 20을 진짜 0020년으로 인식함.

b <- as.Date(a, "%y/%m/%d")
class(b)



##########################
##가장 많이 쓰는것이 문자열
#stringr
#설치가 필요함

# r에서 설치하는건 install.packages("stringr")

# r패키지 모아있는곳을 cran(씨랜)

install.packages("stringr")
#remove.pakages("패키지명")

#사용 / import와 비슷한 것 library함수를 이용
library(stringr)

#숫자만 골라내고 싶을 때
str1 <- c("홍길동35이순신45임꺽정25") 

#정규표현식을 사용 / 숫자 제거
str_extract(str1, "\\d{2}")  #첫번째 결과만 가져오는 함수
str_extract_all(str1, "\\d{2}")  #모든 결과를 다 가져오는 함수
str_exetract_all(str1, "[0-9]{2}") # 다른 정규표현 방식


#정규2 / 세자리 문자만 뽑고 싶을때
str2 <- c("hongkd103leess1002you25TOM400강감찬2005")
str_extract_all(str2, "[a-zA-Z가-힣]{3}")


#정규3 / 세자리 문자 이상만 뽑고 싶을때
str_extract_all(str2, "[a-zA-Z]{3,}")

#정규4 / 세자리이상에서 다섯자리 문자만 추출
str_extract_all(str2, "[a-zA-Z]{3,5}")


str_length(str2) #문자열 길이

str_locate(str2, "강감찬") #특정데이터의 시작위치와 끝 위치

str_c(str2, "유비55")  #문자 추가

#문자 분리 이것도 split이 있음
str3 <- c("hongkd103,leess1002,you25,TOM400,강감찬2005")
str_split(str3, ",")
str3
