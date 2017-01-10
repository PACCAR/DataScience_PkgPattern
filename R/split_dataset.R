
#' Splits train and test sets
#'
#' This function will split a dataset into training
#' and test groups. Group membership is defined by a
#' "train.set" index list.
#'
#' @param data Dataset for splitting, data frame.
#' @param split.pct The percentage of data to be used in training set, numeric between 0-1.
#' @return train.set An index of records used in training, numeric list. Remove these
#'  indices for test set.
#' @examples
#'  train.index <- split_data(iris.data, 0.7)
#'  training.data <- iris.data[train.index, ]
#'  test.data <- iris.data[-train.index, ]
#'
#' @export
split_data <- function(data, split.pct) {
  train.set <- sample(1:nrow(data), split.pct * nrow(data))
  return(train.set)
}
