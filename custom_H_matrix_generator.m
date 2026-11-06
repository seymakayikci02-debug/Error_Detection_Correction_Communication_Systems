
function func_output = custom_H_matrix_generator(k,n,P_matrix)
    H_eye = eye(n-k);
    H_matrix = cat(2,P_matrix,H_eye) ;
    func_output = H_matrix ;
end
