%% Frequency Response of FIR Filters: Lab P-12: 3 Lab Exercise

%% 3.1a)
% We will cascade these filters by convolution, which will be performed by
% multiplication of their transfer functions.
%% 
% First we'll find the transfer function of the general filter
%%
% Y(z) = X(z) - 2cos(wn)z^-1X(z) + z^-2X(z)
%%
% H(z) = 1 - 2cos(wn)z^-1 + z^-2
%%
% Now we'll introduce the nulling frequencies 0.44pi and 0.7pi
%%
% H1(z) = 1 - 2cos(0.44pi)z^-1 + z^-2
%%
% H2(z) = 1 - 2cos(0.7pi)z^-1 + z^-2
%%
% Performing the convolution
%%
% (1 - 2cos(0.44pi)z^-1 + z^-2)(1 - 2cos(0.44pi)z^-1 + z^-2)
%%
% Yields the fourth order filter
%%
% 1 + (-2cos(0.7pi) - 2cos(0.44pi)))z^-1 + (2 + 4cos(0.44pi)cos(0.7pi))z^-2
% + (-2cos(0.44pi) - 2cos(0.7pi))z^-3 + z^-4
%%
% Resulting in the following coefficients
b = [1 -2*cos(0.7*pi)-2*cos(0.44*pi) 2+4*cos(0.44*pi)*cos(0.7*pi) -2*cos(0.44*pi)-2*cos(0.7*pi) 1]
%% 3.1b)

%% 3.1c)

%% 3.1d)

%% 3.1e)

%% 3.1f)

%% 3.2