#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector convolve_cpp(const NumericVector& a,
                           const NumericVector& b) {

  // Declare loop counters, vector sizes, and total length
  int i = 0;
  int j = 0;
  int na = a.size();
  int nb = b.size();
  int nab = na + nb;

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
