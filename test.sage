import time

k.<t>=GF(2^129) # create a finite field k of size 2^129

#definition of S(x), here d=1. (The MiMC S-box)
Frob=k.frobenius_endomorphism(1) # use frebenius to raise the power of an element to 2^1

#definition of B(x), here h1=0, h2=1, h3=6, h4=54
Frob1 = k.frobenius_endomorphism(0) # use frebenius to raise the power of an element to 2^0
Frob2 = k.frobenius_endomorphism(1) # use frebenius to raise the power of an element to 2^1
Frob3 = k.frobenius_endomorphism(6) # use frebenius to raise the power of an element to 2^6
Frob4 = k.frobenius_endomorphism(54) # use frebenius to raise the power of an element to 2^54
#------ generate 3 elements of the field k

suma = 0
sumb = 0
sumc = 0

A0 = 1
B0 = 1
A1 = 1
B1 = 1

t1 = time.time()

for i,x in enumerate(k):
    if(i == 2^16):#the dimension is here
        break
    a=x
    b=A0*x + B0
    c=A1*x + B1

    for rounds in range(4):#the number of rounds here

#------ now compute the step y = x^{2^{d}}
        a1 = Frob(a) # raise a to 2^d
        b1 = Frob(b) # raise b to 2^d
        c1 = Frob(c) # raise c to 2^d
#--------- now compute the step x = xy, i.e. S(x)=x^{2^d}x=x^{2^d+1}
        a = a1*a
        b = b1*b
        c = c1*c
#------this step completes the G(x) part of Algorithm 2

#------- start the operation B(x)
        #t = k.gen()
        #c1 = t^61 + t^57 + t^56 + t^55 + t^54 + t^52 + t^50 + t^49 + t^45 + t^44 + t^41 + t^37 + t^34 + t^32 + t^31
        #+ t^30+ t^29 + t^27 + t^26 + t^25 + t^24 + t^23 + t^22 + t^19 + t^16 + t^12 + t^11 + t^10 + t^8 + t^6 + t^5 + t^4 + t^3 + 1

        #c2 = t^60 + t^57 + t^52 + t^47 + t^44 + t^41 + t^39 + t^37 + t^35 + t^34 + t^31 + t^30 + t^29 + t^28 + t^24
        #+ t^23 + t^21 + t^20 + t^19 + t^18 + t^14 + t^13 + t^11 + t^10 + t^8 + t^6 + t^5 + t^3 + t^2 + 1

        #we treat the coefficients of all non-constant monomial as 1 for simplicity
        sum1 = Frob1(a) + Frob2(a) + Frob3(a) + Frob4(a)
        sum2 = Frob1(b) + Frob2(b) + Frob3(b) + Frob4(b)
        sum3 = Frob1(c) + Frob2(c) + Frob3(c) + Frob4(c)
#------- the operation B(x) is completed

#------- the matrix multiplication
    # matrix = [[2 1 3],[1 1 1],[3,1,2]], i.e. we use a simple matrix M

        a = 2*sum1 + 1*sum2 + 3*sum3
        b = 1*sum1 + 1*sum2 + 1*sum3
        c = 3*sum1 + 1*sum2 + 2*sum3
##############################################1 round#########################
    suma = suma + a
    sumb = sumb + b
    sumc = sumc + c

t2 = time.time()

print(t2-t1)

print(suma,'\n')
print(sumb,'\n')
print(sumc,'\n')
