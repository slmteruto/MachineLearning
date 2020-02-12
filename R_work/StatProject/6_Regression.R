#Regression  - 회귀

#(2) 회귀 분석
#- 인과관계  (상관분석에선 인과관계를 함부로 해석하면 안됐다)
#- 1(독립변수 또는 원인변수):1(종속변수, 결과변수) -> 단일 회귀분석
#- 다:1 -> 다중 회귀분석   (회귀분석의 일반적인 형태이다.)
#- 조건이 있다.
#- 연속변수여야함.(또한 선형성도 이루어야한다./직선형태)
#- 정규분포 (데이터가 정규분포여야함)  - 정규분포이기만 하면 데이터는 절반이상 성공 
#- 등분산이어야 함. 
#- 다중공선성이 작아야함 - 다중 공선성이란 독립성을 이야기. (각 컬럼끼리 비슷한놈이 적어야 된다는 것)

#- 일반 선형 모델(Ordinary Linear Model) 
#- 일반화 선형 모델 (General Linear Model) - 로지스틱 회귀분석 
#################################################################################

#단순 선형회귀
# y = wx+b
# w, b를 찾는게 목적이다 .
#-------------------


str(women) # 미국 여성 대상으로 키와 몸무게 조사 (30세~39세) :인치와 파운드


plot(weight ~ height, data=women)  #홀리 쉿 선 넘모 이뿌자나

fit <- lm(weight ~ height, data=women)  # 절편과 기울기를 구해줌

summary(fit)  #별이 세개 찍힌건 엄청 강한관계를 뜻함. 
# call : 사용한식
# Residusals : 실제값과 오차(잔차)
# R-squared(결정계수) : 0.99 = 99% 키는 몸무게에 엄청난 영향이 있다.
# 결정계수는 주어진 종속변수와 추정한 종속변수 간의 상관계수의 제곱
# F-statistic : 두 변수는 선형 관계가 있다없다 p-value로 


abline(fit, col="blue") #가장 적정선을 찾아준다. col은 색깔 
#최적 위치

cor.test(women$weight, women$height) 
#cor 0.9954948은 상관계수
0.9954948^2 #0.991이 나오는데 이게 뭐라고???..


#다항 회귀 분석 
#(다중과는 좀 다름) y = ax
fit2 <- lm(weight ~ height+ I(height^2), data=women) 
#수식이 하나 더 추가 된것
# I() : 항을을 추가하는 함수
# height^2 를 넣어서 2차함수로 만든것

summary(fit2)
# 모두 일치하는 함수를 찾겠다. 
# 아까는 99.1%였는데
# 이거는 99.95% (0.9995)로 상승했다. 

plot(weight ~ height, data=women)
lines(women$height, fitted(fit2), col="red")  #결과 지림
#곡선을 그리려면 lines를 사용해야 한다.
# 거의 99.9% 정확도로 맞는것을 확인할 수 있음. 


# 회귀분석의 조건 충족

#수치로 확인 전 그래프로 확인해보겠다.


par(mfrow=c(2,2)) #2,2 로 한번에 보기
plot(fit) #직선

# 첫번째 그래프 v모양. 선형성을 만족하는건 0 을 기준으로 의미없이 흩어져있어야 좋음  모양이 없이
# Q-Q (p.339 QQplot) : 정규 분포가 되려면 선을 따라 데이터가 모여있어야 한다. 
# Scale-location : 등분산 / 등분산이 자연스럽게 흩어져야함. 모양을 가지면 안됨 (선모양)
# Residuals : 이상치 확인하는 그래프, cook's distance가 이상치? 

# 너무 이 데이터에 맞추면 과적합.. 하게 된다. 오차 허용범위를 넓히는게 정확할 수 도 있음.



# 3차원으로 하면 더 좋아지나??
fit3 <- lm(weight ~ height + I(height^2) + I(height^3), data=women)
summary(fit3)
#??? 0.9998나옴  높긴하다.
par(mfrow=c(2,2))
plot(fit3)


#########################################################################################
mydata <- read.csv("data/regression.csv")
head(mydata)


# 유치원이 많으면 합계 출산율에 영향을 주나 
#= 출산율은 유치원수에 영향을 받나 

# 1. 종속변수, 독립변수 뽑기
# 종속변수
y = cbind(mydata$birth_rate)
y

# 독립변수
x = cbind(mydata$kindergarten)


