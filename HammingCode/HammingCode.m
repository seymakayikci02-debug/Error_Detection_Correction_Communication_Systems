
clear all;
% Generative Matrix
% [total message length ,data length ,parity length] = [n,k,d] = [2^m-1 ,2^m-1-m ,m]

% Parameters

data_length = 4;
k = data_length ;
pe = 5e-5;
L = 10000;        


d = 0 ;
for i = 1: k
    if(2^d>=d+k+1)
        break;
    else
        d=d+1;
    end
end

fprintf("\n\n ");
fprintf("k(data length): %d d(parity length): %d ",k,d);

m = d ;
k = 2^m-1-m ;
n = 2^m-1 ;

fprintf("\nn(total): %d k(message length): %d d(parity length): %d m(parity length): %d",n,k,d,m);
fprintf("\n\n ");

% ************** U matrix *****************

U_matrix = custom_U_matrix_generator(L,k);

% ************** P matrix *****************  

P_matrix = custom_P_matrix_generator(L,k,n);


% ************** H matrix *****************

H_matrix = custom_H_matrix_generator(k,n,P_matrix);


% ************** G matrix ********************

G_matrix = custom_G_matrix_generator(k,P_matrix);


% ***************** Encoder ******************

C_matrix = custom_encoder(U_matrix,G_matrix);


% ***************** Transmission ******************


R_matrix = zeros(size(C_matrix));

R_matrix = custom_bsc(C_matrix,pe);


R_matrix = double(R_matrix );       % From logical array to double array

fprintf("\nR_matrix : \n");
disp(R_matrix); 

% ***************** Decoder(built-in) ******************

R_matrix_decoded = decode(R_matrix,7,4,'linear/binary',G_matrix);

fprintf("\nR_matrix_decoded: \n");
disp(R_matrix_decoded); 


% ***************** Syndrom Testing ******************

S_matrix = custom_syndrom_testing(H_matrix,R_matrix) ;




