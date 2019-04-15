library(dagitty)



gg <- dagitty('dag {
              QTL [pos="0,0"] 
              M [pos="1,0"]
              Y [pos="2,0"]
              C1 [pos="1,0.5"]
              C2 [pos="1,-0.5"]
              C3 [pos="0, -0.5"]
              
              QTL -> M -> Y
              QTL <- C1 -> Y
              M <- C2 -> Y
              QTL <- C3 -> M
              QTL -> Y}')

plot(graphLayout(gg))




gg %>%
  tidy_dagitty() %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_node() +
  geom_dag_text() +
  geom_dag_edges_arc(curvature = 0.1) +
  theme_dag() +
  scale_dag()
ggsave("Figs/confounding.pdf", width = 6.5, height = 4)



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

###########

bigger_dag <- dagify(Y ~ QTL + M + C1 + C2,
                     QTL ~ C1,
                     M ~ QTL + C2
                     )

bigger_dag %>% 
  node_parents("QTL") %>%
  ggdag_canonical() %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend, color = parent)) +
  geom_dag_node() +
  geom_dag_edges() +
  geom_dag_text(col = "white") +
  theme_dag() +
  scale_adjusted() + 
  theme(legend.position='none')
