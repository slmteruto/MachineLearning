install.packages("UsingR")
library(UsingR)


####
#부모키는 자식키에 영향을 미치나
str(galton)
View(galton)

plot(child ~ parent, data=galton)

cor.test(galton$child, galton$parent) # 둘다 연속 변수

#결과가 0.45인데 어느정도 관계가 있다는 것

# 회귀분석전 관계가 있는 상관관계를 먼저 파악

out = lm(child~parent, data=galton)
summary(out)
# 상관관계는 기울기가 아니다. 

abline(out, col="red")

plot(jitter(child, 5) ~ jitter(parent, 5), data=galton) #jitter 흔든다는 뜻?


sunflowerplot(galton)


####################################################################
# pop_growth : 인구증가율
# elderly_rate : 65세 이상 노령인구 비율
# finance : 재정 자립도
# cultural_center : 인구 10만명 당 문화 기반 시설 수 


mydata <- read.csv("data/cor.csv")
View(mydata)
str(mydata)

plot(mydata$pop_growth, mydata$elderly_rate)

cor(mydata$pop_growth, mydata$elderly_rate, method="pearson")  #순위
cor(mydata$pop_growth, mydata$elderly_rate, method="spearson") #순위를 가지고 ?????

# 많은 변수에 대해서 상관분석을 해야한다면
x <- cbind(mydata$pop_growth, mydata$birth_rate, mydata$elderly_rate, mydata$finance, mydata$cultural_center)

cor(x)

