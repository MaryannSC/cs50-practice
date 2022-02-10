sum = 0

num = int(input("How many values would you like to sum? "))

for i in range(num):
    x = int(input(f"Enter value {i + 1}: "))
    sum += x

print(f"The sum is: {sum}")

