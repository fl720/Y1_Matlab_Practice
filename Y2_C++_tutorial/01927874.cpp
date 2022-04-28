
#include <iostream> 
#include <cmath>
using namespace std ;

int factorial( double n ) {
    // Favtorial function to work out n! . Where n! = n * (n-1) * (n-2) * (n-3) * ...... 3 *2 *1 ; 
    if (n == 0 ) {
        return 1 ; 
    }

        double result = 1 ; 
    for ( int i = 1 ; i < n ; i++ ) {
        result = result * i ; 
    }
    return result ; 
}

float exp( float x , double N ) {
    //e to the power of x function. Where e is the natural constant and x is a float point value given by the user. N is the maximium times/step/depth required by the user

    float ex = 0 ; 

    for( int j = 0 ; j < (N+1) ; j++ ) {
        ex = ex + ( 1.0 / factorial( j ) ) * pow( x,j ) ; 
    }

    return ex ; 
}

int main() {

    double N = 0  ; 
    while (N < 1 ) {
        cout << "Please enter an interger for N in the finite series expansion for e^x :" ; 
        cin >> N ;         
    }


    float x ; 
    cout << "Please enter a number for the x :" ; 
    cin >> x ; 

    float tanh_x = 0.0 ; 

    tanh_x = ( exp(x,N) - exp(-x,N) ) / ( exp( x,N) + exp(-x,N) ) ; 

    float real_tanh = tanh(x) ; 
     
    float difference = 0 ; 
    difference = real_tanh - tanh_x ; 

    
    cout << "tanh( " << x << " ) is : " << tanh_x << ". "  << "The difference with real tanh is : " << difference << endl; 

    return tanh_x ; 
}