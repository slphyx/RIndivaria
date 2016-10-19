###################################################################################################################
# White NJ, Chapman D, & Watt G (1992)
# The effects of multiplication and synchronicity on the vascular distribution of parasites in falciparum malaria.
# Trans R Soc Trop Med Hyg 86(6):590-597.
###################################################################################################################

Model.NJW1992 <- function(initn0, mu, sigma, pmf, runtime, outform=0, maxob=26){
# public static Matrix<double> NJW1992(double initN0, double mu, double sigma, double pmf, int maxobserve, int RunMax, int outform)
#
  obj<-clrCallStatic("Parasites.Models","NJW1992",as.double(initn0),as.double(mu),as.double(sigma),
                     as.double(pmf),as.integer(maxob),as.integer(runtime),as.integer(outform))

  outobj<-clrGet(obj,"Values")
  if(outform==0){
  outdata <- matrix(outobj,ncol=3)
  colnames(outdata)<-c("observed time","circulating parasites","log10(circulating parasites)")
  }else if(outform==1){
    outdata <- matrix(outobj,ncol=48)
  }else if(!(outform%in%c(0,1))){
    stop("Please check your 'outform'. It should be 0 or 1.")
  }

  return(outdata)
}
