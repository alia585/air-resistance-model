[tf1, th1, vxh1, vyh1, xh1, yh1]=ballbounce(V(1),Alpha(1));
[tf2, th2, vxh2, vyh2, xh2, yh2]=ballbounce(V(2),Alpha(2));
[tf3, th3, vxh3, vyh3, xh3, yh3]=ballbounce(V(3),Alpha(3));

T=[th1; th2+tf1; th3+tf1+tf2];
X=[xh1; xh2+xh1(end); xh3+xh2(end)+xh1(end)];
Y=[yh1; yh2; yh3];
VX=[vxh1; vxh2; vxh3];
VY=[vyh1; vyh2; vyh3];

figure(9); plot(X,Y)
title('Variation of vertical displacement Y with the horizontal displacement X', 'FontSize', 20);
xlabel('Horizontal displacement / m', 'FontSize', 18);
ylabel('Vertical displacement / m', 'FontSize', 18);
figure(10)
subplot(2,2,1)
plot(T,VX,'r')
title('Variation of horizontal velocity with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);
ylabel('Horizontal velocity / m/s', 'FontSize', 18);
subplot(2,2,2)
plot(T,VY,'r')
title('Variation of vertical velocity with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);
ylabel('Vertical velocity / m/s', 'FontSize', 18);
subplot(2,2,3)
plot(T,X)
title('Variation of horizontal displacement with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);
ylabel('Horizontal displacement / m', 'FontSize', 18);
subplot(2,2,4)
plot(T,Y)
title('Variation of vertical displacement with time', 'FontSize', 20);
xlabel('Time / s', 'FontSize', 18);
ylabel('Vertical displacement / m', 'FontSize', 18);