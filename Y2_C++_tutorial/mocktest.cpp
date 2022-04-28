#include <iostream>
#include <algorithm>
#include <vector>
#include <cstdlib>
using namespace std ;

int f_x( double x ,vector<double> a) {
    double y = 0 ; 
    for (int i = 0 ; i < a.size() ; i++ ) {
        y = a[i] * x^i + y ; 
    }
    return y ; 
}

int f_dash_x( double x , vector<double> a ) {
    double y_dash = 0 ; 
    for (int j = 0 ; j < (a.size() - 1) ; j++ ) {
        y_dash = a[j+1] * ( j + 1 ) * x^j + y_dash ; 
    }
    return y_dash ; 
}

int main()
{
    double n = 0 ; 
	cout << "Please enter the number of a (n) " ;
    cin >> n ; 
    
    vector<double> array ;

    array[n] = {} ;  
    
    double count = 0 ; 
    while ( count != n ) {
        double temp_store = 0 ; 
        cout << "please input a value for a_x " ; 
        cin >> temp_store ; 

        double temp_posi = 0 ; 
        cout << "please specify the position (x)" ; 
        cin >> temp_posi ; 

        array[temp_posi] = temp_store ; 

        count ++ ; 
    }
    
    //sort( array.begin() , array.end() ) ; 


    double x = 0 ; 
    cout << "Please give a parameter value for x:" ; 
    cin >> x ; 
    
    double difference = 0 ; 
    double convergence_aim = 10^-8 ; 
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
    return x ; 
    }
     
}
