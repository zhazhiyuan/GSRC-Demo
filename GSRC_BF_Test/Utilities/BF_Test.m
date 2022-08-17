function   [BF_PSNR,BF_FSIM,BF_SSIM, im_BF]       =    BF_Test(Img,    f,    sigma1,Ori)

randn ('seed',0);

sigmas = 3;        %  spatial gaussian kernel 
sigmar1 = 2*sigma1;    %  range gaussian kernel for SBF
sigmar2 = 2*sigma1;    %  range gaussian kernel  for RBF
w = 6*round(sigmas)+1;
tol = 0.01;  

sigma  =  sigma1;

[m, n]  =size(f);

L = 0;
[M, N]=computeTruncation(f, sigmar1, w, tol);
[f1, div1] = computeDivergence(f, f, sigmas,sigmar1,L,w,N,M);
%
% compute RBF and divergence
%
L = 1;
h = ones(2*L+1, 2*L+1) /((2*L+1)^2) ;
barf  =  imfilter(f,h);
[M, N] = computeTruncation(barf, sigmar2, w, tol);
[f2, div2] = computeDivergence(f, barf,sigmas,sigmar2,L,w,N,M);
%
% compute optimal weights
%
A = [norm(f1,'fro')^2,  sum(sum(f1.*f2));
         sum(sum(f1.*f2)), norm(f2,'fro')^2];
b = [sum(sum(f1.*f)) - sigma^2*div1; 
        sum(sum(f2.*f)) - sigma^2*div2];
theta = A\b; 
%
% form the WBF
%
im_BF = theta(1)*f1 + theta(2)*f2;




BF_PSNR  =csnr(im_BF,Img,0,0)

BF_FSIM=  FeatureSIM(im_BF,Img);
BF_SSIM=  cal_ssim(im_BF,Img,0,0);


if sigma1==20

Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/20_Result/',Final_denoisng));

elseif sigma1==30

Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/30_Result/',Final_denoisng));


elseif sigma1==40

Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/40_Result/',Final_denoisng));


elseif sigma1==50

Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/50_Result/',Final_denoisng));


elseif sigma1==75

Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/75_Result/',Final_denoisng));



else


Final_denoisng= strcat(Ori,'_BF_','_sigma_',num2str(sigma1),'_PSNR_',num2str(BF_PSNR),'_FSIM_',num2str(BF_FSIM),'_SSIM_',num2str(BF_SSIM),'.png');

imwrite(uint8(im_BF),strcat('./BF_Results/100_Result/',Final_denoisng));


end




end

