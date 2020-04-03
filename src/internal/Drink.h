#pragma once

#include "DrinkInterface.h"

namespace demo
{
class Drink : public DrinkInterface
{
public:
    int makeCoffee(bool milk, double sugars);
    int makeHerbalTea();
};
} // namespace demo
