% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ParamSet.R
\name{ParamSet}
\alias{ParamSet}
\title{ParamSet}
\description{
A set of \link{Param} objects.
Please note that when creating a set or adding to it, the parameters of the
resulting set have to be uniquely named with IDs with valid R names.
The set also contains a member variable \code{values} which can be used to store an active configuration /
or to partially fix
some parameters to constant values (regarding subsequent sampling or generation of designs).
}
\section{S3 methods and type converters}{

\itemize{
\item \code{as.data.table()}\cr
\link{ParamSet} -> \code{\link[data.table:data.table]{data.table::data.table()}}\cr
Compact representation as datatable. Col types are:\cr
\itemize{
\item id: character
\item lower, upper: double
\item levels: list col, with NULL elements
\item special_vals: list col of list
\item is_bounded: logical
\item default: list col, with NULL elements
\item storage_type: character
\item tags: list col of character vectors
}
}
}

\examples{
ps = ParamSet$new(
  params = list(
    ParamDbl$new("d", lower = -5, upper = 5, default = 0),
    ParamFct$new("f", levels = letters[1:3])
  )
)

ps$trafo = function(x, param_set) {
  x$d = 2^x$d
  return(x)
}

ps$add(ParamInt$new("i", lower = 0L, upper = 16L))

ps$check(list(d = 2.1, f = "a", i = 3L))
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{assert_values}}{(\code{logical(1)})\cr
Should values be checked for validity during assigment to active binding \verb{$values}?
Default is \code{TRUE}, only switch this off if you know what you are doing.}
}
\if{html}{\out{</div>}}
}
\section{Active bindings}{
\if{html}{\out{<div class="r6-active-bindings">}}
\describe{
\item{\code{params}}{(named \code{list()})\cr
List of \link{Param}, named with their respective ID.}

\item{\code{params_unid}}{(named \code{list()})\cr
List of \link{Param}, named with their true ID. However,
this field has the \link{Param}'s \verb{$id} value set to a
potentially invalid value. This active binding should
only be used internally.}

\item{\code{deps}}{(\code{\link[data.table:data.table]{data.table::data.table()}})\cr
Table has cols \code{id} (\code{character(1)}) and \code{on} (\code{character(1)}) and \code{cond} (\link{Condition}).
Lists all (direct) dependency parents of a param, through parameter IDs.
Internally created by a call to \code{add_dep}.
Settable, if you want to remove dependencies or perform other changes.}

\item{\code{set_id}}{(\code{character(1)})\cr
ID of this param set. Default \code{""}. Settable.}

\item{\code{length}}{(\code{integer(1)})\cr
Number of contained \link{Param}s.}

\item{\code{is_empty}}{(\code{logical(1)})\cr
Is the \code{ParamSet} empty?}

\item{\code{class}}{(named \code{character()})\cr
Classes of contained parameters, named with parameter IDs.}

\item{\code{lower}}{(named \code{double()})\cr
Lower bounds of parameters (\code{NA} if parameter is not numeric).
Named with parameter IDs.}

\item{\code{upper}}{(named \code{double()})\cr
Upper bounds of parameters (\code{NA} if parameter is not numeric).
Named with parameter IDs.}

\item{\code{levels}}{(named \code{list()})\cr
List of character vectors of allowed categorical values of contained parameters.
\code{NULL} if the parameter is not categorical.
Named with parameter IDs.}

\item{\code{nlevels}}{(named \code{integer()})\cr
Number of categorical levels per parameter, \code{Inf} for double parameters or unbounded integer parameters.
Named with param IDs.}

\item{\code{is_bounded}}{(named \code{logical()})\cr
Do all parameters have finite bounds?
Named with parameter IDs.}

\item{\code{special_vals}}{(named \code{list()} of \code{list()})\cr
Special values for all parameters.
Named with parameter IDs.}

\item{\code{default}}{(named \code{list()})\cr
Default values of all parameters.
If no default exists, element is not present.
Named with parameter IDs.}

\item{\code{tags}}{(named \code{list()} of \code{character()})\cr
Can be used to group and subset parameters.
Named with parameter IDs.}

\item{\code{storage_type}}{(\code{character()})\cr
Data types of parameters when stored in tables.
Named with parameter IDs.}

\item{\code{is_number}}{(named \code{logical()})\cr
Position is TRUE for \link{ParamDbl} and \link{ParamInt}.
Named with parameter IDs.}

\item{\code{is_categ}}{(named \code{logical()})\cr
Position is TRUE for \link{ParamFct} and \link{ParamLgl}.
Named with parameter IDs.}

\item{\code{all_numeric}}{(\code{logical(1)})\cr
Is \code{TRUE} if all parameters are \link{ParamDbl} or \link{ParamInt}.}

\item{\code{all_categorical}}{(\code{logical(1)})\cr
Is \code{TRUE} if all parameters are \link{ParamFct} and \link{ParamLgl}.}

\item{\code{trafo}}{(\verb{function(x, param_set)})\cr
Transformation function. Settable.
User has to pass a \verb{function(x, param_set)}, of the form\cr
(named \code{list()}, \link{ParamSet}) -> named \code{list()}.\cr
The function is responsible to transform a feasible configuration into another encoding,
before potentially evaluating the configuration with the target algorithm.
For the output, not many things have to hold.
It needs to have unique names, and the target algorithm has to accept the configuration.
For convenience, the self-paramset is also passed in, if you need some info from it (e.g. tags).
Is NULL by default, and you can set it to NULL to switch the transformation off.}

\item{\code{has_trafo}}{(\code{logical(1)})\cr
Has the set a \code{trafo} function?}

\item{\code{values}}{(named \code{list()})\cr
Currently set / fixed parameter values.
Settable, and feasibility of values will be checked when you set them.
You do not have to set values for all parameters, but only for a subset.
When you set values, all previously set values will be unset / removed.}

\item{\code{has_deps}}{(\code{logical(1)})\cr
Has the set parameter dependencies?}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-ParamSet-new}{\code{ParamSet$new()}}
\item \href{#method-ParamSet-add}{\code{ParamSet$add()}}
\item \href{#method-ParamSet-ids}{\code{ParamSet$ids()}}
\item \href{#method-ParamSet-get_values}{\code{ParamSet$get_values()}}
\item \href{#method-ParamSet-set_values}{\code{ParamSet$set_values()}}
\item \href{#method-ParamSet-subset}{\code{ParamSet$subset()}}
\item \href{#method-ParamSet-search_space}{\code{ParamSet$search_space()}}
\item \href{#method-ParamSet-check}{\code{ParamSet$check()}}
\item \href{#method-ParamSet-test}{\code{ParamSet$test()}}
\item \href{#method-ParamSet-assert}{\code{ParamSet$assert()}}
\item \href{#method-ParamSet-check_dt}{\code{ParamSet$check_dt()}}
\item \href{#method-ParamSet-test_dt}{\code{ParamSet$test_dt()}}
\item \href{#method-ParamSet-assert_dt}{\code{ParamSet$assert_dt()}}
\item \href{#method-ParamSet-add_dep}{\code{ParamSet$add_dep()}}
\item \href{#method-ParamSet-format}{\code{ParamSet$format()}}
\item \href{#method-ParamSet-print}{\code{ParamSet$print()}}
\item \href{#method-ParamSet-clone}{\code{ParamSet$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-new"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-new}{}}}
\subsection{Method \code{new()}}{
Creates a new instance of this \link[R6:R6Class]{R6} class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$new(params = named_list())}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{params}}{(\code{list()})\cr
List of \link{Param}, named with their respective ID.
Parameters are cloned.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-add"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-add}{}}}
\subsection{Method \code{add()}}{
Adds a single param or another set to this set, all params are cloned.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$add(p)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{p}}{(\link{Param} | \link{ParamSet}).}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-ids"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-ids}{}}}
\subsection{Method \code{ids()}}{
Retrieves IDs of contained parameters based on some filter criteria
selections, \code{NULL} means no restriction.
Only returns IDs of parameters that satisfy all conditions.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$ids(class = NULL, is_bounded = NULL, tags = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{class}}{(\code{character()}).}

\item{\code{is_bounded}}{(\code{logical(1)}).}

\item{\code{tags}}{(\code{character()}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{character()}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-get_values"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-get_values}{}}}
\subsection{Method \code{get_values()}}{
Retrieves parameter values based on some selections, \code{NULL} means no
restriction and is equivalent to \verb{$values}.
Only returns values of parameters that satisfy all conditions.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$get_values(
  class = NULL,
  is_bounded = NULL,
  tags = NULL,
  type = "with_token",
  check_required = TRUE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{class}}{(\code{character()}).}

\item{\code{is_bounded}}{(\code{logical(1)}).}

\item{\code{tags}}{(\code{character()}).}

\item{\code{type}}{(\code{character(1)})\cr
Return values \code{with_token}, \code{without_token} or \code{only_token}?}

\item{\code{check_required}}{(\code{logical(1)})\cr
Check if all required parameters are set?}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Named \code{list()}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-set_values"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-set_values}{}}}
\subsection{Method \code{set_values()}}{
Allows to to modify (and overwrite) or replace the parameter values.
Per default already set values are being kept unless new values are being provided.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$set_values(..., .values = list(), .insert = TRUE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{(any)\cr
Named parameter values.}

\item{\code{.values}}{(named \code{list()})\cr
Named list with parameter values. Names must not already appear in \code{...}.}

\item{\code{.insert}}{(\code{logical(1)})\cr
Whether to insert the values (old values are being kept, if not overwritten), or to
replace all values. Default is TRUE.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-subset"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-subset}{}}}
\subsection{Method \code{subset()}}{
Changes the current set to the set of passed IDs.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$subset(ids)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{ids}}{(\code{character()}).}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-search_space"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-search_space}{}}}
\subsection{Method \code{search_space()}}{
Construct a \code{\link{ParamSet}} to tune over. Constructed from \code{\link{TuneToken}} in \verb{$values}, see \code{\link[=to_tune]{to_tune()}}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$search_space(values = self$values)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{values}}{(\verb{named list}): optional named list of \code{\link{TuneToken}} objects to convert, in place of \verb{$values}.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-check"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-check}{}}}
\subsection{Method \code{check()}}{
\pkg{checkmate}-like check-function. Takes a named list.
A point x is feasible, if it configures a subset of params,
all individual param constraints are satisfied and all dependencies are satisfied.
Params for which dependencies are not satisfied should not be part of \code{x}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$check(xs)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xs}}{(named \code{list()}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{TRUE}, if not a string with the error message.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-test"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-test}{}}}
\subsection{Method \code{test()}}{
\pkg{checkmate}-like test-function. Takes a named list.
A point x is feasible, if it configures a subset of params,
all individual param constraints are satisfied and all dependencies are satisfied.
Params for which dependencies are not satisfied should not be part of \code{x}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$test(xs)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xs}}{(named \code{list()}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{TRUE}, if not \code{FALSE}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-assert"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-assert}{}}}
\subsection{Method \code{assert()}}{
\pkg{checkmate}-like assert-function. Takes a named list.
A point x is feasible, if it configures a subset of params,
all individual param constraints are satisfied and all dependencies are satisfied.
Params for which dependencies are not satisfied should not be part of \code{x}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$assert(xs, .var.name = vname(xs))}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xs}}{(named \code{list()}).}

\item{\code{.var.name}}{(\code{character(1)})\cr
Name of the checked object to print in error messages.\cr
Defaults to the heuristic implemented in \link[checkmate:vname]{vname}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{xs} invisibly, if not an error message.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-check_dt"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-check_dt}{}}}
\subsection{Method \code{check_dt()}}{
\pkg{checkmate}-like check-function. Takes a \link[data.table:data.table]{data.table::data.table}
where rows are points and columns are parameters. A point x is feasible,
if it configures a subset of params, all individual param constraints are
satisfied and all dependencies are satisfied. Params for which
dependencies are not satisfied should be set to \code{NA} in \code{xdt}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$check_dt(xdt)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xdt}}{(\link[data.table:data.table]{data.table::data.table} | \code{data.frame()}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{TRUE}, if not a string with the error message.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-test_dt"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-test_dt}{}}}
\subsection{Method \code{test_dt()}}{
\pkg{checkmate}-like test-function (s. \verb{$check_dt()}).
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$test_dt(xdt)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xdt}}{(\link[data.table:data.table]{data.table::data.table}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{TRUE}, if not \code{FALSE}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-assert_dt"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-assert_dt}{}}}
\subsection{Method \code{assert_dt()}}{
\pkg{checkmate}-like assert-function (s. \verb{$check_dt()}).
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$assert_dt(xdt, .var.name = vname(xdt))}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{xdt}}{(\link[data.table:data.table]{data.table::data.table}).}

\item{\code{.var.name}}{(\code{character(1)})\cr
Name of the checked object to print in error messages.\cr
Defaults to the heuristic implemented in \link[checkmate:vname]{vname}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If successful \code{xs} invisibly, if not an error message.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-add_dep"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-add_dep}{}}}
\subsection{Method \code{add_dep()}}{
Adds a dependency to this set, so that param \code{id} now depends on param \code{on}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$add_dep(id, on, cond)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{id}}{(\code{character(1)}).}

\item{\code{on}}{(\code{character(1)}).}

\item{\code{cond}}{(\link{Condition}).}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-format"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-format}{}}}
\subsection{Method \code{format()}}{
Helper for print outputs.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$format(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{(ignored).}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-print"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-print}{}}}
\subsection{Method \code{print()}}{
Printer.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$print(
  ...,
  hide_cols = c("levels", "is_bounded", "special_vals", "tags", "storage_type")
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{(ignored).}

\item{\code{hide_cols}}{(\code{character()})\cr
Which fields should not be printed? Default is \code{"levels"},
\code{"is_bounded"}, \code{"special_vals"}, \code{"tags"}, and \code{"storage_type"}.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ParamSet-clone"></a>}}
\if{latex}{\out{\hypertarget{method-ParamSet-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ParamSet$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
