#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdio>
#include <windows.h>
#include <fcntl.h>

#include <testlib.h>


int main_test(int argc, char *argv[]);


FILE* CreateFileFromString(std::string str) {
  HANDLE ih, oh;
  if (CreatePipe(&ih, &oh, NULL, str.size() + 1)) {
    int ohh = _open_osfhandle((int) oh, _O_WRONLY);
    FILE *of = fdopen(ohh, "w");
    fprintf(of, "%s", str.c_str());
    fclose(of);

    int ihh = _open_osfhandle((int) ih, _O_RDONLY);
    return fdopen(ihh, "r");
  }
  else
    return NULL;
}



namespace std {
  std::ostream cout_test(std::cout.rdbuf());
  std::istream cin_test(std::cin.rdbuf());
}



#define registerTestlibCmd(argc, argv) \
  registerTestlibCmd(argc, argv); \
  std::ostringstream cout_temp; \
  std::ifstream cin_temp(inf.name.c_str()); \
  std::cout_test.rdbuf(cout_temp.rdbuf()); \
  std::cin_test.rdbuf(cin_temp.rdbuf()); \
  main_test(argc, argv); \
  ans.stdfile = true; \
  ans.init(CreateFileFromString(cout_temp.str()), _answer); \
  *stderr = *stdout;
