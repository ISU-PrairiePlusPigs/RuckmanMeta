#' Meta data on the plots including randomization
#'
#' Information on each of the plots in this experiment.
#'
#' @format A data frame with 21 observations and 8 variables:
#' \code{plot}: the plot id
#' \code{block}: the whole plot for randomization of harvest year
#' \code{subplot}: the subplot for randomization of treatment
#' \code{area_acre}: plot area in acres
#' \code{manure}: "yes" if manure was previously used on the plot and "no" otherwise
#' \code{trt}: the shorthand randomized (except for the non-manure plots) treatment
#' \code{treatment}: the long treatment name
#'
#' @details This is a split-plot design where the whole plots (blocks) were
#' randomly assigned an initial year of harvest. This was used as the whole plot
#' because we believe in the future half of the prairie will be harvested in on
#' year and the remainder the following year. Thus, the impact of this harvest
#' timing is not of interest.
#'
#' A treatment was randomly assigned within a subplot so that each of the 3
#' treatments (FB, LoDiv, and HiDiv) are represented in each subplot. The only
#' place randomization was not done was on the non-manure plots where each plot
#' here had the HiDiv treatment. This was done to increase power in assessing
#' the effect of manure on one of two prairie treatments (LoDiv, HiDiv). The
#' argument for HiDiv vs LoDiv is that if we find the manure has negligible
#' effect on the HiDiv then it is likely that manure will have a negligible
#' effect on the LoDiv as well.
"plots"
