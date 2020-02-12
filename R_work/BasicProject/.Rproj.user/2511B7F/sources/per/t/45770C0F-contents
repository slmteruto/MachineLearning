###########################
#기본 내장 그래프


#------------------
#[plot]

#사용법
#plot(y축 데이터, 옵션)
#plot(x축데이터, y축데이터, 옵션)
?plot

y <- c(1,1,2,2,3,3,4,4,5,5)
plot(y)


x <- 1:10
y <- 1:10

plot(x, y)
plot(x,y,xlim = c(0, 20), ylim=c(0, 30), main="Graph", type='o')  
#main : 제목
#type : 선을 긋는것 옵션에 따라 다름


x <- runif(100)
y <- runif(100)
plot(x, y, pch=ifelse(y>0.5 , 1, 18))

#여러종류 그래프
## barplot(), hist(), pie(), mosaicplot(), pairs(), persp(), contour(),......


## 그래프 배열
#샘플데이터
head(mtcars)

#그래프 4개 그리기
par(mfrow=c(2,2))
#mfrow : 몇개 그릴건지  (행, 열), 기본값 1행 1열

#하나씩 실행시켜보면 모양이 그뒤로 2행 2열로 맞춰진다. 
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)



par(mfrow = c(1,1))
plot(mtcars$wt, mtcars$mpg)
     

#행 또는 열마다 그래프 갯수를 다르게 지정

layout(matrix(c(1,1,2,3), 2, 2, byrow=T))  #매트릭스 옵션 - 2행 2열  

hist(mtcars$wt)
hist(mtcars$mpg)
hist(mtcars$disp)

#원래대로 하나의 그래프로
par(mfrow=c(1,1))
hist(mtcars$wt)


###############################################################################
#------------------
#[ggplot2]

# http://www.ggplot2-exts.org  #공식사이트
# http://www.r-graph-gallery.com/
#############################################
install.packages("ggplot2")
library(ggplot2)


## 포토샵처럼 레이어 지원
#순서
#1. 배경 설정
#2. 그래프 추가(점, 막대, 선,...)
#3. 설정 추가(축 범위, 범례, 색, 표식....)


#[산포도]
ggplot(data=mpg, aes(x=mpg$displ, y=mpg$hwy)) 
# aes :x축, y축에 쓸 데이터 정함

ggplot(data=mpg, aes(x=mpg$displ, y=mpg$hwy))+ geom_point() 
ggplot(data=mpg, aes(x=mpg$displ, y=mpg$hwy))+ geom_point() + xlim(3,6) + ylim(10,30)   
#x축은 범위가 3~6 y축은 범위가 10~30
#옵션이 +로 추가되는 방식이다.


#mpg데이터의 cty와 hwy간에 어떤 관계가 있는지 알아보려고 한다.
#x축은 cty, y축은 hwy로 된 산포도를 만들어보라

ggplot(data=mpg, aes(x=mpg$cty, y=mpg$hwy)) + geom_point()

#미국 지역 인구통계를 담은 midwest데이터를 이용해 전체인구와 아시아인 인구간에
#어떤관계가 있는지 알아보려한다. x축은 전체인구, y축은 아시아인구로 된 산포도를 만드시오
#단 전체인구는 30만명 이하, 아시아인 인구는 1만명 이하인 지역만 산점도에 표시

ggplot(data=midwest, aes(x=midwest$poptotal, y=midwest$popasian)) + geom_point() + xlim(0, 300000) + ylim(0,10000)

options(scipen=99) #지수를 숫자로 표현


#------------------------
#[막대그래프]
# 구동방식별로 고속도로 평균 연비 확인
library(dplyr)

df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))
df_mpg

ggplot(df_mpg, aes(drv, mean_hwy)) + geom_col()  #col 컬럼 : x축 y축을 다 활용해서 하는 그래프, bar로 하면 안됌

#bar로 할거면 따로따로 해야됨
ggplot(mpg, aes(drv)) + geom_bar()
ggplot(mpg, aes(hwy)) + geom_bar()



#어떤 회사에서 생산한 "suv"차종의 도시 연비가 높은지 알아보려고한다.
#"suv" 차종을 대상으로 평균 cty가 가장 높은 회사 다섯곳을 막대그래프로 표현

