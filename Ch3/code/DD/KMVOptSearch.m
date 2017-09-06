function [AV,sigmaAV]=KMVOptSearch(SV,DP,rf,sigmaSV)
% KMVOptSearch
% code by SCY 2015-3-31
SVtoDP=SV/DP;
x0=[1,1];%������ʼ��
result=fsolve(@(x) KMVfun(SVtoDP,rf,sigmaSV,x),x0);
AV=result(1)*SV;
sigmaAV=result(2);
%AV�����ʲ���ֵ��sigmaAV�����ʲ���ֵ�Ĳ�����