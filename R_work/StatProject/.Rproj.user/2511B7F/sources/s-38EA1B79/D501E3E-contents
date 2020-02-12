#Power Analysis : 적정한 표본의 갯수 산출
install.packages("pwr")

library(pwr)

ky <- read.csv("data/KY.csv", header=T)
ky
table(ky$group)
#cohen's d 공식 

mean.1 <- mean(ky$score[ky$group == 1])
mean.2 <- mean(ky$score[ky$group == 2])

cat(mean.1, mean.2)

sd.1 <- sd(ky$score[ky$group ==1])
sd.2 <- sd(ky$score[ky$group ==2])

cat(sd.1, sd.2)

#cohen's d 공식 이용
#effsize <- |mean.1 - mean.2| / sqrt((sd.1^2 + sd.2^2)/2)
effsize <- abs(mean.1 - mean.2) / sqrt((sd.1^2 + sd.2^2)/2)
#abs : 절대값 함수 

effsize

pwr.t.test(d = effsize, type="two.sample", alternative = "two.sided", power = .8, sig.level = .05) 
# d 인자에 우리가 만든 effsize를 넣어준다.
# type을 넣어서 그 방식을 쓴다고 하는것 하나의 샘플이면 one.sample, 두개면 two.sample
# alternative - tow.sided 양쪽 오차범위를 지정할때 
# power
# sig.level 이 두개는 통상값

