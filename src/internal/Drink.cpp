#include "Drink.h"

namespace demo
{
#define SUGAR_TIME 10
#define MILK_TIME 5
#define TEA_TIME 8

int Drink::makeCoffee(bool milk, double sugars)
{
    return milk ? int(sugars * SUGAR_TIME + MILK_TIME) : int(sugars * SUGAR_TIME);
}

int Drink::makeHerbalTea()
{
    return TEA_TIME;
}
} // namespace demo
