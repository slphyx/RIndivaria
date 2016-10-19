#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

##################################################################################################
# Saralamba et al. Intrahost modeling of artemisinin resistance
#   in Plasmodium falciparum PNAS  397-402,
#   doi: 10.1073/pnas.1006113108
#
# R Version adapted from http://demonstrations.wolfram.com/AModelOfPlasmodiumFalciparumPopulationDynamicsInAPatientDuri/
# by sompob@tropmedres.ac
#
#################################################################################################

Model.SompobPNAS2011 <- function(initn0,mu,sigma,pmf,KZ=c(6,26,27,38,39,44),concpars,everyH=24, ndrug=7,
                           gamma,ec50,emax,Tconst,runmax,outform=0,npoint=NULL,...){

  # (initN0, mu, sd, pmf, KZ double rb,double re,double tb,double te,double sb,double se,
  #                          double xm,double ym,double ke,double everyH,double ndrug,double gammar,
  #            double gammat,double gammas,double ec50r,double ec50t,double ec50s,
  #                          double emaxr,double emaxt,double emaxs,double T,double npoint)

  # read inputs
  if(is.vector(KZ)&&length(KZ)==6){
    rb<-KZ[1]
    re<-KZ[2]
    tb<-KZ[3]
    te<-KZ[4]
    sb<-KZ[5]
    se<-KZ[6]
  }
  else{
    stop("Please check your Kill Zones(KZ). ex c(6,26,27,38,39,44)")
  }

  if(is.vector(gamma) && length(gamma)==3){
    gammar<-gamma[1]
    gammat<-gamma[2]
    gammas<-gamma[3]
  }else{
    stop("Please check the slopes of the EC curves.")
  }


  if(is.vector(ec50)&&length(ec50)==3){
    ec50r<-ec50[1]
    ec50t<-ec50[2]
    ec50s<-ec50[3]
  }else{
    stop("Please check the EC50 vector.")
  }

  if(is.vector(emax)&&length(emax)==3){
    emaxr<-emax[1]
    emaxt<-emax[2]
    emaxs<-emax[3]
  }else{
    stop("Please check the Emax vector.")
  }

  if(is.vector(concpars)&&length(concpars)==3){
    xm<-concpars[1]
    ym<-concpars[2]
    ke<-concpars[3]
  }else{
    stop("Please check the drug concentration vector.")
  }

  ###load dll
  #clrLoadAssembly('TreatWithArtesunate.dll')
  #loaded<-clrGetLoadedAssemblies()
  #print(loaded)

  # if npoint = NULL
    #outform = 0  ---> {time, log10(circulating)}
    #outform = 1 ---> {{agedist at t 0},{age dist at t 1},...}

  # if  npoint != NULL
    # outform   -->  {time, log10(circulating)}
  if(is.null(npoint)){
  clrObj<-clrCallStatic("TreatWithArtesunate.Models","SompobPNAS2011",as.double(10^(initn0)),as.double(mu),
                       as.double(sigma),as.double(pmf),as.double(rb),as.double(re),as.double(tb),
                       as.double(te),as.double(sb),as.double(se),as.double(xm),as.double(ym),as.double(ke),
                       as.double(everyH),as.double(ndrug),as.double(gammar),as.double(gammat),as.double(gammas),
                       as.double(ec50r),as.double(ec50t),as.double(ec50s),
                       as.double(emaxr),as.double(emaxt),as.double(emaxs),as.double(Tconst),as.integer(runmax),as.integer(outform))

  outvec<-clrGet(clrObj,"Values")
    if(outform==0){
      outdata <- matrix(outvec, ncol=2)
      colnames(outdata)<-c("observed time","log10(circulating parasites)")
    }else if(outform==1){
      outdata <- matrix(outvec,ncol=48)
    }

  }else if(!is.null(npoint)){
    clrObj<-clrCallStatic("TreatWithArtesunate.Models","SompobPNAS2011",as.double(10^(initn0)),as.double(mu),
                          as.double(sigma),as.double(pmf),as.double(rb),as.double(re),as.double(tb),
                          as.double(te),as.double(sb),as.double(se),as.double(xm),as.double(ym),as.double(ke),
                          as.double(everyH),as.double(ndrug),as.double(gammar),as.double(gammat),as.double(gammas),
                          as.double(ec50r),as.double(ec50t),as.double(ec50s),
                          as.double(emaxr),as.double(emaxt),as.double(emaxs),as.double(Tconst),as.integer(npoint))


    outvec<-clrGet(clrObj,"Values")
    outdata <- matrix(outvec,ncol=2)
    colnames(outdata)<-c("observed time","log10(circulating parasites)")
  }

  return(outdata)

}



