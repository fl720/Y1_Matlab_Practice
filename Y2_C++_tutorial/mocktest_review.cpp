#include <iostream>
#include <algorithm>
#include <vector>
#include <cstdlib>
#include <cmath> // import exponentiation operator pow()
using namespace std ;

int f_x( double x ,vector<double> a) {
    double y = 0 ; 
    for (int i = 0 ; i < a.size() ; i++ ) {
        // y = a[i] * x^i + y ; // '^' is not exponentiation operator in Cpp
        y = a[i] * pow(x, i) + y;
    }
    return y ; 
}

int f_dash_x( double x , vector<double> a ) {
    double y_dash = 0 ; 
    for (int j = 0 ; j < (a.size() - 1) ; j++ ) {
        // y_dash = a[j+1] * ( j + 1 ) * x^j + y_dash ; // '^' is not exponentiation operator in Cpp
        y_dash = a[j+1] * ( j + 1 ) * pow(x, j) + y_dash ;
    }
    return y_dash ; 
}

int main()
{
    double n = 0 ; 
	cout << "Please enter the number of a (n) " ;
    cin >> n ; 
    
    // vector<double> array ; // array is defined as a vector without elements (which length == 0)
    // array[n] = {} ;  // visit position n cause out of bounds, then program will crash.

    vector<double> array(n, 0); // I guess you want to initialize a vector with n zeros.
    
    // double count = 0 ; 
    // while ( count != n ) {
    //     double temp_store = 0 ; 
    //     cout << "please input a value for a_x " ; 
    //     cin >> temp_store ; 

    //     double temp_posi = 0 ; 
    //     cout << "please specify the position (x)" ; 
    //     cin >> temp_posi ; 

    //     array[temp_posi] = temp_store ; 

    //     count ++ ; 
    // }

    for(int i = 0; i < n; i++)
    {
        cout << "please input a value for a_x " ; 
        cin >> array[i] ; 
    }
    for(int i = 0; i < n - 1; i++)
    {
        cout << "please input a value for a_x " ; 
        cout << array[i] << "x + " ; 
    }
    cout << array[n - 1];
    
    
    //sort( array.begin() , array.end() ) ; 

    double x = 0 ; 
    cout << "Please give a parameter value for x:" ; 
    cin >> x ; 
    
    double difference = 0 ; 
    // double convergence_aim = 10^-8 ; // '^' is not exponentiation operator in Cpp
    double convergence_aim = 1e-8 ;
    double convergence_step = 0 ;
    double x_next = 0 ;  
    while(difference > convergence_aim && convergence_step != 100 ) {

        x_next = x + f_x(x,array) / f_dash_x(x,array) ; 
        difference =  x_next - x ; 
        x = x_next ; 

        convergence_step++ ;
    }

    if ( difference > convergence_aim && convergence_step == 100  ) 
    {
        cout << " No exisits root." << endl ; 
        return 0 ; 
    } else {
        //print result to terminal
        cout << "Converge to root : " << x << endl ; 
        return x ; 
    }
     
}
