.include "beta.uasm"

BR(Start)
A:
    LONG(0x6)       // A[0] – Address A
    LONG(0x11)      // A[1] – Address A+4 = A+4*1
    LONG(0xE3)      // A[2] – Address A+8 = A+4*2
    LONG(0x9)       // A[3] – Address A+12 = A+4*3
    LONG(0xA)       // …
    LONG(0x1C)
    LONG(0x06)
    LONG(0x15)


Start:
    i = 5 // For example i=5
load:
	ADDC(r31, i , r0) //store i at R0
    MULC(r0, 4, r20)
    LD(r31, A + r20, r1)
    LD(r31, A + r20 + 4, r2)
    //check if (r2 <= r1)
    CMPLE(r2, r1, r30)
    BEQ(r30, store_only, r31)
swap_and_store:
    ST(r2, A + r20, r31)
	ST(r1, A + r20 + 4, r31)
    BR(end)
store_only:
	ST(r1, A + r20, r31)
	ST(r2, A + r20 + 4, r31)
end:
    HALT()
