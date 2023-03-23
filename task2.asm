.include "beta.uasm"

BR(Start)
A:
    LONG(0x6)       // A[0] – Address A
    LONG(0x11)      // A[1] – Address A+4 = A+4*1
    LONG(0xE3)      // A[2] – Address A+8 = A+4*2
    LONG(0x9)       // A[3] – Address A+12 = A+4*3
    LONG(0xA)       // …
    LONG(0x1C)		  // A[5]
    LONG(0x06)		  // A[6]
    LONG(0x15)

Start:
    i = 5 // For example i=5
load:
	  ADDC(r31, i , r0)
    MULC(r0, 4, r20)
    LD(r31, A + r20, r1)
    LD(r31, A + r20 + 4, r2)
store:
	ST(r1, A + r20 + 4, r31)
	ST(r2, A + r20, r31)
HALT()
