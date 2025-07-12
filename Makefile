CC = x86_64-w64-mingw32-gcc

all: wlines.exe wlines-daemon.exe

wlines.exe: wlines.c
	$(CC) -DWLINES_VERSION='"$(shell git log -1 --date=short "--format=%cd-%h")"' -Wall -Werror -Wextra -std=c99 -pedantic -s -O2 $^ -o $@ -static -lgdi32 -luser32 -lshlwapi -lshell32

wlines-daemon.exe: wlines.c
	$(CC) -DWLINES_VERSION='"$(shell git log -1 --date=short "--format=%cd-%h")"' -DDAEMON_MODE -Wall -Werror -Wextra -std=c99 -pedantic -s -O2 $^ -o $@ -static -lgdi32 -luser32 -lshlwapi -lshell32 -mwindows

.PHONY: clean
clean:
	rm -f wlines.exe wlines-daemon.exe

