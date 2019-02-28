fig_width <- 15
fig_height <- 10


pdf("R/hs_fig.pdf", width = fig_width, height = fig_height)
source("R/hs_fig.R")
dev.off()

svg("R/hs_fig.svg", width = fig_width, height = fig_height)
source("R/hs_fig.R")
dev.off()
