"
R Getting Started
"

# You can use R studio or VS Code with radian and appropriate R extension
# Use '#' to comment, similar to in Python, or " " for multiline comments
# Get use in using R studio first before doing the project

# Assigning variable, prompting for value, prining
name <- readline("Enter your name: ") # prompt user input in r
sentence <- sprintf("Hello, %s!", name) # formatted string in r
a <- b <- c <- "morning" # assigning same value to multiple variables
welcome <- paste(a, b, c) # concatenate elements in r, alternatively use 'cat'
(6 %% 2) != 8 || 10 == 9 -> y # '%%' for modulus, '%/%' for integer division
print(y)
print(welcome)
print(sentence, quote = FALSE)
