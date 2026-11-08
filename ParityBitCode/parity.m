
% % **********Clean Version**********

% Environment
clear all;
clear figure;
close all;
function rx=custom_bsc(pe,tx)
    mask     =rand(size(tx))<pe;
    flip     =xor(tx==1,mask);
    rx       =flip;
end

function pc = error_calculation(tx,rx)
    error = (tx~=rx);
    pc = mean(error(:));
end

% parameters
pe = 5e-8;
L = 10000000;
% Error Detection
% Parity
data_sent = randi([0 1],L,1);
data_sent_num_bits = sum(data_sent);
parity_sent = mod(data_sent_num_bits,2);
data_sent_p = cat(2,parity_sent,data_sent.');
data_sent_p = data_sent_p(:);
data_received_p = custom_bsc(pe,data_sent_p);
data_received_p = data_received_p(:).';
data_received_p_n = data_received_p(2:L+1);
parity_received = data_received_p(1:1);
data_received_p_n_num_bits = sum(data_received_p_n);
expected_parity = mod(data_received_p_n_num_bits,2);
if(expected_parity ~= parity_received);
    fprintf("\n***********error*************\n\n");
else(expected_parity == parity_received);
    fprintf("\n*********error free or even number of bits had changed************\n\n")
end
clear pc
pc = error_calculation(data_sent_p(:).',data_received_p(:).');
fprintf("pe :")
disp(pe);
fprintf("pc :")
disp(pc);







