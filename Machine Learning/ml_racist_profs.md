Machine Learning - Racist Profs
================
Angel Salazar
11/16/2021

``` r
# meant to allow us to randomly generate numbers for performing simulation and 
# modeling
set.seed(200)

# here, we want to split the data into 75% training and 25% testing
data_split <- initial_split(data_gss,
                            strata = colrac, 
                            prop = 0.75)
                            
# this will be the data for training
data_train <- training(data_split)

# this will be the data for testing
data_test <- testing(data_split)
```

``` r
# estimate a basic log regression model to predict debt as a function of the
# included variables in the data set
# report accuracy for the model
set.seed(200)

# running ?logistic_reg shows "glm" is the default

# now we need to train our model with the given variables controlled 
gss_log_mod <- logistic_reg(engine = "glm", 
                            mode = "classification") %>%
  fit(colrac ~ age + black + degree + partyid_3 + sex + south, 
      data = data_train) %>%
  predict(new_data = data_test) %>%
  mutate(true_colrac = data_test$colrac)
  
# reporting RMSE for the model
accuracy(data = gss_log_mod, true_colrac, estimate = .pred_class)
```

    ## # A tibble: 1 x 3
    ##   .metric  .estimator .estimate
    ##   <chr>    <chr>          <dbl>
    ## 1 accuracy binary         0.537

### Accuracy is: 0.537

``` r
# please set the seed lol
set.seed(200)

# ten fold validation set up
fold_validation <- vfold_cv(data = data_train, 
                            v = 10, 
                            strata = colrac)

fold_validation
```

    ## #  10-fold cross-validation using stratification 
    ## # A tibble: 10 x 2
    ##    splits             id    
    ##    <list>             <chr> 
    ##  1 <split [1331/149]> Fold01
    ##  2 <split [1331/149]> Fold02
    ##  3 <split [1331/149]> Fold03
    ##  4 <split [1331/149]> Fold04
    ##  5 <split [1332/148]> Fold05
    ##  6 <split [1332/148]> Fold06
    ##  7 <split [1333/147]> Fold07
    ##  8 <split [1333/147]> Fold08
    ##  9 <split [1333/147]> Fold09
    ## 10 <split [1333/147]> Fold10

``` r
# cross validation 
cross_validation <- logistic_reg() %>%
  fit_resamples(colrac ~ age + black + degree + partyid_3 + sex + south, 
                resamples = fold_validation) %>%
  collect_metrics(summarize=TRUE)
```

    ## Warning: package 'rlang' was built under R version 4.0.5

    ## Warning: package 'vctrs' was built under R version 4.0.5

``` r
cross_validation
```

    ## # A tibble: 2 x 6
    ##   .metric  .estimator  mean     n std_err .config             
    ##   <chr>    <chr>      <dbl> <int>   <dbl> <chr>               
    ## 1 accuracy binary     0.520    10 0.00864 Preprocessor1_Model1
    ## 2 roc_auc  binary     0.536    10 0.0130  Preprocessor1_Model1

### Accuracy is now: 0.520

``` r
# use all vars except for id and wtss
# need to impute missing vals for all the predictor columns
# replace NA with plausible vals given what we know about other obs
# remove rows w na for colrac
# use median imputation for numeric predictors
# us modal imputation for nominal predictors

# ranger is default so need to override that as well as mode since its unknown rn
r_forest_model <- rand_forest() %>%
  set_engine("randomForest") %>%
  set_mode("classification")

# imputation steps 
imputation_mods <- recipe(colrac ~., 
                          data = data_train) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors())

# 
```
