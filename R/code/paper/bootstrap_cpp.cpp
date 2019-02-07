#include <Rcpp.h>

// Function declaration with Rcpp attribute's export tag
// [[Rcpp::export]]
Rcpp::NumericMatrix bootstrap_cpp(Rcpp::NumericVector ds,
                                  int B = 1000) {
  
  // Preallocate storage for statistics
  Rcpp::NumericMatrix boot_stat(B, 2);
  
  // Number of observations
  int n = ds.size();
  
  // Perform bootstrap 
  for(int i = 0; i < B; i++) {
    // Sample initial data 
    Rcpp::NumericVector gen_data = ds[ floor(Rcpp::runif(n, 0, n)) ]; 
    // Calculate sample data mean and standard deviation
    boot_stat(i, 0) = mean(gen_data);             
    boot_stat(i, 1) = sd(gen_data);
  }
  
  // Return bootstrap results
  return boot_stat;
}