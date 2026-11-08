
clear xlabel ylabel       %this clears ghost built-in functions

r = randi([0 1], 10000, 1);    %numeric
pe=0.5;

fprintf("pe:%d",pe);

channel_data = custom_bsc(r,pe);
pc = custom_calculate_error(r,channel_data);
fprintf("pc:%d",pc);

% close all;

%plot4 %linear using L mean fixed small pe

pe                  =5e-6;
number_of_iteration =10000;
L_vec               =linspace(1,1000,1000);
pc_vec              =zeros(size(L_vec));

for i=1:numel(L_vec)
    error_sum_vec=zeros(size(number_of_iteration));
    for j=1:number_of_iteration
        data_sent       =randi([0 1], L_vec(i), 1 )   ;
        data_received   =custom_bsc(data_sent,pe);
        error_sum_vec(j)=custom_calculate_error(data_sent,data_received);
    end
        pc_vec(i)=mean(error_sum_vec);

end

figure('WindowState','maximized');
plot(L_vec,pc_vec,"LineWidth",1.5,"Color","k");
title("plot5");
xlabel('L_vec'); ylabel('pc_vec');
legend(sprintf("linear using MEAN of L fixed small pe\n pe=5e-6 \nnumber_of_iteration =10000; "));
