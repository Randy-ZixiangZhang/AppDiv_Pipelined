from poplib import POP3_PORT
import numpy
from scipy.optimize import curve_fit


f = (lambda x,y:(1+x)/(1+y))
x = numpy.linspace(0,0.1,10)
y = numpy.linspace(0,0.1,10)
X,Y = numpy.meshgrid(x,y)
Z = f(X,Y)

def func(M,p00,p01,p10):
    x,y = M
    arr = numpy.zeros(x.shape)
    return p01*x+p10*y + p00

popt,pcov = curve_fit(func,numpy.vstack((X.ravel(),Y.ravel())),Z.ravel())

""" print(numpy.vstack((X.ravel(),Y.ravel())))
print(Z.ravel())
print(popt) """

dict = {}

if ((3,4),1) not in dict:
    print("not found it")

dict[((3,4),1)] = numpy.array([2,3,4])

if ((3,4),1) in dict:
    print("found it")

A = numpy.array([2,3,4])
p1,p2,p3 = A
print(p1)
""" dict = {}
dict.setdefault(None)
print(dict.get(123,None)) """

