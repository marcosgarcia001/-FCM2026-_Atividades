library(tidyverse)
library(ggplot2)

dados <- read.csv("Pokemon_full.csv")

dados %>% 
  ggplot(aes(x = type, y = attack, colour = type)) + 
  geom_boxplot(size = 1, alpha = 0.8, width = 0.8, staplewidth = 0.6) + 
  scale_color_manual(name = "Tipo de Pokemon",
                     values = c("bug" = "#D2B48C", 
                                "dark" = "#030303",
                                "dragon"  = "orangered",
                                "eletric" = "#FFD700",
                                "fairy" = "#EEA2AD",
                                "fighting" = "#FFA07A",
                                "fire" = "#FF3030",
                                "flying" = "#CDC0B0",
                                "ghost" = "#838B8B",
                                "grass" = "#66CD00",
                                "ground" = "#8B4513",
                                "ice" = "#98F5FF",
                                "normal" = "#424242",
                                "poison" = "#7D26CD",
                                "psychic" = "#DB7093",
                                "rock" = "#CDC9C9",
                                "steel" = "#8B8B83",
                                "water" = "#3A5FCD"
                     ),
                     labels = c("Setosa", "Versicolor", "Virginica")) +
  scale_size(range = c(3, 5)) +
  labs(title = "Faixa de ataque dos Tipos de Pokemons",
       caption = "Fonte: Pokemon_full.csv",
       x = "Tipo de Pokemon",
       y = "Ataque",) + 
  theme_minimal(base_size = 12) + 
  theme(
    plot.title = element_text(family = "Arial", face = "bold", size = 18),
    legend.position = "none",
    panel.grid.minor = element_blank()
  )
  
