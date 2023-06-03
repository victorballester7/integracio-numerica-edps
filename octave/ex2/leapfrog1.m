x_min = -1;x_max=1;%length of x in meter
a=1;% value of u
T=5.4;%total time in second
lambda = 0.9;%value of lambda
dx =1/40; %value of dx
dt = lambda*dx;
xx=x_min:dx:x_max;%%vector of the x values
nx=length(xx);%number of x values
k_time = T/dt; %number of time steps
T_store=zeros(k_time,nx);
T_x=zeros(1,nx);
 
 
 %%%%%%%%%%%%%%%%%%%%%%%
 %%initial conditons
 %%%%%%%%%%%%%%%%%%%%%%%

T_store(1,:)=u0(xx);%% storing the first time step


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FTCS for second time step using periodic boundary condition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    for j=1:nx
     if j==1
            T_x(j)=T_store(1,j)-0.5*lambda*(T_store(1,j+1)-T_store(1,nx-1));%%%%%periodic boundary
     elseif j<=nx-1;
            T_x(j)=T_store(1,j)-0.5*lambda*(T_store(1,j+1)-T_store(1,j-1));
            
     else
            T_x(j)=T_store(1,j)-0.5*lambda*(T_store(1,2)-T_store(1,j-1));%%%%%periodic boundary
     end
            
    end
 T_store(2,:)=T_x;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Leap frog from 3rd time step using periodic boundary condition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=3:k_time
    for j=1:nx
        
            if j==1 
            T_x(j)=T_store(i-2,j)-lambda*(T_store(i-1,j+1)-T_store(i-1,nx-1)); %%%%%periodic boundary
            
            elseif j<=nx-1 
            T_x(j)=T_store(i-2,j)-lambda*(T_store(i-1,j+1)-T_store(i-1,j-1));
        
            
            else
            T_x(j)=T_store(i-2,j)-lambda*(T_store(i-1,2)-T_store(i-1,j-1));%%%%%periodic boundary
            end
    end
    T_store(i,:)=T_x;
%  disp(norm(T_store(i,:)));
   
 end
 u_real = u0(xx-T);
  plot(xx,T_x(1,:),'-k','LineWidth',2,xx,u_real);  
  errL2 = (sum((u_real(1:end-1) - T_store(end,1:end-1)).^2)*dx)^0.5; % we do not count the last point because it is the same as the first one
  printf("The error (in norm L^2) is %f\n", errL2);
