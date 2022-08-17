function  par   =    Par_Set( nSig,  I )

par.I         =   double(I);

par.nSig      =   nSig;

par.Iter         =   25;

if nSig <= 20
    
    par.win       =   6;
    
    par.nblk      =   60;   
    
    par.c         =   0.7*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;
     
    par.err_or    =   0.001;   
    
    par.Thr      =   0.008;   
    
    
elseif nSig <= 30
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.9*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;
    
    par.err_or    =   0.0009;    
    
    par.Thr      =   0.01;   
    
 elseif nSig <= 40
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.9*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;    

    par.err_or    =   0.001;   
    
    par.Thr      =   0.01;       
    
elseif nSig<=50
    
    par.win       =   7;
    
    par.nblk      =   60;
     
    par.c         =   0.9*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;
    
    par.err_or    =   0.002;    
    
    par.Thr      =   0.02;    

elseif nSig<=75
    
    par.win       =   8;
    
    par.nblk      =   80;
    
    par.c         =   0.9*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;
    
    par.err_or    =   0.002;  
    
    par.Thr      =   0.01;        
else
    
    par.win       =   9; 
    
    par.nblk      =   90;
    
    par.c         =   1*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.3;
    
   par.err_or     =    0.003;
   
    par.Thr      =   0.01;     
end

par.step      =   min(4, par.win-1);

end

