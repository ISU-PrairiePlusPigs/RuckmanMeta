library(dplyr)

set.seed(38)

fields <- readr::read_csv("fields.csv")

#################################################
### Randomization
#################################################
fields <- fields %>%

  # Randomize initial harvest
  group_by(block) %>%
  mutate(harvest = as.integer(ifelse(whole_plot == sample(whole_plot,1), 2019, 2020)),
         whole_plot = paste0(block, ifelse(harvest==2019, "a", "b"))) %>% # Rename whole_plot to coincide with harvest year

  # Randomize treatment
  group_by(block,whole_plot,manure) %>%
  mutate(trt = sample(c("FB","LoDiv","HiDiv")),
         trt = ifelse(manure=="no", "HiDiv", trt)) %>%
  ungroup()


# Check to make sure one but not both of 13a and 13b is FB so that these two
# fields do not look like one gigantic patch
fields %>%
  filter(field %in% c("13a","13b"))

# Check plot sizes for each treatment-manure combination to ensure the
# mean and sd are approximately the same
fields %>%
  group_by(trt,manure) %>%
  summarize(n = n(),
            mean = mean(area_acre),
            sd   = sd(area_acre)) %>%
  arrange(manure, trt)



# Add long treatment names
treatment <- data.frame(trt = c("FB","LoDiv","HiDiv"),
                        treatment = c("Fescue-brome",
                                       "Lower diversity natives",
                                       "Higher diversity natives"),
                        stringsAsFactors = FALSE)

fields <- fields %>%
  left_join(treatment, by="trt")



devtools::use_data(fields, overwrite = TRUE)
