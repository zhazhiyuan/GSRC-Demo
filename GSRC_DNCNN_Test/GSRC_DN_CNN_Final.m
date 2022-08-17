clc
clear
m_20=0; 
m_30=0;    
m_40=0;  
m_10=0;  
m_50=0; 


All_data_Results_2_20 = cell(1,200);
All_data_Results_2_30 = cell(1,200);
All_data_Results_2_40 = cell(1,200);
All_data_Results_2_10 = cell(1,200);
All_data_Results_2_50 = cell(1,200);


for i =1:12
    
ImageNum =i;

switch ImageNum
    
            case 1
                filename = 'Barbara';
            case 2
                filename = 'elaine';
            case 3
                filename = 'flower';
            case 4
                filename = 'foreman';    
            case 5
                filename = 'Goldhill'; 
                
            case 6
                filename = 'House';
            case 7
                filename = 'lena';
            case 8
                filename = 'lin';
            case 9
                filename = 'Monarch';    
            case 10
                filename = 'Parrots'; 
                
            case 11
                filename = 'pentagon';
            case 12
                filename = 'peppers';
 
end

for j  =  1:5
    

randn ('seed',0);

filename;

Sigma_Num  =  [20, 30, 40, 50, 75];
     

Sigma    =  Sigma_Num(j);


 if  Sigma==20
     
 
 [filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (filename, Sigma ); 
 
 m_10= m_10+1;
 
 s=strcat('A',num2str(m_10));
 
 All_data_Results_2_10{m_10}={filename, Sigma,   Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSRC_Dn_CNN_Sigma_20.xls', All_data_Results_2_10{m_10},'sheet1',s);
 
 
 
 
 elseif  Sigma==30
     


 [filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (filename, Sigma ); 
 
 m_20= m_20+1;
 
 s=strcat('A',num2str(m_20));
 
 All_data_Results_2_20{m_20}={filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSRC_Dn_CNN_Sigma_30.xls', All_data_Results_2_20{m_20},'sheet1',s);
 
 
  elseif   Sigma==40
      

 [filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (filename, Sigma ); 
 
 m_30= m_30+1;
 
 s=strcat('A',num2str(m_30));
 
 All_data_Results_2_30{m_30}={filename, Sigma,    Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final};
 xlswrite('GSRC_Dn_CNN_Sigma_40.xls', All_data_Results_2_30{m_30},'sheet1',s);
 
 
   elseif  Sigma==50
       
 [filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (filename, Sigma ); 
 
 m_40= m_40+1;
 
 s=strcat('A',num2str(m_40));
 
 All_data_Results_2_40{m_40}={filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSRC_Dn_CNN_Sigma_50.xls', All_data_Results_2_40{m_40},'sheet1',s);
 
 

 else

     
 [filename, Sigma,  Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final]     =  GSRC_Test_DN_CNN (filename, Sigma ); 
 
 m_50= m_50+1;
 
 s=strcat('A',num2str(m_50));
 
 All_data_Results_2_50{m_50}={filename, Sigma,   Dn_CNN_PSNR, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSRC_Dn_CNN_Sigma_75.xls', All_data_Results_2_50{m_50},'sheet1',s);
 
 
 end
 
 
 
 
 

clearvars -except filename i m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 

end
 clearvars -except filename m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 
end





         