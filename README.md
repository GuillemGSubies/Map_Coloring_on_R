# Map_Coloring_on_R

Simple program to color (with 4 colors) a planar graph or a map. This is an excercice for the subject Computational Geometry in the Mathematics Degree at the Universidad Rey Juan carlos. As we did not find any R program to color a map on the internet, we decided to upload this to GitHub.

### How to use the code
##### Installation

If you don't have installed the library data.table, uncomment
``` R
# install.packages("data.table")
```

##### Prerequisites

The graph must be planar and it should have 4 or more vertex, otherwise the coloring is trivial.
The function `pintame` only accepts graphs as adjacency matrix as input. For example, this would be a good graph:
``` R
m <- matrix(c(0,1,0,0,1,0,0,1,0,1,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,1,0), nrow=7, ncol=7, byrow=TRUE)
```

##### Output

The output is a matrix where the first column is the number of the vertex and the second one is the color we should apply to it (each color is a number).

##### Disclaimer

The code is not optimal, at all. Also it has not been tested thoroughly.
