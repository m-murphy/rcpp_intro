####### Install packages used

install.packages(c("Rcpp", "RcppArmadillo", "rbenchmarks", "microbenchmark"))

#######  Compiler test

library("Rcpp")
evalCpp("2 + 2")

#######  R definition of is_odd 

is_odd_r <- function(num = 10L) {
  result <- (num %% 2L == 1L)
  return(result)
}

#######  Inline C++ definition of is_odd

library("Rcpp")
cppFunction("
            bool is_odd_cpp(int num = 10) {
            bool result = (num % 2 == 1);
            return result;
            }")
is_odd_cpp(42L)

#######  Perform benchmark of the two different methods

library("microbenchmark")

results <- microbenchmark(is_odd_r   = is_odd_r(12L),
                          is_odd_cpp = is_odd_cpp(12L))
results


#######  Random number generation in R and Rcpp

library("Rcpp")
evalCpp("R::rnorm(0, 1)")

set.seed(123)
evalCpp("R::rnorm(0, 1)")

set.seed(123)
# Implicit mean of 0, sd of 1
rnorm(1)

set.seed(123)
evalCpp("Rcpp::rnorm(3)")

set.seed(123)
rnorm(3)


#######  External source of convolve_cpp using sourceCpp
library("Rcpp")
sourceCpp("convolve_cpp.cpp")

####### Bootstrap R code

# Function declaration
bootstrap_r <- function(ds, B = 1000) {
  
  # Preallocate storage for statistics
  boot_stat <- matrix(NA, nrow = B, ncol = 2)
  
  # Number of observations
  n <- length(ds)
  
  # Perform bootstrap 
  for(i in seq_len(B)) {
    # Sample initial data
    gen_data <- ds[ sample(n, n, replace=TRUE) ]
    # Calculate sample data mean and SD
    boot_stat[i,] <- c(mean(gen_data),
                       sd(gen_data))
  }
  
  # Return bootstrap result
  return(boot_stat)
}

# Set seed to generate data
set.seed(512)
# Generate data
initdata <- rnorm(1000, mean = 21, sd = 10)
# Set a new _different_ seed for bootstrapping
set.seed(883)
# Perform bootstrap
result_r <- bootstrap_r(initdata)

# Generate graphs
make_boot_graph <- function(ds, actual, type, ylim){
  hist(ds, main = paste(type, "Bootstrap"), xlab = "Samples",
       col = "lightblue", lwd = 2, prob = TRUE, ylim = ylim, 
       cex.axis = .85, cex.lab = .90)
  abline(v = actual, col = "orange2", lwd = 2)
  lines(density(ds))
}

par(mfrow=c(1,2))
make_boot_graph(result_r[,1], 21, "Mean", c(0, 1.23))
make_boot_graph(result_r[,2], 10, "SD", c(0, 1.85))

####### Bootstrap C++ code
library("Rcpp")
sourceCpp("bootstrap_cpp.cpp")

# Use the same seed use in R bootstrap for C++ bootstrap
set.seed(883)
# Perform bootstrap with C++ function
result_cpp <- bootstrap_cpp(initdata)

# Compare output
all.equal(result_r, result_cpp)

library(rbenchmark)

benchmark(r = bootstrap_r(initdata), cpp = bootstrap_cpp(initdata))[, 1:4]

#######  External source of rmvnorm using sourceCpp
library("Rcpp")
sourceCpp("rmvnorm.cpp")

#######  External source of fastLM using sourceCpp
library("Rcpp")
sourceCpp("fastLM.cpp")


####### Package Skeleton

library("Rcpp")
Rcpp.package.skeleton("samplePkg")
