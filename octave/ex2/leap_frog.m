%%%Initialization%%%%
F = @(x) sin(pi*(x-1)).^2 .*(1<=x).*(x<=2);

xmin=0;
xmax=8;
N=100;
dx=(xmax-xmin)/N; %%number of nodes-1

t=0;
tmax=4;
dt=0.75*dx;
tsteps=tmax/dt;

%%%%%Discretization%%%%%%%%
x=xmin-dx:dx:xmax+dx;

%%%%%initial conditions
u0 = F(x);
%%%%Here I am finding u_k^1, I used Euler's method to do so.
u1 = u0;
for k=2:N+1
    u1(k)=u0(k)-(dt/dx)*(u0(k)-u0(k-1));
end
u1(1)=u1(2);

unm1=u0;
un=u1;
unp1=u1;

for n=1:tsteps
    for i=2:N
        unp1(i)=unm1(i)-(dt/dx)*(un(i+1)-un(i-1));
    end

    t=t+dt;
    unm1=un;
    un=unp1;
    plot(x,un,'bo-')

end