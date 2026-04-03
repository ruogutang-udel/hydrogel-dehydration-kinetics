# ===== 1. Load data =====
data <- read.csv("Water_dehydration_4 samples+60C.csv")

# Check data
head(data)
names(data)

# Extract time
t <- data$`Placing time`
# ===== 2. Plot raw data =====
plot(
  t,
  data$`Biochar/hydrogel 90:10`,
  type = "b",
  pch = 16,
  lwd = 2,
  col = "black",
  xlab = "Time (h)",
  ylab = "Water retention (%)",
  main = "Dehydration at 60°C",
  ylim = c(0, 100)
)

lines(t, data$`Biochar/hydrogel 80:20`, col = "red", lwd = 2, lty = 2)
lines(t, data$`Biochar/hydrogel 70:30`, col = "blue", lwd = 2, lty = 3)
lines(t, data$`Pure hydrogel`, col = "forestgreen", lwd = 2, lty = 4)

legend(
  "topright",
  legend = c("90:10", "80:20", "70:30", "Pure hydrogel"),
  col = c("black", "red", "blue", "forestgreen"),
  lty = c(1, 2, 3, 4),
  lwd = 2,
  bty = "n"
)
# ===== 3. Model function =====
fit_model <- function(y, t) {
  fit <- nls(
    y ~ y0 + (100 - y0) * exp(-k * t),
    start = list(y0 = 10, k = 0.01)
  )
  return(coef(fit))
}
# ===== 4. Fit all samples =====
coef_9010 <- fit_model(data$`Biochar/hydrogel 90:10`, t)
coef_8020 <- fit_model(data$`Biochar/hydrogel 80:20`, t)
coef_7030 <- fit_model(data$`Biochar/hydrogel 70:30`, t)
coef_pure <- fit_model(data$`Pure hydrogel`, t)
# ===== 5. Extract parameters =====
k_values <- c(
  coef_9010["k"],
  coef_8020["k"],
  coef_7030["k"],
  coef_pure["k"]
)

y0_values <- c(
  coef_9010["y0"],
  coef_8020["y0"],
  coef_7030["y0"],
  coef_pure["y0"]
)

labels <- c("90:10", "80:20", "70:30", "Pure hydrogel")
# ===== 6. Plot k comparison =====
barplot(
  k_values,
  names.arg = labels,
  col = c("black", "red", "blue", "forestgreen"),
  ylab = "Dehydration rate constant (k)",
  main = "Comparison of dehydration rates"
)
# ===== 7. Plot fitted curves =====
t_fit <- seq(0, 120, length.out = 100)

plot(
  t,
  data$`Biochar/hydrogel 90:10`,
  pch = 16,
  col = "black",
  xlab = "Time (h)",
  ylab = "Water retention (%)",
  main = "Model fitting",
  ylim = c(0, 100)
)

lines(
  t_fit,
  coef_9010["y0"] + (100 - coef_9010["y0"]) * exp(-coef_9010["k"] * t_fit),
  col = "black",
  lwd = 2
)