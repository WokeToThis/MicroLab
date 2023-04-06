.global my_hasher
.p2align 1
.type my_hasher,%function


my_hasher:

.fnstart

	PUSH {R4}

    MOV R1,#10 // Const value.
    MOV R4,#0

	// Get the sum of digits/1st_step.
    loop1:

		//R0 -> The number 'x' we want to process.
		SDIV R2,R0,R1           // R2 = R0 / 10. (integer division).
		MUL R3,R2,R1            // R3 = R2 * 10.
		SUB R3,R0,R3            // R4 = R0 - R3. Or in other words R4 = R0 mod 10.
		ADD R4,R4,R3            // We add the digit to the sum.
		MOV R0,R2				// We remove the last digit from the number 'x' (ex.: 157 -> 15).
		
	// If R2 == 0 then R0 < 10 and we have finished with the first part. 
    CMP R2,#0 
	BNE loop1
	
	// Reset R5 and move the result to R0 cause we might need reevaluation.
    MOV R0,R4
    MOV R4,#0

	// If result is bigger than 10 goto to 1st step for reevaluation.
    CMP R0,#10
    BGT loop1

	// If result is negative get absolute value.
    CMP R0,#0      
    IT LT
    RSBLT R0,R0,#0

	// Set R1 to 1 since we multiply (zero element).
    MOV R1,#1
    
	loop2:
		
		MUL R1,R0,R1 // Multiply R1 with the number.
		SUB R0,R0,#1 // Decrease number by 1.
	
	// If number == 1 exit loop2.
	CMP R0,#1 
    BNE loop2

	// Save result.
    MOV R0,R1
	
	POP {R4}

    BX LR

.fnend