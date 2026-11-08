
clear xlabel ylabel       %this clears ghost built-in functions


r = randi([0 1], 10000, 1);    %numeric
pe=0.5;

fprintf("pe:%d",pe);

channel_data=custom_bsc(r,pe);
pc = custom_calculate_error(r,channel_data);
fprintf("pc:%d",pc);

% close all;


%plot5 %linear using L number

pe=0.5;
L_vec = linspace(1,10000,10000);     % linspace

pc_vec = zeros(size(L_vec));
for i=1:numel(L_vec)
    data_sent    =  randi([0:1],L_vec(i),1);
    data_received=  custom_bsc(data_sent,pe);
    pc_vec(i)    =  custom_calculate_error(data_sent,data_received);
end

figure('WindowState','maximized');
plot(L_vec,pc_vec,"--k","LineWidth",1.5);
title("plot4");
xlabel('L, number of trial'); ylabel('pc_vec');
legend(sprintf("linear using L number \npe=0.5; \nL_vec = linspace(1,10000,10000)"),'Interpreter','none');

