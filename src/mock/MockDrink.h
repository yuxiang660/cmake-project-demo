#pragma once

#include "internal/DrinkInterface.h"

#include <gmock/gmock.h>

namespace mock
{
class MockDrink : public demo::DrinkInterface
{
public:
    MOCK_METHOD2(makeCoffee, int(bool milk, double sugars));
    MOCK_METHOD0(makeHerbalTea, int());
};
} // namespace mock
