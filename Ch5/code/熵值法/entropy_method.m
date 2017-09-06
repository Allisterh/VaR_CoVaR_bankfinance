function [score,weight]=entropy_method(data)
[id,indexnum]=size(data);
[mapdata,range_settings]=mapminmax(data');
range_settings.ymin=0.002; %������һ�������Сֵ
range_settings.ymax=0.996; %������һ��������ֵ
range_settings.yrange=range_settings.ymax-range_settings.ymin; %������һ����ļ���
data2=mapminmax(data',range_settings); %ʹ�õ�����ļ����趨�����¶�ԭ���ݽ��й�һ��
normaldata=data2'; %��һ���������
%% �����j��ָ���£���i����¼ռ��ָ��ı���p(i,j)
for i=1:id
    for j=1:indexnum
        p(i,j)=normaldata(i,j)/sum(normaldata(:,j));
    end
end
%% �����j��ָ�����ֵe(j)
k=1/log(id);
for j=1:indexnum
    e(j)=-k*sum(p(:,j).*log(p(:,j)));
end
d=ones(1,indexnum)-e;  % ������Ϣ�������
weight=d./sum(d);    % ��Ȩֵw
score=weight*p';         % ���ۺϵ÷