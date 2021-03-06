
#
# Uwaga: 
# Funkcja percent_map jest zaprojektowana do dzia�ania ze zbiorem danych stany.rds
# Mo�e nie dzia�a� poprawnie z innymi zbiorami danych je�eli kolejno�� ich wierszy
# nie b�dzie dok�adnie odpowiada� kolejno�ci, w jakiej pakiet "maps" generuje wykresy danych.

percent_map <- function(var, color, legend.title, min = 0, max = 100) {

  # wygeneruj wektor kolor�w wype�niaj�cych dla mapy
  shades <- colorRampPalette(c("white", color))(100)
  
  # ogranicz gradient do procent�w, kt�re wyst�puj� mi�dzy min a max
  var <- pmax(var, min)
  var <- pmin(var, max)
  percents <- as.integer(cut(var, 100, 
    include.lowest = TRUE, ordered = TRUE))
  fills <- shades[percents]

  # wygeneruj kartogram (map� typu choropleth)
  
  # wype�nij hrabstwa kolorem
  map("county", fill = TRUE, col = fills, 
    resolution = 0, lty = 0, projection = "polyconic", 
    myborder = 0, mar = c(0,0,0,0))
  
  # na�� granice stan�w
  map("state", col = "white", fill = FALSE, add = TRUE,
    lty = 1, lwd = 1, projection = "polyconic", 
    myborder = 0, mar = c(0,0,0,0))
  
  # dodaj legend�
  inc <- (max - min) / 4
  legend.text <- c(paste0(min, " % lub mniej"),
    paste0(min + inc, " %"),
    paste0(min + 2 * inc, " %"),
    paste0(min + 3 * inc, " %"),
    paste0(max, " % lub wi�cej"))
  
  legend("bottomleft",
    legend = legend.text, 
    fill = shades[c(1, 25, 50, 75, 100)], 
    title = legend.title)
}

