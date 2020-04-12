a = 6378137;
f = 1/298.257222101; %扁率
b = a - a*f ;         %短軸
e = sqrt(a^2-b^2);   %線性偏心率
e1 = sqrt(a^2-b^2)/a;%第一偏心率
GM = 3986005*(10^8);
w = 7.292115*(10^(-5)); %轉速
beta = -90:1:90;  %緯度範圍
re = 9.7803267715;
rp = 9.8321863685;
k = 0.001931851353;
m = (w^2)*(a^2)*b/GM; 
h = 10;
u = b + h ; %橢球高10公尺
Q10 = 1/2*((1+3*(u^2)/(e^2))*atan(e/u)-3*u/e); %高十公尺
Q = 1/2*((1+3*(b^2)/(e^2))*atan(e/b)-3*b/e);
for x=0:180
    for y =0:360
        U(x+1,y+1)=(GM/e)*atan(e/b)+((w^2)/3)*(a^2); %講義49頁公式
        
    end
end
aws1 = U(1) %水準面上重力位均相同,因此取一個出來即可

for x=0:180
        for y =0:360
            U10(x+1,y+1)=(GM/e)*atan(e/u)+((w^2)/2)*(a^2)*(Q10/Q)*((sin(x)^2) - 1/3)+((w^2)/2)*(u^2 + e^2)*(cos(x))^2;%講義48頁公式
            
        end
end
aws2 =U10(1)%水準面上重力位均相同,因此取一個出來即可

%normal gravity closed formula
e2 = 0.00669438002290;
%R = re*(1+k*sin(x)^2)/sqrt(1-e2*sin(x)^2) %x = 緯度
%formula 1
%R1 = re*(1+0.0052790414*sin(x)^2+0.0000232718*sin(x)^4
        %+0.0000001262**sin(x)^6+0.0000000007**sin(x)^8);
%formula 2
%R2 = re*(1+0.0053024*sin(x)^2 - 0.25*0.0000058*sin(2x)^2;
for x = 0:179
        R(x+1)=re*(1+k*sin(x)^2)/sqrt(1-e2*sin(x)^2); %grs80 gravity funtion
        R1(x+1) = re*(1+0.0052790414*sin(x)^2+0.0000232718*sin(x)^4+0.0000001262*sin(x)^6+0.0000000007*sin(x)^8); % method1
        R2(x+1) = re*(1+0.0053024*sin(x)^2 -0.25*0.0000058*sin(2*x)^2); %method 2
        R12(x+1) =R1(x+1) -R2(x+1); %t兩種方法差值
        RH1(x+1) = R1(x+1)*(1-(2/a)*(1+f+m-2*f*sin(x)^2)*10+300/a^2); %方法一的10公尺重力加速度
        RH2(x+1) = R2(x+1)*(1-(2/a)*(1+f+m-2*f*sin(x)^2)*10+300/a^2); %方法二的10公尺重力加速度      
end

%畫圖
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




