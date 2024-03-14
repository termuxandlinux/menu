#!/usr/bin/env python3

# ASCII Art banner
print('''
  ____            _      _  __ _     
 |  _ \  ___  ___| |_ __| |/ _(_)_ __
 | | | |/ _ \/ __| __/ _\` | |_| | '__|
 | |_| |  __/ (__| || (_| |  _| | |   
 |____/ \___|\___|\__\__,_|_| |_|_|   
''')

# Main menu function
def main_menu():
    print("[1] pkg")
    print("[2] pkgo")
    print("[3] apt")
    choice = input("Enter your choice: ")

    if choice == "1":
        pkg_menu()
    elif choice == "2":
        pkgo_menu()
    elif choice == "3":
        apt_menu()
    else:
        print("Invalid choice")

# pkg menu function
def pkg_menu():
    print("[1] install")
    print("[2] search")
    print("[3] update")
    pkg_choice = input("Enter your choice: ")

    if pkg_choice == "1":
        package_name = input("which package: ")
        print(f"pkg install -y {package_name}")
    elif pkg_choice == "2":
        package_name = input("which package: ")
        print(f"pkg search {package_name}")
    elif pkg_choice == "3":
        print("pkg update")
    else:
        print("Invalid choice")

# pkgo menu function
def pkgo_menu():
    print("[1] -i")
    print("[2] -u")
    print("[3] -d")
    pkgo_choice = input("Enter your choice: ")

    if pkgo_choice == "1":
        package_name = input("which package: ")
        print(f"pkgo -i {package_name}")
    elif pkgo_choice == "2":
        package_name = input("which package: ")
        print(f"pkgo -u {package_name}")
    elif pkgo_choice == "3":
        package_name = input("which package: ")
        print(f"pkgo -d {package_name}")
    else:
        print("Invalid choice")

# apt menu function
def apt_menu():
    print("[1] install")
    print("[2] search")
    print("[3] update")
    print("[4] upgrade")
    apt_choice = input("Enter your choice: ")

    if apt_choice == "1":
        package_name = input("which package: ")
        print(f"apt install -y {package_name}")
    elif apt_choice == "2":
        package_name = input("which package: ")
        print(f"apt search {package_name}")
    elif apt_choice == "3":
        print("apt update")
    elif apt_choice == "4":
        print("apt upgrade")
    else:
        print("Invalid choice")

# Main program
main_menu()
