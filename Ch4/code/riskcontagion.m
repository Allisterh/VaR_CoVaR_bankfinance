clear

X=xlsread('lingo.xlsx','2014','A1:P16');  %���м�˫�߷��ճ��ھ���(Lingo Result)
BankNum=16;  %��������
Deta=0.25;   %����ͬҵ�����ʲ��ķ���Ȩ��ϵ��
LGDList=[5 10 15 20 40 50 60 65 70 75 80 90 100]/100;      %ͬҵ����ʽ��ΥԼ��ʧ��
LGDLen=length(LGDList);
Num=10;     %��Ⱦ�������ֵ�趨
LunCi=zeros(BankNum,LGDLen);       %��ΥԼ���£�ÿ�����е���������Ĵ�Ⱦ�ִΣ���ʼ����
BankDownLunCi=zeros(BankNum,LGDLen);    %��ΥԼ���£�ÿ�����е�������������е�����������ʼ����
BiLi=zeros(BankNum,LGDLen);   %��ΥԼ���£�ÿ�����е������������Ӱ�������ʲ����أ���ʼ����
TotalAsset=xlsread('asset.xlsx','Sheet1','A1:P1');   %�������ʲ�
Liability_interbank=xlsread('liability_interbank.xlsx','Sheet1','A1:P1');   %���м为ծ
InterBankDebtSum=sum(Liability_interbank);   %�������м为ծ֮��
CoreCapital=xlsread('corecapital.xlsx','Sheet1','A1:P1');  %�����ʱ�
RiskWeightedAsset=xlsread('rwa.xlsx','Sheet1','A1:P1');  %���ռ�Ȩ�ʲ��ܶ�
BankDownResult2014=cell(size(LGDList,2),Num);  %���е��������������ʼ��
BankDownTotalResult2014=cell(size(LGDList,2),Num);  %���е���������������ʼ��

for ll=1:LGDLen           %�����ѭ����ѭ������ll=LGD
    LGD=LGDList(ll);
    BankDownTotalNum=zeros(Num,BankNum);
    BankDownNum=zeros(BankNum,BankNum);

  for kk=1:Num       %���ѭ����ѭ������kk=�ִ�    
     [BankDownTotalNum(kk,:) BankDownNum] = BankDownFun(X,Deta,LGD,BankNum,BankDownNum,InterBankDebtSum,CoreCapital,RiskWeightedAsset);  %ii�������ȵ���,��kk�ִ���,���е��յ����
   %�������1����ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ�����Ŀ���������2����ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ����������������ii����
     BankDownResult2014{ll,kk}=BankDownNum; %���ݱ��棺��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ����������������ii����
	 BankDownTotalResult2014{ll,kk}=BankDownTotalNum(kk,:);  %���ݱ��棺��ǰΥԼ�ʺ͵�ǰ�ִ��£�����ii�����������������е��յ�����Ŀ
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
xlswrite('���з��մ�Ⱦ2014.xls', {'����ii��������ĵ�����������'},'Sheet1','A1');
xlswrite('���з��մ�Ⱦ2014.xls', {'ũҵ����'},'Sheet1','A2');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ͨ����'},'Sheet1','A3');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A4');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A5');
xlswrite('���з��մ�Ⱦ2014.xls', {'�й�����'},'Sheet1','A6');
xlswrite('���з��մ�Ⱦ2014.xls', {'ƽ������'},'Sheet1','A7');
xlswrite('���з��մ�Ⱦ2014.xls', {'�ַ�����'},'Sheet1','A8');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A9');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A10');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A11');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ҵ����'},'Sheet1','A12');
xlswrite('���з��մ�Ⱦ2014.xls', {'�������'},'Sheet1','A13');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A14');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A15');
xlswrite('���з��մ�Ⱦ2014.xls', {'�Ͼ�����'},'Sheet1','A16');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet1','A17');
xlswrite('���з��մ�Ⱦ2014.xls', LGDList,'Sheet1','B1');
xlswrite('���з��մ�Ⱦ2014.xls', BankDownLunCi,'Sheet1','B2');

xlswrite('���з��մ�Ⱦ2014.xls', {'����ii��������ķ��մ�Ⱦ����'},'Sheet2','A1');
xlswrite('���з��մ�Ⱦ2014.xls', {'ũҵ����'},'Sheet2','A2');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ͨ����'},'Sheet2','A3');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A4');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A5');
xlswrite('���з��մ�Ⱦ2014.xls', {'�й�����'},'Sheet2','A6');
xlswrite('���з��մ�Ⱦ2014.xls', {'ƽ������'},'Sheet2','A7');
xlswrite('���з��մ�Ⱦ2014.xls', {'�ַ�����'},'Sheet2','A8');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A9');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A10');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A11');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ҵ����'},'Sheet2','A12');
xlswrite('���з��մ�Ⱦ2014.xls', {'�������'},'Sheet2','A13');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A14');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A15');
xlswrite('���з��մ�Ⱦ2014.xls', {'�Ͼ�����'},'Sheet2','A16');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet2','A17');
xlswrite('���з��մ�Ⱦ2014.xls', LGDList,'Sheet2','B1');
xlswrite('���з��մ�Ⱦ2014.xls', LunCi,'Sheet2','B2');

xlswrite('���з��մ�Ⱦ2014.xls', {'����ii�����������Ӱ���ʲ�����'},'Sheet3','A1');
xlswrite('���з��մ�Ⱦ2014.xls', {'ũҵ����'},'Sheet3','A2');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ͨ����'},'Sheet3','A3');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A4');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A5');
xlswrite('���з��մ�Ⱦ2014.xls', {'�й�����'},'Sheet3','A6');
xlswrite('���з��մ�Ⱦ2014.xls', {'ƽ������'},'Sheet3','A7');
xlswrite('���з��մ�Ⱦ2014.xls', {'�ַ�����'},'Sheet3','A8');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A9');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A10');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A11');
xlswrite('���з��մ�Ⱦ2014.xls', {'��ҵ����'},'Sheet3','A12');
xlswrite('���з��մ�Ⱦ2014.xls', {'�������'},'Sheet3','A13');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A14');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A15');
xlswrite('���з��մ�Ⱦ2014.xls', {'�Ͼ�����'},'Sheet3','A16');
xlswrite('���з��մ�Ⱦ2014.xls', {'��������'},'Sheet3','A17');
xlswrite('���з��մ�Ⱦ2014.xls', LGDList,'Sheet3','B1');
xlswrite('���з��մ�Ⱦ2014.xls', BiLi,'Sheet3','B2');