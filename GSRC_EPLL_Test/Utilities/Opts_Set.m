% =========================================================================
% Image denoising via group sparsity residual constraint, Version 2.0
% Copyright(c) 2017 Zhiyuan Zha
% All Rights Reserved.
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
function  Opts   =    Opts_Set( nSig,  I )

Opts.I         =   (I);

Opts.nSig      =   nSig;

Opts.Iter         =   25;

if nSig <= 20
    
    Opts.win       =   6;
    
    Opts.nblk      =   60;   
    
    Opts.c         =   0.3*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.5;
    
    Opts.Thr       =   5e-4;
     
    Opts.err_or       =   0.002;    
    
    
elseif nSig <= 30
    
    Opts.win       =   7;
    
    Opts.nblk      =   60;
    
    Opts.c         =   0.3*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.5;
    
    Opts.Thr       =   5e-4;
    
    Opts.err_or       =   0.002;      
    
 elseif nSig <= 40
    
    Opts.win       =   7;
    
    Opts.nblk      =   60;
    
    Opts.c         =   0.3*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.5;    
    
    Opts.Thr       =   6e-4;

    Opts.err_or       =   0.002;   
    
elseif nSig<=50
    
    Opts.win       =   7;
    
    Opts.nblk      =   60;
     
    Opts.c         =   0.5*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.4;
    
    Opts.Thr       =   4e-4;    
    
    Opts.err_or       =   0.002;   
    
elseif nSig<=75
    
    Opts.win       =   8;
    
    Opts.nblk      =   80;
    
    Opts.c         =   0.9*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.3;
    
    Opts.Thr       =   1e-4;  
    
    Opts.err_or       =   0.002;   
    
else
    
    Opts.win       =   9; 
    
    Opts.nblk      =   90;
    
    Opts.c         =   0.9*2*sqrt(2);  
    
    Opts.w         =   0.1;     
    
    Opts.lamada    =   0.3;
    
    Opts.Thr       =   2e-4;      
    
    Opts.err_or       =   0.002;   
end

Opts.step      =   min(4, Opts.win-1);

end

