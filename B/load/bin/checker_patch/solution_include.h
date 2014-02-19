#define cout cout_test
#define cin cin_test


// подавление ошибки C4716 Error: Must return a value в Visual C++
#ifdef _MSC_VER
#pragma warning(default:4716)
#endif



#define main(...) \
  main_test(int first_arg_test, ## __VA_ARGS__, int argc_test, char *argv_test[], ...); \
  int main_test(int argc, char *argv[]) { \
    return main_test(0, argc, argv, argc, argv); \
  } \
  int main_test(int first_arg_test, ## __VA_ARGS__, int argc_test, char *argv_test[], ...)
