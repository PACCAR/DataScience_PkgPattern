
#' Run the classification tree
#'
#' This function will execute a classification tree built with this
#' package on new data.
#'
#' @param model A model object trained with the \code{\link{train_tree}}
#'  function of this package.
#' @param new.data Dataset to be classified using the defined model.
#' @return predict Returns new.data dataset with classes appended
#'  as column "predict"
#' @examples
#'  train.index <- split_data(iris.data, 0.7)
#'  training.data <- iris.data[train.index, ]
#'  test.data <- iris.data[-train.index, ]
#'
#'  obj.func <- formula(Species ~ Sepal.Length + Sepal.Width)
#'  my.model <- train_tree(obj.func, training.data)
#'
#'  predictions <- run_model(my.model, test.data)
#'
#' @export
run_model <- function(model, new.data) {
  new.data$predict <- stats::predict(model, new.data, type = 'class')
  return(new.data)
}





#' Build confusion matrix
#'
#' Build a confusion matrix from actual and predicted class comparisons.
#'
#' @param actual Actual classes list
#' @param predicted Predicted classes list
#' @return confusion.matrix Confusion matrix in table format.
#' @examples
#'  train.index <- split_data(iris.data, 0.7)
#'  training.data <- iris.data[train.index, ]
#'  test.data <- iris.data[-train.index, ]
#'
#'  obj.func <- formula(Species ~ Sepal.Length + Sepal.Width)
#'  my.model <- train_tree(obj.func, training.data)
#'
#'  predictions <- run_model(my.model, test.data)
#'
#'  build_confusion_mat(predictions$Species, predictions$predict)
#'
#' @export
build_confusion_mat <- function(actual, predicted) {
  confusion.matrix <- as.matrix(table(Actual = actual, Predicted = predicted))
  return(confusion.matrix)
}
