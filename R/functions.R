test_plot <- function() {
  plot(rnorm(1000))
}

get_params <- function () {
  list(max_gens = 10000,
       males_per_winner = 10,
       num_nests = 100,
       encounter_delta = 1,
       metabolism = 1,
       female_mat_time = 10, 
       maturation_rate = 1,
       mutation_rate = 0.001,
       mutation_sd = 0.01,
       mass_to_energy = 10,
       growth_a = 0.5,
       growth_b = 0.1,
       initial_mass = 5,
       alpha_mean = 0,
       alpha_sd = 3,
       beta_sd = 3,
       beta_max = 10,
       beta_mean = 0,
       verbose = F,
       log_every = 1000,
       contest_noise = 0,
       quiet = T)
}

param_table <- function (p) {
  p %>% as.data.frame %>%
    t %>% data.frame %>% add_rownames("Parameter") %>% 
    xtable(caption = "The Parameters used to run the model") %>%
    print(file = "parameters.tex")
}

get_last_generation_data <- function (parameters){
  ldply(c(0, 20, 50, 100, 500, 1000), function(cn) {
    parameters$contest_noise <- cn
    run_parallel(parameters, "encounter_delta", seq(1, 10, 0.5), mc.cores = 4) %>% 
      rbind.fill(.) %>% mutate(contest_noise = cn)
  }) %>%  filter(generation == parameters$max_gens)
}

beta_plot <- function (df) {
   ggplot(df, aes(encounter_delta, beta, col = as.factor(contest_noise)) ) +
    geom_smooth(method="lm") + 
    ggtitle("beta trait")
}

alpha_plot <- function (df) {
  ggplot(df, aes(encounter_delta, alpha, col = as.factor(contest_noise)) ) +
    geom_smooth(method="lm") +
    ggtitle("alpha trait") 
}

fight_randomness_plot <- function (){
  ldply(c(20, 50, 100, 1000), function(x) data.frame(df = x, z = rf(3000, x, x))) %>% 
    ggplot(aes(z, col = as.factor(df))) + geom_density()
}