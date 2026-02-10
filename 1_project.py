print("______________________________________________")
print("\n*****WELCOME TO STUDENT MANAGEMENT SYSTEM*****")
print("______________________________________________")
print("      ___________________________________      ")
l=["MOHAN_KUMAR","SUMAN_YAUDAV","VIKASH_YAUDAV","IPPU_YADAV","RITESH KUMAR"]
def view_list():
    for i in range(len(l)):
        print(l[i])
def add_data():
    x=input("\n enter the name:-")
    l.append(x)
    print("name added sucessfully....")
def remove_data():
    name=input("enter the name to remove:")
    if name in l:
        l.remove(name)
        print("name is deleted sucessfully.....")


def search_data():
    name=input("enter the name to search:")
    if name in l:
        
        print("this name is present in the list...")
    else:
        print("NAME NOT FOUND IN THE LIST...")
# main program
while (True):
    print("\n PLEASE THE ANY ONE OPTIONS.")
    print("1. TO VIEW THE STUDENT LIST.")
    print("2. TO ADD A NEW NAME IN THE LIST.")
    print("3. TO REMOVE  THE NAME IN THE LIST.")
    print("4. TO SEARCH NAME IN THE IN THE LIST.")
    print("5. EXIT")

    choice=int(input("\n ENTER THE ANY CHOICE:"))
    if choice==1:
        view_list()
    elif choice==2:
        add_data()
    elif choice==3:
        remove_data()
    elif choice==4:
        search_data()
    elif choice==5:
        print("THANK YOU FOR USING STUDENT MANAGEMENT SYSTEM")
        break
    else:
        print("INVALID CHOICE....")
    ch=input("DO YOU WANT TO CONTINUE (Y/N) : ")
    if (ch=='Y' or ch=='y'):
       continue
    else:
        break
        

    
