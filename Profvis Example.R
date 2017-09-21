data <- as.data.frame(
  matrix(rnorm(4e5 * 150, mean = 5), ncol = 150)
)

normCols <- function(d) {
  # Get vector of column means
  means <- apply(d, 2, mean)
  
  # Subtract mean from each column
  for (i in seq_along(means)) {
    d[, i] <- d[, i] - means[i]
  }
  d
}

#--------------------------------------------
#Welcome Profvis

library(profvis)
profvis({
  normCols <- function(d) {
    means <- apply(d, 2, mean)
    
    for (i in seq_along(means)) {
      d[, i] <- d[, i] - means[i]
    }
    d
  }
  
  normCols(data)
})

#-------------------------------------------
#A better way
profvis({
  d <- data
  means <- vapply(d, mean, numeric(1))
  
  for (i in seq_along(means)) {
    d[, i] <- d[, i] - means[i]
  }
})