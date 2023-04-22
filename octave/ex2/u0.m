% Initial condition for the 1D wave equation

function a = u0(x)
  % a = (1-2*abs(x)).*(abs(x)<=1/2);
  % a = sin(2*pi*x).*(abs(x)<=1);
  a = sin(2*pi*x);
end