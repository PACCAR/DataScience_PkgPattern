
#' Train a classification tree
#'
#' This function trains a classification decision tree using the
#' \strong{rpart} package.
#'
#' @param objective The objective function for training, of type formula.
#' @param data Training dataset, a dataframe.
#' @return tree.model A classification model.
#'
#' @examples
#'  train.index <- split_data(iris.data, 0.7)
#'  training.data <- iris.data[train.index, ]
#'  test.data <- iris.data[-train.index, ]
#'
#'  obj.func <- formula(Species ~ Sepal.Length + Sepal.Width)
#'  my.model <- train_tree(obj.func, training.data)
#'
#' @export
train_tree <- function(objective, data) {
  tree.model <- rpart::rpart(objective, data, method = 'class')
  return(tree.model)
}
