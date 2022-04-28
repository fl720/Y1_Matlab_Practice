//while loop
#include <iostream>
#include <string>
using namespace std;

int main() {
    int n ; 
    string vInput ; 

    //Read a number from the user and convert it tii an interger
    cout<< "Enter a starting number: " ; 
    cin >> vInput ; 
    n = stoi(vInput) ; 

    if ( n < 0 ) {
        cout << "Invalid number entered." << endl ; 
        return 1 ; 
    }


//    while ( n> 0 ) {
//        cout << n << ", " ; 
//      --n ; 
//   }  


    do {
        cout << n << ", " ; 
        --n ; 
    } while ( n> 0 ) ; 
    // with do in the front it will run the loop first before it check the condition! 
    
    cout << "FIRE!" << endl ; 

    return 0 ; 
}