
function func_output = custom_U_matrix_generator(L,k)

    U = randi([0 1],L,1);       % U: data_sent
    
    no_of_packages = fix(L/k) ;
    if(mod(L,k)~=0)
        fprintf('\nWarning: Message size (L) is indivisible in %d\n',k);
        fprintf('\nThe data will be sent lack of last digits.\n');    
        L = no_of_packages * k ;
    end

    r = 1;
    c = 1;
    for i = 1:L
    
       U_matrix(c,r) = U(i,1);     % data_sent_matrix is built dividing data_sent and 
       r=r+1;                      % and putting data_sent in "row by row" every length of 4 part of data_sent
    
       if(mod(i,k) == 0)
            c =c +1;
            r =1 ;
        end 
    end

    func_output = U_matrix ;
end