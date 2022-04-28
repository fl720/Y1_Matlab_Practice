//
// Program to find the nearest root of a polynomial of arbitrary order
// given a starting position x0.
//
#include <iostream>
#include <sstream>
#include <cmath>
#include <vector>
using namespace std;

// Evaluate a polynomial, given by coefficients a, at x.
double EvaluatePolynomial(vector<double> a, double x) {
    double result = 0.0;
    double xpow   = 1.0;
    for (int i = 0; i < a.size(); ++i) {
        result += a[i]*xpow;
        xpow *= x;
    }
    return result;
}

// Calculate the coefficients of the derivative of a polynomial given by
// the coefficients a.
vector<double> DifferentiatePolynomial(vector<double> a) {
    cout << "Diff " << a.size() << endl;
    vector<double> b;                       // Coefficients of derivative
    for (int i = 1; i < a.size(); ++i) {    // Differentiate each power of x
        b.push_back(a[i]*i);
    }
    return b;
}


int main() {
    vector<double> f;
    vector<double> df;

    // Request list of coefficients from the user and separate into STL vector
    string input;
    double tmp;
    int cnt = 0;
    cout << "Enter coefficients (space-separated): ";
    getline(cin, input);
    stringstream S(input);
    while (S.good()) {
        S >> tmp;
        f.push_back(tmp);
        cnt++;
    }

    // Validate input
    if (f.empty()) {
        cout << "No polynomial specified." << endl;
        return 1;
    }

    // Get the derivative of the polynomial
    cout << "Differentiate" << endl;
    df = DifferentiatePolynomial(f);

    double x = 0.0;
    double x_new = 0.0;
    double epsilon = 1e-8;
    int max_it = 100;

    // Request initial guess from user
    cout << "Enter initial guess (default: 0): ";
    cin >> input;
    x = stod(input);

    x_new = x + 2.0*epsilon;    // Ensure difference starts > epsilon
    cnt = 0;

    // Iterate until convergence, or maximum iteration count, reached.
    while (fabs(x_new - x) > epsilon && cnt < max_it) {
        x = x_new;
        x_new = x - EvaluatePolynomial(f,x)/EvaluatePolynomial(df,x);
        cout << x_new << ", " << fabs(x_new - x) << endl;

        cnt++;
    }
    x = x_new;

    // Print result to terminal
    if (cnt == max_it) {
        cout << "Did not converge." << endl;
    }
    else {
        cout << "Converged to root " << x << " after " << cnt << " iterations."
             << endl;
    }
}