@###############################################################
@
@    Sivalingam Periasamy - CS18M502
@    Int - min, max arm lab 3
@
@###############################################################
@ DATA SECTION
.data
data_start: .word 0x205A15E3 ; #(0010 0000 0101 1010 0001 0101 1101 0011 – 13)
            .word 0x256C8700 ; #(0010 0101 0110 1100 1000 0111 0000 0000 – 11)
			.word 0x2D1CF70E ; #(0010 1101 0001 1100 1111 0111 0000 1110 – 17)
data_end:   .word 0x295468F2 ; #(0010 1001 0101 0100 0110 1000 1111 0010 – 14)

Output: NUM: 	.word 0x0;
        WEIGHT: .word 0x0;


LDR R0, =data_start  @ START ADDRESS   
LDR R1, =data_end    @ END ADDRESS
LDR R2, =NUM         @ NUM ADDRESS
LDR R3, =WEIGHT      @ WEIGHT ADDRESS
MOV R4, #0    	     @ SET INITIAL MAX WEIGHT TO ZERO
MOV R5, #0    	     @ SET INITIAL MAX NUM TO ZERO

ITERATE_DATA:
	LDR R6, [R0], #4     @ 4 BYTE DATA (1 WORD)
	MOV R7, R6           @ BACKUP OF R6
	MOV R8, #0    	     @ RESET TEMP MAX WEIGHT TO ZERO
	
	SUM_WEIGHT:
		AND R9, R6, #1	     @ GET LSB
		ADD R8, R9	         @ SUM TEMP WEIGHT
		LSR R6, R6, #1	     @ LOGICAL RIGHT SHIFT
		CMP R6, #1           @ CHECK IF R6 IS ZERO
		BGE SUM_WEIGHT		 @ LOOP SUM_WEIGHT

	CMP R8, R4			@IF CURRENT WEIGHT GT MAX WEIGHT THEN UPDATE MAX WEIGHT
	BGT UPDATE_OUTUPT_MAX_WEIGHT
	
	AFTER_UPDATE:		
	CMP R0, R1			@IF NEXT ADDRESS GT THAN END ADDRESS OF DATA THEN END PROGRAM
	BGT END_PROGRAM
	
	B ITERATE_DATA		@LOOP THE DATA

UPDATE_OUTUPT_MAX_WEIGHT:
	MOV R4, R8           @ MAX WEIGHT
	MOV R5, R7           @ MAX NUM
	B AFTER_UPDATE		 @ BACK TO DATA LOOP


END_PROGRAM:
	STR R5, [R2] 		@STORE THE MAX NUM VALUE IN ADDRESS OF NUM
	STR R4, [R3]		@STORE THE MAX WEIGHT VALUE IN ADDRESS OF WEIGHT
	
	@ R2, R3 registers loaded back using NUM and WEIGHT (Just to check if the Output is set properly)
	LDR R10, =NUM
	LDR R11, =WEIGHT
	LDR R2, [R10]
	LDR R3, [R11]