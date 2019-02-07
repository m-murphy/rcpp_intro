gibbs_r <- function(N, thin) {

  mat <- matrix(NA, nrow = N, ncol = 2)
  x <- 0
  y <- 0

  for(i in 1:N) {
    j <- 0
    for(j in 1:thin) {
      x <- rgamma(1, 3.0, 1.0 / (y * y + 4));
      y <- rnorm(1, 1.0 / (x + 1), 1.0 / sqrt(2 * x + 2));
    }

    mat[i, 1] <- x; # Note the difference in Indexing
    mat[i, 2] <- y;

  }

  return(mat);
}
