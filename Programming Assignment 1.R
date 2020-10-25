pollutantmean <- function(directory, pollutant, id=1:332){
  setwd(paste("/Users/yahsintsai/Downloads/", directory, sep="")) #set path
  #vals <- c(); n <- c() #initialize
  for (i in length(id)){ #scanin csvs
    if (id[i]<10){
      tmp <- read.csv(paste("00", id[i], ".csv", sep=""))
    }
    else if (id[i]>=10 & id[i]<100){
      tmp <- read.csv(paste("0", id[i], ".csv", sep=""))
    }
    else{
      tmp <- read.csv(paste(id[i], ".csv", sep=""))
    }
    cleaned <- tmp[!is.na(tmp[pollutant]), ] #remove NAs
    vals <- sum(cleaned[pollutant]) #sum of all values
    n <- nrow(cleaned[pollutant]) #number of values
  }
  return (c(vals, n))
}
upper <- 0; lower <- 0
for (i in 1:332){
  upper <- upper + pollutantmean("specdata", "nitrate", i)[1]
  lower <- lower + pollutantmean("specdata", "nitrate", i)[2]
}
lower

#how to move to the next item?
################################################################
complete <- function(directory, id=1:332){
  setwd(paste("/Users/yahsintsai/Downloads/", directory, sep="")) #set path
  nobs <- c() #initialize
  for (i in length(id)){ #scanin csvs
    if (id[i]<10){
      tmp <- read.csv(paste("00", id[i], ".csv", sep=""))
    }
    else if (id[i]>=10 & id[i]<100){
      tmp <- read.csv(paste("0", id[i], ".csv", sep=""))
    }
    else{
      tmp <- read.csv(paste(id[i], ".csv", sep=""))
    }
    tmp <- tmp[complete.cases(tmp), ]
    nobs[i] <- nrow(tmp)
  }
  data.frame(id, nobs)
}
complete("specdata",  10)
#how to move to the next item?

RNGversion("3.5.1")  
set.seed(42)
use <- sample(332, 10)
use
for (i in 1:10){
  print(complete("specdata",  333-use[i])$nobs)
}

################################################################
corr <- function(directory, threshold=0){
  setwd(paste("/Users/yahsintsai/Downloads/", directory, sep="")) #set path
  corr_each <- c() #initialize
  for (i in 1:332){ #scanin csvs
    if (i<10){
      tmp <- read.csv(paste("00", i, ".csv", sep=""))
    }
    else if (i>=10 & i<100){
      tmp <- read.csv(paste("0", i, ".csv", sep=""))
    }
    else{
      tmp <- read.csv(paste(i, ".csv", sep=""))
    }
    tmp <- tmp[complete.cases(tmp), 2:3]
    if (nrow(tmp)>threshold){
      corr_each[i] <- cor(tmp$sulfate, tmp$nitrate)
    }
  }
  corr_each[complete.cases(corr_each)]
}

cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)
