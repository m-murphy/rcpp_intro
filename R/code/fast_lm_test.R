X = matrix(c(rep(1, 300), runif(300, 0, 50)), nrow = 300)
y = 5 + 3 * X[,2] + rnorm(300, 0, 5)

results <- microbenchmark(
  lm_r = lm.fit(X, y),
  lm_cpp = fastLm(X, y)
)

results
