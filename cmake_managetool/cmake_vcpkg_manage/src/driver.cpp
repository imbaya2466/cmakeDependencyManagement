#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cmath>
#include <typeinfo>

#include "boost/core/demangle.hpp"
#include "driver.h"

int main() {  
  std::srand(static_cast<unsigned int>(std::time(0)));  
  boost::optional<int> i = Generator::get_even_random_number();
  if (i) {
    std::cout << std::sqrt(static_cast<float>(*i)) << "\n";
    std::cout << boost::core::demangle(typeid(boost::optional<int>).name()) << "\n";
  }
}