//STL
#include <iostream>
#include <algorithm>
#include <vector>
#include <cstdlib>

using namespace std;

double random_number() {
    return double(rand()) / RAND_MAX * 1000.0 ;
}

int main() {
    vector<double> v( 8, 0.0 ) ; 

    //Generate random numbers
    generate( v.begin() , v.end(), random_number ) ; 

    //Print out entries in a container
    for_each(v.begin(), v.end(), [](double& x) {
        cout << x << endl ; 
    }) ; 

    //Calculate maximum value in the container
    double inf_norm = * max_element( v.begin(), v.end() ) ; 

    //Normalise values by the maximum value 
    transform( v.begin() , v.end() , v.begin(), [&inf_norm](double x) {
        return x / inf_norm ; 
    } ) ; 

    sort(v.begin(), v.end(), [] (double i, double j ) {
        return (i>j) ; 
    }) ; 

    //Print out the end result using range-based loop. 
    for ( auto &x : v) {
        cout << x << endl ; 
    }

    //Selectively copy from container to another 
    vector<double> w ;
    copy_if(v.begin(), v.end(), back_inserter(w), [](double p ) {
        return (p <0.5) ; 
    }) ; 
    cout << "Numberof entries < 0.5 :" << w.size() << endl ; 

    //return 0 ; 
}