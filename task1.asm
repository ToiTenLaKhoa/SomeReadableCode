.include "beta.uasm"

BR(Start)
A:
     LONG(1)       // A[0] – Address A
     LONG(2)       // A[1] – Address A+4  = A+4*1
     LONG(3)       // A[2] – Address A+8  = A+4*2
     LONG(4)       // A[3] – Address A+12 = A+4*3
     LONG(5)       // …
     LONG(6)
     LONG(7)
     LONG(8)


Start:
    LD(r31, A + 20, r1)
    LD(r31, A + 24, r2)
store:
	ST(r1, A + 24, r31)
	ST(r2, A + 20, r31)
HALT()
