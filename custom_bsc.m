function func_output=custom_bsc(array,pe)

    mask=rand(size(array))<pe;
    flip=xor(array==1,mask);  %array==1 converts numeric to logical array
                              %it will flip the array when mask is true
    func_output=flip;

end