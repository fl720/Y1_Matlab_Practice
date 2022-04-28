//For loop
#include <iostream>
#include <chrono>
#include <thread>

using namespace std;

int main() {
// start at n = 10, while n is bigger than 0 , then decrement the n by 1 
    for (int n = 10 ; n > 0 ; --n ) {
        cout << "n is " << n  << ", " << flush ; 
        std::this_thread::sleep_for( std::chrono::seconds(1) ) ; 
        //this mean while it runing the forloop it will stop for 1 second, then excute the line to contuniue.  
    }
// "flush" is to push the number at back for displacement rather than a new line 
    cout << "FIRE!" << endl ; 
    return 0 ; 
}