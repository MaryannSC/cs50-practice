import random

num = random.randint(1,10)
#print(num)
print("You have 3 tries to guess a random number :)")


for tries in range(3):
    guess = int(input(f"What is your guess? "))
    if guess > num:
        print("Your guess is too high")
    elif guess < num:
        print("Your guess is too low")
    elif guess == num:
        print("You got it!")
        break

# while guess != num and tries > 1:
#     if guess > num:
#         print("Your guess is too high")
#     elif guess < num:
#         print("Your guess is too low")
#     tries -= 1
#     guess = int(input("What is your guess? "))




