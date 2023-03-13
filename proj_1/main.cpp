/*
Create Rational class in C++. It should include functions
add_rational,
sub_rational,
mul_rational,
div_rational,
print_rational,
Is_rational
*/

#include <iostream>
#include <stdexcept>
#include <cassert>
using namespace std;

class Rational
{
private:
    int num, denom;

public:
    Rational(int n = 0, int d = 1)
    {
        // error handle divide by zero
        if (d == 0)
        {
            throw std::invalid_argument("Denominator cannot be zero");
        }

        num = n;
        denom = d;
    }
    // add
    Rational operator+(const Rational &other)
    {
        int new_num = num * other.denom + other.num * denom;
        int new_denom = denom * other.denom;
        return Rational(new_num, new_denom);
    }
    // subtract
    Rational operator-(const Rational &other)
    {
        int new_num = num * other.denom - other.num * denom;
        int new_denom = denom * other.denom;
        return Rational(new_num, new_denom);
    }
    // mulitply
    Rational operator*(const Rational &other)
    {
        int new_num = num * other.num;
        int new_denom = denom * other.denom;
        return Rational(new_num, new_denom);
    }
    // divide
    Rational operator/(const Rational &other)
    {
        int new_num = num * other.denom;
        int new_denom = denom * other.num;
        return Rational(new_num, new_denom);
    }

    bool is_rational()
    {
        return num < denom;
    }
    // print rational
    friend std::ostream &operator<<(std::ostream &os, const Rational &r)
    {
        cout << "rational(" << r.num << "," << r.denom << ") ";
        return os;
    }
};

int main()
{
    // Test valid arguments

    Rational r1(3, 4);
    Rational r2(1, 2);
    Rational r3(6, 5);

    cout << r1 << " is rational: " << r1.is_rational() << endl;
    cout << r2 << " is rational: " << r2.is_rational() << endl;
    cout << r3 << " is rational: " << r3.is_rational() << endl;

    Rational x = r1 + r2;
    cout << r1 << " + " << r2 << " = " << x << endl;
    x = r1 - r2;
    cout << r1 << " - " << r2 << " = " << x << endl;
    x = r1 * r2;
    cout << r1 << " * " << r2 << " = " << x << endl;
    x = r1 / r2;
    cout << r1 << " / " << r2 << " = " << x << endl;

    // test divide by zero
    try
    {
        // this line cannot be created
        cout << "Trying to initialize rational( 1, 0)" << endl;
        Rational r4(1, 0);
        cout << r4 << endl;
    }
    catch (std::invalid_argument &e)
    {
        // exception caught
        cout << e.what() << endl;
    }


    return 0;
}
