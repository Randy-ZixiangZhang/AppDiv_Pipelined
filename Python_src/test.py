from Unit_Def import Shifter,Big_LUT
from AppDiv_Fitting import AppDiv


from binary_fractions import Binary
bf1str: str = "-1.01"
fl2: float = 0.6
bf1: Binary = Binary(bf1str)
print(f"Binary({fl2}) = {Binary(fl2)}")

#string of binary
bf2str: str = str(Binary(fl2))

radix_pos = bf2str.find('.')
print(bf2str[:radix_pos + 13])

#print(Binary(123.456))
#print(f"float of ({bf1str}) = {Binary.to_float(bf1str)} ")
#print(f"float of ({bf1str}) = {Binary.to_float(bf1str)+1} ")

#print(range(0,0.1))
#P = {range(0,0.1):(1,1,1),range(0.1,0.2):(0,0,0)}

#print(P[0.05])

print("test")
print(Binary("1e{}".format(-0)))



number_bit_width = 16
decimal_pos = 4
big1 = Big_LUT(16,12)

shift_test = Shifter(number_bit_width,decimal_pos)
shift_test.input = 1
str1 = str(Binary(1))+".0"
print(str(Binary(1))+".0")
dot_pos = str1.find('.')
for index,bit in enumerate(str1):
    if bit == '1':
        pos_firstOne = index #index of first leading 1
        break 
mantissa_str = str1[pos_firstOne+1:] #take all the bits after position of '.'
expo = dot_pos - pos_firstOne - 1 #remember the shifts
print("test")
print(mantissa_str)
print(Binary("1e{}".format(-expo)))
print(Binary(mantissa_str))
print(Binary(mantissa_str)*Binary("1e{}".format(-expo)))
mantissa = str(Binary(mantissa_str)*Binary("1e{}".format(-expo)))

print(str1[:dot_pos + decimal_pos + 1 ])
print(str(Binary("0")))
#mantissaAstr,expoA = shift_test.getMantissaExpo()