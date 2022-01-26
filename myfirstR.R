# You can use R studio or VS Code with radian and appropriate extension to load R files
# Use '#' to comment, similar to in Python
# Get use in using R studio first before going the project

# Assigning variable & prining
print("hello world")
x = 6
(6 %% 2) != 8 || 10 == 9 -> y
print(x)
print(y)

# Conditional
if (y && x >= 7){
    print("statement1")
} else if (x == 6) {
    print("statement2")
} else {
    print("statement3")
}

# Switch Case
option1 = 3
switch(option1,
    {print("a")},
    {print("b")},
    {print("c")},
    )
option2 = "goodbye"
switch(option2,
    "hello" = {print("welcome!")},
    "goodbye" = {print("see you later!")},
    )
