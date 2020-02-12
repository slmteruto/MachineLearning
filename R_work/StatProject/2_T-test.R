### 두 그룹의 평균 비교
#------------------------


# T-Test, student T-Test, Independent T-Test : 모수적(정규분포다)
# Mann-whitney U Test (wilcoxen rank-sum test, Mann-Whitney-wilcoxen test(MWW)) : 비모수적(정규분포가 아니다.)

# welch's T-Test  #두 그룹을 비교할 때 T-Test를 쓸거냐, 다른 테스트를 쓸거냐

# 선택 기준은? 데이터를 보고 판단해야함. 
# 1. 결과값이 연속변수인지 아닌지. 양적자료, 질적자료냐
#     연속이라면 T-Test, 아니면 T-Test는 물건너가고 Mann-Whitney를 쓸 '가능성' 이 생김. 결정은 안됨

# 2. 연속일 경우면 연속값이 정규분포냐 아니냐 
#     정규분포면 T-Test, 아니면 T-Test는 물건너가고 Mann-Whitney를 쓸 '가능성' 이 생김. 결정은 안됨

# 3. 등분산 여부 
#     등분산이면 T-Test, 아니면 이때는 welch's T-Test를 사용한다. 


#
install.packages("moonBook")
library(moonBook)



# 경기도에 소재한 한 대학병원에서 2년동안 내원한 관상동맥증후군 환자 
?acs
#여기서 Dx 부분 STEMI, NSTEMI
head(acs)
str(acs)

mean.man <- mean(acs$age[acs$sex == "Male"])
mean.woman <- mean(acs$age[acs$sex == "Female"])

cat(mean.man, mean.woman)


#남자, 여자/ 나이에 따라 관상동맥이 있는지 판단 
cat(mean.man, mean.woman)

moonBook::densityplot(age ~ sex, data=acs)  
#인자는 (결과를 알고싶은 변수 ~ 원이제공 변수)/ 나이를 알고싶기 때문에 age / 원인은 성별이라고 생각해서 sex
# 그다음 데이터 data=acs

# 그래프를 보니까 하나는 정규 같긴한데 여성은 아닌거 같고... 두개 모두 정규가 아니기 때문에 
# 근데 눈으로 판단할 수가 없기 때문에 


#정규 분포 테스트 (Shapiro Test)
# 귀무가설 : 정규분포가 맞다
# 대립가설 : 정규분포가 아니다.
shapiro.test(acs$age[acs$sex=="Male"])

# p-value가 95% 이상이기 때문에 남성은 정규분포가 맞다.

shapiro.test(acs$age[acs$sex=="Female"])
# 95%가 아니기 때문에 여성성은 정규분포가 아니다.

#그래서  T-Test는 건너갔고 Mann을 써야함 
# 확정짓기전에 등분산인지도 확인한다. 


#등분산 테스트
# 귀무가설 : 등분산이 맞다
# 대립가설 : 등분산이 아니다. 
var.test(age ~ sex, data=acs)
# 0.05보다 크네? 귀무가설이넹 등분산이였다. 

wilcox.test(age ~ sex, data=acs)
#결과로는 
# 귀무가설 : 남성과 여성의 평균나이가 차이가 없다.
# 대립가설 : 남성과 여성의 평균나이가 차이가 있다. 



# 일반정규분포면 평균을 신뢰할 수 있다.
# 일반정규분포가 아니면  평균을 신뢰할 수 없다. 그래서 wilcox테스트 방식을 써서 평균에 순위를 매겨서 계산
# wilcox 다른이름으론 rank-sum 


#만약 정규 분포였다면 T-Test를 쓸 수가 있었을 것.. 이 예제는 아니지만 그냥 써봄
#등분산일 경우 사용 
t.test(age ~ sex, data=acs, var.test=T)  #var.test=T 등분산  옵션 
#등분산이 아닐 경우 사용
t.test(age ~ sex, data=acs, var.test=F)  #var.test=F  옵션  이렇게 하면 welch's 방식을 사용하게 됨. 

################################################################
### 집단이 하나인 경우 
# A회사의 건전지 수명이 1000시간일 때 무작위로 뽑은 10개의 건전지 수명에 대해 샘플이 
# 모집단과 다르다고 할 수 있는가. 

# 귀무가설 : 모집단의 평균과 같다. 
# 대립가설 : 모집단의 평균과 다르다. 

a <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017, 990, 955)

#1. 모집단(표본)의 평균
a.mean <- mean(a)
a.mean

# 차이가 없네? 

#정규분포
shapiro.test(a)
#p-value가 0.97이다 어마어마한 정규분포

# 정규분포이기 때문에 T-Test를 사용할 수 있다. 
?t.test   #여길보면 mu라는게 있다.  모집단의 평균을 알고있다면 이걸 써라

