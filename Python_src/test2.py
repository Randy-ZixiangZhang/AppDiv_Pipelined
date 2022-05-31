import numpy

import bisect
from scipy.optimize import curve_fit

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

        return (self.fitting_database.get(key_paras))

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





print([(lambda x:2*x)(x) for x in [2,3,5]])
big = Big_LUT(10,16)
print(big.find(0.15,0.25))
""" print(big.boundaries_pair_list[9])
print(big.boundaries) """

