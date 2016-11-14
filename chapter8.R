### load data ###
source('prepare data.R')
### Libraries, settings ###
require(nlme)
require(multcomp)
lCtr <- lmeControl(opt = "optim", msMaxIter = 500, gradHess = F)

### first models ###
f1 <- lme(symptoms ~ women + age80 + women*age80, random = ~1|PersonID, data = fdata, method = "ML", control = lCtr)
-2*logLik(f1)
f2 <- lme(mood ~ 1, random = ~1|PersonID, data = fdata, method = "ML", control = lCtr)
-2*logLik(f2)
f3 <- lme(symptoms ~ women + age80 + PMmood2 + WPmood + women*age80, random = ~1|PersonID, data = fdata, method = "ML", control = lCtr, na.action = na.omit, contrasts = )
summary(f3)

### Linear combinations ###
lk <- c(0, 0, 0, 1, 0, 0)
k <- matrix(c(0, 0, 0, 1, -1, 0), 1)
t <- glht(f3, linfct = k)
t$linfct
summary(t)











