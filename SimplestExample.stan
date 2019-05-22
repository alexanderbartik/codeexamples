//  Simplest Job Model
data {                          
  int<lower=0> N;                         // number of observations
  int<lower=0> J1;                        // number of lead occs
  
  int<lower=1, upper=J1> leadocc[N];      // lead occc
  vector[N] y;                            // log(wages)
}
parameters {
  vector[J1] alphaJ1;                     // lead occ par
  real mu_alphaJ1;                        // mean par for lead occ
  real<lower=0> sigma_alphaJ1;            // standard error for the intercept
  real<lower=0> sigma_y;                  // standard error for y

}
transformed parameters {
  vector[N] y_hat;                        // create one variable with predictions for each observation

  for (i in 1:N)                          // loop for all cases
      y_hat[i] = alphaJ1[leadocc[i]];
}
model {
  // priors for var parameters
  sigma_alphaJ1 ~ normal(0, 1);
  sigma_y ~ normal(0, 1);  

  // priors for mean parameters
  mu_alphaJ1 ~ normal(0, 1);  

  // varying parameters
  alphaJ1 ~ normal(mu_alphaJ1, sigma_alphaJ1);

  y ~ normal(y_hat, sigma_y);      // model
}
