function F=KMVfun(SVtoDP,rf,sigmaSV,x)
% KMVfun
% code by SCY 2015-3-31
d1=(log(x(1)*SVtoDP)+(rf+0.5*x(2)^2))/x(2);
d2=d1-x(2);
F=[x(1)*normcdf(d1)-exp(-rf)*normcdf(d2)/SVtoDP-1;
    normcdf(d1)*x(1)*x(2)-sigmaSV];
%x(1)��ʾ�ʲ����г���ֵ���Ʊ���г���ֵ֮�ȣ�x(2)��ʾ�ʲ�������
   