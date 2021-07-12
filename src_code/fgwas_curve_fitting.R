library(fGWAS)
library(tidyverse)
# For AA data

file.phe.long_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_AA.csv"

file.phe.time_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_AA.csv"
file.phe.cov_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_AA.csv"
# Loading phenotype data with the specific curve type and covariance type
obj.phe_AA <- fg.load.phenotype( file.phe.long_AA, file.phe.cov_AA, file.phe.time_AA, curve.type = "Exponential", file.plot.pdf="/ddn/home2/r2725/projects/jeannette/data/curve.fitting_AA.pdf")
# show the curve fitting results 
show(obj.phe_AA$summary.curve$summary) 
# show the covariance selection results 
show(obj.phe_AA$summary.covariance$summary) 
# show summary information of phenotype object 
obj.phe_AA; 
# plot all phenotype traits and fitted curve in one PDF figure 
plot(obj.phe_AA, file.pdf="/ddn/home2/r2725/projects/jeannette/data/plot.curve.fitting_AA.pdf")

# For EA data

file.phe.long_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_EA.csv"
file.phe.time_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_EA.csv"
file.phe.cov_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_EA.csv"
# Loading phenotype data with the specific curve type and covariance type
obj.phe_EA <- fg.load.phenotype( file.phe.long_EA, file.phe.cov_EA, file.phe.time_EA,curve.type = "Power", file.plot.pdf="/ddn/home2/r2725/projects/jeannette/data/curve.fitting_EA.pdf")
# show the curve fitting results 
show(obj.phe_EA$summary.curve$summary) 
# show the covariance selection results 
show(obj.phe_EA$summary.covariance$summary) 
# show summary information of phenotype object 
obj.phe_EA
# plot all phenotype traits and fitted curve in one PDF figure 
plot(obj.phe_EA, file.pdf="/ddn/home2/r2725/projects/jeannette/data/plot.curve.fitting_EA.pdf")
