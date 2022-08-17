function  par   =    Par_Set( nSig,  I)

par.I         =   double(I);

par.nSig      =   nSig;

par.Iter         =   25;

if nSig <= 20
    
    par.win       =   6;
    
    par.nblk      =   60;   
    
    par.c         =   0.2*2*sqrt(2);  
    
    par.w         =   0.2;     
    
    par.lamada    =   0.7;
    
    par.Thr       =  -0.008;
    
    par.err_or    = 0.003;
     
    
elseif nSig <= 30
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.4*2*sqrt(2);  
    
    par.w         =   0.2;     
    
    par.lamada    =   0.6;
    
    par.Thr       =  -0.002;
    
    par.err_or    = 0.005;
    
    
    
    
 elseif nSig <= 40
    
    par.win       =   7;
    
    par.nblk      =   60;
    
    par.c         =   0.6*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.4;    
    
     par.Thr      =  0;
    
    par.err_or    = 0.003;   
    

    
elseif nSig<=50
    
    par.win       =   7;
    
    par.nblk      =   60;
     
    par.c         =   0.6*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.4;
    
     par.Thr      =  0;
    
    par.err_or    = 0.003;       

     
    
    
    
elseif nSig<=75
    
    par.win       =   8;
    
    par.nblk      =   80;
    
    par.c         =   0.5*2*sqrt(2);  
    
    par.w         =   0.1;     
    
    par.lamada    =   0.4;
      
     par.Thr      =  -0.005;
    
    par.err_or    = 0.002;       
    
else
    
    par.win       =   9; 
    
    par.nblk      =   90;
    
    par.c         =   c*2*sqrt(2);  
    
    par.w         =   w;     
    
    par.lamada    =   lamada;
end

par.step      =   min(4, par.win-1);

end

