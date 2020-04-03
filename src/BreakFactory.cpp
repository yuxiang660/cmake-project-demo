#include "BreakFactory.h"
#include "internal/DrinkInterface.h"
#include "internal/Drink.h"

namespace demo
{

std::unique_ptr<Break> BreakFactory::create()
{
    std::unique_ptr<DrinkInterface> drink = std::make_unique<Drink>();
    return std::make_unique<Break>(std::move(drink));
}

}