# Load the survival library

library(survival)

# Read in the data and create a "survival object"

mydata <- read.csv('C:/Users/tahan/OneDrive/Desktop/Customer Churn/NetLixxCox.csv')
summary(mydata)
str(mydata)
attach(mydata)


# Run a cox regression of survival on female, age, and coupon status

mydata$survival <- Surv(followtime,churn==1) 
fit <- coxph(Surv(followtime,churn==1)~female+age+coupon,data = mydata)

# View the results!
fit
summary(fit)

fit2<- survfit(survival~coupon, data = mydata)
plot(fit2, ylim= c(.55,1),col = c("red","blue"))
legend("topright",c("NoCoupon","YesCoupon"),lty= 1,col = c("red","blue"))

# Run a test for non-proportional hazards on our cox regression results
testFit<- cox.zph(fit)
testFit



