### 키보드 입력
# scan()  : 벡터입력 
# edit()  : 데이터 프레임 입력 (하나의 테이블을 통째로 입력받을 때)
#-----------------------------

#[scan]
# 숫자 입력
a <- scan()
a


# 문자 입력 what이라는 옵션
b <- scan(what=character())
b


#[edit]
df <- data.frame()
df <- edit(df) # 어느곳에 채울것인지 인자로 넘겨줌
df

##########################################################
#[테스트 파일 생성]
#student.txt
#101 hong	175 65
#201 lee	185 85
#301 kim	173 60
#401 park	180 79

student <- read.table("data/student.txt")
student

#컬럼이름 변경
names(student) <- c("번호", "이름", "키", "몸무게")
student



#[테스트 파일 복사]
#student1.txt로 저장 / 헤더 추가
#번호	이름	키	몸무게
#101 hong	175 65
#201 lee	185 85
#301 kim	173 60
#401 park	180 79


student1 <- read.table(file="data/student1.txt", header=T)  #사실 생략된게 file=  이것이다. 
student1

#기가막힌 기능이 있음 경로를 직접 지정하는게 아니고 다이얼로그 실행해서 직접 파일 선택하는 기능
student1 <- read.table(file.choose(), header=T)
student1


#[테스트 파일 복사]
#student2.txt로 저장 / 모든 구분자를 ; 로 변경
#번호;이름;키;몸무게
#101;hong;175;65
#201;lee;185;85
#301;kim;173;60
#401;park;180;79

student2 <- read.table(file="data/student2.txt", header=T, sep=";")
student2



#[테스트 파일 복사]
#student1 복사 -> student3    / 결측치 만들기
#번호	이름	키	몸무게
#101 hong	175 65
#201 lee	185 85
#301 kim	173 -
#401 park	- 79


student3 <- read.table(file="data/student3.txt", header=T, na.strings= c("-", "+", "&"))
student3


#################################
#[엑셀파일 읽기]
#read.xlsx()
#java가 설치 되어있어야함. path설정도 되어있어야함
# 설치 install.packages("xlsx")

install.packages("xlsx")

library(rjava)
library(xlsx)


studentx <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")  #몇 번째 시트인가, utf인코딩
studentx

#############################################
#[웹에서 읽기]
# 설치 install.packages("httr")
# 설치 install.packages("XML")
install.packages("httr")
install.packages("XML")

library(httr)
require(XML)

url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

get_url <- GET(url) #httr에서 제공하는 html가져오는 함수
get_url



html_content <- readHTMLTable(rawToChar(get_url$content))  
#html태그중 table태그에만 접근하는 함수/ 전체 테이블 중 content이름이 있는것을 raw데이터이므로 char로 변형해서 저장

str(html_content)

#dataframe에 담기
df <- as.data.frame(html_content)
df



######################################
#[화면 출력]
# 변수명
# 괄호
# cat()  : 문자열과 숫자를 연결할 때 사용
# print()


x <- 10
y <- 20
z <- x+y

# z
# (z <- x+y)
# print(z)
# print("x+y의 결과는 ", z, "입니다")  #이거 안됨
# cat("x+y의 결과는 ",z,"입니다")

cat("x+y의 결과는 ",z,"입니다")


#############################################
#[파일로 저장]
# write.table()
# write.csv()

studentx <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")  #위에서 만든걸 다시 쓰기
studentx


write.table(studentx, "data/stud1.txt")
write.table(studentx, "data/stud2.txt", row.names = F)
write.table(studentx, "data/stud3.txt", row.names = F, quote=F)

write.csv(studentx, "data/stud4.csv", row.names = F, quote=F) #csv로 저장하기


#write.xlsx()
library("xlsx")
write.xlsx(studentx, "data/stud5.xlsx")


# save(), load() : 주로 rda파일을 다룰 때 사용
save(studentx, file="data/sud6.rda")

rm(studentx)
studentx

load("data/stud6.rda")
studentx

#[sink]
#sample 데이터 
data()

data(iris)
head(iris)
tail(iris)


#sink("data/iris.txt")  이것을 실행시킨 뒤부터는 모든 내용이 저기에 저장이 된다.
sink("data/iris.txt")
head(iris)
tail(iris)
str(iris)

sink()  # sink종료

head(iris)