df_mpg <- mpg %>% filter(class=="suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

ggplot(df_mpg, aes(df_mpg$manufacturer, df_mpg$mean_cty)) +geom_col()

ggplot(df_mpg, aes(reorder(df_mpg$manufacturer, df_mpg$mean_cty), df_mpg$mean_cty)) +geom_col()  
#reorder : 정렬할때 기준
ggplot(df_mpg, aes(reorder(df_mpg$manufacturer, -df_mpg$mean_cty), df_mpg$mean_cty)) +geom_col()  
#-를 붙이면 내림차순



# 자동차 중에서 어떤 종류(class)가 가장 많은지 알아보려고 한다.
# 자동차 종류별 빈도를 표현한 막대그래프를 그려보시오.
ggplot(mpg, aes(class)) + geom_bar()



#------------------------
#[선그래프]

head(economics)
tail(economics)

ggplot(economics, aes(date, unemploy)) + geom_line()  #선그래프로 그리는것
ggplot(economics, aes(date, psavert)) + geom_line()


#------------------------
#[상자그래프]
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()


# class가 "compact", "subcompact", "suv"인 자동차의 cty가 어떻게 다른지 비교하려고 한다.
# 세 차종의 cty를 나타낸 상자그림을 그려보시오.
class_mpg <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot(class_mpg, aes(class, cty)) + geom_boxplot()



##################################################
# 기본 그래프 중에서 특이한 기능

#------------------------
#[arrows]

x <- c(1,3,6,8,9)
y <- c(12, 56, 78, 32, 9)

plot(x,y)

#화살표 표시
arrows(3, 56, 1, 12)  #x시작, x끝, y시작, y끝

#글자표시
text(4, 40, "이것은 샘플입니다", srt=55)

#꽃잎 그래프
x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6, 6, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)
plot(x,y)

#위와 같은 그래프를 볼 때 중첩된것의 비율을 알기 힘들어서 꽃잎 그래프를 쓴다. 
z <- data.frame(x,y)
sunflowerplot(z) #오우 몇가닥인지가 중첩 갯수군

#------------------------
#[stars]
#별그래프
# 데이터의 전체적인 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한눈에 파악

head(mtcars)

stars(mtcars[1:4], flip.labels=F, key.loc=c(13, 1.5), draw.segments=T)  
#나이팅게일이 심각성을 보여주려고 그래프 그린.. 통계의 여왕이라네 



#------------------------
#[symbols]

x <- c(1,2,3,4,5)
y <- c(2,3,4,5,6)

z <- c(10, 5, 100, 20, 10)

symbols(x, y, z)


######################################################
#Special Graph

#[인터렉티브 그래프]
# https://plot.ly/ggplot2


install.packages("plotly")
library(plotly)

p <- ggplot(mpg, aes(displ, hwy)) + geom_point()
ggplotly(p)


#diamonds 샘플데이터
p <- ggplot(diamonds, aes(x=cut, fill=clarity)) + geom_bar(position="dodge")  
#position을 주면 막대그래프를 따로 볼수있음
p
#어떻게 커팅했냐에 따라 달라짐

ggplotly(p)

# dygraphs 패키지를 이용한 인터렉티브 시계열 그래프 그리기
install.packages("dygraphs")
library(dygraphs)
library(xts)

head(economics)

eco <- xts(economics$unemploy, order.by = economics$date)
eco
dygraph(eco)

dygraph(eco) %>% dyRangeSelector()


# 여러값을 동시에 표현
eco_a <- xts(economics$psavert, order.by=economics$date)
eco_b <- xts(economics$unemploy/1000, order.by=economics$date) #1000으로 나눈건 단위 맞추려고


eco2 <- cbind(eco_a, eco_b)
head(eco2)

colnames(eco2) <- c("psavert", "unemploy")
head(eco2)

dygraph(eco2)


#[지도 그래프]
# 단계 구분도 choropleth Map

install.packages("ggiraphExtra")
library(ggiraphExtra)

head(USArrests)  #체포율 범죄율을 나타내는 샘플데이터
str(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var="state")
head(crime)

crime$state <- tolower(crime$state)
head(crime)


#map_data함수  (지도, 지역)
install.packages("maps")
states_map <- map_data("state")
states_map

install.packages("mapproj")

#잘못 설치 되었다면 
# remove.packages("mapproj")

# url <- "https://cran.rstudio.com/bin/windows/contrib/3.6/mapproj_1.2.6.zip"
install.packages(url, repos=NULL, type="source")

ggChoropleth(data=crime, aes(fill=Murder, map_id=state), 
             map=states_map, interactive=T)  #fill 어떤 데이터를 색으로 채울것인가. 


# 대한민국 지도
# https://github.com/cardiomoon

install.packages("devtools")
#다른 url에서 받을 때 사용 
devtools::install_github("cardiomoon/kormaps2014")

install.packages("ggiraphExtra")
install.packages("maps")
install.packages("mapproj")

devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

str(kormap1)
str(korpop1)

str(changeCode(kormap1)) # 한글 안깨지도록
str(changeCode(korpop1)) # 한글 안깨지도록
str(changeCode(korpop2)) # 한글 안깨지도록
str(changeCode(korpop3)) # 한글 안깨지도록

korpop11 <- changeCode(korpop1) # korpop1 을 korpop11 변수명으로 지정 
str(korpop11) # korpop11 보기

korpop1 <- rename(korpop1, pop="총인구_명", name="행정구역별_읍면동")
str(korpop1)

ggChoropleth(data=dorpop1, aes(fill=pop, map_id=code, tooltip=name), map=kormap1, interactive = T)

str(chageCode(tbc))
tbc <- changeCode(tbc)
ggChoropleth(data=tbc, aes(fill=NewPts, map_id=code, tooltip=name), map=kormap1, interactive = T)




#[워드클라우드]
remove.packages("rJava")
install.packages('rJava', repos='http://cran.us.r-project.org', INSTALL_opts='--no-multiarch')
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk1.8.0_231/jre/bin/server')
library(rJava)


devtools::install_local(path="C:/Users/user/Downloads/KoNLP_0.0-8.0.tar.gz")
Sys.getenv('JAVA_HOME')
install.packages("memoise")
install.packages("KoNLP",INSTALL_opts="--no-multiarch") #한글 처리


library(KoNLP)


#사전 설정
uneNIADic()

#데이터 준비
txt <- readLines("data/hiphop.txt")  #lines는 하나의 문자열로 가져옴
head(txt)

#특수문자 제거
library(stringr)
str_replace_all(txt, "\\W", " ")
head(txt)


#명사 추출 
nouns <- extractNoun(txt)
class(nouns)
nouns[1:10]


wordcount <- table(unlist(nouns))  #list를 해제해야 하나의 뭐가된다고??..
wordcount[50:60]


df_word <- as.data.frame(wordcount, stringsAsFactors = F) #조건 왜 쓴거지
tail(df_word)


#컬럼명 수정
library(dplyr)
df_word <- rename(df_word, word=Var1, freq=Freq)

#두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2) 
#nchar : 한글자를 의미 // word가 2글자 이상인걸 뽑아라

tail(df_word)

#top20 확인

top_20 <- df_word %>% arrange(desc(freq)) %>% head(20)
top_20


# wordcloud로 출력
install.packages("wordcloud")


library(wordcloud)
library(RColorBrewer)

#난수 고정
set.seed(1234)

wordcloud(words=df_word$word, freq=df_word$freq, min.freq = 2, random.order=F,
          colors=brewer.pal(8, "Dark2"),
          scale=c(4,0,3))
#min.freq 최소 2번 이상 나온 값만 출력
#random 정렬
#scale 모양





##test
mpg <- as.data.frame(ggplot2::mpg)

########################
#1
mpg$displ_val <- ifelse(mpg$displ >= 5, 'h', 'l')
mpg %>% group_by(mpg$displ_val) %>% summarise(hwy_mean = mean(hwy))


########################
#2

#popadults는 해당 지역의 성인 인구, poptotal은 전체 인구를 나타낸다.  
#midwest데이터에 "전체 인구 대비 미성년 인구 백분율" 변수를 추가하고, 
#미성년 인구 백분율이 가장 높은 상위 5개 county(지역)의 미성년 인구 백분율을 출력
midwest <- as.data.frame(ggplot2::midwest)

midwest$child_per <- (midwest$poptotal-midwest$popadults)/midwest$poptotal * 100
midwest %>% 
  select(county,child_per) %>% 
  arrange(desc(midwest$child_per)) %>% 
  head(5)


########################
#3


########################
#4
mpg <- mpg %>% mutate(tot  = (cty+hwy)/2)
mpg


df_comp <- mpg %>% filter(class=='compact')
df_comp

df_suv <- mpg %>% filter(class=='suv')
df_suv

df_comp %>% summarise(avg_tot = mean(tot))
df_suv %>% summarise(avg_tot = mean(tot))


########################

#5
options(scipen=99)
ggplot(data=midwest, aes(x=midwest$poptotal, y=midwest$popasian)) + geom_point() + xlim(0, 500000) + ylim(0, 10000)


########################
#6
mpg

result <- mpg %>% 
  filter(mpg$class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(avg_cty = mean(cty)) %>% 
  arrange(desc(avg_cty)) %>% 
  top_n(5)

ggplot(result, aes(reorder(result$manufacturer, -result$avg_cty), result$avg_cty)) +geom_col()


