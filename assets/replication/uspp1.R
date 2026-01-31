library(broom)
library(dplyr)
library(reshape2)
library(gridExtra)
library(ggplot2)

getwd()
setwd("/Users/olgahan/Downloads/Dissertation3.17/usa")
#read data

csv_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# Get the most recently created/modified .csv file
latest_csv <- csv_files[which.max(file.info(csv_files)$ctime)]


# Read it into a data frame
df_tr <- read.csv(latest_csv)
names(df_tr)
class(df_tr$StartDate)
df_tr = df_tr[-2:0,]

df_tr <- df_tr %>%
  mutate(across(contains("pp"), as.numeric)) %>%
  rowwise() %>%
  mutate(pp = mean(c_across(contains("pp")))) %>%
  ungroup()


# #CACE
# 
# 
# df_tr_cace <- df_tr %>% mutate(
#   
#   passed_attention = (attention1 == 4 & attention2 == "Patriotism"),  # adjust if only 1
#   
#   complier = if_else(passed_attention, 1, 0)
# )
# 
# 
# df_checkk = df_tr_cace[,c('threat_v',"mc_security","mc_economy","mc_culture","mc_general","attention1","attention2","passed_attention","complier" )]
# 
# library(AER)
# 
# treatments <- c("security", "economy", "culture", "general")
# results <- list()
# 
# for (treat in treatments) {
#   df_sub <- df_tr_cace %>%
#     filter(threat_v %in% c(treat, "placebo")) %>%
#     mutate(
#       Z = if_else(threat_v == treat, 1, 0),
#       D = complier
#     )
#   
#   iv_model <- ivreg(pp ~ D | Z, data = df_sub)
#   results[[treat]] <- summary(iv_model)
# }
# 
# results$security
# results$economy
# results$general
# results$culture
#df_tr$StartDate <- as.POSIXct(df_tr$StartDate, format = "%Y-%m-%d %H:%M:%S")

# Define your cutoff time
#cutoff_time <- as.POSIXct("2025-04-08 11:13:00")

# Filter rows where timestamp is after the cutoff
#df_tr <- subset(df_tr, StartDate > cutoff_time)

df_tr$Duration..in.seconds. = as.numeric(df_tr$Duration..in.seconds.)

#attention checks 

df_tr <- df_tr %>%
  filter(
    (threat_v == "economy"  & mc_economy == "Economy") |
      (threat_v == "security" & mc_security == "Security") |
      (threat_v == "culture"  & mc_culture == "Culture") |
      (threat_v == "general"  & mc_general == "United States") |
      (threat_v == "placebo")
  )

df_tr = subset(df_tr, attention1 == 4)

df_tr = subset(df_tr, attention2 == "Patriotism")

df_tr = subset(df_tr, citizenship == "Yes")

df_tr$Duration..in.seconds. = as.numeric(df_tr$Duration..in.seconds.)

#df_tr = subset(df_tr, duration > 179)

#aggregate measures
df_tr <- df_tr %>%
  mutate(across(contains("pp"), as.numeric)) %>%
  rowwise() %>%
  mutate(pp = mean(c_across(contains("pp")))) %>%
  ungroup()

df_tr <- df_tr %>%
  mutate(across(contains("cp"), as.numeric)) %>%
  rowwise() %>%
  mutate(cp = mean(c_across(contains("cp")))) %>%
  ungroup()

df_tr <- df_tr %>%
  mutate(across(contains("bp"), as.numeric)) %>%
  rowwise() %>%
  mutate(bp = mean(c_across(contains("bp")))) %>%
  ungroup()

df_tr <- df_tr %>%
  mutate(ns1 = as.numeric(ns1),
         ns2 = as.numeric(ns2),
         ns3 = as.numeric(ns3),
         ns4 = as.numeric(ns4)) 

df_tr = df_tr %>%
  mutate(ns = rowMeans(select(., ns1, ns2, ns3, ns4), na.rm = TRUE))%>%
  ungroup()


#numeric columns
df_tr$education_alt = as.numeric(df_tr$education_alt)
df_tr$age = as.numeric(df_tr$age)

# # Function for t-test
# get_ttest <- function(data, group) {
#   t.test(pp ~ threat_v, data = filter(data, threat_v %in% c("placebo", group))) %>%
#     tidy()
# }
# 
# # Run t-tests for each comparison
# results <- lapply(c("culture", "economy", "general", "security"), 
#                   function(x) get_ttest(df, x))

