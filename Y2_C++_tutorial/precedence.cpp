/*
 * Solution to Exercise 3.2
 *
 * Applies operator precedence.
 *
 */
/*
#include <iostream>
using namespace std;

int main() {
    int a = 2;
    int b = 5;
    int c = 4;

    int result = a + b * c / a * ( b - c ) + b % c;
    cout << "Result is " << result << endl;

    return 0;
}

*/

//======================Ex3.1======================
/*
#include <iostream> 
using namespace std ; 

int main() {

    int a = 2 ; 
    int b = 5 ;
    int c = 4 ; 

    int ans = 0 ; 

    ans = a + b * c / a * (b-c) + b%c ; 

    cout << "ans is :" << ans << endl ; 

    return 0 ; 
}
*/

//======================Ex3.2======================
#include <iostream>
using namespace std ; 

int main() {
    float x,y,z;

    x = 2 ; 
    y = 3 ; 

    z = x+y ; 

    cout << "Result is " << z << endl ; 

    return 0 ; 
}