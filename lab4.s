.globl binary_search
binary_search:
    mov r4, #0                            // int startIndex = 0;
    sub r5, r2, #1                        // int endIndex = length - 1;
    mov r6, r5, LSR #1                    // int middleIndex = endIndex/2;
    mov r7, #-1				  // int keyIndex = -1;                        
    mov r8, #1                            // int NumIters = 1;
    B loop

loop:                                     // while
    cmp r7, #-1                           // (keyIndex == -1)
    bne done                              // Exits to return keyIndex of not equal to -1
    cmp r4, r5                            // if(startIndex > endIndex)
    BGT done
    ldr r10, [r0, r6, LSL #2]             // numbers[middleIndex]
    cmp r10, r1                           // else if(numbers[middleIndex] == key)
    beq equalskey
    bgt greaterkey
    blt ELSE 

back:
    ldr r10, [r0, r6, LSL #2]             // numbers[middleIndex]
    rsb r11, r8, #0                       // -NumIters                  
    str r11, [r0, r6, LSL #2]           // numbers[middleIndex] = -NumIters

    sub r9, r5, r4                        // endIndex - startIndex
    mov r9, r9, LSR #1                    // (endIndex - startIndex)/2
    add r9, r9, r4                        // startIndex + (endIndex - startIndex)/2
    mov r6, r9                            // middleIndex = startIndex + (endIndex - startIndex)/2;
    add r8, r8, #1                        // NumIters++;
    B loop

done:
    mov r0, r7
    mov pc, lr

equalskey:
    mov r7, r6                            // keyIndex = middleIndex;
    B back

greaterkey:
    sub r5, r6, #1                        // middleIndex - 1;
    B back

ELSE:
    add r4, r6, #1                        // startIndex = middleIndex + 1;
    B back
