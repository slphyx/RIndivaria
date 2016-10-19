#Function called when loading the package with 'library'.
#crafted for indivaria by slphyx
.onLoad <- function(libname='~/R', pkgname='indivaria') {
     libLocation<-system.file(package=pkgname)
     if(R.version$arch=='x86_64'){
       arch<-'x64'
     }else{
       arch<-'i386'
     }
     libpath <- file.path(libLocation, paste0('libs/',arch))
     loadAssembly <- function(fn) {
         f <- file.path(libpath, fn)
         if( !file.exists(f) ) {
             packageStartupMessage(paste0('Sorry, I could not find path to ',fn,'. You will have to load it manually.'))
           } else {
               rClr::clrLoadAssembly(f)
             }
     }
     #load the main dll files
     loadAssembly('TreatWithArtesunate.dll')
     loadAssembly('Parasites.dll')
     loadAssembly('AntimalarialDrug.dll')
  }
