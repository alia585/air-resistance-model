function [tf, th, vxh, vyh, xh, yh]=ballbounce(v0,alpha)

z0=zeros(4,1);
z0(1)=v0*cosd(alpha);
z0(2)=v0*sind(alpha);
z0(3)=0;
z0(4)=0;

[th, zh]=ode45(@ballfun, [0 6], z0);
vxh=zh(:,1);
vyh=zh(:,2);
xh=zh(:,3);
yh=zh(:,4);
yvector=find(yh<0);
yselect=yh(yvector(1)-2:yvector(1)+2); 
tselect=th(yvector(1)-2:yvector(1)+2);
tf=interp1(yselect, tselect, 0);

[th, zh0]=ode45(@ballfun, [0 tf], z0);
vxh=zh0(:,1); % assigns the first row of zh2 to vxh2
vyh=zh0(:,2);
xh=zh0(:,3);
yh=zh0(:,4);



end