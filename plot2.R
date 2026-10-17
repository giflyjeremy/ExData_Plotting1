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

# Menggunakan nama hari dalam bahasa Inggris.
Sys.setlocale("LC_TIME", "C")

# Menyimpan grafik kedua.
png("plot2.png", width = 480, height = 480, bg = "white")

plot(
  power$datetime,
  power$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

dev.off()