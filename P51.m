RandStream.setGlobalStream(RandStream('mt19937ar','seed',1518062));
S=rand(1);
v0=29*(1+0.24*S);
alpha = 36*(1 + 0.25*S); v0=29*(1+0.24*S); m=10; B=2; g=9.81;

z0=zeros(4,1);
z0(1)=v0*cosd(alpha); % initial condition for vx
z0(2)=v0*sind(alpha); % initial condition for vy
z0(3)=0; % initial condition for x
z0(4)=0; % initial condition for y

[th, zh]=ode45(@ballfun, [0 6], z0); % takes the integral of the equation of function ballfun between the boundaries t=0s to t=6s
vxh=zh(:,1); % assigns the first row of z to vxh
vyh=zh(:,2);
xh=zh(:,3);
yh=zh(:,4);

subplot(2,2,1);
plot(th,vxh,'r')
title('Variation of the velocity in the x-direction with time');
ylabel('Velocity / m/s');

subplot(2,2,2);
plot(th,vyh,'r')
title('Variation of the velocity in the y-direction with time');

subplot(2,2,3);
plot(th,xh)
title('Variation of the displacement in the x-direction with time');
xlabel('Time / s');
ylabel('Displacement');

subplot(2,2,4);
plot(th,yh)
title('Variation of the displacement in the y-direction with time');
xlabel('Time / s');

%P5.2

% approximating for the time when the ball strikes the ground i.e. when y=0 (Method1)
% finding the time interval t_range between which the ball hits the ground 
t_index=find(yh<0);
t_range=(th(t_index(1))+th(t_index(1)-1))/2;
fprintf('The result of using Method 1 to find t when y=0 was t=%gs\n',t_range)

%Using interpolation to find the time (Method 2)
yvector=find(yh<0); % this is a required procedure since the data set for t begins at y=0. Therefore to obtain a non-trivial solution we look for a range in which the y values become negative.
yselect=yh(yvector(1)-2:yvector(1)+2); % specify the range above and below the first data point at which y becomes negative to interpolate from
tselect=th(yvector(1)-2:yvector(1)+2);
t_0=interp1(yselect, tselect, 0); % third argument specifies the yh value to look for when t=0
fprintf('The result of using Method 2 to find t when y=0 was t=%gs\n',t_0)

% P5.3
[th0, zh0]=ode45(@ballfun, [0 t_0], z0);
vxh0=zh0(:,1); % assigns the first row of zh2 to vxh2
vyh0=zh0(:,2);
xh0=zh0(:,3);
yh0=zh0(:,4);

figure(3)

subplot(2,2,1);
plot(th0,vxh0,'r')
title('Variation of the velocity in the x-direction with time', 'FontSize', 20);
ylabel('Velocity / m/s', 'FontSize', 18);

subplot(2,2,2);
plot(th0,vyh0,'r')
title('Variation of the velocity in the y-direction with time', 'FontSize', 20);

