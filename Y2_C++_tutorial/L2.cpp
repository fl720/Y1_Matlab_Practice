#include <iostream>
using namespace std;

int main() {
    int a = 1 ;  // using "int" to specify the data type 
    int b = 2 ;
    int c = 0 ;

    float d = {1.1} ; // Narrowing conversion would happened if its not "float""{}" or "double""{}", converting 1.1 to 1 

    c = a + b ; 

    c = (a + b) * a ; 

    d = (double)a / b ; 
    cout << a << "/" << b << "=" << d << endl;

    a =a + 1 ;  //increment  
    a++ ; 

    b = b - 1 ;
    b-- ;       //decrement

    c = b + a++ ;  // procedue is : c = b+ a ; a= a+1   a++ is post-increment
    c = b + (++a) ; //   a = a + 1 ; c = b+a ; ++a is pre-increment 

    //it will affect the output of C as a is different in both cases. 

    return 0 ; 

}