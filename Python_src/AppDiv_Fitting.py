

from Unit_Def import Shifter,Big_LUT
from binary_fractions import Binary
import math
import numpy as np
class AppDiv:


    def __init__(self,bit_width,radix_pos,lut:Big_LUT):
        #give the bit length
        self._shifter = Shifter(bit_width,radix_pos)
        self._lut = lut

    def execute(self,dividend,divisor): #how to make take different type of number, string, number
        #using sequential statements to execute the dataflow model
        self._shifter.input  = dividend
        mantissaAstr,expoA = self._shifter.getMantissaExpo()
        self._shifter.input = divisor
        mantissaBstr,expoB = self._shifter.getMantissaExpo()

        mantissa_A = Binary.to_float(mantissaAstr)
        mantissa_B = Binary.to_float(mantissaBstr)
        p00,p01,p10 = self._lut.find(mantissa_A,mantissa_B)
        M = p01*mantissa_A + p10*mantissa_B + p00
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

        if flag_showbar == True:
            number_points = 0
            for i in m_i[:-1]:
                for j in np.floor(np.linspace(i,1,math.floor(test_parameter*i/maximum_input))):
                    number_points+=1

        number_failed_points = 0
        number_success_points = 0
        progress = 0
        for i in m_i[:-1]:
            for j in np.floor(np.linspace(i,1,math.floor(test_parameter*i/maximum_input))):
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
        print("AppDiv with approximate regions ",self._lut.number_region, " by ",self._lut.number_region)
        print(f'has averge error of {error_average:.3f} percentage')
        print(f'maximum error of {error_max:.3f} percentage' )
        print("tested points ",len(errors), " in total")
        print("failed points due to conversion bugs: ",number_failed_points)
    @property
    def Bit_Width(self):
        return self.Bit_Width 


if __name__ == "__main__":
    shifter1 = Shifter(16,4)
    big1 = Big_LUT(15,16)
    appdiv1 = AppDiv(16,4,big1)
    print(appdiv1.execute(15,12))
    appdiv1.error_summary(50,True)


