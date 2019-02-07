results <- microbenchmark(
  gibbs_r   = gibbs_r(100, 1000),
  gibbs_cpp = gibbs_cpp(100, 1000),
  times = 10
)

results
