#include "BreakFactory.h"
#include "Break.h"

#include <iostream>

using namespace std;

int main()
{
    cout << "Break Simple Example" << endl;
    demo::BreakFactory factory;
    auto b = factory.create();
    cout << "Break::morningBreak() returns " << b->morningBreak() << endl;
    return 0;
}
