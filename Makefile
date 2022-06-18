CC = gcc
RM = rm -f
CFLAGS = -Wall -O2
LIBS = -ludev -lm
LDFLAGS =

all: ptouch-770-write-usb ptouch-770-write-stdout

clean:
	$(RM) ptouch-770-write-usb ptouch-770-write-stdout *.o

ptouch-770-write-usb: ptouch-770-write-usb.o
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

ptouch-770-write-stdout: ptouch-770-write-stdout.o
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $^
