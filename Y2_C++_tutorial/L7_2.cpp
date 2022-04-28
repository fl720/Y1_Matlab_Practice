//pointer
#include <iostream>

using namespace std;

int main() {

    // Declaring pointers, pointer arithmetic and dereferencing 
    double vK1 = 0.0 ;         //vK1 variable declaration
    double vK2 = 1.0 ;         //vK2 variable declaration
    double vK3 = 2.0 ;         //vK3 variable declaration

    double *vPointer = &vK1 ;  //store address of vK1 in vPointer
    cout << *vPointer << endl ; //print the value in *vPointer

    vPointer = &vK3 ;          //store address of vK3 in vPointer 
    cout << *vPointer << endl ;

    *vPointer += vK2 ;        //add vK2 to *vPointer
    cout << *vPointer << endl ;

    if ( *vPointer == vK3 ) {
        cout << "Same value !" << endl ; 
    }

    //Loading over an array using pointers
    int myArray[8] = { 1,1,2,3,5,8,11,19} ; 
    int * ptr = &myArray[0] ; 
    for ( int i = 0 ; i < 8 ; ++i ) {
        cout << *ptr++ << endl ; 
    }

    return 0 ; 
}