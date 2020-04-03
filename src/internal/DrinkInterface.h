#pragma once

namespace demo
{
class DrinkInterface
{
public:
    virtual ~DrinkInterface() = default;
    virtual int makeCoffee(bool milk, double sugars) = 0;
    virtual int makeHerbalTea() = 0;
};
} // namespace demo
