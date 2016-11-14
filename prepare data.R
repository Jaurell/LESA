fdata <- read.csv("C:/Users/jonaur/Desktop/DATA/lesa.csv", fileEncoding="UTF-8-BOM")

#############center
sfdata <- split(fdata, fdata['PersonID'])
vars <- c('women','baseage','mood','stressor')

for (var in vars){
  wp_var <- sprintf('WP%s',var)
  PM_var <- sprintf('PM%s',var)
  for (x in names(sfdata)){
    sfdata[[x]][PM_var] <- colMeans(sfdata[[x]][var], na.rm = T)
    sfdata[[x]][wp_var] <- scale(sfdata[[x]][var], scale = F, center = T)
  }
}

fdata <- do.call("rbind", sfdata)
fdata['age80']  <- fdata$baseage - 80
fdata['mood2']  <- fdata$mood - 2
fdata['PMmood2'] <- fdata$PMmood -2
fdata['PMstressor40'] <-  fdata$PMstressor -.40
##############
fdata <- fdata[complete.cases(fdata[c('women','baseage','symptoms','mood','stressor')]) & fdata$studyday <15,]
