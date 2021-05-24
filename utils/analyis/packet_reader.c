#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <errno.h>

static char buffer[1024*1024];
int main(int argc, const char* argv[]) 
{
	int portno;
	int sock;
	struct sockaddr_in addr;

	if (argc != 2) {
		printf("Usage: $0 portno\n");
		exit(1);
	}
	portno = atoi(argv[1]);
	addr.sin_family = AF_INET;
	addr.sin_port = htons(portno);
	addr.sin_addr.s_addr = INADDR_ANY;
	sock =  socket(AF_INET, SOCK_DGRAM, 0);
	if (sock < 0) {
		printf("ERROR: socket error=%d\n", errno);
		exit(1);
	}
	int err = bind(sock, (struct sockaddr *)&addr, sizeof(addr));
	if (err < 0) {
		printf("ERROR: bind error=%d\n", errno);
		exit(1);
	}
	int len = recv(sock, buffer, sizeof(buffer), 0);
	if (len <= 0) {
		printf("ERROR: recv error=%d\n", errno);
		exit(1);
	}
	write(1, buffer, len);


	return 0;
}
