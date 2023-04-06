.global hash
.p2align 2
.type hash, %function

	
// R0 -> Has the sum/hash value.
// R1 -> Has the data on latin letters(the transormations).
// R2 -> Points to the next character to be encoded.
// R3 -> Has the current character to be encoded.
// R4 -> Has the encoded value.

hash:

.fnstart
	
	PUSH {R4}
	
	MOV R2, R0
	MOV R0, #0
	
	do:
			
		//Set the default value of R4 to 0 in case ascii code is \
		smaller than 48
		MOV R4, #0
			
		//Get word's ascii code and increase str pointer and store to R3. 
		LDRB R3, [R2], #1
		
		//Exits in char '\0' or '\n' or '\r'.
		CMP R3, #0
		BEQ exit_loop
		CMP R3, #10
		BEQ exit_loop
		CMP R3, #13
		BEQ exit_loop
		
		
		//Substract 48 to get the disired number N. \
		  Since the numbers are greater than 48, we will get the negative values from [48 - N].
		CMP R3, #48
		IT GE
		RSBGE R4, R3, #48
		
		// Set unwanted characters to 0.
		CMP R3, #58
		IT GE
		MOVGE R4, #0
		
		//Handling latin letters.
		CMP R3, #97
		ITT GE
		SUBGE R4, R3, #97
		LDRBGE R4, [R1, R4] //Store the table value in R3 from table_offset. 
		
		// Set unwanted characters to 0.
		CMP R3, #123
		IT GE
		MOVGE R4, #0

		//Add the value to the sum in R0. 
		ADD R0, R0, R4
		
		B do
	
	exit_loop:
	
	POP {R4}
	
	BX LR
	
.fnend
