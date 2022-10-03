from Unit_Def import Shifter,Big_LUT
from binary_fractions import Binary
import math
import numpy as np
from AppDiv_Fitting import AppDiv
import matplotlib.pyplot as plt

if __name__ == "__main__":
    
    
    number_bit_width = 16
    radix_pos = 4
    big1 = Big_LUT(16,12)
    appdiv1 = AppDiv(number_bit_width,radix_pos,big1)
    #print(appdiv1.execute(10,12))
    error_average_dict = {}
    error_max_dict = {}

    error_average_list = []
    error_max_list = []
    
    test_para = 10 

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

    xpoints = np.array(bit_length_range)
    ypoints = np.array(error_max_dict[approximate_region1])
    plt.plot(xpoints,ypoints,'b',label = f'{approximate_region1:.0f} by {approximate_region1:.0f} regions fitting')
    plt.legend(loc = "upper right")
    plt.ylabel("MAEP")
    plt.xlabel("bit width of constant p,q and r")
    plt.show()
