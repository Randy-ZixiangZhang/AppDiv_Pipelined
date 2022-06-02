
from binary_fractions import Binary

class Shifter(): #shift_unit in vhd
    _input = None
    _bit_width = None
    _radix_pos = None
    def __init__(self,bit_width,radix_pos) -> None:
        self._bit_width = bit_width
        self._radix_pos = radix_pos

    @property
    def input(self):
        return self._input
    @input.setter
    def input(self,num:float):
        if num > self.max_num or num < self.min_num:
            raise Shifter("input number outside range")
        else:
            self._input = num
    @property
    def max_num(self): #maximum value representable
        int_part = 2**(self._bit_width-self._radix_pos) - 1
        fractional_part = 0
        for i in range(1,self._radix_pos+1):
            fractional_part += (1/2)**i
        return int_part + fractional_part
    @property
    def min_num(self):
        return (1/2)**self._radix_pos        
    
    def getBinaryStr(self):
        #from float to str, and remove bit exceeding radix_pos
        bf2str:str = str(Binary(self.input))
        if bf2str.find('.') == -1:
            bf2str = bf2str + ".0"
        dot_pos = bf2str.find('.')
        return (bf2str[:dot_pos + self._radix_pos + 1 ])

    def getMantissaExpo(self):
        BinaryStr = self.getBinaryStr()
        pos_radix = BinaryStr.find('.')
        for index,bit in enumerate(BinaryStr):
            if bit == '1':
                pos_firstOne = index
                break 
        mantissa_str = BinaryStr[pos_firstOne+1:]
        expo = pos_radix - pos_firstOne - 1
        return (mantissa_str,expo)




if __name__ == "__main__":        
    shift1 = Shifter(16,4)

    print(shift1.max_num)
    print(shift1.min_num)
    shift1.input = 14
    print(shift1.getBinaryStr())
    a,b = shift1.getMantissaExpo()
    print(a,b)