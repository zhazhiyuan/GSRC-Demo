function [Ori, Sigma, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_BM3D (Ori, Sigma)


fn               =     [Ori, '.tif'];


I                =     imread(fn);

[~,~,kkk]        =     size (I);

if kkk==3
    
 Opts.I          = double (rgb2gray(I));
 
 
else

Opts.I            =     double(I);


end




Opts              =    Opts_Set (Sigma, Opts.I);

Opts.nim          =    Opts.I + Opts.nSig* randn(size( Opts.I ));

disp(sprintf('PSNR of the noisy image = %f \n', csnr(Opts.nim, Opts.I, 0, 0) ));

%   Pre-processing by the Prefiltering BM3D.

[BM3D_PSNR,BM3D_Inital]       =    BM3D(Opts.I, Opts.nim, Opts.nSig, 'np', 0);

disp(sprintf('PSNR of the BM3D Denoised image = %f \n', BM3D_PSNR));

[Denoising,iter]              =    GSRC_BM3D_Denoising( Opts, Opts.Thr, BM3D_Inital, Opts.err_or);

Im      =      Denoising{iter-1};


PSNR_Final       =  csnr (Im, Opts.I ,0,0);

FSIM_Final       =  FeatureSIM (Im, Opts.I );

SSIM_Final       =  cal_ssim (Im, Opts.I ,0,0);

if Sigma==20

Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./20_Result/',Final_denoisng));

elseif Sigma==30
    
Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./30_Result/',Final_denoisng));

elseif Sigma==40
    
Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./40_Result/',Final_denoisng));

elseif Sigma==50
    
Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./50_Result/',Final_denoisng));

elseif Sigma==75
    
Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./75_Result/',Final_denoisng));


else
    
Final_denoisng= strcat(Ori,'_GSRC_BM3D_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final),'_SSIM_',num2str(SSIM_Final),'.png');

imwrite(uint8(Im),strcat('./100_Result/',Final_denoisng));
end





end

