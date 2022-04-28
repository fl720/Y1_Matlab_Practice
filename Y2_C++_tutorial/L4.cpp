//File I/O
#include <iostream>
#include <fstream>

using namespace std ;

int main() {

    ifstream vMyfile( "XX_FILE/XX.TXT" ) ; 
    string vTemp ; 
    if( vMyFile.good() ) {
        // Cjeck file opened okay
        while (true) {
            //keep tring
            vMyFile >> vTemp ; 
            // ... to read file 
            if( vMyFile.eof() ) {
                // Test if end of file reached
                break ; 
                // ... and stop if it is
            }
            cout << vTemp << endl ; 
            // Print what we read 
        }
        vMyFile.close() ;
    } else {
        cout << " Failed to open file " << endl ; 
        return 1 ; 
    }
    return 0 ;
}