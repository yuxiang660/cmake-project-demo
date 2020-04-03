#include "Break.h"
#include "mock/MockDrink.h"

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <memory>

using ::testing::Return;
using ::testing::_;

namespace
{
TEST(BreakTest, MorningBreak)
{
    auto drink = std::make_unique<mock::MockDrink>();
    EXPECT_CALL(*drink, makeCoffee(_, _))
        .WillOnce(Return(2))
        .WillOnce(Return(1));
    EXPECT_CALL(*drink, makeHerbalTea())
        .WillOnce(Return(3));
    demo::Break b(std::move(drink));
    EXPECT_LE(b.morningBreak(), 6);
}
} // namespace