# Combine results
# do.call(rbind, results)

#manipulation and attention checks

#df_tr = subset(df_tr, attention1 == 4)

#df_tr = subset(df_tr, attention2 == x)

#manipulation checks

# df_tr <- df_tr %>%
#   filter(
#     (threat_v == "economy" & mc_economy == "Ekonomi") |
#       (threat_v == "security" & mc_security == "Güvenlik") |
#       (threat_v == "culture" & mc_culture == "Kültürel") |
#       (threat_v == "general" & mc_general == "Suriye")
#   )
# 

#distribution plots
p1 <- ggplot(df_tr, aes(x = pp_1)) + geom_density(fill = "blue", alpha = 0.5) + xlab("Q1")
p2 <- ggplot(df_tr, aes(x = pp_3)) + geom_density(fill = "red", alpha = 0.5) + xlab("Q2")
p3 <- ggplot(df_tr, aes(x = pp_4)) + geom_density(fill = "green", alpha = 0.5) + xlab("Q3")
p4 <- ggplot(df_tr, aes(x = pp_2)) + geom_density(fill = "purple", alpha = 0.5) + xlab("Q4")
p5 <- ggplot(df_tr, aes(x = pp_5)) + geom_density(fill = "orange", alpha = 0.5) + xlab("Q5")
p6 <- ggplot(df_tr, aes(x = pp)) + geom_density(fill = "black", alpha = 0.5) + xlab("Aggregate")


#combine the plots using grid.arrange
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 2)


png(file="us_pp1_dist.png", height = 1111, width = 1311,  res = 300)
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 2)

dev.off()

#BP 
bp1 <- ggplot(df_tr, aes(x = bp1)) + geom_density(fill = "blue", alpha = 0.5) + xlab("Q1")
bp2 <- ggplot(df_tr, aes(x = bp3)) + geom_density(fill = "red", alpha = 0.5) + xlab("Q2")
bp3 <- ggplot(df_tr, aes(x = bp4)) + geom_density(fill = "green", alpha = 0.5) + xlab("Q3")
bp4 <- ggplot(df_tr, aes(x = bp2)) + geom_density(fill = "purple", alpha = 0.5) + xlab("Q4")
bp5 <- ggplot(df_tr, aes(x = bp5)) + geom_density(fill = "orange", alpha = 0.5) + xlab("Q5")
bp6 <- ggplot(df_tr, aes(x = bp)) + geom_density(fill = "black", alpha = 0.5) + xlab("Aggregate")


#combine the plots using grid.arrange
grid.arrange(bp1, bp2, bp3, bp4, bp5, bp6, ncol = 2)


png(file="us_bp_dist.png", height = 1111, width = 1311,  res = 300)
grid.arrange(bp1, bp2, bp3, bp4, bp5, bp6, ncol = 2)

dev.off()

#cp 
cp1 <- ggplot(df_tr, aes(x = cp1)) + geom_density(fill = "blue", alpha = 0.5) + xlab("Q1")
cp2 <- ggplot(df_tr, aes(x = cp3)) + geom_density(fill = "red", alpha = 0.5) + xlab("Q2")
cp3 <- ggplot(df_tr, aes(x = cp4)) + geom_density(fill = "green", alpha = 0.5) + xlab("Q3")
cp4 <- ggplot(df_tr, aes(x = cp2)) + geom_density(fill = "purple", alpha = 0.5) + xlab("Q4")
cp5 <- ggplot(df_tr, aes(x = cp5)) + geom_density(fill = "orange", alpha = 0.5) + xlab("Q5")
cp6 <- ggplot(df_tr, aes(x = cp)) + geom_density(fill = "black", alpha = 0.5) + xlab("Aggregate")


# Combine the plots using grid.arrange
grid.arrange(cp1, cp2, cp3, cp4, cp5, cp6, ncol = 2)


png(file="us_cp_dist.png", height = 1111, width = 1311,  res = 300)
grid.arrange(cp1, cp2, cp3, cp4, cp5, cp6, ncol = 2)

dev.off()

