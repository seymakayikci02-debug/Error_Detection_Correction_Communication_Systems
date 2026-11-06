
function func_output = custom_P_matrix_generator(L,k,n)

    m = n-k;
    P_matrix=zeros(m,k);                                         % m x k parity-generation matrix
    
    parity_pos_vec = [];                                         % Positions of the m parity bits
    
    no_of_packages = fix(L/k) ;

    for i=1:n                                                    % n = total codeword length
        if( sum(dec2binvec(i)) == 1 )                            % Power-of-2 positions are parity positions
            parity_pos_vec(end+1) = i    ;                       % Store parity-bit position
        end
    end

    for r = 1:no_of_packages                                    % r = current message/package
        U_matrix_idx=1;                                  % Index of current data bit among k bits
    
        for parity_index = 1 : length(parity_pos_vec)            % parity_index = current parity bit
                U_matrix_idx=1;                          % Start again from first data bit
            for i=1:n                                            % i = position inside n-bit codeword
                if( sum(dec2binvec(i)) ~= 1)                     % Non-power-of-2 positions contain data bits    
                    if( bitget((i),parity_index) == 1 )        % summing
                        P_matrix (parity_index,U_matrix_idx) =1; % 1 means this data bit affects this parity bit
                    end
    
                    U_matrix_idx = U_matrix_idx + 1;  % Move to next of the k data bits
    
                end       
    
            end
    
        end
    end

    func_output = P_matrix ;
end