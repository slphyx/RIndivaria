## examples
library(rClr)
library(RIndivaria)

exT <- function(n = 20000) {
  # Purpose: Test if system.time works ok;   n: loop size
  system.time(for(i in 1:n)
    Model.SompobPNAS2011(initn0 = 10, mu = 10, sigma = 6, pmf = 8, concpars = c(1.5,1000,0.5),
                         gamma = c(6.5,6.5,6.5),ec50 = c(20.5,20.5,20.5),
                         emax = c(99,99.99,99.99),Tconst = 2, npoint = 15)
    )
}

exT()

library(doParallel)
cl <- makeCluster(6)
registerDoParallel(cl)

exT2 <- function(n = 20000) {
  # Purpose: Test if system.time works ok;   n: loop size
  system.time(
    foreach(i = 1:n, .packages=c('rClr','RIndivaria')) %dopar% {

    Model.SompobPNAS2011(initn0 = 10, mu = 10, sigma = 6, pmf = 8, concpars = c(1.5,1000,0.5),
                         gamma = c(6.5,6.5,6.5),ec50 = c(20.5,20.5,20.5),
                         emax = c(99,99.99,99.99),Tconst = 2, npoint = 15)
  }
    )
}

exT2()
stopCluster(cl)

out<-Model.SompobPNAS2011(initn0 = 10, mu = 10, sigma = 6, pmf = 8, concpars = c(1.5,1000,0.5),
                    gamma = c(6.5,6.5,6.5),ec50 = c(20.5,20.5,20.5),
                      emax = c(99,99.99,99.99),Tconst = 2, npoint = 15)

out2<-Model.SompobPNAS2011(initn0 = 10, mu = 10, sigma = 6, pmf = 8, concpars = c(1.5,1000,0.5),
                    gamma = c(6.5,6.5,6.5),ec50 = c(20.5,20.5,20.5),
                      emax = c(99,99.99,99.99),Tconst = 2,runmax=120)
