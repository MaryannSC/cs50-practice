import random
import time

def main():
    number = random.randint(5,15)
    countdown(number)
    print("Happy New Year!")

def countdown(n):
    for i in range(n, 0, -1):
        print(i)
        time.sleep()

main()

