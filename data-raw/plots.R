library(dplyr)

set.seed(38)

plots <- readr::read_csv("plots.csv")

#################################################
### Randomization
#################################################
plots <- plots %>%

  # Randomize initial harvest
  group_by(block) %>%
  mutate(harvest = as.integer(ifelse(subplot == sample(subplot,1), 2019, 2020)),
         subplot = paste0(block, ifelse(harvest==2019, "a", "b"))) %>% # Rename subplot to coincide with harvest year

  # Randomize treatment
  group_by(block,subplot,manure) %>%
  mutate(trt = sample(c("FB","LoDiv","HiDiv")),
         trt = ifelse(manure=="no", "HiDiv", trt)) %>%
  ungroup()


# Check to make sure one but not both of 13a and 13b is FB so that these two
# plots do not look like one gigantic patch
plots %>%
  filter(plot %in% c("13a","13b"))

# Check plot sizes for each treatment-manure combination to ensure the
# mean and sd are approximately the same
plots %>%
  group_by(trt,manure) %>%
  summarize(n = n(),
            mean = mean(area_acre),
            sd   = sd(area_acre)) %>%
  arrange(manure, trt)



# Add long treatment names
treatment <- data.frame(trt = c("FB","LoDiv","HiDiv"),
                        treatement = c("Fescue-brome",
                                       "Lower diversity natives",
                                       "Higher diversity natives"),
                        stringsAsFactors = FALSE)

plots <- plots %>%
  left_join(treatment, by="trt")



devtools::use_data(plots, overwrite = TRUE)
