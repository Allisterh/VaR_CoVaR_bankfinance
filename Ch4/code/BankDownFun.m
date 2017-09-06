function[BankDownTotalNumOutput BankDownNumOutput]=BankDownFun(X,Deta,LGD,BankNum,BankDownNum,InterBankDebtSum,CoreCapital,RiskWeightedAsset)

X_data=X.*InterBankDebtSum;     %����һ��X���ʵ����ֵ���䵥λΪԪ
CoreCapital_T=CoreCapital';
RiskWeightedAsset_T=RiskWeightedAsset';
BankDownNum_temp=BankDownNum+eye(BankNum);        %�����������е���

for ii=1:BankNum     %ii�������ȵ���
   Down_temp=BankDownNum_temp(ii,:);       %�ڸ������£�ii�����Ѿ�����������е��յ����(��������)
    for jj=1:BankNum      %�ж�jj���е������
     if 0==Down_temp(jj)     %��jj���л�û�е���
      if (CoreCapital_T(jj)-sum(LGD.*X_data(jj,:).*Down_temp))/(RiskWeightedAsset_T(jj)-Deta.*sum(X_data(jj,:).*Down_temp))<0.06 %���е��յ��ж�����
          BankDownNum_temp(ii,jj)=1;          %�ڸ������£�ii�����Ѿ����jj���е���
       end
     end
   end
end

BankDownNumOutput=BankDownNum_temp-eye(BankNum);     %��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ����������������ii����
BankDownTotalNumOutput=sum(BankDownNumOutput');      %��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ�����Ŀ
end