function dotz=ballfun(t,z)

RandStream.setGlobalStream(RandStream('mt19937ar','seed',1518062));
S=rand(1);
vx=z(1); vy=z(2); x=z(3); y=z(4);
alpha = 36*(1 + 0.25*S); v0=29*(1+0.24*S); m=10; B=2; g=9.81;

dotz=zeros(4,1); % returns a 4x1 column vector of zeros
dotz(1)=-(B/m)*vx;
dotz(2)=-g-(B/m)*vy;
dotz(3)=vx;
dotz(4)=vy;

end

