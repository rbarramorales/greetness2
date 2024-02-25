#include <string>

#include "greetness2/greetness2.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Name is greetness2", "[library]")
{
  auto const exported = exported_class {};
  REQUIRE(std::string("greetness2") == exported.name());
}