fit <- lm(y ~ x, data=mydata)
summary(fit)
# R-squared : 0.039이다. 3%이다. 관계가 거의 없다라고 이해하자. women때는 0.99였다. 
# 근데 낮다고 관계없네 라고 치부할건 아니다. 가끔 관계있는데도 낮게 나올 때가 있다. 
# 절편은 1.29049 이다. 
# x(유치원) 기울기는 0.04684 이다   그래서 출산율에 미약하지만 영향을 준다. 0.05 


plot(fit)
# Residuals VS Fitted : 0을 기준으로 특별한 모양이 아니므로 선형성은 만족하는것 같다
# Nomal Q-Q : 정규분포 윗쪽이 좀 이상하다. 이건 아닌거 같다.
# Scale-Location : 등분산은 딱히 문제 없어 보인다. 
# Residuals VS Leverage : 이상치 딱히 걸리는건 없다.


# 정규분포가 이상한데 어떻게 할까. 이럴때 transformation을 사용   (소득과 같은 그래프)
# x값이든 y값이든 한쪽을 증가시켜서 그래프이동으로 정규분포를 맞춰준다. (transformation)
# x 또는 y를 얼마를 계산해줘야 바뀔지 

fit2 <- lm(y ~ x, data = mydata)
# 일반적으로 제곱 -2승을 하던지, 2승을 하던지 등등

# x나 y에 log를 해본다. 
fit2 <- lm(log(y) ~ log(x), data = mydata)
summary(fit2)
# 결과가 별이 하나가 더 늘어났다. 결과가 좋은쪽으로 바뀜
# 설명계수도 좋아짐 

#그래프로 확인해보면
plot(fit2)

# 정규분포가 아까보다 좋아진걸 확인할 수 있다. 

shapiro.test(resid(fit))  # 정규 분포가 아님
shapiro.test(resid(fit2)) # 수정 후 갑자기 정규분포로 바껴버림

############
# 2
# 시군구가 합계 출산에 영향을 주는가

d <- cbind(mydata$dummy)


fit3 <- lm(y ~ d, data=mydata)
summary(fit3)

d

plot(fit3)

# 선형도 아님

#####################################################################################
# 다중 회귀 분석
# y = a1x1 + a2x2 + a3x3

# 여러개의 변수를 쓰는 것을 말함
#-----------------------------------------

# 우리가 변수 하나만 해서 y= ax+b만 되었다. 
# y = a1x1 + a2x2 + a3x3 이런 형태를 처리하는 것 


# 종속 변수 : 살인사건 발생률이 무엇에 영향을 받는지 알아야하므로
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
states

# 원인 변수 : 살인사건에 영향을 주는 변수들 

fit <- lm(Murder ~ Murder + Population + Illiteracy + Income + Frost, data=states)  #종속변수 ~ 원인변수+원인변수+...

# 컬럼이 너무 많으면 위 방법을 쓰기 어려우므로 이 방법을 사용한다.
fit <- lm(Murder ~ ., data=states)  # . 의 의미는 종속변수를 제외하고 나머지 다 라는 의미이다. 
summary(fit)

# income, prost는 영향을 너무 안미친다. 0.05가 넘기에 


# 서로 관련 없는것끼리 묶여있어야 하는게 중요하다 다중공선성? 그걸 걸러내는것도 중요
# 다중공선성 (Multicolinearity) 
# VIF : 다중공선성을 측정하는 지수  : 분산 팽창 지수 

# vif는 루트를 많이 씌워서 계산한다 root(vif)가 일반적으로 2보다 크다면 다중공선성에 문제가 있다고 판단. 

install.packages("car")
library(car)

sqrt(vif(fit))
# 2를 넘어가는 값이 있나? 없다. 다행히 다중공선성에는 문제가 없다. 



# 그다음 살펴봐야할게 이상치이다. 
# 이상하다고 무조건 빼면 안된다. 주요한 값이 이상치로 인식될 수 있기 때문이다. 

# 이상치 종류
# - 일반이상치 : 표준편차 2배이상 크거나 작은값 

# - 큰 지레점(high leverage points) : (절편을 포함한 인수들의 숫자 / 전체 개수) 이 값이 2~3배 이상 되는 관측치
#    그래서 states에서 쓴 데이터에서는 분모는 총 50개, 분자는 인자4개(인구,빙결, 수입, 병?)+절편(Murder)1개 총 5개그래서 5/50
#    0.1이다. 

