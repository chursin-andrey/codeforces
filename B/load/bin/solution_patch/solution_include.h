// подавление ошибки C4716 Error: Must return a value в Visual C++
#ifdef _MSC_VER
#pragma warning(default:4716)
#endif


#include <iostream>
#include <fstream>


int main_test(int argc, char *argv[]);

int main(int argc, char *argv[]) {
  std::ifstream cin_temp("input.txt");
  std::ofstream cout_temp("output.txt");
  std::cout.rdbuf(cout_temp.rdbuf());
  std::cin.rdbuf(cin_temp.rdbuf());

  main_test(argc, argv);
}



#define main(...) \
  main_test(int first_arg_test, ## __VA_ARGS__, int argc_test, char *argv_test[], ...); \
  int main_test(int argc, char *argv[]) { \
    return main_test(0, argc, argv, argc, argv); \
  } \
  int main_test(int first_arg_test, ## __VA_ARGS__, int argc_test, char *argv_test[], ...)
