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

function  [Denoising ,DN_CNN_PSNR,iter]     =     GSRC_DN_CNN_Denoising( par )

randn ('seed',0);
nim            =   par.nim;

ori_im         =   par.I;

b              =   par.win;

[h, w, ch]     =   size(nim);

N              =   h-b+1;

M              =   w-b+1;

r              =   [1:N];

c              =   [1:M]; 

disp(sprintf('PSNR of the noisy image = %f \n', csnr(nim, ori_im, 0, 0) ));

im_out         =   nim;

Im_DnCNN_nim        =   nim; 

lamada         =   par.w;

nsig           =   par.nSig;

m              =   par.nblk;

cnt            =   1;

AllPSNR        =  zeros(1,par.Iter );

AllSSIM        =  zeros(1,par.Iter );

Denoising      =  cell (1,par.Iter);

for iter = 1 : par.Iter    
    
        im_out               =    im_out + lamada*(nim - im_out);
        
        dif                  =    im_out-nim;
        
        vd                   =    nsig^2-(mean(mean(dif.^2)));
        
    if iter==1
        
                      
            par.nSig         =    sqrt(abs(vd)); 

            nSig_DN_CNN        =    par.nSig;
            
           
          [DN_CNN_PSNR,im_Dn_CNN]       =    DN_CNN_Test(par.I, Im_DnCNN_nim, nSig_DN_CNN);
           
    
      
            X_im_DN_CNN                =    Im2Patch( im_Dn_CNN, par ); 
            
            % Similar patchs index by Pre-filtering...
            blk_arr          =    Block_matching( im_Dn_CNN, par);     
            
   else
            par.nSig         =    sqrt(abs(vd))*par.lamada;
            
   end 
        
            AllSSIM(iter)    =   cal_ssim( im_out, Im_DnCNN_nim, 0, 0 );
            
        if iter>1         
            
            if (AllSSIM(iter)- AllSSIM(iter-1)<     par.Thr )
                
              % Similar patchs index by denoised image...
              blk_arr        =   Block_matching( im_out, par);  
              
            end
            
        end

     

               X             =     Im2Patch( im_out, par );  
               
               Ys            =     zeros( size(X) );   
               
               W             =     zeros( size(X) );
               
               K             =     size(blk_arr,2);
                 
        for  i  =  1 : K  
            %
            % Get Nonlocal Similar patches from noisy image...
            
               A             =      X(:, blk_arr(:, i));    
               
              mA             =      repmat(mean( A, 2 ), 1, size(A, 2));
              
              A              =      A-mA;   
            
           %%
             % Get Nonlocal Similar patches from pre-filtering ...
            
              B              =      X_im_DN_CNN (:, blk_arr(:, i));
            
              mB             =      repmat(mean( B, 2 ), 1, size(A, 2));
            
              B              =      B-mB;  
            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Group Sparsity Residual Constraint (GSRC)
            
            TMP              =    GSRC( double(A), double(B ), par.c, par.nSig, mA );
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
    Ys(:, blk_arr(1:m,i))    =   Ys(:, blk_arr(1:m,i)) + TMP;
    
    W(:, blk_arr(1:m,i))     =   W(:, blk_arr(1:m,i)) + 1;
    
        end

     im_out        =   zeros(h,w);       
     
     im_wei        =  zeros(h,w);     
     
      k            =   0;
      
     for i   =  1:b
         for j  = 1:b
                k    =  k+1;
                im_out(r-1+i,c-1+j)  =  im_out(r-1+i,c-1+j) + reshape( Ys(k,:)', [N M]);
                im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + reshape( W(k,:)', [N M]);
          end
     end
     
      im_out            =        im_out./(im_wei+eps);
        
     Denoising{iter}    =        im_out;

     AllPSNR(iter)      =        csnr( im_out, par.I, 0, 0 );
     
         PSNR_ii         = csnr( im_out, par.I, 0, 0 );
              
    fprintf( 'Iteration %d : nSig = %2.2f, PSNR = %f\n', cnt, par.nSig, csnr( im_out, par.I, 0, 1 ));
    
    cnt   =  cnt + 1;
        
   if iter>1
       

              dif      =  norm(abs(Denoising{iter}) - abs(Denoising{iter-1}),'fro')/norm(abs(Denoising{iter-1}), 'fro');

       
       if dif< par.err_or
           
           break;
           
       end   
       
   end 
   
end

return;




