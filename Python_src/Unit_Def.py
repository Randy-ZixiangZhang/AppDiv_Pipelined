
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
        mantissa = str(Binary(mantissa_str)*Binary("1e{}".format(-expo)))
        return (mantissa,expo)

#test


if __name__ == "__main__":        
    shift1 = Shifter(16,4)

    print(shift1.max_num)
    print(shift1.min_num)
    shift1.input = 14
    print(shift1.getBinaryStr())
    a,b = shift1.getMantissaExpo()
    print(a,b)


import numpy
import bisect
from scipy.optimize import curve_fit
def float2bin(num:float,precision:int)->str:
    bf2str:str = str(Binary(num))
    if bf2str.find('.') == -1:
        bf2str = bf2str + ".0"
    radix_pos = bf2str.find('.')
    return(bf2str[:radix_pos + precision + 1])
def approximate_func(M,p00,p01,p10):
    x,y = M
    arr = numpy.zeros(x.shape)
    return p01*x+p10*y + p00

class Big_LUT:
    def __init__(self,number_region:int,bit_width_keys:int) -> None: #lively look up would be too expensive #so generate a data structure and feed into it?
        self.number_region =  number_region
        self.bit_width_keys = bit_width_keys
        self.boundaries = numpy.linspace(0,1,self.number_region + 1) #for 10, 11 numbers are generated.
        self.boundaries_pair_list = [(lambda index:(self.boundaries[index],self.boundaries[index+1]))(index) for index in range(len(self.boundaries[:-1]))]
        self.fitting_database = {}
        self.per_region_samplingpoints = 100

    def initialize(self) -> None:#call this once to save LUT to avoid calling everytime later.
        pass
        #curve fitting

        #self.big_lut = 
    def find(self,dividend_mantissa:float,divisor_mantissa:float):
        #if self.boundaries[0] <= dividend <= self.boundaries[-1]:
        index_dividend = bisect.bisect_left(self.boundaries,dividend_mantissa) - 1#boundary 0 0.1 --- 1
        #if self.boundaries[0] <= divisor <= self.boundaries[-1]:
        index_divisor = bisect.bisect_left(self.boundaries,divisor_mantissa) - 1

        index_tuple = (index_dividend if index_dividend >= 0 else 0,index_divisor if index_divisor >= 0 else 0)

        flag_dividend_larger = dividend_mantissa >= divisor_mantissa
        key_paras = (index_tuple,flag_dividend_larger)

        if key_paras not in self.fitting_database : #key is nested tuple((),)
            paras = self.lookforParas(index_tuple,flag_dividend_larger) # a list
            self.fitting_database[key_paras] = paras
            return (paras)

        p00,p01,p10_ex = self.fitting_database.get(key_paras)
        p00 = Binary.to_float(float2bin(p00,16))
        p01 = Binary.to_float(float2bin(p01,16))
        p10 = -abs(Binary.to_float(float2bin(p10_ex,12)))
        return (p00,p01,p10)

    def lookforParas(self,index_tuple,DividendLarger): #-> Tuple[p00,p01,p11]:
        index_dividend,index_divisor = index_tuple
        floor_dividend,ceil_dividend = self.boundaries_pair_list[index_dividend]
        floor_divisor,ceil_divisor = self.boundaries_pair_list[index_divisor]
        x = numpy.linspace(floor_dividend,ceil_dividend,self.per_region_samplingpoints)
        y = numpy.linspace(floor_divisor,ceil_divisor,self.per_region_samplingpoints)
        X,Y = numpy.meshgrid(x,y)
        Z = numpy.zeros(X.shape)
        f = (lambda ma,mb:(1+ma)/(1+mb)) if DividendLarger else (lambda ma,mb:(1+ma)/(1+mb)*2)
        Z = f(X,Y)

        popt,pcov = curve_fit(approximate_func,numpy.vstack((X.ravel(),Y.ravel())),Z.ravel())
        return popt




if __name__ == "__main__":
    ([(lambda x:2*x)(x) for x in [2,3,5]])
    big = Big_LUT(10,16)
    print(big.find(0.15,0.25))
    """ print(big.boundaries_pair_list[9])
    print(big.boundaries) """