subplot(2,2,3);
plot(th0,xh0)
title('Variation of the displacement in the x-direction with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);
ylabel('Displacement', 'FontSize', 18);

subplot(2,2,4);
plot(th0,yh0)
title('Variation of the displacement in the y-direction with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);


%%%% P5.4
V(1)=v0; % Declare the first element of V as the initial velocity v1
Alpha(1)=alpha;
bounce=1; % Variable to hold the bounce iteration

fprintf('Initial velocity is %gm/s \n',v0)
fprintf('Initial angle is %g° \n',alpha)

while (V(bounce) >= 0.5*v0) && (bounce<125) % loop will terminate when V value becomes less than half of the initial velocity v0. Incase the number of bounces is very high, we set a limiting condition of 125 bounces to prevent a large loop
   
    bounce=bounce+1; % increment bounce number after each loop
   V(bounce)=0.7*(1+0.21*S)*(V(bounce-1)); % the incremented argument allows the loop to insert a value after each iteration. The new velocity is multiplied by the previous velocity value with each iteration
   Alpha(bounce)=Alpha(bounce-1)-2; % with each iteration, the new Alpha value is returned by subtracting the previous Alpha value by 2
   
   fprintf('For bounce number %g, the velocity is %gm/s and the angle is %g° \n',bounce-1, V(bounce), Alpha(bounce))
    
end

fprintf('The ball bounces %g times before its velocity becomes less than half of its initial velocity \n', bounce-1)

%P5.5
%projection for 1st bounce
z1=zeros(4,1);
z1(1)=V(1)*cosd(Alpha(1)); % initial condition for vx
z1(2)=V(1)*sind(Alpha(1)); % initial condition for vy
z1(3)=(V(1)*cosd(Alpha(1)))*t_0; % initial condition for x
z1(4)=0; % initial condition for y
[th1, zh1]=ode45(@ballfun, [t_0 12], z1); % takes the integral of the equation of function ballfun between the boundaries t=0s to t=6s
vxh1=zh1(:,1); % assigns the first row of z to vxh
vyh1=zh1(:,2);
xh1=zh1(:,3);
yh1=zh1(:,4);



%{
figure(4)

subplot(2,2,1);
plot(th1,vxh1,'r')
title('Variation of the velocity in the x-direction with time');
ylabel('Velocity / m/s');

subplot(2,2,2);
plot(th1,vyh1,'r')
title('Variation of the velocity in the y-direction with time');

subplot(2,2,3);
plot(th1,xh1)
title('Variation of the displacement in the x-direction with time');
xlabel('Time / s');
ylabel('Displacement');

subplot(2,2,4);
plot(th1,yh1)
title('Variation of the displacement in the y-direction with time');
xlabel('Time / s');

y1vector=find(yh1<0);
y1select=yh1(y1vector(1)-2:y1vector(1)+2); 
t1select=th1(y1vector(1)-2:y1vector(1)+2);
t_1=interp1(y1select, t1select, 0); % time taken for y=0 3rd time or 2nd bounce

%for V(2)
z2=zeros(4,1);
z2(1)=V(2)*cosd(Alpha(2)); % initial condition for vx
z2(2)=V(2)*sind(Alpha(2)); % initial condition for vy
z2(3)=(V(2)*cosd(Alpha(2)))*t_1; % initial condition for x
z2(4)=0; % initial condition for y
[th2, zh2]=ode45(@ballfun, [t_1 18], z2); % takes the integral of the equation of function ballfun between the boundaries t=0s to t=6s
vxh2=zh2(:,1); % assigns the first row of z to vxh
vyh2=zh2(:,2);
xh2=zh2(:,3);
yh2=zh2(:,4);

figure(5)

subplot(2,2,1);
plot(th2,vxh2,'r')
title('Variation of the velocity in the x-direction with time');
ylabel('Velocity / m/s');

subplot(2,2,2);
plot(th2,vyh2,'r')
title('Variation of the velocity in the y-direction with time');

subplot(2,2,3);
plot(th2,xh2)
title('Variation of the displacement in the x-direction with time');
xlabel('Time / s');
ylabel('Displacement');

subplot(2,2,4);
plot(th2,yh2)
title('Variation of the displacement in the y-direction with time');
xlabel('Time / s');

y2vector=find(yh2<0);
y2select=yh1(y2vector(1)-2:y2vector(1)+2); 
t2select=th2(y2vector(1)-2:y2vector(1)+2);
t_2=interp1(y2select, t2select, 0); 


%for V(3)
z3=zeros(4,1);
z3(1)=V(3)*cosd(Alpha(3)); % initial condition for vx
z3(2)=V(3)*sind(Alpha(3)); % initial condition for vy
z3(3)=(V(3)*cosd(Alpha(3)))*t_2; % initial condition for x
z3(4)=0; % initial condition for y
[th3, zh3]=ode45(@ballfun, [t_2 20], z3); % takes the integral of the equation of function ballfun between the boundaries t=0s to t=6s
vxh3=zh3(:,1); % assigns the first row of z to vxh
vyh3=zh3(:,2);
xh3=zh3(:,3);
yh3=zh3(:,4);

figure(6)

subplot(2,2,1);
plot(th3,vxh3,'r')
title('Variation of the velocity in the x-direction with time');
ylabel('Velocity / m/s');

subplot(2,2,2);
plot(th3,vyh3,'r')
title('Variation of the velocity in the y-direction with time');

subplot(2,2,3);
plot(th3,xh3)
title('Variation of the displacement in the x-direction with time');
xlabel('Time / s');
ylabel('Displacement');

subplot(2,2,4);
plot(th3,yh3)
title('Variation of the displacement in the y-direction with time');
xlabel('Time / s');

%}


