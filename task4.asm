.include "beta.uasm"
       BR(Start)
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
	check = R2  
	offset = R3	
	temp1 = r4	
	temp2 = r5
       ADDC(R31, max_index, i)

compare1:
       CMPEQ(r31, i, check)
       BNE(check, finish, r31)
       ADDC(r31, 0, j)

compare2:
       CMPLT(j, i, check)
       BEQ(check, decrease_i, r31)
       MULC(j, 4, offset)
       LD(offset, A, temp1)
       LD(offset, A + 4, temp2)

comapre3:
       CMPLT(temp2, temp1, check)
       BEQ(check, increase_j, r31)
       BNE(check, swap, r31)
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
