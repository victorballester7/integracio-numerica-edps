% Initial condition for the 1D wave equation

function a = u0(x)
  a = cos(pi*x).^2.*(abs(x)<=1/2);
end