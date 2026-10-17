# Membaca dataset; tanda ? menunjukkan nilai yang hilang.
power <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  colClasses = c("character", "character", rep("numeric", 7)),
  stringsAsFactors = FALSE,
  comment.char = ""
)

# Memilih data tanggal 1 dan 2 Februari 2007.
power <- power[
  power$Date %in% c("1/2/2007", "2/2/2007"),
]

# Memastikan tersedia 2.880 pengamatan per menit.
stopifnot(nrow(power) == 2880)

# Menyimpan histogram berukuran 480 x 480 piksel.
png(
  filename = "plot1.png",
  width = 480,
  height = 480,
  bg = "white"
)

hist(
  power$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency"
)

dev.off()