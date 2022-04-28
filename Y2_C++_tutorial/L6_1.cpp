// function
#include <iostream>

using namespace std;

int addNumbers ( int x , int y ) {
    return x + y ; 
}

int main() {
    int a = 2 ;
    int b = 3 ; 

    cout << addNumbers( a , b ) << endl ; 


    return 0 ; 
}

/* however, if we define the addNumbers function after the main it will have compile error ( as the program did not define the function before the main function ) to solve that we can just define an empty function just with the name on  : 

    int addNumbers ( int x , int y ) ;     // <----this aka : decoration

    int main() {
        int a = 2 ;
        int b = 3 ; 

        cout << addNumbers( a , b ) << endl ; 


        return 0 ; 
    }

    int addNumbers ( int x , int y ) {     // <---- this is definition 
        return x + y ; 
    }

*/ 
