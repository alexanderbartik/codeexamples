###############################################################################
# Model 0: OPEN FILES
###############################################################################
needed.packages<-c("data.table","rstan")
install.packages(needed.packages)
lapply(needed.packages,library, character.only = TRUE)

model.small.dt <- LoadRDS('dataprep_small')

###############################################################################
# Model 2: Prepping Stan variables
###############################################################################
data.list <- list(N = nrow(model.small.dt),
                  J1 = uniqueN(model.small.dt$lead.OCC2010.int),
                  leadocc = as.numeric(model.small.dt$lead.OCC2010.int),
                  y = (model.small.dt$log.lead.hourwage.mod))

str(data.list)
summary(data.list)

###############################################################################
# Model 3: Running stan model
###############################################################################

model_compile<- stan_model(paste(main_dir,'SimplestExample.stan',sep='/'))

model6 <- sampling(model_compile,data = data.list, 
                   warmup=1000,iter=2000,chains = 1)

