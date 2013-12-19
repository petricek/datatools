[![Build Status](https://travis-ci.org/petricek/datatools.png)](https://travis-ci.org/petricek/datatools)

Data Tools
==========

| util | description |
|``apply-spline.pl``|Apply a spline calibration to predictions read from stdin |
|``audit2weights``|Extract feature names and weights from vowpal wabbit --audit output |
|``clip.pl``| Truncate list of numeric predictions to a specified interval |
|``cv-split.pl``|Split lines in a round-robin into n files for crossvalidation. |
|``etop``| Show running jobs and instances on Amamazon EMR |
|``field-split.pl``|Sort out lines from input into separate files based on value of a column |
|``flip``| Swap columns in a 2 column input - useful when feeding vowpal wabbit predictions to perf |
|``ll.pl``| Logloss |
|``load-user-data.pl``|Load data into Redis  |
|``make-auditline``| Create an uber example for weight extraction from vowpal wabbit |
|``make-calibration-plot.sh``|Plot calibration plot from model predictions. |
|``make-spline-fit.sh``|Fit a spline to model predictions and dump a piecewise linear approximation as a tsv |
|``mean.sh``| Compute mean of input values |
|``median.sh``|Compute median of input values |
|``nfields.pl``|Count number of fields in each line of a tsv |
|``pad.pl``| Pad each line with empty fields up to specified N if necessary |
|``probs.pl``|Compute binned table of predictions versus actual outcomes - useful for calibration. |
|``quantiles``|Compute quantiles of inputs |
|``range2dates``|Given a start and end date in YYYYMMDD format prints all dates in the range |
|``remapdv``| Maps between -1,1 labels for logloss and 0,1 for squared |
|``resample-with-repetition.pl``|Resampling for bootstrap |
|``run_dnz.pl``|Nzsql wrapper that waits if the server is down. |
|``sd.sh``| Compute standard deviation of input. |
|``select-columns-re.pl``|Print selected columns from a tsv - supports regexes |
|``shuffle.pl``|Shuffle blocks of N lines  |
|``shutdown-when-idle.sh``|Take down an EMR cluster when jobs finished |
|``split.pl``| |
|``subsample-negatives.pl``|Print negative lines only with probability p and keep all positive lines |
|``subsample.pl``|Print each line with a probability p |
|``subst``| Macro expansion that uses env variables |
|``sum.pl``| Sum numbers read from input |
|``tee-auditline``|Make vowpal uber example while piping the original data through (saves 1 pass over data) |
|``tokenize.pl``| |
|``tsv2json``|Generate a JSON model spec that holds weights and spline  |
|``ttest``| Performs t-test comparison of observations fed on stdin |
|``twin.pl``|  |
|``umetric.pl``|the missing 'perf -blocks ROC' |
|``uniq.pl``| Hash based uniq that does not require sorted input  |
|``uniqsort.pl``|Hash based in memory uniq sort |
|``wait-for-idle.sh``|Wait for the EMR cluster to become idle |
