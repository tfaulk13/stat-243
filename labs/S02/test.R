#' @title Standardize
#' @description Computes z-scores (scores in standard units)
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of standard scores
#' @examples 
#'  a <- runif(5)
#'  z <- standardize(a)
#'  mean(z)
#'  sd(z)
standardize <- function(x, na.rm = FALSE) {
  z <- (x - mean(x, na.rm = na.rm)) / sd(x, na.rm = na.rm)
  return(z)
}

test_that("standardize works with normal input", {
  x <- c(1, 2, 3)
  z <- (x - mean(x)) / sd(x)
  
  expect_length(standardize(x), z)
  expect_equivalent(standardize(x), z)
  expect_type(standardize(x), 'double')
})

test_that("standardize works with missing values", {
  y <- c(1, 2, NA)
  z1 <- (y - mean(y, na.rm = FALSE)) / sd(y, na.rm = FALSE)
  z2 <- (y - mean(y, na.rm = TRUE)) / sd(y, na.rm = TRUE)
  
  expect_equal(standardize(y), z1)
  expect_equal(standardize(y, na.rm = TRUE), z2)
  expect_type(standardize(y), 'double')
})

test_that("standardize handles logical vector", {
  w <- c(TRUE, FALSE, TRUE)
  z <- (w - mean(w)) / sd(w)
  
  expect_equal(standardize(w), z)
  expect_length(standardize(w), length(w))
  expect_type(standardize(w), 'double')
})

