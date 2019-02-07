library("Rcpp")

cppFunction("
            bool is_odd_cpp(int num = 10) {
              bool result = (num % 2 == 1);
              return result;
            }
            ")

is_odd_cpp(42L)
