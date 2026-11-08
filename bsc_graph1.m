
clear xlabel ylabel       %this clears ghost built-in functions


r = randi([0 1], 10000, 1);    %numeric
pe=0.5;

fprintf("pe:%d",pe);

channel_data=custom_bsc(r,pe);
pc = custom_calculate_error(r,channel_data);
fprintf("pc:%d",pc);

% close all;

%plot1 linear using num_of_diff_errs

L =10000;
num_of_diff_errs=500;

pe_vec=linspace(0,1,num_of_diff_errs);

pc_vec=zeros(size(pe_vec));
for i=1:num_of_diff_errs
    data_sent    =  randi([0:1], L,1);
    data_received=  custom_bsc(data_sent,pe_vec(i));
    pc_vec(i)    =  calculate_error(data_sent,data_received);
end

figure('WindowState','maximized');
plot(pe_vec,pc_vec,"--k","LineWidth",1.5);
title("plot1");
xlabel('pe_vec'); ylabel('pc_vec');
legend(sprintf(" linear using num_of_diff_errs \nL =10000  \nnum_of_diff_errs=500"),'Interpreter','none');
