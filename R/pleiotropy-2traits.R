library(broman)
bgcolor <- brocolors("bg")
iArrows <- igraph:::igraph.Arrows

par(fg="white",col="white",col.axis="white",col.lab="white",col.main="white",
    bg=bgcolor, mar=rep(0.1, 4), bty="n")

plot(0,0, xaxt="n", yaxt="n", xlab="", ylab="", type="n",
     xlim=c(-16-2/3, 150), ylim=c(0, 100), xaxs="i", yaxs="i")
x <- c(25, 75)
xmid <- 50
y <- seq(10, 90, len=5)
text(x[1], y[3], expression(Q))

text(x[2], y[2], expression(Y[2]))
#text(x[2], y[3], expression(Y[2]))
text(x[2], y[4], expression(Y[1]))

arrowcol <- brocolors("crayons")["Cerulean"]
xd <- 8
yd <- 3.5
arrowlwd <- 5
arrowlen <- 0.3
arrows(x[1]+xd, y[3] - yd, x[2] - xd, y[2] + yd, lwd=arrowlwd,
      col=arrowcol, len=arrowlen)
arrows(x[1]+xd, y[3] + yd, x[2] - xd, y[4] - yd, lwd=arrowlwd,
      col=arrowcol, len=arrowlen)
dev.off()