# - 영향 관측치(Cook's Distance) : (독립변수의 수/ (샘플수-독립변수개수-1)) 의 값보다 큰 값들이 이상치가 된다. 
#   4/(50-4-1) = 0.1정도 나온다. 이 값보다 큰 값들은 이상치 

# 모든 데이터를 비교해서 찾아야할순 없잖아요. 
# 다행히 동시에 시각적으로 보여주는 그래프가 있다. 



par(mfrow=c(1,1))
influencePlot(fit, id=list(method="identify"))  #car 패키지에 있는 함수 
# id : 여러 옵션을 주는것?

# 결과 : 콘솔에 stop이 떠있는데 계속 동작을 하고 있는 중이라는 것, 그래프 위쪽에도 finish도 떠있음

# 일반이상치 :결과에서 y축에 2 이상 넘어가고 -2넘어가는 것들은 이상치라고 생각한다. (y축)

# 큰지레점 : 0.1 의 두배이상 즉 0.2이상을 이상치로 생각한다. (x축)

# 영향관측치 : 원의 크기가 영향관측치이다. 큰게 이상치 


# 그래프 위에 locator active 상태이다  이상태일때 이상치들을 클릭하고 finish를 누른다. 
# 그러면 새로운 결과가 뜨는데 이상치들의 지역이 뜬다. 

###### 회귀모형의 교정##############
### 정규분포에 대한 교정

par(mfrow=c(2,2))
plot(fit)

# 별 특별한 모양없네
# 정규분포도 적당하고
# 등분산선 만족
# 이상치 뭐 문제없어보이는데..

# 얜 너무 완벽하네? 

plot(fit)

powerTransform(states$Murder) #이 함수는 
# murder에는 0.60 승 하라는 뜻 
# 람다? 뭔가 값을 입력받을때 (y^람다)  즉 y^0.6을 해주는게 좋다는 것
# 근데 -2 -1, -0.5, 0, 0.5, 1, 2 이런 깔끔한 값을 넣으므로 0.6할바엔 0.5를 해주는게 좋다. 

# 뭔소리야.. 
summary(powerTransform(states$Murder))
# lambda값이 나오네 - 
# 이건 또 뭐야 lambda = (1)일경우 0.14512가 되는데 사실상 의미가없다.? p-value가 0.05 이상나왔기 때문 

# 아 정규분포가 아닐 때 transform으로 추천받은 값을 
# fit <- lm(Murder^0.6 ~ ., data=states) 이거 할 때 넣어줘서 정규분포로 만들어 줄 수 있다.



### 선형성 교정
# x, y축 둘 중 하나로 하는건 매한가지
# car 패키지에 또 있다.
# boxTidwell() 함수가 제한해주는 함수


# 직선으로 먼저 맞춰보고 곡선으로 맞출지를 정해야한다.
# 직선 맞추기
# 4가지 변수중 population, Illiteracy가 가장 관련 있었던 변수였다.
# 이 두개로 한번 해보도록 하겠음

# 먼저 확인
boxTidwell(Murder ~ Population + Illiteracy, data=states)
# 둘다 p-value가 0.05보다 크기 때문에 의미가 없다. (그래서 할필요가 없어)
# 만약에 만약임 0.05가 안됐을 때는 x값에 lambda값 을 제곱해주라는 것 (x^lambda)
# 그래서 Murder ~ Population^0.8693 + Illiteracy^1.35812, data=states

# 다만 절대적이 아니고 그냥 방안중 하나 / 그래서 안되더라도 실망할 필요가 없다.


####### 등분산 교정
# 마지막으로 등분산성을 만족하지 못했을 때 

# car 패키지에 있다.
# ncvTest() 함수 사용 -> 등분산 교정을 해야할지 말아야할지 판단 

ncvTest(fit)
# Chisquare : 차이제곱
# df : 차수 
# p : 0.18 0.05보다 훨씬 크므로 할 필요가 없다는 것을 확인

# 근데 만약에 p-value가 0.05보다 작아졌다면???

# spreadLevelPlot(fit) 이 함수를 사용한다.  회귀분석 결과를 넘겨준다

spreadLevelPlot(fit)
# 결과에 transformation : 1.2096.. 이 값을 y값(종속변수)에 제곱하라는 것 2와 가까우면 그냥 제곱해버리고 



### 회귀분석 모형의 선택 : Backward stepwise Regression, Forward stepwise Regression

# states에서 변수 4개 다 할 때랑,  관련없는거 두개(income, frost)를 빼고 살펴보자

