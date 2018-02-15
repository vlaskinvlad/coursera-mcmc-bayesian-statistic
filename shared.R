library("rjags")

jags_model_compile = function(str_model_, data_,  n_chains_ = 3, burnout = 1e3, inits_=NULL) { 
    m_ = jags.model(textConnection(str_model_), data = data_, inits = inits_, n.chains = n_chains_)
    update(m_, burnout)    
    m_
}

jags_model_sample = function(mod_, n_iter_, var_names_) {
    samples_ = coda.samples(model = mod_, n.iter = n_iter_, variable.names = var_names_)
    samples_combined_ = as.mcmc(do.call(rbind, samples_))
    list("samples" = samples_, "samples_cmb" = samples_combined_)
}

jags_model_diag = function(samples_) { 
    list("gelman_diag" = gelman.diag(samples_), 
         "acf_diag" = autocorr.diag(samples_),
         "eff_size" = effectiveSize(samples_),
         "raftery_diag" = raftery.diag(samples_)
        )
}