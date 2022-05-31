import test2
from binary_fractions import Binary
import math

#two integer
dividend:float = 32
divisor:float = 166
precision = 4

#float to binary conversion
def float2bin(num:float,precision:int)->str:
    bf2str:str = str(Binary(num))
    if bf2str.find('.') == -1:
        bf2str = bf2str + ".0"
    radix_pos = bf2str.find('.')
    return(bf2str[:radix_pos + precision + 1])

def getMantissa(bstr:str):
    pos_radix = bstr.find('.')
    for i in range(len(bstr)):
        if bstr[i] == '1':
            pos_firstOne = i
            break 
    
    mantissa_str = bstr[pos_firstOne+1:]
    expo = pos_radix - pos_firstOne - 1

    mantissa = str(Binary(mantissa_str)*Binary("1e{}".format(-expo)))
    return (mantissa,expo)


print(str(Binary(0)))

#print(Binary("0b.0"))
#print(float2bin(1,precision))
#print(getMantissa(float2bin(1,precision)))
#find mantissa

def find_quotient(dividend,divisor,precision):
    mantissa_A, expo_A = getMantissa(float2bin(dividend,precision))
    mantissa_B, expo_B = getMantissa(float2bin(divisor,precision))

    mantissa_A_float = Binary.to_float(mantissa_A)
    mantissa_B_float = Binary.to_float(mantissa_B)

    big = test2.Big_LUT(10,16)
    p00,p01,p10_ex = big.find(mantissa_A_float,mantissa_B_float)

    p00 = Binary.to_float(float2bin(p00,16))
    p01 = Binary.to_float(float2bin(p01,16))
    p10 = -abs(Binary.to_float(float2bin(p10_ex,12)))
    #print("p10_ex %f p10 %f" %(p10_ex,p10))


    M_exact = p01*mantissa_A_float + p10*mantissa_B_float + p00

    M = Binary.to_float(float2bin(M_exact,16))
    
    shift = expo_A - expo_B - 1 if mantissa_A_float<mantissa_B_float else expo_A - expo_B
    bstr_M = str(Binary(M)*Binary("1e{}".format(shift)))
    final = Binary.to_float(bstr_M)
    quotient = dividend/divisor
    error = (final - quotient)/quotient*100
    return final,quotient,error


""" print(Binary.to_float(mantissa_A))
print(mantissa_A)
print(expo_A) """


#print(type(big.find(mantissa_A_float,mantissa_B_float)))
#print(str(M))

""" print(dividend/divisor)
print(final)
print("error {}".format((final - quotient)/quotient*100)) """


#print(big.find(0.15,0.05))
print(find_quotient(4095,3,4))



max = 2**12 - 1
min = 2
point = 20

p00 = 1.233322523423
print(Binary.to_float(float2bin(p00,12)))

approximates = []
quotients = []
errors = []



m_i = test2.numpy.floor(test2.numpy.linspace(max,1,point))
for i in m_i[:-1]:
    for j in test2.numpy.floor(test2.numpy.linspace(i,1,math.floor(point*i/max))):
        try: 
            final,quotient,error = find_quotient(i,j,4)
            #print("dividend %d divisor %d" %(i,j))
            errors.append(error)
        except:
            continue

print(sum(errors)/len(errors))
#print(max(errors))

textfile = open("error_file.txt", "w")
for element in errors:
    textfile.write(str(element) + "\n")
textfile.close()

""" print((float2bin(-0.687222,12)))
print(Binary.to_float(float2bin(-0.687222,12))) """