# Analyzing-Customer-Churn-2

#### Parametric Survival Analysis: Cox Proportional Hazards Model



### 	Creating a regression model that predicts how changes in the independent variables multiply (or divide) the average churn rate.

## Abstract

Last work, we discussed using Kaplan-Meier estimators, survival curves, and the log-rank test to start analyzing customer churn data. We plotted survival curves for a customer base, then bifurcated them by gender, and confirmed that the difference between the gender curves was statistically significant. Of course, these methods can only get us so far. This paper we will predict churn using multiple variables.

## Introduction

NetLixx, a fictional company that sells monthly access to a library of guitar tabs for popular songs. Since we need to be doing regression across multiple variables, we’ll use a slightly more complicated data set than we used last work. This time, the data will incorporate a user’s gender, their age, and whether or not they signed up with a “first month free” coupon. And, just like last work, we’ll know whether or not they’ve already churned, as well as a follow-up time (start date minus churn date for churners, start date minus today’s date for non-churners).

## Approach

Instead of just bifurcating some data and looking for differences, we will use cox proportional hazards model to create a best-fit model that predicts a dependent variable’s value based on numerous explanatory variables.
Method

We applied a survival analysis technique using parametric model. We used coxph fit function in R-studio, then we run a cox regression of survival on female, age, and coupon status, and we summarized the survival fit, the following is the result:


 

First of all, we can see that the coefficient for the female variable is not statistically significant. (If this was a real analysis, we’d probably remove it and run the model again, but this is an illustrative example with fake data…) But the other two variables did produce significant results! 
In order to interpret the coefficients in general the positive coefficient means that as the independent variable increases the time-to-event decreases, (lower duration or more likely for the event to happen).

Thus, the result shows that the coupon users are more likely to churn. Unlike the older and female customers are less likely to churn.
Also, in order to interpret magnitude of the effects, we’re most interested in that exp(coef) column. This gives us the multiplicative relationship between the two hazard (churn) rates.

##### In general interpretation of hazard rates is a hazard ratio of 2(0.5) means that for a one unit increase in the x variable, the     hazard rate (probability of event happening) increases by 100% (decreases by 50%). A hazard rate of greater than 1 means that it is more likely for the event to happen.

Thus, the result shows that one increase in the age variable, the churn rate decreases by 99.4%, and for one unite increase in coupon variable the probability of churn increases by 80 %.
That means coupon users churn 1.8 times faster (or 80% faster) than the baseline survival rate. And a 1-year increase in customer age multiplies the hazard rate by .994, or 99.4%. So, we get a slight reduction in churn for every additional year of a customer’s age. 

## Testing for non-proportional hazards

Cox regression is built on some assumptions and, if the data violates those assumptions, the statistics will be all wrong. And, unfortunately, cox regression comes with one particularly big assumption – proportional hazards.

##### What does “proportional hazards” mean? Proportional Hazards Models are Statistical models used in survival analysis, that assert that the effect of the study factors on the hazard rate in the study, population is multiplicative and does not change over time.

In our case, we said “coupon users churn 1.8 times faster than non-coupon users”, that means cox regression assumes that all relationships are multiplicative throughout time. In other words, the model assumes the churn rate for coupon users is always 1.8 times higher than non-coupon users.
In order to test the whole model, we used cox.zph function, the following is the result:

 

From the output above, the test is not statistically significant for each of the female and age, but the coupon and the global test is a statistically significant. Therefore, we can NOT assume the proportional hazards.
If we want to make sure we have useful statistics, we’re going to have to remove the coupon variable from the model.


## Conclusion

We have completed a cox regression analysis, the results as follow:
As people get older, they churn less. And there doesn’t seem to be a relationship between gender and churn. Also, our investigation into the non-proportionality of the coupon variable told us that coupon users tend to leave quickly in the first month, but they’re pretty much normal users after that.


