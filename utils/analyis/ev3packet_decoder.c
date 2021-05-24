#include <stdio.h>
#include <unistd.h>

static char buffer[1024];
static void read_packet(void)
{
	int c = 0;

	while (c < sizeof(buffer)) {
		ssize_t ret = read(0, &buffer[c], 1);
		if (ret <= 0) {
			continue;
		}
		c++;
	}
	return;
}
static void decode_packet(void)
{
	//header
	printf("%c%c%c%c\n", buffer[0], buffer[1], buffer[2], buffer[3]);
	//version
	printf("version 0x%x\n", *((unsigned int*)&buffer[4]));
	//unity time
	printf("time %lf\n", (double)(*((unsigned long long*)&buffer[16])/1000000.0));

	printf("color %u\n", *((unsigned int*)&buffer[40]));
	printf("reflect %u\n", *((unsigned int*)&buffer[44]));
	printf("rgb_r %u\n", *((unsigned int*)&buffer[48]));
	printf("rgb_g %u\n", *((unsigned int*)&buffer[52]));
	printf("rgb_b %u\n", *((unsigned int*)&buffer[56]));
	
	printf("ultrasonic %u\n", *((unsigned int*)&buffer[120]));
	printf("touch0 %u\n", *((unsigned int*)&buffer[144]));
	printf("touch1 %u\n", *((unsigned int*)&buffer[148]));
	printf("motor_angle_a %u\n", *((unsigned int*)&buffer[256+32]));
	printf("motor_angle_b %u\n", *((unsigned int*)&buffer[260+32]));
	printf("motor_angle_c %u\n", *((unsigned int*)&buffer[264+32]));

	printf("pos_x %lf\n", (*((double*)&buffer[480+32])));
	printf("pos_y %lf\n", (*((double*)&buffer[488+32])));
	return;
}

int main(int argc, const char* argv[])
{
	while (1) {
		read_packet();
		decode_packet();
	}
	return 0;
}
