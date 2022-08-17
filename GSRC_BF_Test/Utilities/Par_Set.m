function  par   =    Par_Set( nSig,  I )

par.I         =   double(I);

par.nSig      =   nSig;

par.Iter         =   25;

if nSig <= 20
    
    par.win       =   6;
    
    par.nblk      =   60;   
    
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   1.2;
     
    par.err_or    =   0.007;   
    
    par.Thr       =  -0.03;       
    
elseif nSig <= 30
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   1.2;
    
    par.err_or    =   0.009;   
    
    par.Thr       =  -0.05;  
    
    
elseif nSig <= 40
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   1;    

    par.err_or    =   0.009;
    
    par.Thr       =  -0.02;      
    
elseif nSig<=50
    
    par.win       =   7;
    
    par.nblk      =   60;
     
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   1;
    
    par.err_or    =   0.009;
    
    par.Thr       =  -0.02;      
    
elseif nSig<=75
    
    par.win       =   8;
    
    par.nblk      =   80;
    
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.2;     
    
    par.lamada    =   0.9;
    
    par.err_or    =   0.007;    
    
    par.Thr       =  -0.008;      
else
    
    par.win       =   9; 
    
    par.nblk      =   90;
    
    par.c         =   0.1*2*sqrt(2);  
    
    par.w         =   0.2;     
    
    par.lamada    =   0.9;
    
    par.err_or    =   0.0054;    
    
    par.Thr       =  -0.004;  
end

par.step      =   min(4, par.win-1);

end

