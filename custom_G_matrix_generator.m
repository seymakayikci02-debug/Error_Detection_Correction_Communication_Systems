
function func_output = custom_G_matrix_generator(k,P_matrix)

    G_eye = eye(k);
    G_matrix = cat(2,G_eye,P_matrix.') ;
    
    func_output = G_matrix ;
end