#NS 
ns1 <- ggplot(df_tr, aes(x = ns1)) + geom_density(fill = "blue", alpha = 0.5) + xlab("Q1")
ns2 <- ggplot(df_tr, aes(x = ns2)) + geom_density(fill = "red", alpha = 0.5) + xlab("Q2")
ns3 <- ggplot(df_tr, aes(x = ns3)) + geom_density(fill = "green", alpha = 0.5) + xlab("Q3")
ns4 <- ggplot(df_tr, aes(x = ns4)) + geom_density(fill = "purple", alpha = 0.5) + xlab("Q4")
ns5 <- ggplot(df_tr, aes(x = ns)) + geom_density(fill = "black", alpha = 0.5) + xlab("Aggregate")


#combine the plots using grid.arrange
grid.arrange(ns1, ns2, ns3, ns4, ns5, ncol = 2)


png(file="us_ns_dist.png", height = 1111, width = 1311,  res = 300)
grid.arrange(ns1, ns2, ns3, ns4, ns5, ncol = 2)

dev.off()

#CATEGORICAL
prop.table(table(df_tr$race))
prop.table(table(df_tr$gender_respondent))
prop.table(table(df_tr$military))
prop.table(table(df_tr$military_family))
prop.table(table(df_tr$ideology))
prop.table(table(df_tr$party))
prop.table(table(df_tr$employment))

#summary stats
data = df_tr
data$race <- as.numeric(as.factor(data$race))
data$gender_respondent <- as.numeric(as.factor(data$gender_respondent))
data$ideology <- as.numeric(as.factor(data$ideology))
data$party <- as.numeric(as.factor(data$party))
data$employment <- as.numeric(as.factor(data$employment))
data$military <- as.numeric(as.factor(data$military))


# Check converted variables
str(data)
# Summary statistics using summary()
summary(data)



#correlation plots
data = df_tr

data <- data %>% 
  mutate(party = as.factor(ifelse(party == "Republican Party", 0,
                                  ifelse(party == "Democrat Party", 1, NA))),
         employment = as.factor(ifelse(employment == "Employed full-time/Self-employed", 1, 
                                       ifelse(employment == "Currently unemployed and seeking opportunities", 0, NA) )),
         ideology = as.factor(ifelse(ideology == "Conservative", 0,
                                     ifelse(ideology == "Liberal", 1, NA))),
         gender_respondent = as.factor(ifelse(gender_respondent == "Male", 0,
                                              ifelse(gender_respondent == "Female", 1, NA))),
         race = as.factor(ifelse(race=="White/Caucausian", 0, 1))
  )

# data <- data[, c("pp", "age", "gender_respondent", "ideology", "party", "education_alt", "race", "employment", "bp","cp","ns","military_family")]
data <- data[, c("pp", "age", "gender_respondent", "ideology",  "education_alt", "race", "employment","party", "bp","cp","ns")]

data$race <- as.numeric(as.factor(data$race))
data$gender_respondent <- as.numeric(as.factor(data$gender_respondent))
data$ideology <- as.numeric(as.factor(data$ideology))
data$party <- as.numeric(as.factor(data$party))
data$employment <- as.numeric(as.factor(data$employment))
#data$military <- as.numeric(as.factor(data$military))
#data$military_family <- as.numeric(as.factor(data$military_family))
df_tr$threat_v <- factor(df_tr$threat_v,
                         levels = c("placebo", "general","culture","economy","security"))


colnames(data)[which(names(data) == "pp")] <- "projected_p"
colnames(data)[which(names(data) == "cp")] <- "constructive_p"
colnames(data)[which(names(data) == "bp")] <- "blind_p"
colnames(data)[which(names(data) == "ns")] <- "national_symbol"

colnames(data)[which(names(data) == "gender_respondent")] <- "gender"
colnames(data)[which(names(data) == "education_alt")] <- "education"

colnames(data)

correlation_matrix <- cor(data,  use = "complete.obs")
#correlation_matrix <- cor(data)


# Install and load the corrplot package for visualization
library(corrplot)

# Plot the correlation matrix
corrplot(correlation_matrix, method = "circle", type = "lower", tl.col = "black", tl.srt = 45)



png(file="us1_correlation1.6.png", height = 1111, width = 1311,  res = 300)
corrplot(correlation_matrix, method = "circle", type = "lower", tl.col = "black", tl.srt = 45)

dev.off()

