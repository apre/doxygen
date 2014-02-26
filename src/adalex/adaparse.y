%tocken_type {int}


%include {
#include <iostream>
#include "ada_tockens.h"
}


%syntax_error {
	std::cout << "syntax error "  << std::endl;
}
