function L=logopp(x)
%
%LOGOPP returns the log opponent values of a matrix according to the 
%formula:  L(x) = 105*log10(x+1+n)
%

L = log10(x+1)*105;

end