t.test(a, mu=1000)

#p-value가 0.5보다 크기 때문에 오차범위 이내이다. 따라서 수명이 1000시간이 맞다고 판단한다. 



# 집단이 하나인 경우 2
# 어떤 학급의 수학 평균성적이 55점이었다. 0교시 수업을 시행하고 나서 학생들의 성적을 살펴보았다.
 a <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)

 a.mean <- mean(a)
 a.mean
 
#정규분포
shapiro.test(a)
#엇.. 0.95를 못넘자나 정규분포 아니라고 판단. 이럴 땐 mann
t.test(a, mu=55, alternative = "greater")
# p-value가 0.8이나 ?
# 성적이 올랐다고 할 수 도 없음 - 귀무가설이다. 
# -



###################################################################

#20개 도시 추출(우리나라 75개의 자치도시 중에 20개만 추출)
# 귀무 가설 : 20개 도시의 합계출산율이 모집단의 합계 출산율과 같다.
# 대립 가설 : 도시별로 출산율이 다르다.

# 모집단의 평균 출산율은 1.37812

mydata <- read.csv("data/onesample.csv")
mydata

shapiro.test(mydata$birth_rate)
t.test(mydata$birth_rate, mu=1.37812)


#############################################################
# dummy라는 컬럼은 0은 군을 나타내고 1은 시를 나타내는 컬럼이다.
# 시와 군에 따라 합계 출산율의 차이가 있는지 없는지를 보려고 한다.
# 귀무가설 : 차이가 없다
# 대립가설 : 차이가 있다.

# 대립가설을 연구가설이라고도 한다. 

mydata <- read.csv("data/independent.csv")
View(mydata)


gun.mean <- mean(mydata$birth_rate[mydata$dummy==0])
si.mean <- mean(mydata$birth_rate[mydata$dummy==1])

cat(gun.mean, si.mean)

# 이 수치만으론 차이가 있다없다를 이야기하기 그렇다.
# 그래서 연속변수인지 확인, 정규분포인지 확인
# 출산율이기 때문에 연속이죠
# 그럼 정규분포를 확인해보면

shapiro.test(mydata$birth_rate[mydata$dummy==0])
# 0.5  기준으로 이상하니까 정규분포가 아니다.
# 어차피 하나만 정규분포가 안되어도 t-test못쓰긴하지만 그냥 시 별로도 알아보자
shapiro.test(mydata$birth_rate[mydata$dummy==1])
# 이것도 정규분포가 아니넹

#그럼 뭘 쓰지? mann-whitney 를 쓴다. 

wilcox.test(mydata$birth_rate ~ mydata$dummy, data=mydata)
# 0.04는 차이가 없다고 발표를 해야할 수준


#############################################################################
#R sample   - mtcars 자동차 스펙
# 오토나 수동에 따라 연비가 같을까 다를까
# am : 0 오토, 1 수동
# mpg : 연비 

# 귀무 가설 : 연비가 다르다.
# 대립 가설 : 연비가 같다. 

str(mtcars)

mean.auto <- mean(mtcars$mpg[mtcars$am==0])
mean.manual <- mean(mtcars$mpg[mtcars$am==1])

cat(mean.auto, mean.manual)                  
#확 차이가 나버리는데

#그러면 정규분포가 맞는지
shapiro.test(mtcars$mpg[mtcars$am==0])
shapiro.test(mtcars$mpg[mtcars$am==1])

#auto는 넘 높은데.. manual은 정규분포같다.
# 둘다 정규분포 통과. 이제 등분산 테스트

var.test(mtcars[mtcars$am==1, 1], mtcars[mtcars$am==0, 1])
#0.05보다 크므로 귀무가설 채택/ 둘의 분산도 거의 같다. 

t.test(mpg ~ am, data=mtcars, var.test=T)


##############################################################################
# 연속변수가 아니거나 정규분포가 아닐 경우 : wilcoxen signed rank Test

pd <- read.csv("data/pairedData.csv")
pd

# 데이터를 long형으로 구조변경  구조변경을하는 함수 (melt, cast)
library(reshape2)

melt(pd, id=("ID"), variable.name="GROUP", value.name="RESULT")  #id 기준값, 나머진 이름 변수, 변수이름


#gather함수
install.packages("tidyr")
library(tidyr)

?gather()

pd2 <- gather(pd, key="GROUP", value="RESULT", -ID) #id가 필요없기 때문 -id로 빼준다.

shapiro.test(pd2$RESULT[pd2$GROUP=="before"])  
#0.05보다 커서 정규분포이다.......?????

shapiro.test(pd2$RESULT[pd2$GROUP=="After"])  
#0.05보다 커서 정규분포이다.......?????  0.5 아녔어?