rounded = cor(df_tr[,c('bp','cp','pp')])
xtable(rounded, caption = "Correlation matrix of key variables")

#DESCRIPTIVE 

# png(file="tr1_corr.png", height = 1111, width = 1311,  res = 300)
# corrplot(correlation_matrix, method = "circle", type = "lower", tl.col = "black", tl.srt = 45)
# 
# dev.off()


#for treatment, dif in dif w placebo.

# Function to calculate effect size (mean difference) and p-value
library(dplyr)
library(broom)

# Function to calculate effect size (mean difference) and p-value
get_did_stats <- function(data, group) {
  filtered_data <- filter(data, threat_v %in% c("placebo", group))
  
  # Ensure exactly 2 levels in filtered data
  if (n_distinct(filtered_data$threat_v) == 2) {
    t_test_result <- t.test(pp ~ threat_v, data = filtered_data)
    
    tibble(
      comparison = paste("placebo vs", group),
      effect_size = diff(t_test_result$estimate),
      p_value = t_test_result$p.value
    )
  } else {
    tibble(
      comparison = paste("placebo vs", group),
      effect_size = NA,
      p_value = NA
    )
  }
}

# Create a combined threat group
df_tr <- df_tr %>%
  mutate(threat_combined = ifelse(threat_v %in% c("culture", "economy", "general", "security"), 
                                  "combined_threat", 
                                  "placebo"))

df_tr$threat_combined = as.factor(df_tr$threat_combined)
levels(df_tr$threat_combined)
levels(df_tr$threat_v)

df_tr$threat_combined <- factor(df_tr$threat_combined,
                          levels = c("placebo", "combined_threat"))


# Generate the DiD table


get_did_stats_cb <- function(data, group) {
  filtered_data <- filter(data, threat_combined %in% c("placebo", group))
  
  # Ensure exactly 2 levels in filtered data
  if (n_distinct(filtered_data$threat_combined) == 2) {
    t_test_result <- t.test(pp ~ threat_combined, data = filtered_data)
    
    tibble(
      comparison = paste("placebo vs", group),
      effect_size = diff(t_test_result$estimate),
      p_value = t_test_result$p.value
    )
  } else {
    tibble(
      comparison = paste("placebo vs", group),
      effect_size = NA,
      p_value = NA
    )
  }
}


#DATA FOR ROBUSTNESS CHECKS: DURATION X3, MILITARY ALTERNATIVE

#.25
first_quantile <- quantile(df_tr$Duration..in.seconds., 0.25)

df_tr25 = subset(df_tr, Duration..in.seconds. > first_quantile)


#.20
first_quantile <- quantile(df_tr$Duration..in.seconds., 0.20)

df_tr20 = subset(df_tr, Duration..in.seconds. > first_quantile)


#.30
first_quantile <- quantile(df_tr$Duration..in.seconds., 0.30)

df_tr30 = subset(df_tr, Duration..in.seconds. > first_quantile)




########



# function: exact diff-in-means + SE + CI
get_did_stats_full <- function(data, group) {
  filtered_data <- dplyr::filter(data, threat_v %in% c("placebo", group))
  
  # ensure 2 groups
  if (dplyr::n_distinct(filtered_data$threat_v) != 2) {
    return(tibble(
      comparison = paste("placebo vs", group),
      effect_size = NA_real_,
      se = NA_real_,
      ci_low = NA_real_,
      ci_high = NA_real_,
      p_value = NA_real_
    ))
  }
  
  # t-test gives exact SE and CI
  tt <- t.test(pp ~ threat_v, data = filtered_data)
  
  # IMPORTANT: diff(tt$estimate) = mean(placebo) - mean(treat)
  # We want: treat - placebo
  eff <- -diff(tt$estimate)
  
  tibble(
    comparison = paste("placebo vs", group),
    effect_size = eff,
    se = as.numeric(tt$stderr),
    ci_low = eff - qt(0.975, df = tt$parameter) * as.numeric(tt$stderr),
    ci_high = eff + qt(0.975, df = tt$parameter) * as.numeric(tt$stderr),
    p_value = tt$p.value
  )
}

