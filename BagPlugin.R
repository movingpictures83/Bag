library(AppliedPredictiveModeling)
transparentTheme(trans = .4)
library(caret)
library(mlbench)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(inputfile) {
	pfix = prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
   # Need to get the three files
   trainfile <<- paste(pfix, parameters["train", 2], sep="/")
   numbags <<- as.integer(parameters["numbags", 2])
}

run <- function() {}

output <- function(outputfile) {
	training <- read.csv(trainfile)
baggedCT <- bag(x=training[,names(training)!="Class"], y=as.factor(training$Class), B=numbags, bagControl = bagControl(fit=ctreeBag$fit, predict=ctreeBag$pred, aggregate=ctreeBag$aggregate))
print(summary(baggedCT))
}
