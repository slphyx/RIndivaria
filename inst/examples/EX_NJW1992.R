
ext<-function(n=10000){
  system.time(
  for(i in 1:n)
    Model.NJW1992(initn0 = 10^10, mu=16, sigma = 6, pmf = 10,runtime = 240)
  )
}

ext()

library(rClr)
library(indivaria)
library(doParallel)

cl<-makeCluster(6)
registerDoParallel(cl)

ext2<-function(n=10000){
  system.time(
  foreach(i=1:n, .packages=c("rClr","indivaria")) %dopar%{
    Model.NJW1992(initn0 = 10^10, mu=16, sigma = 6, pmf = 10,runtime = 240)
  }
  )
}

ext2()

stopCluster(cl)
