
function func_output = custom_syndrom_testing(H_matrix,R_matrix)

    S_matrix =zeros(size(R_matrix)) ;
    S_matrix = ( R_matrix ) * ( H_matrix.' ) ;   
    S_matrix = mod(S_matrix,2);
   
    func_output = S_matrix ;    
    fprintf("\nS_matrix: \n");
    disp(S_matrix); 

    if(S_matrix == 0) fprintf("Syndrom Testing has passed\nMessage received with no error\n")
    else fprintf("Syndrom Testing has failed\nError Detected\n")
end