/*****************************************************************
//
// FILE: hw3main.c
//
// DESCRIPTION: This file contains the main function to drive hw3
//
//****************************************************************/

#include <iostream>
#include <string.h>
#include <stdlib.h>
#include "llist.h"

using namespace std;

int debug = 0;

int main(int argc, char * argv[])
{
        llist list;
        int choice = 0;

        cout << "\nSystem Recorder v2.0\n";

        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           DEBUG MODE ENABLED\n";
            cout << "******************************************\n";
        #endif
    /* Main menu loop */
    do
    {
        int bYear;
        int account;
        char fullName[25];
        char address[80];
        int clear;

        cout << "+------------------------+\n";
        cout << "|     --Main menu--      |\n";
        cout << "|  [1]\tAdd new record   |\n";
        cout << "|  [2]\tModify record    |\n";
        cout << "|  [3]\tPrint record     |\n";
        cout << "|  [4]\tPrint database   |\n";
        cout << "|  [5]\tDelete record    |\n";
        cout << "|  [6]\tExit             |\n";
        cout << "|  [7]\tClear screen     |\n";
        cout << "+------------------------+\n\n";

        cout << "Enter a number to make a selection: \n";

        cin >> choice;

        /* User selection */
        switch (choice)
        {
            case 1:
                cout << "Add new record\n\n";

                cout << "Enter your account number:\n";
                cin >> account;
                cout << "\n";

                cout << "Enter your first and last name:\n";
                cin.ignore();
                cin.getline (fullName, sizeof(fullName));
                cout << "\n";

                cout << "Enter your birth year:\n";
                cin >> bYear;
                cout << "\n";

                cout << "Enter your address as follows:\n";
                cout << "Street Number, Street Name, Apartment Number\n";
                cin.ignore();
                cin.getline (address, sizeof(address));
                cout << "\n";

                list.addRecord(account, fullName, address, bYear);
                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           addRecord invoked\n";
                    cout << "******************************************\n";
                #endif

                break;
            case 2:
                cout << "Modify record\n\n";

                cout << "Enter your account number:\n";
                cin >> account;
                cout << "\n";

                cout << "Enter your address as follows:\n";
                cout << "Street Number, Street Name, Apartment Number\n";
                cin >> address;
                cin.ignore();
                cin.getline (address, sizeof(address));
                cout << "\n";

                list.modifyRecord(account, address);

                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           modifyRecord invoked\n";
                    cout << "******************************************\n";
                #endif

                choice = 0;
                break;
            case 3:
                cout << "Print record\n\n";
                cout << "Enter your account number:\n";
                cin >> account;
                cout << "\n";

                list.printRecord(account);

                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           printRecord invoked\n";
                    cout << "******************************************\n";
                #endif

                break;
            case 4:
                cout << "Print database\n\n";

                list.printAll();

                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           printAll invoked\n";
                    cout << "******************************************\n";
                #endif

                break;
            case 5:
                cout << "Delete record\n\n";
                cout << "Enter your account number:\n";
                cin >> account;
                cout << "\n";
                list.deleteRecord(account);

                #ifdef DEBUG
                    cout << "*add*****************************************\n";
                    cout << "           deleteRecord invoked\n";
                    cout << "******************************************\n";
                #endif

                break;
            case 6:
                exit(0);
                break;
            case 7:
                for (clear = 0; clear < 50; clear++ )
                    cout << "\n";
                break;
            default:
                cout << "Invalid entry, stopping program...\n\n";
                exit(0);

                break;
        }
        choice = 0;
    } while(choice == 0);
}
