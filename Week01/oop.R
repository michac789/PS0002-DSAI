"
R Object Oriented Programming
"

# S3 Class
# define new object & instance variable
circ1 <- list(radius = 5, color = "red")
class(circ1) <- "Circle"
circ1$color
# define methods
print.circle <- function(obj) {
    cat(obj$color, "circle with radius", obj$radius, "\n")
}
# add new attributes
attributes(circ1)
attr(circ1, "bordercolor") <- c("black")
attributes(circ1)

# S4 Class
rect <- setClass("Rectangle", slots = list(
    width = "numeric", height = "numeric", color = "character"
)) # rect here is saved as a constructor for this object
rect1 <- new("Rectangle", height = 10, width = 6, color = "red")
rect2 <- rect(height = 7, width = 5)
show(rect1) # print object
rect1@width # access slot
rect1@width <- 3 # modify slot
rect2@color <- "black"
show(rect2)
# create methods
setMethod("area", "Rectangle",
    function(obj) {
        return(obj@width * obj@height)
    }
)
area(rect1)
# inheritance
sq <- setClass("Square", contains = "Rectangle")
setMethod("area", "Square",
    function(obj) {
        return(obj@width * obj@width)
    }
)
square <- sq(width = 10, color = "blue")
square
