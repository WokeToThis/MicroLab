#include <stdio.h>
#include <uart.h>

void create_table(char* table);
extern int hash(char* str, char* table);
extern int my_hasher(int value);

//int main(void){
	
//	uart_init(115200);
//	uart_enable();
//	uart_print("Hello\n\r");
	
//}

void create_table(char* table){
    table[0] = 10; 
    table[1] = 42; 
    table[2] = 12; 
    table[3] = 21; 
    table[4] = 7; 
    table[5] = 5; 
    table[6] = 67; 
    table[7] = 48; 
    table[8] = 69; 
    table[9] = 2; 
    table[10] = 36; 
    table[11] = 3 ;
    table[12] = 19; 
    table[13] = 1 ;
    table[14] = 14; 
    table[15] = 51; 
    table[16] = 71; 
    table[17] = 8 ;
    table[18] = 26;
    table[19] = 54;
    table[20] = 75;
    table[21] = 15;
    table[22] = 6;
    table[23] = 59;
    table[24] = 13;
    table[25] = 25;
}

void test_1(){
	char word[20] = "19sAdf+G5\{}";
	
	char table[26];
	create_table(table);
	
	int y = hash(word, table);
	printf("1st output: %d\n");
	
	
	
}


int main(void)
{
    char word[10];

    scanf("%s", &word);
    
		char table[26];
    create_table(table);
 
    int y = hash(word, table);
		printf("%d\n", y);

		int output = my_hasher(y);
		printf("Final Output: %d", output);

		sprintf(word,"Out %d", output);
		//uart_print(word);
	
		return 0;
}