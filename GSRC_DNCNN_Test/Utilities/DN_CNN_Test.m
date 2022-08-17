function   [DN_CNN_PSNR,output]       =    DN_CNN_Test(Img, Im_DnCNN_nim, nSig_DN_CNN)


if nSig_DN_CNN==20
    
 load('sigma=20.mat');
 
elseif nSig_DN_CNN==30
    
  load('sigma=30.mat');   
  
elseif nSig_DN_CNN==40
    
    load('sigma=40.mat');    
        
elseif nSig_DN_CNN==50
            
  load('sigma=50.mat'); 
  
else
    
   load('sigma=75.mat');  
   
end

input  = (Im_DnCNN_nim/255);

    res = simplenn_matlab(net, input); %%% use this if you did not install matconvnet.
    
    output = input - res(end).x;
    
    
    
    DN_CNN_PSNR   = csnr(output*255, Img,0,0)
    







end