# combined threat exact stats
get_did_stats_cb_full <- function(data, group = "combined_threat") {
  filtered_data <- dplyr::filter(data, threat_combined %in% c("placebo", group))
  
  if (dplyr::n_distinct(filtered_data$threat_combined) != 2) {
    return(tibble(
      comparison = paste("placebo vs", group),
      effect_size = NA_real_,
      se = NA_real_,
      ci_low = NA_real_,
      ci_high = NA_real_,
      p_value = NA_real_
    ))
  }
  
  tt <- t.test(pp ~ threat_combined, data = filtered_data)
  eff <- -diff(tt$estimate)  # treat - placebo
  
  tibble(
    comparison = paste("placebo vs", group),
    effect_size = eff,
    se = as.numeric(tt$stderr),
    ci_low = eff - qt(0.975, df = tt$parameter) * as.numeric(tt$stderr),
    ci_high = eff + qt(0.975, df = tt$parameter) * as.numeric(tt$stderr),
    p_value = tt$p.value
  )
}

# build plot df
did_plot_df <- bind_rows(
  get_did_stats_full(df_tr, "culture"),
  get_did_stats_full(df_tr, "economy"),
  get_did_stats_full(df_tr, "general"),
  get_did_stats_full(df_tr, "security"),
  get_did_stats_cb_full(df_tr, "combined_threat")
) %>%
  mutate(
    label = gsub("placebo vs ", "", comparison),
    label = factor(label,
                   levels = c("culture", "economy", "general", "security", "combined_threat"))
  )

# coef plot
p_coef <- ggplot(did_plot_df, aes(x = effect_size, y = label)) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_errorbarh(aes(xmin = ci_low, xmax = ci_high), height = 0.2) +
  geom_point(size = 2) +
  labs(
    x = "Difference in means (Treatment − Placebo)",
    y = NULL,
    title = "Treatment effects on Projected Patriotism (Diff-in-means)"
  ) +
  theme_minimal(base_size = 13)

print(p_coef)


