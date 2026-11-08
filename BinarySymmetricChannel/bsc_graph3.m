
clear xlabel ylabel       %this clears ghost built-in functions


r = randi([0 1], 10000, 1);    %numeric
pe = 0.5;

fprintf("pe:%d",pe);

channel_data = custom_bsc(r,pe);
pc = custom_calculate_error(r,channel_data);
fprintf("pc:%d",pc);

% close all;

%plot3 logarithmic using num_of_diff_errs

L =10000;
num_of_diff_errs=500;
pe_vec=logspace(-1,-8,num_of_diff_errs);

pc_vec=zeros(size(pe_vec));
for i=1:num_of_diff_errs
    data_sent    =  randi([0:1], L,1);
    data_received=  custom_bsc(data_sent,pe_vec(i));
    pc_vec(i)    =  custom_calculate_error(data_sent,data_received);
end

idx = pc_vec > 0;
pe_vec_log = log(pe_vec(idx));
pc_vec_log = log(pc_vec(idx));
figure('WindowState','maximized');
plot(pe_vec_log,pc_vec_log,"--k","LineWidth",1.5);
title("plot3 ");
xlabel('pe_vec'); ylabel('pc_vec');
legend(sprintf("L =10000 \nnum_of_diff_errs=500 \npe_vec=logspace(-1,-8,num_of_diff_errs)\nboth axis log"),'Interpreter','none');

