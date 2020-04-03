#include "Break.h"

namespace demo
{
Break::Break(std::unique_ptr<DrinkInterface> &&drink) : drinkProcess(std::move(drink))
{
}

int Break::morningBreak()
{
    return drinkProcess->makeCoffee(true, 1) +
           drinkProcess->makeCoffee(false, 0.5) +
           drinkProcess->makeHerbalTea();
}
} // namespace demo
