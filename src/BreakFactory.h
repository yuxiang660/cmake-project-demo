#pragma once

#include "Break.h"

#include <memory>

namespace demo
{
class BreakFactory
{
public:
    std::unique_ptr<Break> create();
};
} // namespace demo