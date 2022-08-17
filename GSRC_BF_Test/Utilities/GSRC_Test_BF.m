function [Ori, Sigma, BF_PSNR, BF_FSIM,BF_SSIM, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_BF (Ori, Sigma)

randn ('seed',0);

fn               =     [Ori, '.tif'];


I                =     imread(fn);


colorI           =      I;

[~, ~, kk]       =     size (I);

if kk==3
    
    I     = rgb2gray (I);
    
end

%par.I            =     double(I);

par              =    Par_Set (Sigma,I);

par.nim          =    par.I + par.nSig* randn(size( par.I ));

[Denoising ,BF_PSNR, BF_FSIM,BF_SSIM,iter]              =    GSRC_BF_Denoising( par, Ori);

im  = Denoising{iter-1};

PSNR_Final       =   csnr (im, par.I,0,0);
FSIM_Final       =   FeatureSIM(im, par.I);
SSIM_Final       =   cal_ssim (im, par.I,0,0);
if Sigma==20

Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./20_Result/',Final_denoisng));

elseif Sigma==30
Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./30_Result/',Final_denoisng));
elseif Sigma==40
Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./40_Result/',Final_denoisng));
elseif Sigma==50
Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./50_Result/',Final_denoisng));
elseif Sigma==75
Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./75_Result/',Final_denoisng));

else
    Final_denoisng= strcat(Ori,'_GSRC_BF_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./100_Result/',Final_denoisng));
end

end

