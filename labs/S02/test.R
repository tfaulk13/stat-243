library(testthat)

# load the source code of the functions to be tested
source('~/Documents/Github/stat-243/labs/S02/functions.R')

# context with one test that groups expectations
context('Tests for Standardize')


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
