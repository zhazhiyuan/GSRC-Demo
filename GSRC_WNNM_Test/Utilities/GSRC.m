% =========================================================================
% GSRC-Denoising for image denoising, Version 1.0
% Copyright(c) 2017 Zhiyuan Zha
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------

function  X  =   GSRC( A, B, c, nsig, mA )

U                  =    getsvd(A);

A0                 =    U'*A; % Group sparse coefficient of noisy image

s0                 =    mean (A0.^2,2);

s0                 =    max  (0, s0-nsig^2);

LambdaM            =    repmat ( c*nsig^2./(sqrt(s0)+eps),[1, size(A0,2)]);

B0                 =    U'*   B; % Group sparse coefficient of pre-filtered image

Alpha              =  soft (A0-B0, LambdaM)+ B0; % Eq.(7)

X                  =   U*Alpha;

X                  =   X + mA;

return;