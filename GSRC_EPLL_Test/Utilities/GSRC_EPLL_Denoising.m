
function [Denoising,iter]     =  GSRC_EPLL_Denoising( Opts, Thr, EPLL_Inital,err_or)

randn ('seed',0);

nim                     =           Opts.nim;

ori_im                  =           Opts.I;

 b                      =           Opts.win;

[h,  w,  ch]            =           size(nim);

N                       =           h-b+1;

M                       =           w-b+1;

r                       =           [1:N];

c                       =           [1:M]; 

fprintf('Begining GSRC Operator...\n');
im_out                  =            nim;

%Im_EPLL                 =            nim; 

lamada                  =            Opts.w;

nsig                    =            Opts.nSig;

m                       =            Opts.nblk;

cnt                     =            1;

AllPSNR                 =            zeros(1, Opts.Iter);

AllSSIM                 =            zeros(1, Opts.Iter);

Denoising               =            cell (1, Opts.Iter);

for iter = 1 : Opts.Iter    

        im_out          =             im_out + lamada*(nim - im_out);
        
        dif             =             im_out-nim;
        
        vd              =             nsig^2-(mean(mean(dif.^2)));

        if iter==1
            
             Opts.nSig          =      sqrt(abs(vd)); 

            

            X_im_EPLL         =        Im2Patch( EPLL_Inital, Opts ); 
            
            % Similar patches index by Pre-filtering...
            blk_arr           =        Block_matching( EPLL_Inital, Opts); 
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
       else
            Opts.nSig          =        sqrt(abs(vd))*Opts.lamada;
            
       end 
            
           AllSSIM(iter)      =        cal_ssim( im_out, EPLL_Inital, 0, 0 );
 
        if iter>1     
          
             if (AllSSIM(iter)- AllSSIM(iter-1)<Thr)||(AllSSIM(iter)- AllSSIM(iter-1))<0
                 
             % Similar patches index by Denoised image...    
           %  cnt
          %   AllSSIM(iter)- AllSSIM(iter-1)
              blk_arr    =   Block_matching( im_out, Opts);  
              
             end
             
       end


           X                  =         Im2Patch( im_out, Opts );  
           
           Ys                 =         zeros( size(X) );      
           
           W                  =         zeros( size(X) );
           
           K                  =         size(blk_arr,2);

                  
        for  i  =  1 : K  
            %%
            
            % Get Nonlocal Similar patches from Noisy input images.
            A                 =        X(:, blk_arr(:, i));  
            
            mA                =        repmat(mean( A, 2 ), 1, size(A, 2));
            
            A                 =        A-mA;   
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           %%
            % Get Nonlocal Similar patches from Pre-filtering.
            
            B                 =       X_im_EPLL (:, blk_arr(:, i));

            mB                =       repmat(mean( B, 2 ), 1, size(A, 2));
            
            B                 =       B-mB;  
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
            %Group Sparsity Residual Constraint (GSRC)
           TMP              =       GSRC( double(A), double(B ), Opts.c, Opts.nSig, mA ); % Core


     Ys(:, blk_arr(1:m,i))    =       Ys(:, blk_arr(1:m,i)) + TMP;
     
     W(:, blk_arr(1:m,i))     =       W(:, blk_arr(1:m,i)) + 1;
     
        end

        im_out   =  zeros(h,w);
        im_wei   =  zeros(h,w);
        k        =   0;
        for i  = 1:b
            for j  = 1:b
                k    =  k+1;
                im_out(r-1+i,c-1+j)  =  im_out(r-1+i,c-1+j) + reshape( Ys(k,:)', [N M]);
                im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + reshape( W(k,:)', [N M]);
            end
        end
        
        im_out               =       im_out./(im_wei+eps);
        
        Denoising{iter}      =       im_out;
        
        PSNR_ii   = csnr( im_out, Opts.I, 0, 1 );
    
        AllPSNR(iter)        =       csnr( im_out, Opts.I, 0, 1 );
              
        fprintf( 'Iteration %d : nSig = %2.2f, PSNR = %f\n', cnt, Opts.nSig, csnr( im_out, Opts.I, 0, 1 ));
        
        cnt                  =        cnt + 1;
        
   if iter>1
                   
              dif      =  norm(abs(Denoising{iter}) - abs(Denoising{iter-1}),'fro')/norm(abs(Denoising{iter-1}), 'fro');      
       
       if dif <err_or
           break;
       end    
   end
      
end
im      =      Denoising{iter-1};
disp(sprintf('PSNR of the Denoised image = %f \n', csnr(im, ori_im, 0, 0) ));
return;




