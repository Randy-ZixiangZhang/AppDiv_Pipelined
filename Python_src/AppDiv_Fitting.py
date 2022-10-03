#test git 

from Unit_Def import Shifter,Big_LUT
from binary_fractions import Binary
import math
import numpy as np
class AppDiv:


    def __init__(self,bit_width,decimal_pos,lut:Big_LUT):
        #give the bit length
        self._bit_width = bit_width # bit width for the approximate divider
        self._decimal_pos = decimal_pos # how to interpret the e.g 16 bit divider, if decimal = 4, means the integer part is the first 4 bits.
        self._shifter = Shifter(bit_width,decimal_pos) # the shifter is determined when the AppDiv is initialized with the two parameters.
        self._lut = lut

    def setLut(self,lut:Big_LUT):
        self._lut = lut


    def execute(self,dividend,divisor): # execute a single division
        self._shifter.input  = dividend # feed into shifter
        mantissaAstr,expoA = self._shifter.getMantissaExpo()
        self._shifter.input = divisor
        mantissaBstr,expoB = self._shifter.getMantissaExpo()

        mantissa_A = Binary.to_float(mantissaAstr)
        mantissa_B = Binary.to_float(mantissaBstr)
        p00,p01,p10 = self._lut.find(mantissa_A,mantissa_B)
        M_exact = p01*mantissa_A + p10*mantissa_B + p00
        M = self.clip(M_exact)
        shift = expoA - expoB - 1 if mantissa_A<mantissa_B else expoA - expoB
        bstr_M = str(Binary(M)*Binary("1e{}".format(shift)))
        final = Binary.to_float(bstr_M)
        quotient = dividend/divisor
        error = (final - quotient)/quotient*100
        return final,quotient,error

    def error_summary(self,test_parameter,flag_showbar = False):
        maximum_input = self._shifter.max_num
        errors = []
        m_i = np.floor(np.linspace(maximum_input,1,test_parameter)) 
        m_i = list(set(m_i))

        if flag_showbar == True:
            number_points = 0
            for i in m_i[:-1]:
                for j in np.floor(np.linspace(i,1,math.floor(test_parameter*i/maximum_input))):
                    number_points+=1

        number_failed_points = 0
        number_success_points = 0
        progress = 0
        n_i = []
        for i in m_i[:-1]:
            n_i  = set(np.floor(np.linspace(i,1,math.floor(test_parameter*i/maximum_input))));
            for j in n_i:
                try: 
                    final,quotient,error = self.execute(i,j)
                    errors.append(abs(error))
                    number_success_points+=1
                    if flag_showbar == True:
                        new_progress = np.floor(number_success_points/number_points*100)
                        if new_progress - progress == 1:
                            progress = new_progress
                            print(f'progress: {new_progress:.0f} percentage')           
                except:
                    number_failed_points += 1
                    continue
        error_average = sum(errors)/len(errors)
        error_max = max(errors)
        if flag_showbar == True:
            print("AppDiv with approximate regions ",self._lut.number_region, " by ",self._lut.number_region)
            print(f'has averge error of {error_average:.3f} percentage')
            print(f'maximum error of {error_max:.3f} percentage' )
            print("tested points ",len(errors), " in total")
            print("failed points due to conversion bugs: ",number_failed_points)
        return (error_average,error_max)

    def clip(self,num):
        bf2str:str = str(Binary(num))
        if bf2str.find('.') == -1:
            bf2str = bf2str + ".0"
        decimal_pos = bf2str.find('.')
        return(bf2str[:decimal_pos + (self._bit_width -3) + 1])

    @property
    def Bit_Width(self):
        return self._bit_width 


if __name__ == "__main__":
    import matplotlib.pyplot as plt
    
    number_bit_width = 16
    decimal_pos = 4
    big1 = Big_LUT(16,12)
    appdiv1 = AppDiv(number_bit_width,decimal_pos,big1)
    #print(appdiv1.execute(10,12))
    error_average_dict = {}
    error_max_dict = {}


    test_para = 25


    error_average_list = []
    error_max_list = []
    approximate_region0 = 1
    
    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region0,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region0] = error_average_list
    error_max_dict[approximate_region0] = error_max_list

    error_average_list = []
    error_max_list = []
    approximate_region1 = 2

    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region1,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region1] = error_average_list
    error_max_dict[approximate_region1] = error_max_list

    error_average_list = []
    error_max_list = []
    approximate_region2 = 3

    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region2,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region2] = error_average_list
    error_max_dict[approximate_region2] = error_max_list

    error_average_list = []
    error_max_list = []
    approximate_region3 = 4

    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region3,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region3] = error_average_list
    error_max_dict[approximate_region3] = error_max_list
    #error_average, error_max = appdiv1.error_summary(50,False)

    error_average_list = []
    error_max_list = []

    approximate_region4 = 6

    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region4,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region4] = error_average_list
    error_max_dict[approximate_region4] = error_max_list


    error_average_list = []
    error_max_list = []

    approximate_region5 = 8
    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region5,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region5] = error_average_list
    error_max_dict[approximate_region5] = error_max_list



    error_average_list = []
    error_max_list = []
    approximate_region6 = 10
    bit_length_range = range(4,21)
    for bit_width in bit_length_range:
        lut = Big_LUT(approximate_region6,bit_width)
        appdiv1.setLut(lut)
        error_average, error_max = appdiv1.error_summary(test_para,True)
        error_average_list.append(error_average)
        error_max_list.append(error_max)
    error_average_dict[approximate_region6] = error_average_list
    error_max_dict[approximate_region6] = error_max_list

    xpoints = np.array(bit_length_range)

    ypoints = np.array(error_max_dict[approximate_region0])
    plt.plot(xpoints,ypoints,'k',label = f'{approximate_region0:.0f} by {approximate_region0:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region1])
    plt.plot(xpoints,ypoints,'b',label = f'{approximate_region1:.0f} by {approximate_region1:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region2])
    plt.plot(xpoints,ypoints,'r',label = f'{approximate_region2:.0f} by {approximate_region2:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region3])
    plt.plot(xpoints,ypoints,'g',label = f'{approximate_region3:.0f} by {approximate_region3:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region4])
    plt.plot(xpoints,ypoints,'c',label = f'{approximate_region4:.0f} by {approximate_region4:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region5])
    plt.plot(xpoints,ypoints,'m',label = f'{approximate_region5:.0f} by {approximate_region5:.0f} regions fitting')
    ypoints = np.array(error_max_dict[approximate_region6])
    plt.plot(xpoints,ypoints,'y',label = f'{approximate_region6:.0f} by {approximate_region6:.0f} regions fitting')
    plt.legend(loc = "upper right")
    plt.ylabel("MAEP")
    plt.xlabel("bit width of constant p,q and r")
    plt.show()

