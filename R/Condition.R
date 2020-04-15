#' @title Dependency Condition
#'
#' @usage NULL
#' @format [R6::R6Class] object.
#'
#' @description
#' Condition object, to specify the condition in a dependency.
#'
#' @section Construction:
#' ```
#' c = Condition$new(type, rhs)
#' ```
#'
#' * `type` :: `character(1)` \cr
#'   Name / type of the condition.
#'
#' * `rhs::any` \cr
#'   Right-hand-side of the condition.
#'
#' @section Methods:
#'
#' * `test(function(x))`\cr
#'   `??? -> logical(n)` \cr
#'   Checks if condition is satisfied.
#'   Called on a vector of parent param values.
#'
#' @section Currently implemented simple conditions:
#' * `CondEqual$new(rhs)` \cr
#'   Parent must be equal to `rhs`.
#' * `CondAnyOf$new(rhs)` \cr
#'   Parent must be any value of `rhs`.
#'
#' @aliases CondEqual CondAnyOf
#' @export
Condition = R6Class("Condition",
  public = list(
    type = NULL,
    rhs = NULL,
    initialize = function(type, rhs) {
      self$type = assert_string(type)
      self$rhs = rhs
    },

    test = function(x) stop("abstract"),

    as_string = function(lhs_chr = "x") {
      sprintf("%s %s %s", lhs_chr, self$type, str_collapse(self$rhs))
    },

    print = function(...) {
      catf("%s: %s", class(self)[1L], self$as_string())
    }
  ),
)

#' @export
CondEqual = R6Class("CondEqual", inherit = Condition,
  public = list(
    initialize = function(rhs) super$initialize("equal", rhs),
    test = function(x) !is.na(x) & x == self$rhs,
    as_string = function(lhs_chr = "x") sprintf("%s = %s", lhs_chr, as.character(self$rhs))
  )
)

#' @export
CondAnyOf = R6Class("CondAnyOf", inherit = Condition,
  public = list(
    initialize = function(rhs) super$initialize("anyof", rhs),
    test = function(x) !is.na(x) & x %in% self$rhs,
    as_string = function(lhs_chr = "x") sprintf("%s \u2208 {%s}", lhs_chr, str_collapse(self$rhs))
  )
)