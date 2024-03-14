#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void pkg_menu();
void pkgo_menu();
void apt_menu();

void main_menu() {
    int choice;
    printf("[1] pkg\n");
    printf("[2] pkgo\n");
    printf("[3] apt\n");
    printf("Enter your choice: ");
    scanf("%d", &choice);

    switch(choice) {
        case 1:
            pkg_menu();
            break;
        case 2:
            pkgo_menu();
            break;
        case 3:
            apt_menu();
            break;
        default:
            printf("Invalid choice\n");
            break;
    }
}

void pkg_menu() {
    int pkg_choice;
    char package_name[100];

    printf("[1] install\n");
    printf("[2] search\n");
    printf("[3] update\n");
    printf("Enter your choice: ");
    scanf("%d", &pkg_choice);

    switch(pkg_choice) {
        case 1:
            printf("which package: ");
            scanf("%s", package_name);
            printf("pkg install -y %s\n", package_name);
            break;
        case 2:
            printf("which package: ");
            scanf("%s", package_name);
            printf("pkg search %s\n", package_name);
            break;
        case 3:
            printf("pkg update\n");
            break;
        default:
            printf("Invalid choice\n");
            break;
    }
}

void pkgo_menu() {
    int pkgo_choice;
    char package_name[100];

    printf("[1] -i\n");
    printf("[2] -u\n");
    printf("[3] -d\n");
    printf("Enter your choice: ");
    scanf("%d", &pkgo_choice);

    switch(pkgo_choice) {
        case 1:
            printf("which package: ");
            scanf("%s", package_name);
            printf("pkgo -i %s\n", package_name);
            break;
        case 2:
            printf("which package: ");
            scanf("%s", package_name);
            printf("pkgo -u %s\n", package_name);
            break;
        case 3:
            printf("which package: ");
            scanf("%s", package_name);
            printf("pkgo -d %s\n", package_name);
            break;
        default:
            printf("Invalid choice\n");
            break;
    }
}

void apt_menu() {
    int apt_choice;
    char package_name[100];

    printf("[1] install\n");
    printf("[2] search\n");
    printf("[3] update\n");
    printf("[4] upgrade\n");
    printf("Enter your choice: ");
    scanf("%d", &apt_choice);

    switch(apt_choice) {
        case 1:
            printf("which package: ");
            scanf("%s", package_name);
            printf("apt install -y %s\n", package_name);
            break;
        case 2:
            printf("which package: ");
            scanf("%s", package_name);
            printf("apt search %s\n", package_name);
            break;
        case 3:
            printf("apt update\n");
            break;
        case 4:
            printf("apt upgrade\n");
            break;
        default:
            printf("Invalid choice\n");
            break;
    }
}

int main() {
    main_menu();
    return 0;
}
