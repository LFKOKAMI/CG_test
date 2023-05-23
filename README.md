If you want to test the zero-sum property in only one output words, you can simply change

        suma == 0 and sumb == 0 and sumc == 0 #(used to test all-zero property)

to

        suma == 0 or sumb == 0 or sumc == 0 #(used to test one-zero property)
        
        
 In the defaut setting, we use the random matrix. If you want to use the fixed matrix, please consider to use
 
            a = (t^2)*sum1 + 1*sum2 + (1+t^2)*sum3
            b = 1*sum1 + 1*sum2 + 1*sum3
            c = (1+t^2)*sum1 + (t^2)*sum2 + 1*sum3
 
 rather than
 
            a = linearTrans[0][0]*sum1 + linearTrans[0][1]*sum2 + linearTrans[0][2]*sum3
            b = linearTrans[1][0]*sum1 + linearTrans[1][1]*sum2 + linearTrans[2][2]*sum3
            c = linearTrans[2][0]*sum1 + linearTrans[1][1]*sum2 + linearTrans[2][2]*sum3
 
 
