#include "Drink.h"

#include <gtest/gtest.h>

namespace
{

TEST(DrinkTest, makeCoffee)
{
    demo::Drink d;
    EXPECT_EQ(d.makeCoffee(true, 1), 15);
    EXPECT_EQ(d.makeCoffee(false, 0.5), 5);
}

TEST(Drink, makeHerbalTea)
{
    demo::Drink d;
    EXPECT_EQ(d.makeHerbalTea(), 8);
}

}
