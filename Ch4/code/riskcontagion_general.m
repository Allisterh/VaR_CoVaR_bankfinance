clear
for i=1:1:8  %���������������
k=2015-i;  %��ȡ��ǰ���

eval(['X=xlsread(''lingo.xlsx'',''',num2str(k),''',''A1:P16'');']);
BankNum=16;  %��������
Deta=0.25;   %����ͬҵ�����ʲ��ķ���Ȩ��ϵ��
LGDList=[5 10 15 20 40 50 60 65 70 75 80 90 100]/100;      %ͬҵ����ʽ��ΥԼ��ʧ��
LGDLen=length(LGDList);
Num=10;     %��Ⱦ�������ֵ�趨
LunCi=zeros(BankNum,LGDLen);       %��ΥԼ���£�ÿ�����е���������Ĵ�Ⱦ�ִΣ���ʼ����
BankDownLunCi=zeros(BankNum,LGDLen);    %��ΥԼ���£�ÿ�����е�������������е�����������ʼ����
BiLi=zeros(BankNum,LGDLen);   %��ΥԼ���£�ÿ�����е������������Ӱ�������ʲ����أ���ʼ����
eval(['TotalAsset=xlsread(''asset.xlsx'',''Sheet1'',''A',num2str(i),':P',num2str(i),''');']);   %�������ʲ�
eval(['Liability_interbank=xlsread(''liability_interbank.xlsx'',''Sheet1'',''A',num2str(i),':P',num2str(i),''');']);   %���м为ծ 
InterBankDebtSum=sum(Liability_interbank);   %�������м为ծ֮��
eval(['CoreCapital=xlsread(''corecapital.xlsx'',''Sheet1'',''A',num2str(i),':P',num2str(i),''');']);    %�����ʱ�
eval(['RiskWeightedAsset=xlsread(''rwa.xlsx'',''Sheet1'',''A',num2str(i),':P',num2str(i),''');']);    %���ռ�Ȩ�ʲ��ܶ� 
eval(['BankDownResult',num2str(k),'=cell(size(LGDList,2),Num);']);  %���е��������������ʼ�� 
eval(['BankDownTotalResult',num2str(k),'=cell(size(LGDList,2),Num);']);  %���е���������������ʼ��

for ll=1:LGDLen           %���ѭ����ѭ������ll=LGD
    LGD=LGDList(ll);
    BankDownTotalNum=zeros(Num,BankNum);
    BankDownNum=zeros(BankNum,BankNum);

  for kk=1:Num       %���ѭ����ѭ������kk=�ִ�    
     [BankDownTotalNum(kk,:) BankDownNum] = BankDownFun(X,Deta,LGD,BankNum,BankDownNum,InterBankDebtSum,CoreCapital,RiskWeightedAsset);  %ii�������ȵ���,��kk�ִ���,���е��յ����
   %�������1����ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ�����Ŀ���������2����ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ����������������ii����
   eval(['BankDownResult',num2str(k),'{ll,kk}=BankDownNum;']); %���ݱ��棺��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ����������������ii����    
   eval(['BankDownTotalResult',num2str(k),'{ll,kk}=BankDownTotalNum(kk,:);']); %���ݱ��棺��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ�����Ŀ
     %ͳ�Ƶ�ǰΥԼ�ʺ������ִ��£��������е�������������е������������ֵ��10���е����ֵ��������ʽ�㷨��
    for mm=1:BankNum    %�����ѭ����ѭ������mm=����mm   
        if BankDownLunCi(mm,ll)<BankDownTotalNum(kk,mm)
           BankDownLunCi(mm,ll)=BankDownTotalNum(kk,mm);
           LunCi(mm,ll)=kk; %��������ʱ����10���������󵹱��������ִ������
           BiLi(mm,ll)=sum(TotalAsset.*BankDownNum(mm,:))/(sum(TotalAsset)-TotalAsset(mm)); %��������ʱ����10���������󵹱���������Ӱ���ʲ��������
          %����=�ʲ���*�ѵ��յ��������=�ѵ��յ��ʲ�������ĸ=sum���ʲ��У�-����ii�����ʲ�
        end
    end
 end
end

%%������ģ��
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''����ii��������ĵ�����������''} ,''Sheet1'',''A1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ũҵ����''} ,''Sheet1'',''A2'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ͨ����''} ,''Sheet1'',''A3'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A4'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A5'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�й�����''} ,''Sheet1'',''A6'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ƽ������''} ,''Sheet1'',''A7'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�ַ�����''} ,''Sheet1'',''A8'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A9'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A10'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A11'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ҵ����''} ,''Sheet1'',''A12'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�������''} ,''Sheet1'',''A13'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A14'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A15'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�Ͼ�����''} ,''Sheet1'',''A16'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet1'',''A17'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', LGDList,''Sheet1'',''B1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', BankDownLunCi,''Sheet1'',''B2'');']);


eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''����ii��������ķ��մ�Ⱦ����''} ,''Sheet2'',''A1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ũҵ����''} ,''Sheet2'',''A2'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ͨ����''} ,''Sheet2'',''A3'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A4'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A5'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�й�����''} ,''Sheet2'',''A6'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ƽ������''} ,''Sheet2'',''A7'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�ַ�����''} ,''Sheet2'',''A8'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A9'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A10'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A11'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ҵ����''} ,''Sheet2'',''A12'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�������''} ,''Sheet2'',''A13'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A14'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A15'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�Ͼ�����''} ,''Sheet2'',''A16'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet2'',''A17'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', LGDList,''Sheet2'',''B1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', LunCi,''Sheet2'',''B2'');']);

eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''����ii�����������Ӱ���ʲ�����''} ,''Sheet3'',''A1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ũҵ����''} ,''Sheet3'',''A2'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ͨ����''} ,''Sheet3'',''A3'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A4'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A5'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�й�����''} ,''Sheet3'',''A6'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''ƽ������''} ,''Sheet3'',''A7'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�ַ�����''} ,''Sheet3'',''A8'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A9'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A10'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A11'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��ҵ����''} ,''Sheet3'',''A12'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�������''} ,''Sheet3'',''A13'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A14'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A15'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''�Ͼ�����''} ,''Sheet3'',''A16'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', {''��������''} ,''Sheet3'',''A17'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', LGDList,''Sheet3'',''B1'');']);
eval(['xlswrite(''���з��մ�Ⱦ',num2str(k),'.xls'', BiLi,''Sheet3'',''B2'');']);

eval(['save(''BankDownResult',num2str(k),'.mat'',''BankDownResult',num2str(k),''');']);
eval(['save(''BankDownTotalResult',num2str(k),'.mat'',''BankDownTotalResult',num2str(k),''');']);

clearvars -EXCEPT i
end

%%�����ȡģ��
for i=1:1:8  %���������������
k=2015-i;  %��ȡ��ǰ���
eval(['load(''BankDownResult',num2str(k),'.mat'');']);
eval(['load(''BankDownTotalResult',num2str(k),'.mat'');']);
end
clearvars i k
save('BankDownResult.mat');  %�����е��ս�����ܱ��浽�����ļ���
load('BankDownResult.mat');  %��ȡ���ܵ����е��ս��