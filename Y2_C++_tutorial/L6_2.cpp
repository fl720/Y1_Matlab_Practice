// passing by value and reference 

#include <iostream>

using namespace std;

int myFunction( int &x, int &y ) ; 

int main() {
    int a = 2 ; 
    int b = 3 ;

    int c = myFunction(a,b) ; 
    cout << c << endl ; 

    cout << "a = " << a << endl ; 
    cout << "b = " << b << endl ;

    return 0 ; 
}

int myFunction(int &x , int &y ) {
    x *= 2 ;  // it will multiply x by 2 and store into x, which is same as x = x*2
    return x + y^2 ; 
}

// in order to change by refernce we add "&" before the parameter. so x and y will then be aliases for a and b. a and x will have same memory location but different name. Same applied for b and y. 