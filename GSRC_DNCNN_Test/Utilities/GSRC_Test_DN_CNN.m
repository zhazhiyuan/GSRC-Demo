function [Ori, Sigma, DN_CNN_PSNR,PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (Ori, Sigma)

randn ('seed',0);

fn               =     [Ori, '.tif'];


I                =     imread(fn);


colorI           =      I;

[~, ~, kk]       =     size (I);

if kk==3
    
    I     = rgb2gray (I);
    
    x_yuv = rgb2ycbcr(colorI);
    
    x_yuv_noise   =  x_yuv;
    
    
    x_inpaint_yuv(:,:,2) = x_yuv(:,:,2); % Copy U Componet
    
    x_inpaint_yuv(:,:,3) = x_yuv(:,:,3); % Copy V Componet
       
end

%par.I            =     double(I);

par              =    Par_Set (Sigma,I);

par.nim          =    par.I + par.nSig* randn(size( par.I ));

[Denoising ,DN_CNN_PSNR, iter]              =    GSRC_DN_CNN_Denoising( par);

im  = Denoising{iter-1};

PSNR_Final       =   csnr (im, par.I,0,0);
FSIM_Final       =   FeatureSIM(im, par.I);
SSIM_Final       =   cal_ssim (im, par.I,0,0);
if Sigma==20

Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./20_Result/',Final_denoisng));

elseif Sigma==30
Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./30_Result/',Final_denoisng));
elseif Sigma==40
Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./40_Result/',Final_denoisng));
elseif Sigma==50
Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./50_Result/',Final_denoisng));
elseif Sigma==75
Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./75_Result/',Final_denoisng));

else
    Final_denoisng= strcat(Ori,'_GSRC_DN_CNN_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(im),strcat('./100_Result/',Final_denoisng));
end

end

