//arrays 

#include <iostream>

using namespace std;

int main() {

    int a[ 5 ] = {} ; // the array of size 5 ; a[5] = {} to initialise all to 0 or put number inside the {1,2,3,4,5}


    cout << "first element : " << a[0] << endl ; 
    cout << "third element : " << a[2] << endl ;

    for (int i = 0 ; i < 5 ; ++i ) {
        cout << a[i] << endl ; 
    }

    return 0 ; 
}