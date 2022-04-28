//I/O 
#include <iostream>
#include <limits>
#include <string>
using namespace std;

int main() {

    string input ; 
    cout << " Enter text(whitespace-delimited):" ;
    cin >> input ; 

    cout << "using stream operators :" << input << endl ; 
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    cout << "Using default genline: " <<input << endl ;
    cout << "Enter text (comma-delimited):" ; 
    getline(cin, input, ',' ) ; 

    cout << "Using comma separator: " << input << endl ; 
    cin.ignore(numeric_limits<streamsize>::max() , '\n' ) ; 

    return 0 ; 
}