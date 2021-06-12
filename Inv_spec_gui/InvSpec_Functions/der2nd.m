function X_2nd_der = der2nd(X, order, window)
% Summary: Function to compute the 2nd derivative of data
%         using a defined window for SavitzkyGolay
%
% Chemometrics Toolbox / copied open source (see additional information)
%-------------------------------------------------------------------------
% Robert Bosch GmbH
% Robert-Bosch-Campus 1
% 71272 Renningen
%-------------------------------------------------------------------------
%
% Function syntax:
% X_2nd_der = der2nd(X, order, window)
% 
% input parameter:  
%                   X            = measurement data
%                   label        = label for columns within X
%                   oder         = order of polynom to fit
%                                  must be less than the value for window
%                   window       = size of data filter used for 
%                                  Savitzky Golay fitting, must be odd!
% output parameter: 
%                   X_2nd_der    = 2nd derivative data
%                    
%
%   Additional information:
%       Author(s): R. Losada
%       Copyright 1988-2004 The MathWorks, Inc.
%       $Revision: 1.11.4.4 $  $Date: 2009/08/11 15:47:54 $
%       savitzkyGolayFilt filters the signal X using a Savitzky-Golay 
%       (polynomial) filter. 
%       Note that if the polynomial order N equals F-1, no smoothing
%       will occur.
%
%   References:
%     [1] Sophocles J. Orfanidis, INTRODUCTION TO SIGNAL PROCESSING,
%              Prentice-Hall, 1995, Chapter 8.
%
%% Calculate 2nd derivative (copy of online script)
% Transpose X
X=X';

% Check if the input arguments are valid
if round(window) ~= window, error(generatemsgid('MustBeInteger'),'Frame length must be an integer.'), end
if rem(window,2) ~= 1, error(generatemsgid('SignalErr'),'Frame length must be odd.'), end
if round(order) ~= order, error(generatemsgid('MustBeInteger'),'Polynomial order must be an integer.'), end
if order > window-1, error(generatemsgid('InvalidRange'),'The Polynomial order must be less than the frame length.'), end

W = ones(window,1);
DIM = [];

% Check for right length of W
if length(W) ~= window
    error(generatemsgid('InvalidDimensions'),'The weight vector must be of the same length as the frame length.')
end


% Compute the projection matrix B
pp = fix(-window./2):fix(window./2);
B = savitzkyGolay(pp,order,2,pp,W);

if ~isempty(DIM) && DIM > ndims(X)
	error(generatemsgid('InvalidDimensions'),'Dimension specified exceeds the dimensions of X.')
end

% Reshape X into the right dimension.
if isempty(DIM)
	% Work along the first non-singleton dimension
	[X, nshifts] = shiftdim(X);
else
	% Put DIM in the first dimension (this matches the order 
	% that the built-in filter function uses)
	perm = [DIM,1:DIM-1,DIM+1:ndims(X)];
	X = permute(X,perm);
end

if size(X,1) < window, error(generatemsgid('InvalidDimensions'),'The length of the input must be >= frame length.'), end

% Preallocate output
X_2nd_der = zeros(size(X));

% Compute the transient on
X_2nd_der(1:(window+1)/2-1,:) = fliplr(B(:,(window-1)/2+2:end)).'*flipud(X(1:window,:));

% Compute the steady state output
ytemp = filter(B(:,(window-1)./2+1),1,X);
X_2nd_der((window+1)/2:end-(window+1)/2+1,:) = ytemp(window:end,:);

% Compute the transient off
X_2nd_der(end-(window+1)/2+2:end,:) = fliplr(B(:,1:(window-1)/2)).'*flipud(X(end-(window-1):end,:));

% Convert Y to the original shape of X
if isempty(DIM)
	X_2nd_der = shiftdim(X_2nd_der, -nshifts);
else
	X_2nd_der = ipermute(X_2nd_der,perm);

% New Adaption for easier code
end
X_2nd_der=X_2nd_der';

end

