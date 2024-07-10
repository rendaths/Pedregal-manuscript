## figure for paper
library(patchwork)
library(ggplotify)

source("scripts/contextual_tree_map.R")
source("scripts/contextual_tree.R")

((tree_plot2/zoom1)|plot_lac)/leg+ 
  plot_layout(heights =c(8, 2))
?plot_layout

# Combine tree_plot2 and zoom1 with specified widths
combined_tree_zoom <- ((tree_plot2/zoom1)|plot_lac) + plot_layout(widths = c(3, 1));combined_tree_zoom 

# Combine the plots into the final layout
combined_plot <- combined_tree_zoom/ leg + 
  plot_layout(heights = c(8, 2));combined_plot
