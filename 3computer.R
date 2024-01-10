# Exercise 3.1

# Read the data
intel <- read.table("data/intel.txt", header = TRUE)
sunspot <- read.table("data/sunspot.txt", header = TRUE)
mlco2 <- read.table("data/mlco2.txt", header = TRUE, row.names = 1)
sales <- read.table("data/sales.txt", header = TRUE, row.names = 4)
passengers <- read.table("data/passengers.txt", header = TRUE, row.names = 4)

str(intel)
str(sunspot)
str(mlco2)
str(sales)
str(passengers)

# Create ts objects
# Vectors, matrices and data frames can be given as an input. In the case of
# matrices and data frames, It is assumed that each column represents one
# univariate time series.
intel_ts <- ts(intel[, -1])

# One can specify start of the time series
sunspot_ts <- ts(sunspot$Spots, start = 1749)

# One can also specify number of observation per unit of time. In below cases
# we say that there are 12 observations per year, i.e., one per month.
mlco2_ts <- ts(mlco2$MLCO2, frequency = 12)
sales_ts <- ts(sales$Sales, start = 1970, frequency = 12)

# Instead of specifying frequency one can set the fraction of the sampling
# period between successive observations with argument deltat.
passengers_ts <- ts(passengers$Passengers, start = 1949, deltat = 1 / 12)


# 1. Intel
# Without setting yax.flip = TRUE y-tick labels are on top of each other.
plot(intel_ts, yax.flip = TRUE)

# i) Intel_Close
# - No trend
# - No seasonality
# - Level of the time series alters
# => Time series does not seem stationary

# ii) Intel_Volume
# - No trend
# - No seasonality
# - Level of the time series alters
# => Time series does not seem stationary

# 2. Sun spots
plot(sunspot_ts)

# - No trend
# - Seasonality with approx 11 year period
# - Amplitude alters
# => Time series does not seem stationary

# 3. MLCO2
plot(mlco2_ts)

# - Linear upward trend
# - Seasonality with approx 12 months
# => Time series does not seem stationary

# 5. Sales
plot(sales_ts)

# - Upward trend
# - Seasonality with approx 12 months. Amplitude increases by time.
# => Time series does not seem stationary.

# 6. Passengers
plot(passengers_ts)

# - Upward slightly curvilinear trend
# - Seasonality with approx 12 months. Amplitude increases by time.
# => Time series does not seem stationary.

# Exercise 3.2
par(mfrow = c(1, 2))
plot(passengers_ts, main = "Passengers")
plot(log(passengers_ts), main = "Log(Passengers)")
dev.off()

# With logarithmic scale amplitude stays almost constant.
# With logarithmic scale curvature trend gets slightly overcompesated.


# Exercise 3.3
# acf/pacf plots should decay to zero quite fast for stationary processes.
# However, note that sample acf/pacf are defined also for nonstationary
# distributions. In case of nonstationary distributions acf/pacf plots are
# useful for example in detecting trend and seasonality.

# 1. Intel close
par(mfrow = c(1, 2))
acf(intel_ts[, "Intel_Close"], lag.max = Inf, main = "ACF of Intel_Close")
pacf(intel_ts[, "Intel_Close"], lag.max = Inf, main = "PACF of Intel_Close")

# Based on acf/pacf plots only, intel_close could be stationary.


# 1. Sun spots
par(mfrow = c(1, 2))
acf(sunspot_ts, main = "ACF of Spots")
pacf(sunspot_ts, main = "PACF of Spots")

# By previous plots it was clear that sunspots is not stationary. This is also
# clear from the autocorrelation plots. That is, acf decays quite slowly.
# In addition, length of season can be easily seen from the acf plot.
