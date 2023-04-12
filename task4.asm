.include "beta.uasm"
       BR(Start)
       // the array to be sorted
A:
       LONG(0xB6)     // A[0] – Address A
       LONG(0x11)     // A[1] – Address A+4 = A+4*1
       LONG(0xE3)     // A[2] – Address A+8 = A+4*2
       LONG(0x9)      // A[3] – Address A+12 = A+4*3
       LONG(0xA)      // A[4] …
       LONG(0x1C)
       LONG(0x06)
       LONG(0x15)
       LONG(0xC2)
       LONG(0x21)
       LONG(0x5B)
       LONG(0x18)

Start:
       // The array A has 12 elements
       max_index = 11

	i = r0
	j = r1
	check = R2    // store status of compare instructions
	offset = R3	// offset address of A[j]
	temp1 = r4	// R4, R5 - temporary storage A[j] and A[j+1]
	temp2 = r5
       // i=max_index
       ADDC(R31, max_index, i)
       // Write your statements here

compare1:
       CMPEQ(r31, i, check) // check = (i == 0)
       BNE(check, finish, r31) // if (check == 1) goto finish
       ADDC(r31, 0, j) // else j = 0

compare2:
       CMPLT(j, i, check) // check = (j < i)
       BEQ(check, decrease_i, r31)  // if (check == 0) goto decrease_i

       // A[j] is loaded to temp1
       // A[j + 1] is loaded to temp2
       MULC(j, 4, offset)
       LD(offset, A, temp1)
       LD(offset, A + 4, temp2)

comapre3:
       CMPLT(temp2, temp1, check) // check = (temp2 < temp1)
       BEQ(check, increase_j, r31) // if (check == 0) goto increase_j
       BNE(check, swap, r31) // else goto swap
swap:
       // temp1 stores to A[j + 1]
       // temp2 stores to A[j]
       ST(temp1, A + 4, offset)
       ST(temp2, A, offset)
       BR(increase_j)

decrease_i:
       SUBC(i, 1, i)
       BR(compare1)

increase_j:
       ADDC(j, 1, j)
       BR(compare2)

finish:
       HALT()