%% internal function savitzkyGolay
function [fc, df] = savitzkyGolay(x,n,dn,x0,W,flag)
% Function:
%       Savitzky-Golay Smoothing and Differentiation Filter
%       The Savitzky-Golay smoothing/differentiation filter (i.e., the
%       polynomial smoothing/differentiation filter, or  the least-squares
%       smoothing/differentiation filters) optimally fit a set of data
%       points to polynomials of different degrees. 
%       See for details in Matlab Documents (help sgolay). The sgolay
%       function in Matlab can deal with only symmetrical and uniformly
%       spaced data of even number.
%       This function presented here is a general implement of the sgolay
%       function in Matlab. The Savitzky-Golay filter coefficients for even
%       number, nonsymmetrical and nonuniformly spaced data can be
%       obtained. And the filter coefficients for the initial point or the
%       end point can be obtained too. In addition, either numerical
%       results or symbolical results can be obtained. Lastly, this
%       function is faster than MATLAB's sgolay.
%
% Usage:
%       [fc,df] = savitzkyGolay(x,n,dn,x0,flag)
%   input:
%       x    = the original data point, e.g., -5:5 
%       n    = polynomial order
%       dn   = differentation order (0=smoothing),  default=0
%       x0   = estimation point, can be a vector    default=0
%       W    = weight vector, can be empty          
%              must have same length as x0          default=identity
%       flag = numerical(0) or symbolical(1),       default=0
%
%   output:
%       fc   = filter coefficients obtained (B output of sgolay).
%       df   = differentiation filters (G output of sgolay).
% Notes:
% 1.    x can be arbitrary, e.g., odd number or even number, symmetrical or
%       nonsymmetrical, uniformly spaced or nonuniformly spaced, etc.       
% 2.    x0 can be arbitrary, e.g., the initial point, the end point, etc.
% 3.    Either numerical results or symbolical results can be obtained.
% Example:
%       sgsdf([-3:3],2,0,0,[],0)
%       sgsdf([-3:3],2,0,0,[],1)
%       sgsdf([-3:3],2,0,-3,[],1)
%       sgsdf([-3:3],2,1,2,[],1)
%       sgsdf([-2:3],2,1,1/2,[],1)
%       sgsdf([-5:2:5],2,1,0,[],1)     
%       sgsdf([-1:1 2:2:8],2,0,0,[],1)
% Author:
%       Diederick C. Niehorster <dcniehorster@hku.hk> 2011-02-05
%       Department of Psychology, The University of Hong Kong
%
%       Originally based on
%       http://www.mathworks.in/matlabcentral/fileexchange/4038-savitzky-golay-smoothing-and-differentiation-filter
%       Allthough I have replaced almost all the code (partially based on
%       the comments on the FEX submission), increasing its compatibility
%       with MATLABs sgolay (now supports a weight matrix), its numerical
%       stability and it speed. Now, the help is pretty much all that
%       remains.
%       Jianwen Luo <luojw@bme.tsinghua.edu.cn, luojw@ieee.org> 2003-10-05
%       Department of Biomedical Engineering, Department of Electrical Engineering
%       Tsinghua University, Beijing 100084, P. R. China  
% Reference
%[1]A. Savitzky and M. J. E. Golay, "Smoothing and Differentiation of Data
%   by Simplified Least Squares Procedures," Analytical Chemistry, vol. 36,
%   pp. 1627-1639, 1964.
%[2]J. Steinier, Y. Termonia, and J. Deltour, "Comments on Smoothing and
%   Differentiation of Data by Simplified Least Square Procedures,"
%   Analytical Chemistry, vol. 44, pp. 1906-1909, 1972.
%[3]H. H. Madden, "Comments on Savitzky-Golay Convolution Method for
%   Least-Squares Fit Smoothing and Differentiation of Digital Data,"
%   Analytical Chemistry, vol. 50, pp. 1383-1386, 1978.
%[4]R. A. Leach, C. A. Carter, and J. M. Harris, "Least-Squares Polynomial
%   Filters for Initial Point and Slope Estimation," Analytical Chemistry,
%   vol. 56, pp. 2304-2307, 1984.
%[5]P. A. Baedecker, "Comments on Least-Square Polynomial Filters for
%   Initial Point and Slope Estimation," Analytical Chemistry, vol. 57, pp.
%   1477-1479, 1985.
%[6]P. A. Gorry, "General Least-Squares Smoothing and Differentiation by
%   the Convolution (Savitzky-Golay) Method," Analytical Chemistry, vol.
%   62, pp. 570-573, 1990.
%[7]Luo J W, Ying K, He P, Bai J. Properties of Savitzky-Golay Digital
%   Differentiators, Digital Signal Processing, 2005, 15(2): 122-136.
%
%See also:
%       sgolay, savitzkyGolayFilt

% Check if the input arguments are valid and apply defaults
error(nargchk(2,6,nargin,'struct'));

if round(n) ~= n, error(generatemsgid('MustBeInteger'),'Polynomial order (n) must be an integer.'), end
if round(dn) ~= dn, error(generatemsgid('MustBeInteger'),'Differentiation order (dn) must be an integer.'), end
if n > length(x)-1, error(generatemsgid('InvalidRange'),'The Polynomial Order must be less than the frame length.'), end
if dn > n, error(generatemsgid('InvalidRange'),'The Differentiation order must be less than or equal to the Polynomial order.'), end

% set defaults if needed
if nargin<6
    flag=false;
end
if nargin < 5 || isempty(W)
   % No weighting matrix, make W an identity
   W = eye(length(x0));
else
   % Check W is real.
   if ~isreal(W), error(generatemsgid('NotReal'),'The weight vector must be real.'),end
   % Check for right length of W
   if length(W) ~= length(x0), error(generatemsgid('InvalidDimensions'),'The weight vector must be of the same length as the frame length.'),end
   % Check to see if all elements are positive
   if min(W) <= 0, error(generatemsgid('InvalidRange'),'All the elements of the weight vector must be greater than zero.'), end
   % Diagonalize the vector to form the weighting matrix
   W = diag(W);
end
if nargin<4
    x0=0;
end
if nargin<3
    dn=0;
end

% prepare for symbolic output
if flag
    x=sym(x);
    x0=sym(x0);
end

Nx  = length(x);
x=x(:);
Nx0 = length(x0);
x0=x0(:);

if flag
    A=ones(length(x),1);
    for k=1:n
        A=[A x.^k];
    end
    df = inv(A'*A)*A';                          % backslash operator doesn't work as expected with symbolic inputs, but the "slowness and inaccuracy" of this method doesn't matter when doing the symbolic version
else
    df = cumprod([ones(Nx,1) x*ones(1,n)],2) \ eye(Nx);
end
df = df.';

hx = [(zeros(Nx0,dn)) ones(Nx0,1)*prod(1:dn)];  % order=0:dn-1,& dn,respectively
for k=1:n-dn                                    % order=dn+1:n=dn+k
    hx = [hx x0.^k*prod(dn+k:-1:k+1)];
end

% filter coeffs
fc = df*hx'*W;
end