# Looping - FOR
for(i in 2:5){
    print(i)
}
print("")

# Looping - WHILE
x = 3
while(x < 2^3){
    print(x)
    x = x + 2
}

# Print all number which are multiple of 4 given a lower and upper bound
lower <- readline("Enter lower bound: ")
upper <- readline("Enter upper bound: ")
for(num in lower:upper){
    if (num %% 4 == 0){
        print(num)
    }
}
