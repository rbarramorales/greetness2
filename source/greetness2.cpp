#include <string>

#include "greetness2/greetness2.hpp"

#include <fmt/core.h>

exported_class::exported_class()
    : m_name {fmt::format("{}", "greetness2")}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
