# Conditional - IF
if (y && x >= 7){
    print("statement1")
} else if (x == 6) {
    print("statement2")
} else {
    print("statement3")
}

# Conditional - Switch Case
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

# Conditional - Ternary
num <- if(2^2 == 1) "a" else "b"
print(num)
