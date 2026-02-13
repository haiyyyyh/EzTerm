.PHONY : install remove clear test

src = ./src/ezterm.cpp
obj = ./build/ezterm.o
bin = ./bin/libezterm.so
cxx_version = -std=c++20
cflag_no_silence = -v -Wl,--verbose
cflag_save_temp_file = -save-temps
cflag_warning = -Wall -pedantic -fdiagnostics-color=always -Wshadow

$(bin) : $(obj)
	@echo "LD $(obj)->$(bin)"
	@g++ $(obj) -o $(bin) -shared
	@echo "PK $(obj)->./bin/libezterm.a"
	@ar -rc bin/libezterm.a $(obj)
	@echo "all done"

$(obj) : $(src)
	@echo "CC $(src)->$(obj)"
	@g++ -c $(src) -o $(obj) -fPIC -O2 $(cflag_save_temp_file) $(cflag_warning) $(cxx_version)

install : $(bin) bin/libezterm.a include/ezterm.h
	@echo "CP ./bin/libezterm.so -> /usr/lib (use sudo)"
	@sudo cp bin/libezterm.so /usr/lib
	@echo "CP ./bin/libezterm.a -> /usr/lib (use sudo)"
	@sudo cp bin/libezterm.a /usr/lib
	@echo "CP ./include/ezterm.h -> /usr/include (use sudo)"
	@sudo cp include/ezterm.h /usr/include
	@echo "all done"

remove :
	@echo "RM /usr/lib/libezterm.so /usr/lib/libezterm.a /usr/include/ezterm.h (use sudo)"
	@sudo rm /usr/lib/libezterm.so /usr/lib/libezterm.a /usr/include/ezterm.h

clear :
	@echo "CLR temp" && /bin/ls build
	@rm -f build/*
	@echo "done"
	@echo "CLR bin" && /bin/ls bin
	@rm -f bin/*
	@echo "done"
	
test :
	g++ $(src) -o ./test/test -O0 -g $(cflag_no_silence) $(cflag_warning) $(cxx_version)
	@echo "then run ./test/test ..." && sleep 0.3
	./test/test.out
	rm ./test/test.out
