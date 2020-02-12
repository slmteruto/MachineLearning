# 연속 변수가 아니라면 krustal-wallis H test 이 방정식?

# 정규분포가 아니라면 krustal-wallis H test 이 방정식?

# 등분산이 아니라면 welch's ANOVA 

# ANOVA 사용 

# ANOVA 사용후 사후 검증하는 것  :Tukey


View(acs)
#종속변수(결과변수) : LDLC (저밀도 콜레스테롤 수치)
#원인변수(독립변수) : Dx(진단 결과) : STEMI, NSTEMI, unstable angina


library(moonBook)
moonBook::densityplot(LDLC ~ Dx, data=acs)

shapiro.test(acs$LDLC[acs$Dx=="NSTEMI"])  #빨간색 정규 아니쥬?
shapiro.test(acs$LDLC[acs$Dx=="STEMI"])  # 정규죠?
shapiro.test(acs$LDLC[acs$Dx=="Unstable Angina"])  #파란색 정규 아니쥬?


#정규분포 확인을 위한 또다른 방법
out = aov(LDLC ~ Dx, data=acs)  #평균에서 멀어지는 차이가 잔차라고 한다. 
out
shapiro.test(resid(out))  #resid : 편차를 구하는 함수
#p-value보면 정규분포가 아니란걸 알 수 있다. 


#등분산 확인
bartlett.test(LDLC ~ Dx, data=acs)
# p-value는 0.1이라서 등분산이다..?


# 정규분포이고 등분산이라면 : aov()      oneway ANOVA
out = aov(LDLC ~ Dx, data=acs)
summary(out)



# 연속변수가 아니거나 정규분포가 아닐 때  : kruskal.test()
kruskal.test(LDLC ~ Dx, data=acs)


# 정규분포는 맞고 등분산이 아니라면 : oneway.test()  oneway ANOVA
oneway.test(LDLC ~ Dx, data=acs, var.equal = F) 
# var.equal : 등분산이  맞냐 옵션  아닐땐 F,  맞을땐 T


# 사후검정 
# avo() 사용했을 때 사후 검정 : TukeyHSD() 
TukeyHSD(out)

#각각 비교  p adj가 p-value값  
# 0.05이므로 차이가 없음
# 0.0024이므로 차이가 있다.
# 0.44 니까 완벽하게 차이가 없다. 

#kruska.test() 사용했을 때 사후 검정

str(InsectSprays)
View(InsectSprays)

moonBook::densityplot(count ~ spray, data=InsectSprays)

install.packages("userfriendlyscience")
install.packages("mnormt")

library(userfriendlyscience)
posthocTGH(x=InsectSprays$spray, y=InsectSprays$count, method="games-howell")


#oneway.test() 를 사용했을 때 사후 검정
install.packages("nparcomp")
library(nparcomp)

result <- mctp(LDLC ~ Dx, data=acs)
summary(result)


######################################################################################
head(iris)

# 품종별로 Sepal.width의 평균 차이가 있는가?

#정규 분포인가
out <- aov(Sepal.Width ~ Species, data=iris)
shapiro.test(resid(out))
# 오 정규분포입니다.


# 등분산인가
bartlett.test(Sepal.Width ~ Species, data=iris)
summary(out)
#등분산이네요

TukeyHSD(out)



#####################################################################################
#시, 군, 구에 따라서 합계 출산율의 차이가 있는가? 있다면 어느것과 차이가 있는가?
mydata <- read.csv("data/anova_one_way.csv")
View(mydata)


out <- aov(birth_rate ~ ad_layer, data=mydata)
shapiro.test(resid(out))
# 아쉽게도 정규분포가 아니다.

kruskal.test(birth_rate ~ ad_layer, data=mydata)

posthocTGH(x=mydata$ad_layer, y=mydata$birth_rate, method = "games-howell")


#####################################################################################
#Two Way ANOVA

mydata <- read.csv("data/anova_two_way.csv")
head(mydata)

#multichild : 다가구 지원조계 채택 여부


out <- aov(birth_rate ~ ad_layer + multichild + ad_layer:multichild, data=mydata)  # +로 연결한다. 
shapiro.test(resid(out))

summary(out)
#약하지만 있다. 

TukeyHSD(out)

#####################################################################################
# 연속 변수나 정규분포가 아닐 경우
# t-test : MWW
# paired t-test : wilcoxen signed rank test
# oneway repeated measures anova : friedman test


