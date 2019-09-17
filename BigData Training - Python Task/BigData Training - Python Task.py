# ----------> Function for conatenatenation
def concatenate(string_1, string_2):
    """ Concatenates and prints two strings \n Works as a calculator if there are addition expressions in both bthe string.\n"""
    try:
        total = float(0)
        # -----> Splitting both the strings on the basis of plus sign
        numbers_1 = string_1.strip().split('+')
        numbers_2 = string_2.strip().split('+')

        # if the length of the two strings is equal after the split that means there is no plus sign.
        # We will simply concatenate them
        if len(numbers_1) == 1 and len(numbers_2) == 1:
            try:
                # if each input is a single number
                numbers_1 = int(numbers_1[0])
                numbers_2 = int(numbers_2[0])
                print(numbers_1+numbers_2)
            except:
                print(string_1+string_2)
        # if the length of one oif the string does not match the original string, it means there is a plus sign in eith or both strings
        else:
            # Traversing through list of numebers generated from string_1
            for num in numbers_1:
                if num is not '':
                    # converting each number to add to the total result
                    num = float(num)
                    total += num
            # Traversing through list of numebers generated from string_1
            for num in numbers_2:
                if num is not '':
                    # converting each number to add to the total result
                    num = float(num)
                    total += num

            print(total)

    except:
        # In case both strings are not expresions or string.
        print("Invalid Input.\n Either write both the expressions or both strings")
        return

# -----------------------> Main Function
string_1 = input("Enter the first string: ")
string_2 = input("Enter the second string: ")
concatenate(string_1, string_2)