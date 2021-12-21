Machine Learning
================
Angel Salazar
11/11/2021

``` r
# meant to allow us to randomly generate numbers for performing simulation and 
# modeling
set.seed(200)

# here, we want to split the data into 75% training and 25% testing
data_split <- initial_split(data_scorecard,
                            strata = debt, 
                            prop = 0.75)
                            
# this will be the data for training
data_train <- training(data_split)

# this will be the data for testing
data_test <- testing(data_split)
```

``` r
# estimate a basic linear regression model to predict debt as a function of all
# other variables in the data set
# EXCLUDE 'state'
# report RMSE (Root Mean Square Error) for the model
set.seed(200)

# running ?linear_reg shows "lm" is the default

# now we need to train our model with the given variables controlled 
#except for state variable
debt_lin_mod <- linear_reg() %>%
  fit(debt ~ type + admrate + satavg + cost + netcost + avgfacsal + pctpell +
        comprate + firstgen + locale, 
      data = data_train) %>%
  predict(new_data = data_test) %>%
  mutate(true_debt = data_test$debt)
  
# reporting RMSE for the model
rmse(data = debt_lin_mod, truth = true_debt, estimate = .pred)
```

    ## # A tibble: 1 x 3
    ##   .metric .estimator .estimate
    ##   <chr>   <chr>          <dbl>
    ## 1 rmse    standard       3050.

``` r
# please set the seed lol
set.seed(200)

# ten fold validation set up
fold_validation <- vfold_cv(data = data_train, 
                            v = 10, 
                            strata = debt)

fold_validation
```

    ## #  10-fold cross-validation using stratification 
    ## # A tibble: 10 x 2
    ##    splits             id    
    ##    <list>             <chr> 
    ##  1 <split [1180/133]> Fold01
    ##  2 <split [1181/132]> Fold02
    ##  3 <split [1181/132]> Fold03
    ##  4 <split [1181/132]> Fold04
    ##  5 <split [1181/132]> Fold05
    ##  6 <split [1181/132]> Fold06
    ##  7 <split [1183/130]> Fold07
    ##  8 <split [1183/130]> Fold08
    ##  9 <split [1183/130]> Fold09
    ## 10 <split [1183/130]> Fold10

``` r
# cross validation 
cross_validation <- linear_reg() %>%
  fit_resamples(debt ~ type + admrate + satavg + cost + netcost + avgfacsal + 
                  pctpell + comprate + firstgen + locale, 
                resamples = fold_validation) %>%
  collect_metrics(summarize=TRUE)
```

    ## Warning: package 'rlang' was built under R version 4.0.5

    ## Warning: package 'vctrs' was built under R version 4.0.5

``` r
cross_validation
```

    ## # A tibble: 2 x 6
    ##   .metric .estimator     mean     n std_err .config             
    ##   <chr>   <chr>         <dbl> <int>   <dbl> <chr>               
    ## 1 rmse    standard   3049.       10 57.0    Preprocessor1_Model1
    ## 2 rsq     standard      0.393    10  0.0224 Preprocessor1_Model1