#정규분포 확인됐으니 T-Test 쓰는데 앞에서 한거랑 다르다. 
# 하나의 그게 아니라서 ?

# 옵션에 paired로 두개 데이터..? 뭔차이라고..?

t.test(pd2$RESULT ~ pd2$GROUP, data=pd2, paired=T) #paired의 기본값은 F이다
#전 후 차이가 있다. 

# 그래프로 시각화 
#densityplot(pd2$RESULT ~ pd2$GROUP, data=pd2)  #하나의 독립적인 변수에만 사용가능해서 사용할수없다. 

before <- subset(pd2, GROUP=="before", RESULT) #따로 뽑아내기 pd2에서 group이 before인것
before

after <- subset(pd2, GROUP=="After", RESULT) 
after

#한쌍의 데이터를 전문적으로 처리하는 패키지
install.packages("PairedData")
library(PairedData)

##ggplot2 기반이다. 
#moonBook 기반이기도 하다.

pd3 <- paired(before, after) #paired함수에 위에서 만든 before, after를 추가해준다
plot(pd3, type="profile") + theme_bw() 
#theme_bw : 흑백 테마 옵션 // 왜 쓰는거야.. 
#뭔그림이야;; 이걸로 알 수 있다고? 내가 몽충인가.




#####################################################################
# 같은 집단에서 
str(sleep)
View(sleep)

before <- subset(sleep, group==1, extra)
after <- subset(sleep, group==2, extra)

sleep2 <- paired(before, after)
plot(sleep2, type="profile") + theme_bw()

shapiro.test(sleep$extra[sleep$group==1])
shapiro.test(sleep$extra[sleep$group==2])

t.test(sleep$extra ~ sleep$group, data=sleep, paired = T)
with(sleep, t.test(extra ~ group, data=sleep, paired=T))

#만약 정규분포가 아니라면
wilcox.test(sleep$extra[sleep$group==2] - sleep$extra[sleep$group==1])
#또는
with(sleep, wilcox.test(extra[group==2] - extra[group==1], exact=F))

######################################################################



#2010 - 2015년 출산율 



mydata <- read.csv("data/paired.csv")



head(mydata)



mydata2 <- gather(mydata, key="GROUP", value="RESULT")

mydata2



mydata2 <- gather(mydata, key="GROUP", value="RESULT", -c(ID, cities))

mydata2



with(mydata2, shapiro.test(RESULT[GROUP=="birth_rate_2010"]))

with(mydata2, shapiro.test(RESULT[GROUP=="birth_rate_2015"]))



with(mydata2, var.test(RESULT[GROUP=="birth_rate_2010"], RESULT[GROUP=="birth_rate_2015"]))

with(mydata2, t.test(RESULT[GROUP=="birth_rate_2010"], RESULT[GROUP=="birth_rate_2015"], paired=T))


#차이가 없습니다. 10년과 15년의 출산율에 변화차이가 없다.








#여기까지 T-Test의 세가지의 경우에 대해 알게 되었다.



#근데 집단이 세개 있다면?  t-test 비교를 세번 해야되기 때문에 불편하다. 그래서 ANOVA 방법을 사용한다.



# ANOVA 방식

# 집단이 3개 이상일 때 : One Way ANOVA  (일원 배치 분산 분석)

#        - Independent T-test의 확장 

# 시간의 따른 차이 검정 : Repeated Measured ANOVA (반복 측정 분산 분석)

#         밥먹기 전 후 차이가 있냐 두가지 경우밖에 없으므로 - paired

#         여러개 시간이 있다면 이럴 때 ANOVA를 쓴다. 

# 요인에 따른 차이 검정 : Two Way ANOVA (이원 배치 분산 ??)

#         1000도, 1500도 치킨 맛 차이 이럴 경우 Independent Test를 하면 되는데

#         1000도, 1500도 치킨 맛 차이 , 오븐, 기름에 튀겼을 때 맛차이 일 경우엔 t-test를 두번 하는게 아니고 two-way를 쓴다 

# 시간 + 요인에 따른 차이 : Two Way Repeated Mesured ANOVA (?)

#         집단에서 통증에 대해 실험군, 대조군일땐 t-test 쓰면 되긴 하다.

#         하지만 실험군, 대조군이 늘어나면  One way ANOVA로 갈아타면 되는데

#         만약 시점까지 존재하게 된다면 이걸 써야한다.  실험전, 실험후 + 실험군 대조군







# 우리가 만약에 베스킨이 있는데 퍼주는 용량을 g이 일정 이상 되어야 하는데  여러번 볼 때 100g이냐 아니냐 조사를 하면 T-Test를 쓰게 된다.

# 그런데 각 매장별로 만족도를 조사해서 차이가 있는지 본다면, 이 경우에는 여러가지 집단이 되기 때문에 ANOVA를 쓴다. 

# 



####################################


