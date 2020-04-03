#pragma once

#include "internal/DrinkInterface.h"
#include <memory>

namespace demo
{
class Break
{
public:
    Break(std::unique_ptr<DrinkInterface> &&drink);
    int morningBreak();

private:
    std::unique_ptr<DrinkInterface> drinkProcess;
};
} // namespace demo
