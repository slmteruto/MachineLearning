####
# Chi-Square Test
# Fisher's exact test
# Cochran-armitage trend test
###


#자동차와 실린더 수와 변속기의 관계
head(mtcars)

table(mtcars$cyl, mtcars$am)

# 가독성을 위해 테이블 수정
mtcars$tm <- ifelse(mtcars$am == 0, "automatic", "manual")
result <- table(mtcars$cyl, mtcars$tm)
result

addmargins(result)

chisq.test(result) # 정확하지 않다고 뜨기 때문에
fisher.test(result)





###############################################################################
# 흡연자, 비흡연자, 과거흡연자 와 고혈압(HBP) 의 유무가 서로 연관이 있을까 

# Cochran-Amitage trend test : prop.trend.test()
?prop.trend.test

str(acs)
table(acs$HBP, acs$smoking)

#컬럼의 순서를 바꾸기
acs$smoking <- factor(acs$smoking, levels = c("Never", "Ex-smoker", "Smoker"))
result = table(acs$HBP, acs$smoking)
result


# x에 해당하는 값 (고혈압 발생횟수)
result[2,]

# n에 해당하는 값(흡연여부)

prop.trend.test(result[2, ], colSums(result))

mytable(smoking ~ age, data=acs)


##시각화 

#모자이크 그래표
mosaicplot(result)
mosaicplot(result, color=c())
colors()
demo("colors")

t(result)
mosaicplot(t(result), color=c("tan1", "firebrick2"))


#타이틀
mosaicplot(t(result), color=c("tan1", "firebrick2"), ylab="Hypertension",
           xlab="Smoking")

##############################################################################

#시 군 구에 따라 다자녀 조례 채택여부가 연관이 있는가?

mydata <- read.csv("data/anova_two_way.csv")
head(mydata)


#####################################

