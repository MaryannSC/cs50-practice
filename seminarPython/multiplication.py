def main():
    for i in range(1, 11):
        for j in range(1, 11):
            multiply(i, j)
        print()

def multiply(x, y):
    product = x * y
    print(f"{x} * {y} = {product}")

main()