p_coef_clean <- ggplot(did_plot_df, aes(x = effect_size, y = label)) +
  geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6, color = "grey40") +
  geom_errorbarh(aes(xmin = ci_low, xmax = ci_high),
                 height = 0.2, linewidth = 1.2, color = "black") +
  geom_point(size = 3, color = "black") +
  labs(
    x = "Difference in means (Treatment − Placebo)",
    y = NULL,
    title = "Treatment effects on Projected Patriotism (Diff-in-means)"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_text(size = 12, face = "bold"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

print(p_coef_clean)


########
#MAIN ANALYSES

did_table <- bind_rows(
  get_did_stats(df_tr, "culture"),
  get_did_stats(df_tr, "economy"),
  get_did_stats(df_tr, "general"),
  get_did_stats(df_tr, "security"),
  get_did_stats_cb(df_tr, "combined_threat")  # Combined comparison
)

print(did_table)
library(xtable)
latex_table <- xtable(did_table)


did_table20 <- bind_rows(
  get_did_stats(df_tr20, "culture"),
  get_did_stats(df_tr20, "economy"),
  get_did_stats(df_tr20, "general"),
  get_did_stats(df_tr20, "security"),
  get_did_stats_cb(df_tr20, "combined_threat")  # Combined comparison
)

print(did_table20)
latex_table <- xtable(did_table20)
latex_table


did_table25 <- bind_rows(
  get_did_stats(df_tr25, "culture"),
  get_did_stats(df_tr25, "economy"),
  get_did_stats(df_tr25, "general"),
  get_did_stats(df_tr25, "security"),
  get_did_stats_cb(df_tr25, "combined_threat")  # Combined comparison
)

print(did_table25)
latex_table <- xtable(did_table25)

print(latex_table, type = "latex")

did_table30 <- bind_rows(
  get_did_stats(df_tr30, "culture"),
  get_did_stats(df_tr30, "economy"),
  get_did_stats(df_tr30, "general"),
  get_did_stats(df_tr30, "security"),
  get_did_stats_cb(df_tr30, "combined_threat")  # Combined comparison
)

print(did_table30)
latex_table <- xtable(did_table30)

# Print the LaTeX code
print(latex_table, type = "latex")
#xtable


#for regression:
# Run the regression
# Convert character columns to factors

# df_tr$military_binary = ifelse(df_tr$military == "Yes", 1, 0)
# df_tr$family_military = ifelse(df_tr$military_family == "Yes", 1, 0)


df_tr$military_binary <- ifelse(df_tr$military == "Yes", 1,
                                ifelse(df_tr$military == "No", 0, NA))

df_tr$family_military <- ifelse(df_tr$military_family == "Yes", 1,
                                ifelse(df_tr$military_family == "No", 0, NA))


df_tr <- df_tr %>%
  mutate(across(c("gender_respondent", "race", "ideology", "party", "employment", "threat_v"), as.factor))

df_tr$education_alt = as.numeric(df_tr$education_alt)
sapply(df_tr[, c("gender_respondent",  "race", "ideology", "party", "employment", "threat_v")], levels)

model <- lm(pp ~ cp + ns + bp + gender_respondent  + military_binary + race + ideology + party + employment + threat_v, data = df_tr)

summary(model)
# Get the tidy output of the regression
model_summary <- tidy(model)

xtable(model)

#all duration models
#.2
model <- lm(pp ~ cp + ns + bp + gender_respondent  + military_binary + race + ideology + party + employment + threat_v, data = df_tr20)

summary(model)
# Get the tidy output of the regression
model_summary <- tidy(model)

xtable(model)

#.25
model <- lm(pp ~ cp + ns + bp + gender_respondent  + military_binary + race + ideology + party + employment + threat_v, data = df_tr25)

summary(model)
# Get the tidy output of the regression
model_summary <- tidy(model)

xtable(model)

#.3
model <- lm(pp ~ cp + ns + bp + gender_respondent  + military_binary + race + ideology + party + employment + threat_v, data = df_tr30)

summary(model)
# Get the tidy output of the regression
model_summary <- tidy(model)

xtable(model)


variables_of_interest <- model_summary %>%
  filter(term %in% c( "ns", "military_binary")) %>%
  select(term, estimate, p.value)

# Print the table
print(variables_of_interest)

latex_table <- xtable(variables_of_interest)
latex_table
#family
model <- lm(pp ~ cp + ns + bp + gender_respondent  + family_military + race + ideology + party + employment + threat_v, data = df_tr)


tidy_two <- tidy(model, conf.int = TRUE) %>%
  filter(term %in% c("ns", "family_military")) %>%
  # rename manually without recode()
  mutate(term = ifelse(term == "ns", "National symbols", "Military service (family)"))


p_two <- ggplot(tidy_two, aes(x = estimate, y = term)) +
  geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6, color = "grey40") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                 height = 0.18, linewidth = 1.2, color = "black") +
  geom_point(size = 3.4, color = "black") +
  labs(
    x = "Coefficient estimate (95% CI)",
    y = NULL,
    title = "",
    subtitle = ""
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = "grey30"),
    axis.text.y = element_text(size = 12, face = "bold"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank()
  )

print(p_two)


summary(model)
xtable(model)

# Get the tidy output of the regression
model_summary <- tidy(model)
# Filter to only include variables of interest: cp, ns, military, and bp
variables_of_interest <- model_summary %>%
  filter(term %in% c("ns", "family_military")) %>%
  select(term, estimate, p.value)

# Print the table
print(variables_of_interest)

latex_table <- xtable(variables_of_interest)
latex_table
# Print the LaTeX code
print(latex_table, type = "latex")
#xtable


#ols? ordinal logit? 


# Fit a linear model
model <- lm(pp ~ cp + ns + bp +  military_binary + threat_combined +  gender_respondent  + race + ideology + party + employment , data = df_tr)

# Generate a summary of the model
model_summary <- summary(model)

# Convert the model summary into a LaTeX table
model_table <- xtable(model_summary)

# Print the LaTeX code
print(model_table, type = "latex")

# Fit a linear model, with alternative military
model <- lm(pp ~ cp + ns + bp +  family_military + threat_v + gender_respondent  + race + ideology + party + employment , data = df_tr)

# Generate a summary of the model
model_summary <- summary(model)

# Convert the model summary into a LaTeX table
model_table <- xtable(model_summary)

# Print the LaTeX code
print(model_table, type = "latex")

#with threat combined
# Fit a linear model, with alternative military
model <- lm(pp ~ cp + ns + bp +  family_military + threat_combined + gender_respondent  + race + ideology + party + employment , data = df_tr)

# Generate a summary of the model
model_summary <- summary(model)

# Convert the model summary into a LaTeX table
model_table <- xtable(model_summary)

# Print the LaTeX code
print(model_table, type = "latex")
