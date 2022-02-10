def main():
    score = int(input("Score: "))

    print_score(score)

def print_score(n):
    for i in range(n):
        print("#", end = "")
    print()

main()