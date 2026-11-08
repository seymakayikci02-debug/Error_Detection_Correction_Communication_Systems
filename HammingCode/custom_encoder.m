
function func_output = custom_encoder(U_matrix,G_matrix)

    C_matrix = U_matrix * G_matrix  ;  % C_matrix : full message length matrix (data + parity)
    
    fprintf("\nC_matrix: \n");
    disp( C_matrix ); 
        
    for i = 1 : size(C_matrix,1)
        for j = 1 : size(C_matrix,2)
            C_matrix(i,j)=mod( C_matrix(i,j),2 );
        end
    end
    
    func_output = C_matrix ;   
end