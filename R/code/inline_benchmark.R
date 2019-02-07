library(microbenchmark)

is_odd_r <- function(num = 10L) {
  result <- (num %% 2L == 1L)
  return(result)
}

results <- microbenchmark(
  is_odd_r   = is_odd_r(12L),
  is_odd_cpp = is_odd_cpp(12L)
)

results
