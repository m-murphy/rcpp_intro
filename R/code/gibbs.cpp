#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix gibbs_cpp(int N, int thin) {

  NumericMatrix mat(N, 2);
  double x = 0;
  double y = 0;

  for(int i = 0; i < N; i++) {
    for(int j = 0; j < thin; j++) {
      x = R::rgamma(3.0, 1.0 / (y * y + 4)); // Rcpp::rgamma is the vectorized version, returns a vector
      y = R::rnorm(1.0 / (x + 1), 1.0 / sqrt(2 * x + 2)); // Rcpp::rnorm is the vectorized version, returns a vector
    }

    mat(i, 0) = x;  // Note the difference in Indexing
    mat(i, 1) = y;
  }

  return(mat);
}
