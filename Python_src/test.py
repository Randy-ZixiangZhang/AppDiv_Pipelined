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


