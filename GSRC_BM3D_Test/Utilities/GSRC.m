

function  X  =   GSRC( A, B, c, nsig, mA )

U                  =    getsvd(A); % Generated the PCA Basis

A0                 =    U'*A; % Group sparse coefficient of noisy image

s0                 =    mean (A0.^2,2);

s0                 =    max  (0, s0-nsig^2);

LambdaM            =    repmat ( c*nsig^2./(sqrt(s0)+eps),[1, size(A0,2)]); %Eq.(8)

B0                 =    U'*   B; % Group sparse coefficient of pre-filtered image

Alpha              =  soft (A0-B0, LambdaM)+ B0; % Eq.(7)


X                  =   U*Alpha;

X                  =   X + mA;

return;