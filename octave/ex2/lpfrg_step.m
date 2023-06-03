% ==========================================================
% function vn=lpfrg_step(vm,v,M,a,lmb,k)
% ==========================================================
%
% Consider the PDE
%
%    u_t + a u_x + u = 0 for t>=0, 0<=x<=2*pi
%
% with boundary condition u(t,0)=0 for all t.
%
% Given the (M+1)-point time slices in vm, v, assumed to
% correspond to times t0 and t0+k, this routine returns in
% vn the slice corresponding to time t0+2*k according to the
% leapfrog scheme.
%
% The rightmost point is copied from the one on the left.
% ----------------------------------------------------------

function vp=lpfrg_step(vm,v,M,a,lmb,k)
   vp=zeros(1,M+1);
   vp(2:M)=vm(2:M) - a*lmb*( v(3:M+1)-v(1:M-1) );
   vp(1)=0 ;
   vp(M+1)=vp(M) ;
end