fit1 <- lm(Murder ~ ., data=states)
summary(fit1)
# p-value값으로 보면 income과, frost는 영향이 없다.
# R-squared는 52% (0.5285)

fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(fit2)
# R계수 (설명력) : 다중에서는 Adjusted(보정된)를 봐야함  54% (0.5484)
# f값도 14였는데 30으로 높아졌고
# 연관성(*모양) 도 늘어났다.
# 그러므로 회귀분석 돌릴 때 쓸데없는거 빼고 하자 


fit3 <- lm(Murder ~ Income + Frost, data=states)
summary(fit3)  

# 관련없는거 두개를 했더니 진짜 관련 드릅게 없게 나온다 
# p-value가 0.05보다 작아서 엄청 쓰잘데기 없다는 뜻


# 근데! 변수가 몇개 안되는데 이렇게 하기가 너무 불편하기 때문에 
# 한번에 측정하는 측정 지수가 있다.
# 어떤 모형을 선택하는것이 좋은가.

# AIC(Akaite's An Information Criterion) -> 이걸 이용하면 한번에 수치가 나와서 선택하기 좋다 .
?AIC()

#Usage
#AIC(object, ..., k = 2)
#BIC(object, ...)

AIC(fit1, fit2, fit3)
# 여러 모델 중 AIC값이 작은게 좋다
# 그래서 fit2가 좋은거 

# 근데 이것도 fit1, fit2, fit3 일일이 만들기에는 컬럼이 많아지면 불편한데... 자동으로 안되나?
# 네 됩니다. -> 아까 첨에 적어놨던 stepwise Regression

# backward랑 forward랑 두가지 방법이 있다. 
# backward : 전체부터 하나씩 빼면서 찾는것
# forward : 반대로 하나부터 증가시키면서 찾는것

### Backward stepwise Regression 
# 우선 변수생성
full.model <- lm(Murder ~ ., data=states)  # 처음엔 4개변수 다 가져오는걸로 시작

reduced.model <- step(full.model, direction = "backward", trace=0)
reduced.model
# direction : 방향 
# trace : 0으로 하면 과정없이 결론만 보여줌, 1은 보여줌. (변수가 엄청 많아진다면 0으로 하자)
# 오 결과.. 


### Foward stepwise Regression
min.model <- lm(Murder ~ 1, data=states)  # 처음엔 최소변수로만 시작
fwd.model <- step(min.model, direction="forward", scope=(Murder ~ Population + Illiteracy + Income + Frost), trace=1)  
# scope : 얘는 변수를 모르기 때문에 추가할 변수이름을 줘야한다
# forward는 가장 좋은 성능을 우선적으로 뽑으면서 추가한다. 


# Backward를 걍 써라 근데 상황에 따라 조금 forward를 써야 안정적일 경우가 있으므로 생각을 해봐라 



# backward를 쓸 때 감소하다가 굴곡이 생기면 거기서 멈추고 나머진 기회를 잃는다.
# 근데 기회 잃은 놈들이 성능이 더 좋아버릴 수도 있잖아?
# 이 단점을 보완하기 위해

# all subset Regression(모두 다 해보는것)을 사용한다.
install.packages("leaps")
library(leaps)


le <- regsubsets(Murder ~ Population + Illiteracy + Income + Frost, data=states, nbest = 4)  #종속변수, 원인변수를 넘겨준다
le
# nbest : 몇개 선택할건지 

# 얘는 그래프를 그려야 뭔가 나옴
par(mfrow=c(1,1))
plot(le, scale="adjr2")




#결과를 보면 가로로 한줄이 조합결과이다

# 맨밑에 0.033인 경우는 income만일 때
# 두번째 줄은 population만일때
# 세번째 줄은 Frost만 일때
# 네번째 줄은 population, income, frost일 경우
# 이런식으로 쭉 했을 때 맨 위값은 population과 illteracy이다 



##################################################################################################################
# 개꿀 로지스틱 회귀분석 

# 그동안의 회귀분석은 입력값이 있으면 뭔가 그에 해당하는 값이 나왔는데
# 1시간 공부했을 때 시험 합격(P), 실패(F) 가 있다면 이것도 회귀분석이 되는건가?? 

# 이럴경우는 직선이 곡선이 되어야 가능하므로  e^wx+b의 형태가 되어야 가능하다 
# 시그모이드 함수 (logistic 회귀분석)
# 딥러닝에 아주 중요한 파트 

