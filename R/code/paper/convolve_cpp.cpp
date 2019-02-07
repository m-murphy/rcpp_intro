#include "Rcpp.h"
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector convolve_cpp(const NumericVector& a,
                           const NumericVector& b) {
  
  // Declare loop counters, vector sizes, and total length
  int i, j,
  na = a.size(), nb = b.size(),
  nab = na + nb;
  
  // Create vector filled with 0
  NumericVector ab(nab);
  
  // Crux of the algorithm
  for(i = 0; i < na; i++) {
    for(j = 0; j < nb; j++) {
      ab[i + j] += a[i] * b[j];
    }
  }
  
  // Return result
  return ab;                                     
}