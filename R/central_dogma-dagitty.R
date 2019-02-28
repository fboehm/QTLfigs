library(dagitty)


g2 <- dagitty( "dag {
    Y <- X <- Z1 <- V -> Z2 -> Y
    Z1 <- W1 <-> W2 -> Z2
    X <- W1 -> Y
    X <- W2 -> Y
}")

plot(graphLayout(g2))

#####
g <- dagitty('dag {
    DNA [pos="0,0"]
    RNA [pos="1,0"]
    Protein [pos="2,0"]

    DNA -> RNA -> Protein
}')


pdf("Figs/central_dogma.pdf", height = 2)
plot(g)
dev.off()

#####
g <- dagitty('dag {
    Dhtkd1_DNA [pos="0,0"]
    Dhtkd1_RNA [pos="1,0"]
    DHTKD1_Protein [pos="2,0"]

    Dhtkd1_DNA -> Dhtkd1_RNA -> DHTKD1_Protein
}')





pdf("Figs/central_dogma-Dhtkd1.pdf", height = 2)
plot(g)
dev.off()

svg("Figs/central_dogma-Dhtkd1.svg", height = 2)
plot(g)
dev.off()






#####
# ggdag, dagitty & ggraph
# tips for labeling edges: https://www.data-imaginist.com/2017/ggraph-introduction-edges/
library(ggdag)
library(ggraph)
library(igraph)

simple <- make_graph('bull')
# Random names - I swear
V(simple)$name <- c('Thomas', 'Bob', 'Hadley', 'Winston', 'Baptiste')
E(simple)$type <- sample(c('friend', 'foe'), 5, TRUE)
ggraph(simple, layout = 'graphopt') + 
  geom_edge_link(arrow = arrow(length = unit(4, 'mm'))) + 
  geom_node_point(size = 5)
ggraph(simple, layout = 'graphopt') + 
  geom_edge_link(arrow = arrow(length = unit(4, 'mm')), 
                 end_cap = circle(3, 'mm')) + 
  geom_node_point(size = 5)
ggraph(simple, layout = 'graphopt') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name),
                     end_cap = label_rect(node2.name)), 
                 arrow = arrow(length = unit(4, 'mm'))) + 
  geom_node_text(aes(label = name))
ggraph(simple, layout = 'graphopt') + 
  geom_edge_link(aes(label = type), 
                 arrow = arrow(length = unit(4, 'mm')), 
                 end_cap = circle(3, 'mm')) + 
  geom_node_point(size = 5)
ggraph(simple, layout = 'graphopt') + 
  geom_edge_link(aes(label = type), 
                 angle_calc = 'along',
                 label_dodge = unit(2.5, 'mm'),
                 arrow = arrow(length = unit(4, 'mm')), 
                 end_cap = circle(3, 'mm')) + 
  geom_node_point(size = 5)
g3 <- graph_from_literal(DNA --+ RNA --+ Protein)
ggraph(g3, layout = 'graphopt') + 
  geom_edge_link(aes(label = type), 
                 angle_calc = 'along',
                 label_dodge = unit(2.5, 'mm'),
                 arrow = arrow(length = unit(4, 'mm')), 
                 end_cap = circle(3, 'mm')) + 
  geom_node_point(size = 5)
####
ll <- create_layout(g3, "igraph", algorithm = "nicely")
ggraph(ll) + 
  geom_edge_link(#aes(label = type), 
                 angle_calc = 'along',
                 label_dodge = unit(2.5, 'mm'),
                 arrow = arrow(length = unit(4, 'mm')), 
                 end_cap = circle(3, 'mm')) + 
  geom_node_point(size = 5)
node_positions <- tibble::tibble(x = c(0, 1, 2), y = 0)
g3 %>% 
  layout_igraph_manual(node.positions = node_positions, circular = FALSE)
