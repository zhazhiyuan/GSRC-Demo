% Image Denoising using Optimally Weighted Bilateral Filters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Authors: K. Rithwik, K. N. Chaudhury
%   
%  Date:  May 14, 2015.
%  Update: July 13, 2015.
%
%  References:
%
%  [1] K.N. Chaudhury and K. Rithwik, "Image
%  denoising using optimally weighted bilateral
%  filters: A SURE and fast approach,'' Proc. IEEE
%  International Conference on Image Proc., 2015.
%  available: http://arxiv.org/abs/1505.00074.
%
%  [2] K.N. Chaudhury, D. Sage, and M. Unser, 
%  "Fast O(1) bilateral filtering using trigonometric
%  range kernels," IEEE Trans. Image Proc.,
%  vol. 20, no. 11, 2011.
%
%  [3] K.N. Chaudhury, "Acceleration of the
%  shiftable O(1) algorithm for bilateral filtering
%  and non-local means,"  IEEE Transactions on
%  Image Proc., vol. 22, no. 4, 2013.
%
%  Acronyms:
% 
%  SBF: Standard Bilateral Filter.
%  RBF: Robust Bilater Filter.
%  WBF: Weighted Bilateral Filter.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear; close all;
% parameters
sigma1 = [ 10 20 30 40 50];        %  noise 
for i=1:length(sigma1)
sigmas = 3;        %  spatial gaussian kernel 
sigmar1 = 2*sigma1(i);    %  range gaussian kernel for SBF
sigmar2 = 2*sigma1(i);    %  range gaussian kernel  for RBF
w = 6*round(sigmas)+1;
tol = 0.01;
sigma=sigma1(i)
% read input image
%
% f0 = double(imread('./images/lena.png')); name='lena'
 %f0 = double(imread('./images/barbara.png'));name='barbara'
f0 = double(imread('./images/house.tif')); name='house'
 %f0 = double(imread('./images/boat.png')); name='boat'
%f0 = double(imread('./images/cameraman.tif')); name='cameraman'
 %f0 = double(imread('./images/man.tif')); name='man'
%f0 = double(imread('./images/zelda.tif')); name='zelda'
% f0 = double(imread('./images/mandrill.tif')); name='mandrill'
[m,n]=size(f0) ;                                                    
%
%for i=1:1
   % sigma=sigma1();
% generate noise
%
noise=sigma1(i)*randn(m,n);
%

% noisy input for the algorithm
%
 f = double(f0) + noise;
% f_s=imnoise(uint8(f0),'salt & pepper',0.25);
% 
%%
% compute SBF and divergence
%
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
bfoptSURE = theta(1)*f1 + theta(2)*f2;
% computing PSNR's 
peak=255;
PSNRnoisy = 10 * log10(m*n*peak^2/ ...
    sum(sum((f - f0).^2)) );         % noisy PSNR                                              
PSNR_f1 = 10 * log10(m * n * peak^2 ...                                  
    / sum(sum((f1 - f0).^2)) );       % SBF PSNR                                          
PSNR_f2 = 10 * log10(m * n * peak^2 ...                                  
    / sum(sum((f2 - f0).^2)) );       % RBF PSNR                                          
PSNR_WBF = 10 * log10(m * n * peak^2 ...                       
    / sum(sum((bfoptSURE - f0).^2)) )  % WBF PSNR
ssim_WBF=ssim(uint8(bfoptSURE),uint8(f0))
end 
% display
%
% h=figure('Units','normalized','Position',[0 0.5 1 0.5]);
% set(h,'name','Denoising Results')
% colormap gray,
% %
% subplot(2,3,1)
% imshow(uint8(f0));
% title('Clean Image')
% %
% subplot(2,3,2)
% imshow(uint8(f));
% title(['Noisy Image, PSNR = ', ...
%     num2str(PSNRnoisy,'%.2f')]);
% %
% subplot(2,3,3)
% imshow(uint8(f1));
% title(['SBF, PSNR = ', ...
%     num2str(PSNR_f1,'%.2f')]);
% %
% subplot(2,3,4)
%gcf= imshow(uint8(f2)); print('-depsc2',['rbf_',name,'_20.eps']);
% title(['RBF, PSNR = ', ...
%     num2str(PSNR_f2,'%.2f')]);
% %
% subplot(2,3,5)
% imshow(uint8(bfoptSURE));
% title(['WBF, PSNR = ', ...
%     num2str(PSNRb_f,'%.2f')]);
% %
% subplot(2,3,6)
 %gcf=imshow((f-bfoptSURE),[]);print('-depsc2',['method_noise_',name,'_rbf20.eps']);
 %title('Residual Noise in WBF');

