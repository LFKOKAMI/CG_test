import time

def findD(n,d,a,len,round,deg):

    k.<t>=GF(2^n) # create a finite field k of size 2^129

    Frob=k.frobenius_endomorphism(d) # use frebenius to raise the power of an element to 2^d

    #definition of B(x)
    bb = [0,0,0,0]
    co = [0,0,0,0]
    rc = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    
    for i in range(24):
        rc[i]=k.random_element()
       
    
    for i in range(len):
        bb[i]=a[i]
    
    list_of_powers = [0 for i in range(n)]
    found = False
    while found == False:
        for j in range(len):
            list_of_powers[bb[j]] = k.random_element()
       
        D = matrix(k, n, n, lambda i,j : list_of_powers[(j-i)%n]^(2^i))
        if(D.det() > 0): #it can be either 0 or 1
            found = True
    for j in range(len):
        co[j]= list_of_powers[bb[j]]

    
    Frob1 = k.frobenius_endomorphism(bb[0]) # use frebenius to raise the power of an element to 2^a[0]
    Frob2 = k.frobenius_endomorphism(bb[1]) # use frebenius to raise the power of an element to 2^a[1]
    Frob3 = k.frobenius_endomorphism(bb[2]) # use frebenius to raise the power of an element to 2^a[2]
    Frob4 = k.frobenius_endomorphism(bb[3]) # use frebenius to raise the power of an element to 2^a[3]

    isInv = False
    linearTrans = matrix(k, 3, 3, lambda i,j : k.random_element())
    #print(linearTrans)
    while isInv == False:
        linearTrans = matrix(k, 3, 3, lambda i,j : k.random_element())
        if(linearTrans.det() > 0): #it can be either 0 or 1
            isInv = True
    #print(linearTrans)

    suma = 0
    sumb = 0
    sumc = 0
    
    d = 0

    t1 = time.time()

    for i,x in enumerate(k):
        if(i == 2^deg):#the dimension is here
            break
        
        #whitenning key/constant addition
        a = x + rc[0]
        b = x + rc[1]
        c = x + rc[2]
       

        for r in range(round):#the number of rounds here

    #------ now compute the step y = x^{2^{d}}
            a1 = Frob(a) # raise a to 2^d
            b1 = Frob(b) # raise b to 2^d
            c1 = Frob(c) # raise c to 2^d
    #--------- now compute the step x = xy, i.e. S(x)=x^{2^d}x=x^{2^d+1}
            a = a1*a
            b = b1*b
            c = c1*c

    #------- start the operation B(x)
            sum1 = co[0]*Frob1(a) + co[1]*Frob2(a) + co[2]*Frob3(a) + co[3]*Frob4(a)
            sum2 = co[0]*Frob1(b) + co[1]*Frob2(b) + co[2]*Frob3(b) + co[3]*Frob4(b)
            sum3 = co[0]*Frob1(c) + co[1]*Frob2(c) + co[2]*Frob3(c) + co[3]*Frob4(c)

    #------- the matrix multiplication
            #fixed matrix
            #a = (t^2)*sum1 + 1*sum2 + (1+t^2)*sum3
            #b = 1*sum1 + 1*sum2 + 1*sum3
            #c = (1+t^2)*sum1 + (t^2)*sum2 + 1*sum3
           
            #case2: random matrix M
            a = linearTrans[0][0]*sum1 + linearTrans[0][1]*sum2 + linearTrans[0][2]*sum3
            b = linearTrans[1][0]*sum1 + linearTrans[1][1]*sum2 + linearTrans[1][2]*sum3
            c = linearTrans[2][0]*sum1 + linearTrans[2][1]*sum2 + linearTrans[2][2]*sum3
            
            
            a = a+rc[3*r]
            b = b+rc[3*r+1]
            c = c+rc[3*r+2]
    ##############################################1 round#########################
        suma = suma + a
        sumb = sumb + b
        sumc = sumc + c

        if(suma == 0 and sumb ==0 and sumc ==0):
            d = log(i+1,2).n()
            if(d>1):
                break


    t2 = time.time()

    print('round:', round, 'upper bound:',ceil(d-1), 'time:',ceil(t2-t1))

candi0 = [[0,63],[0,42],[0,9],[0,36],[0,6]]
for c in candi0:
    print(c,end=' ')
    findD(129,1,c,2,5,28)

print()

candi1 = [[0,3],[0,6],[0,36]]
for c in candi1:
    print(c,end=' ')
    findD(63,32,c,2,5,28)

print()


candi2 = [[0,2,25],[0,2,9],[0,2,14],[0,2,20],[0,2,22],[0,2,24],[0,2,25],[0,2,26],[0,2,27],[0,2,38],[0,2,39],[0,2,40],[0,2,41],[0,2,43],[0,2,45],[0,2,51],[0,2,56],[0,3,27],[0,3,39],[0,4,10],[0,4,17],[0,4,26],[0,4,29],[0,4,38],[0,4,41],[0,4,50],[0,4,57],[0,5,19],[0,5,24],[0,5,28],[0,5,40],[0,5,44],[0,5,49],[0,6,14],[0,6,15],[0,6,54],[0,6,55],[0,7,22],[0,7,27],[0,7,34],[0,7,36],[0,7,43],[0,7,48],[0,8,18],[0,8,26],[0,8,45],[0,8,53],[0,9,26],[0,9,28],[0,9,34],[0,9,35],[0,9,37],[0,9,38],[0,9,44],[0,9,46],[0,10,23],[0,10,25],[0,10,27],[0,10,28],[0,10,29],[0,10,44],[0,10,45],[0,10,46],[0,10,48],[0,10,50],[0,11,29],[0,11,34],[0,11,36],[0,11,38],[0,11,40],[0,11,45],[0,12,26],[0,12,30]]
for c in candi2:
    print(c,end=' ')
    findD(63,32,c,3,4,17)
print()

candi3 = [[0,1,6,54],[0,1,6,55],[0,1,6,56],[0,1,6,79],[0,1,6,80],[0,1,6,81],[0,1,7,27],[0,1,7,28],[0,1,7,29],[0,1,7,34],[0,1,7,35],[0,1,7,36],[0,1,7,40],[0,1,7,41],[0,1,7,54],[0,1,7,55],[0,1,7,56],[0,1,7,57],[0,1,7,79],[0,1,7,80],[0,1,7,81],[0,1,7,82],[0,1,7,95],[0,1,7,100],[0,1,7,101],[0,1,7,102],[0,1,7,103],[0,1,7,107],[0,1,7,108],[0,1,7,109],[0,1,8,28],[0,1,8,29]]
for c in candi3:
    print(c,end=' ')
    findD(129,1,c,4,4,17)