# 로지스틱 회귀분석도 수많은 회귀분석 중 하나이다. 


# 샘플 데이터 사용
library(survival) 
str(colon)  # 의약 샘플   
#status  1은 현재 발병, 0은 노 발병
#extent 전이 여부 
#surg   수술 여부

head(colon) #데이터 1800개 올.. 개쩜
#전처리 
table(is.na(colon))
# NA값이 82개나 있네

colon1 <- na.omit(colon)
#결측치 다 삭제후 새로 담기 


result <- glm(status ~ rx + sex + age + obstruct + perfor + adhere +nodes + differ + extent +surg,
        family = binomial, data=colon1)  
#일반적이라는 general을 붙인 glm / 인자는 똑같다 종속변수, 원인변수
# family 

summary(result)
#결과 별 세개짜리는 rx, nodes, extent, surg  이것들이 연관있는 놈들이다.


# 요놈도 회귀분석이니까 stepwise를 쓸 수 있다. 
# Backward
full.model <- lm(status ~ rx + sex + age + obstruct + perfor + adhere +nodes + differ + extent +surg, data=colon1)  # 처음엔 4개변수 다 가져오는걸로 시작

reduced.model <- step(full.model, direction = "backward", trace=1)
reduced.model

#rx + obstruct + adhere + nodes + extent + surg  
# 뭐야 쌤은 AIC 2246인데 왜 나는 2655야


library(moonBook)

extractOR(reduced.model)
#Odds Ratio의 약자이다. 
#OR VS 상대 위험도  뭘 선택하냐는 분석하는 사람 맘
# 뭘 쓰던 상관은 없는데 비율을 구하는 공식이 다름
# odds : 발생한 사건안에서 상대위험도(사건발생률)
# 상대위험도 : 전체에서 사건 발생 

#lcl 하한값
#ucl 상한값
#p-val 0.05 이상이면 관련이 약함 


#####과산포(Overdispersion)
# 위에 family옵션이 과산포와 연관있다
# 과산포가 없다? : binomial
# 과산포가 있다? : quasibinomial

# 그럼 과산포가 있는지 없는지 어떻게 확인하나??? 
# pchisq() 이 함수 사용하면 가능 

# 근데 binomial, quasibinomial 둘다 실행시켜서 p가 0.05보다 큰걸 .......???????????????

#binomial로 할때
fit1 <- glm(status ~ rx + sex + age + obstruct + perfor + adhere +nodes + differ + extent +surg,
    family = binomial, data=colon1)

# quasibinomial로 할때
fit2 <- glm(status ~ rx + sex + age + obstruct + perfor + adhere +nodes + differ + extent +surg,
            family = quasibinomial, data=colon1)



#마지막의 deviance, 등 뭐라는거야

pchisq(summary(fit2)$dispersion * fit1$df.residual, fit1$df.residual, lower=F)  
# fit2의 summary 결과중 dispersion  결과만 뽑아오기 * fit1의 df에 잔차값 
# 잔차값만 따로 
# lower : 설명안해주심


# 결과를 보면 0.25 .....쌤은 왜 0.28이야.. 
# 뭐.. 0.05보다 크므로 과산포가 없다가 결론

# 일반에선 과산포가 제일 중요


summary(fit1)


##### 시각화를 합시다 시각화 
?ORplot()

ORplot(fit1)  #인자로 그냥 만든 fit을 쓰기만 하면 된다
#binomial이 맞았으니 자신있게 fit1을 쓰자 . 

#결과 
#1에 걸려있으면 관련이 없다. 
#1과 멀어질수록 관련이 크다.  봐라 extent랑 rx가 별 세개다. 뭐 다른것도 세개가 있긴한데...


ORplot(fit1, main="Plot for Odds Ratios") # 제목
ORplot(fit1, main="Plot for Odds Ratios", type=2) 
ORplot(fit1, main="Plot for Odds Ratios", type=3)  # type : 그래프 스타일이 달라진다.  (1~4)
ORplot(fit1, main="Plot for Odds Ratios", type=2, show.OR = F) #show.OR : Odds Rate를 보여줄까 말까 (F :안보여줌)
ORplot(fit1, main="Plot for Odds Ratios", type=2, show.OR = F, show.CI = T) # show.CI : 오른쪽에 값을 뿌릴건지
ORplot(fit1, main="Plot for Odds Ratios", type=2, show.OR = F, show.CI = T, pch=15) # pch : 점의 모양
