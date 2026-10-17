# Membaca dataset.
power <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  colClasses = c("character", "character", rep("numeric", 7)),
  stringsAsFactors = FALSE,
  comment.char = ""
)

# Memilih tanggal 1 dan 2 Februari 2007.
power <- power[
  power$Date %in% c("1/2/2007", "2/2/2007"),
]

stopifnot(nrow(power) == 2880)

# Menggabungkan tanggal dan waktu.
power$datetime <- as.POSIXct(
  paste(power$Date, power$Time),
  format = "%d/%m/%Y %H:%M:%S",
  tz = "UTC"
)

power <- power[order(power$datetime), ]
Sys.setlocale("LC_TIME", "C")

# Membuka file PNG dan mengatur empat panel.
png("plot4.png", width = 480, height = 480, bg = "white")

par(mfrow = c(2, 2))

# Kiri atas: daya aktif.
plot(
  power$datetime,
  power$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Kanan atas: tegangan.
plot(
  power$datetime,
  power$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# Kiri bawah: tiga pengukuran energi.
plot(
  power$datetime,
  power$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering",
  ylim = range(
    power[c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")],
    na.rm = TRUE
  )
)

lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")

legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

# Kanan bawah: daya reaktif.
plot(
  power$datetime,
  power$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

dev.off()