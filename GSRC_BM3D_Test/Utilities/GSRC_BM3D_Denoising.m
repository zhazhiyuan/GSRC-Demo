
function  [Denoising,iter ]     =     GSRC_BM3D_Denoising( Opts, Thr, im_BM3D,err_or )

randn ('seed',0);

Nim            =   Opts.nim;

Ori_im         =   Opts.I;

b              =   Opts.win;

[h, w, ch]     =   size(Nim);

N              =   h-b+1;

M              =   w-b+1;

r              =   [1:N];

c              =   [1:M]; 

Out_Put         =   Nim;

lamada         =   Opts.w;

nsig           =   Opts.nSig;

m              =   Opts.nblk;

cnt            =   1;

AllPSNR        =  zeros(1,Opts.Iter );

AllSSIM        =  zeros(1,Opts.Iter );

Denoising      =  cell (1,Opts.Iter);

for iter = 1 : Opts.Iter    
    
        Out_Put               =    Out_Put + lamada*(Nim - Out_Put);
        
         dif                  =    Out_Put-Nim;
        
         vd                   =    nsig^2-(mean(mean(dif.^2)));
        
    if iter==1
        
                      
            Opts.nSig         =    sqrt(abs(vd)); 

            X_im_BM3D        =    Im2Patch( im_BM3D, Opts ); 
            
            % Similar patchs index by Pre-filtering...
            blk_arr          =    Block_matching( im_BM3D, Opts);     
            
    else
       
            Opts.nSig         =    sqrt(abs(vd))*Opts.lamada;
            
   end 
        
            AllSSIM(iter)    =   cal_ssim( Out_Put, im_BM3D, 0, 0 );
            
       if iter>1         
            
            if (AllSSIM(iter)- AllSSIM(iter-1)<Thr)||(AllSSIM(iter)- AllSSIM(iter-1))<0
                
              blk_arr        =   Block_matching( Out_Put, Opts);  
              
            end
            
       end
     
               X             =     Im2Patch( Out_Put, Opts );  
               
               Ys            =     zeros( size(X) );   
               
               W             =     zeros( size(X) );
               
               K             =     size(blk_arr,2);
               
                 
        for  i  =  1 : K  
            %%
            % Get Nonlocal Similar patches from noisy image...
            
               A             =      X(:, blk_arr(:, i));    
               
              mA             =      repmat(mean( A, 2 ), 1, size(A, 2));
              
              A              =      A-mA;   
            
           %%
             % Get Nonlocal Similar patches from pre-filtering ...
            
              B              =      X_im_BM3D (:, blk_arr(:, i));
            
              mB             =      repmat(mean( B, 2 ), 1, size(A, 2));
            
              B              =      B-mB;  
            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Group Sparsity Residual Constraint (GSRC)
            
            TMP              =    GSRC( double(A), double(B ), Opts.c, Opts.nSig, mA );
            
    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
    Ys(:, blk_arr(1:m,i))    =   Ys(:, blk_arr(1:m,i)) + TMP;
    
    W(:, blk_arr(1:m,i))     =   W(:, blk_arr(1:m,i)) + 1;
    
        end

     Out_Put        =   zeros(h,w);       
     
     im_wei        =  zeros(h,w);     
     
      k            =   0;
      
     for i   =  1:b
         for j  = 1:b
                k    =  k+1;
                Out_Put(r-1+i,c-1+j)  =  Out_Put(r-1+i,c-1+j) + reshape( Ys(k,:)', [N M]);
                im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + reshape( W(k,:)', [N M]);
          end
     end
     
      Out_Put            =        Out_Put./(im_wei+eps);
        
     Denoising{iter}    =        Out_Put;

     AllPSNR(iter)      =        csnr( Out_Put, Opts.I, 0, 0 );
     
         PSNR_ii         = csnr( Out_Put, Opts.I, 0, 0 );
              
    fprintf( 'Iteration %d : nSig = %2.2f, PSNR = %f\n', cnt, Opts.nSig, csnr( Out_Put, Opts.I, 0, 1 ));
    
    cnt   =  cnt + 1;
        
   if iter>1
       
              dif      =  norm(abs(Denoising{iter}) - abs(Denoising{iter-1}),'fro')/norm(abs(Denoising{iter-1}), 'fro');


       
       if dif < err_or
           
           break;
           
       end   
       
   end 
   
end

Im      =      Denoising{iter-1};

disp(sprintf('PSNR of the Denoised image = %f \n', csnr(Im, Ori_im, 0, 0) ));
end




