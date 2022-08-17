function [cleanI, EPLL_psnr]= EPLL_Inital_Denoising(I,noise_image,Sigma )
rand('seed',0);
patchSize = 8;

% load image
I = I/255;	

% add noise
noiseSD = Sigma/255;
noiseI = noise_image/255;
excludeList = [];

% set up prior
LogLFunc = [];
load GSModel_8x8_200_2M_noDC_zeromean.mat
prior = @(Z,patchSize,noiseSD,imsize) aprxMAPGMM(Z,patchSize,noiseSD,imsize,GS,excludeList);

%%
tic
% add 64 and 128 for high noise
[cleanI,psnr,~] = EPLLhalfQuadraticSplit(noiseI,patchSize^2/noiseSD^2,patchSize,(1/noiseSD^2)*[1 4 8 16 32],1,prior,I,LogLFunc);
toc

EPLL_psnr= 20*log10(1/std2(cleanI-I));
end

