

from Unit_Def import Shifter,Big_LUT
from binary_fractions import Binary

class AppDiv:
    def __init__(self,shifter:Shifter,lut:Big_LUT):
        #give the bit length
        self._shifter = shifter
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
    @property
    def Bit_Width(self):
        return self.Bit_Width 


if __name__ == "__main__":
    shifter1 = Shifter(16,4)
    big1 = Big_LUT(10,16)
    appdiv1 = AppDiv(shifter1,big1)
    print(appdiv1.execute(15,12))
    
    shift2 = Shifter(16,4)
    big2 = Big_LUT(20,12)
    appdiv2 = AppDiv(shift2,big2)
    print(appdiv2.execute(15,12))