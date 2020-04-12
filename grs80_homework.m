a = 6378137;
f = 1/298.257222101; %��v
b = a - a*f ;         %�u�b
e = sqrt(a^2-b^2);   %�u�ʰ��߲v
e1 = sqrt(a^2-b^2)/a;%�Ĥ@���߲v
GM = 3986005*(10^8);
w = 7.292115*(10^(-5)); %��t
beta = -90:1:90;  %�n�׽d��
re = 9.7803267715;
rp = 9.8321863685;
k = 0.001931851353;
m = (w^2)*(a^2)*b/GM; 
h = 10;
u = b + h ; %��y��10����
Q10 = 1/2*((1+3*(u^2)/(e^2))*atan(e/u)-3*u/e); %���Q����
Q = 1/2*((1+3*(b^2)/(e^2))*atan(e/b)-3*b/e);
for x=0:180
    for y =0:360
        U(x+1,y+1)=(GM/e)*atan(e/b)+((w^2)/3)*(a^2); %���q49������
        
    end
end
aws1 = U(1) %���ǭ��W���O�짡�ۦP,�]�����@�ӥX�ӧY�i

for x=0:180
        for y =0:360
            U10(x+1,y+1)=(GM/e)*atan(e/u)+((w^2)/2)*(a^2)*(Q10/Q)*((sin(x)^2) - 1/3)+((w^2)/2)*(u^2 + e^2)*(cos(x))^2;%���q48������
            
        end
end
aws2 =U10(1)%���ǭ��W���O�짡�ۦP,�]�����@�ӥX�ӧY�i

%normal gravity closed formula
e2 = 0.00669438002290;
%R = re*(1+k*sin(x)^2)/sqrt(1-e2*sin(x)^2) %x = �n��
%formula 1
%R1 = re*(1+0.0052790414*sin(x)^2+0.0000232718*sin(x)^4
        %+0.0000001262**sin(x)^6+0.0000000007**sin(x)^8);
%formula 2
%R2 = re*(1+0.0053024*sin(x)^2 - 0.25*0.0000058*sin(2x)^2;
for x = 0:179
        R(x+1)=re*(1+k*sin(x)^2)/sqrt(1-e2*sin(x)^2); %grs80 gravity funtion
        R1(x+1) = re*(1+0.0052790414*sin(x)^2+0.0000232718*sin(x)^4+0.0000001262*sin(x)^6+0.0000000007*sin(x)^8); % method1
        R2(x+1) = re*(1+0.0053024*sin(x)^2 -0.25*0.0000058*sin(2*x)^2); %method 2
        R12(x+1) =R1(x+1) -R2(x+1); %t��ؤ�k�t��
        RH1(x+1) = R1(x+1)*(1-(2/a)*(1+f+m-2*f*sin(x)^2)*10+300/a^2); %��k�@��10���ح��O�[�t��
        RH2(x+1) = R2(x+1)*(1-(2/a)*(1+f+m-2*f*sin(x)^2)*10+300/a^2); %��k�G��10���ح��O�[�t��      
end

%�e��
hold on
subplot(4,1,1)
plot(0:180,R1,'r')
axis([0, 90, 9.6, 10]);
legend('R1')
ylabel('normal gravity')
subplot(4,1,2)
plot(0:180,R2,'b')
axis([0, 90, 9.6, 10]);
legend('R2')
ylabel('normal gravity')
subplot(4,1,3)
plot(0:179,RH1,'k')
axis([0, 90, 9.6, 10]);
ylabel('normal gravity')
legend('RH1')
subplot(4,1,4)
plot(0:179,RH2,'g')
axis([0, 90, 9.6, 10]);
ylabel('normal gravity')
hold off
legend('RH2')




