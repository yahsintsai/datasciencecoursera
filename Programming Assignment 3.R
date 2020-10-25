#setwd("/Users/yahsintsai/Downloads/Hospital Quality")

## 1 Plot the 30-day mortality rates for heart attack
outcome <- read.csv("outcome-of-care-measures.csv")
names(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

## 2 Finding the best hospital in a state
best <- function(state, outcome){
  ## Read outcome data
  dat <- read.csv("outcome-of-care-measures.csv")
  ## Check that state and outcome are valid
  diseases <- c("heart attack",  "heart failure", "pneumonia")
  if (!(state %in% unique(dat$State))){
    stop("invalid state")
  } else if (!(outcome %in% diseases)) {
    stop("invalid outcome")
  } else {
    options(warn = -1)
    df <- dat[, c(2, 7, 11, 17, 23)]
    df[ ,3:5] <- as.numeric(unlist(df[ ,3:5]))
    tmp <- df[df$State==state, ]
    d <- which(diseases==outcome) + 2 #match d to index
    tmp <- tmp[!is.na(tmp[, d]), ]
    tmp[tmp[, d]==min(tmp[, d]), ][[1]]
  }
}
best("AK", "pneumonia")

## 3 Ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  dat <- read.csv("outcome-of-care-measures.csv")
  ## Check that state and outcome are valid
  diseases <- c("heart attack",  "heart failure", "pneumonia")
  if (!(state %in% unique(dat$State))){
    stop("invalid state")
  } else if (!(outcome %in% diseases)) {
    stop("invalid outcome")
  } else {
    ## Return hospital name in that state with the given rank 30-day death rate
    options(warn = -1)
    df <- dat[, c(2, 7, 11, 17, 23)]
    df[ ,3:5] <- as.numeric(unlist(df[ ,3:5]))
    tmp <- df[df$State==state, ]
    d <- which(diseases==outcome) + 2 #match d to index
    tmp <- tmp[!is.na(tmp[, d]), ] #remove na
    ordered <- tmp[order(tmp[, d], tmp[, 1]), ] #order
    #address num
    if (num=="best"){
      ordered[[1]][1]
    } else if (num=="worst"){
      ordered[[1]][nrow(ordered)]
    } else if (num>nrow(ordered)){
      return(NA)
    } else{
      ordered[[1]][num]
    }
  }
}
rankhospital("TX", "heart failure", 4)

## 4 Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  dat <- read.csv("outcome-of-care-measures.csv")
  ## Check that state and outcome are valid
  diseases <- c("heart attack",  "heart failure", "pneumonia")
  if (!(outcome %in% diseases)) {
    stop("invalid outcome")
  } else {
    options(warn = -1)
    df <- dat[, c(2, 7, 11, 17, 23)]
    df[ ,3:5] <- as.numeric(unlist(df[ ,3:5]))
    d <- which(diseases==outcome) + 2 #match d to index
    tmp <- df[!is.na(df[, d]), ] #remove na
    ## For each state, find the hospital of the given rank
    st <- c(unique(tmp[, 2])); n <- length(unique(tmp[, 2]))
    hospital <- c()
    for (i in 1:n){
      sub <- tmp[tmp[,2]==st[i], ] #in each state
      sub <- sub[order(sub[,d], sub[,1]), ] #reorder with rank and alphabetic order
      if (num=="best"){ #deal with num
        hospital[i] <- sub[1, 1]
      } else if (num=="worst"){
        hospital[i] <- sub[nrow(sub), 1]
      } else if (num>nrow(sub)){
        hospital[i] <- NA
      } else{
        hospital[i] <- sub[num, 1]
      }
    }
    ## Return a data frame with the hospital names and the (abbreviated) state name
    output <- cbind(hospital, st)
    output <- output[order(output[, 2]), ]
    output
  }
}
rankall("heart failure", 10)