?friedman.test #기본제공


RoundingTimes <-
  matrix(c(5.40, 5.50, 5.55,
           5.85, 5.70, 5.75,
           5.20, 5.60, 5.50,
           5.55, 5.50, 5.40,
           5.90, 5.85, 5.70,
           5.45, 5.55, 5.60,
           5.40, 5.40, 5.35,
           5.45, 5.50, 5.35,
           5.25, 5.15, 5.00,
           5.85, 5.80, 5.70,
           5.25, 5.20, 5.10,
           5.65, 5.55, 5.45,
           5.60, 5.35, 5.45,
           5.05, 5.00, 4.95,
           5.50, 5.50, 5.40,
           5.45, 5.55, 5.50,
           5.55, 5.55, 5.35,
           5.45, 5.50, 5.55,
           5.50, 5.45, 5.25,
           5.65, 5.60, 5.40,
           5.70, 5.65, 5.55,
           6.30, 6.30, 6.25),
         nrow = 22,
         byrow = TRUE,
         dimnames = list(1 : 22, c("Round Out", "Narrow Angle", "Wide Angle")))


# 정규분포
library(reshape)

rt1 <- reshape::melt(RoundingTimes)
rt1

out <- aov(value ~ X2, data=rt1)
shapiro.test(resid(out))



boxplot(value ~ X2, data=rt1)
friedman.test(RoundingTimes)


#friedman 사후검정은 조금 복잡하다
friedman.test.with.post.hoc <- function(formu, data, to.print.friedman = T, to.post.hoc.if.signif = T,  
                                        to.plot.parallel = T, to.plot.boxplot = T, 
                                        signif.P = .05, color.blocks.in.cor.plot = T, 
                                        jitter.Y.in.cor.plot =F)

friedman.test.with.post.hoc(value ~ X2 | X1, rt1)

# 여러개가 나오면 0.05로만 볼 수가없으니 각각으로 나눠야 정확하게 나온다
# 이 방법이 본페로니 검정


#0.05/3

###############################################################################################
###Two Way Repeated Mesures ANOVA
#아까까진 one way였다


mydata <- read.csv("data/10_rmanova.csv")
mydata

#long형으로 구조 변경
ac1 <- reshape(mydata, direction = "long", varying=3:6, sep="")
ac1

library(reshape2)
ac2 <- reshape2::melt(mydata, id=c("group", "id"), variable.names="time", 
                     value.name="month", 
                     measure.vars = c("month0", "month1", "month3", "month6"))  #id값, 변수값, 값이름, 

ac2

#시각화

?interaction.plot  
#여기 옵션을보면 factor라는게 있는데 우리의 데이터는 fact형이 아니다. vector형이다. 
str(ac1)
#그래서 factor로 바꿔야한다. 


class(ac1$group)
ac1$group <- factor(ac1$group)
ac1$id <- factor(ac1$id)
ac1$time <- factor(ac1$time)

str(ac1)

interaction.plot(ac1$time, ac1$group, ac1$month)

out <- aov(month ~ group*time + Error(id), data=ac1) #다른관점에서 조합이 되는 것이라서 + 가아닌 *로 한다.
#Error옵션을 해주면 자세한 출력결과를 보여준다.
summary(out)

#Error부분이 상세정보이다. 


#사후 검정

#정규분포라는 가정하에 진행한다. 
ac_0 <- ac1[ac1$time == "0", ]  #time이 0인것만
ac_1 <- ac1[ac1$time == "1", ]  #time이 1인것만
ac_3 <- ac1[ac1$time == "3", ]  #time이 3인것만
ac_6 <- ac1[ac1$time == "6", ]  #time이 6인것만


t.test(month ~ group, data=ac_0)  #p-value에는 엄청 차이가 없다. 
t.test(month ~ group, data=ac_1)  #p-value가 0.01 인데 기준이 0.008이므로 차이가 있다고 하기 어렵다.
t.test(month ~ group, data=ac_3)  #p-value가 0.0002  0.008기준으로 봐도 차이가 엄청 있다.
t.test(month ~ group, data=ac_6)  #p-value가 0.0009  0.008기준으로 봐도 차이가 엄청 있다.


0.05 /6    # 6인 이유는 4C2 이다.  4개중에 2개를 뽑은거기 때문에 
# 그래서 0.008 이 값이 기준이 된다.

# 0.008보다 작은게 차이가 있다는 뜻이 됨



