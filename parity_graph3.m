%%C:\Users\aselsan\Desktop\seyma\parity_error_testing.m

% Environment
% clear all;
% clear figure;

pe = 5e-6;
L = 3000;
num_of_trial = 5000;
L_vec = linspace(1,L,300);
L_vec = unique(round(L_vec));

pc_vec_mean = zeros(size(L_vec));
error_detected_num = zeros(size(L_vec));
odd_detected_num = zeros(size(L_vec));
even_detected_num = zeros(size(L_vec));
ratio_of_correct_error_free = zeros(size(L_vec));
ratio_of_incorrect_error_free = zeros(size(L_vec));
error_free_correct_detected_num = zeros(size(L_vec));
error_free_incorrect_detected_num = zeros(size(L_vec));
error_free_detected_num = zeros(size(L_vec));

 for j = 1:numel(L_vec)
     error_detected = 0;
     data_sent_num_bits = 0;
     parity_sent  = 0;                  %parity_sent
     parity_received  = 0;              %parity_received
     data_received_p_n_num_bits = 0;
     expected_parity = 0;
     pc_vec = zeros(size(num_of_trial));
     parity_error = 0;
     odd_detected = 0;
     even_detected = 0;
     real_error = 0;
     error_free_detected = 0;
     error_free_incorrect_detected = 0;
     error_free_correct_detected = 0;

     for i = 1:num_of_trial

         data_sent = randi([0 1],L_vec(j),1);
         data_sent_num_bits = sum(data_sent);
         parity_sent = mod(data_sent_num_bits,2);     %parity_sent
         data_sent_p = cat(2,parity_sent,data_sent.');
         data_sent_p = data_sent_p(:);
         data_received_p = custom_bsc(data_sent_p,pe);
         data_received_p = data_received_p(:).';
         data_received_p_n = data_received_p(2:L_vec(j)+1);
         parity_received = data_received_p(1:1);           %parity_received
         data_received_p_n_num_bits = sum(data_received_p_n);
         expected_parity  = mod(data_received_p_n_num_bits,2);


         pc_vec(i) = custom_calculate_error(data_sent_p(:).',data_received_p(:).');
         pc_vec_mean(j) = mean(pc_vec);

         parity_error = (expected_parity~=parity_received);

         if(pc_vec(i)==0 && parity_error==1)
            error_detected = error_detected+1;  %always gives 0. if pc==0 it will never give error
         end

         if(pc_vec(i)~=0 && parity_error==0)
            even_detected = even_detected+1;
         end
         if(pc_vec(i)~=0 && parity_error==1)
            odd_detected = odd_detected+1;
         end

         if(pc_vec(i)~=0)
            real_error = real_error+1;
         end

         if(parity_error==0)
            error_free_detected = error_free_detected+1;
         end
         if(pc_vec(i)==0 && parity_error==0)
            error_free_correct_detected = error_free_correct_detected+1;
         end
         if(pc_vec(i)~=0 && parity_error==0)
            error_free_incorrect_detected = error_free_incorrect_detected+1;
         end

     parity_error = 0;
     end

 
     error_detected_num(j) = error_detected;
     odd_detected_num(j) = odd_detected;
     even_detected_num(j) = even_detected;
     error_free_detected_num(j) = error_free_detected;
     error_free_correct_detected_num(j) = error_free_correct_detected ;
     error_free_incorrect_detected_num(j) = error_free_incorrect_detected ;

     ratio_of_incorrect_error_free(j) = abs(error_free_incorrect_detected_num(j)) / abs(error_free_detected_num(j));
     ratio_of_correct_error_free(j)   = abs(error_free_correct_detected_num(j)) / abs(error_free_detected_num(j));


     fprintf("j:");
     disp(j);
 end


% figure3,4
 figure('WindowState','maximized')

 t=tiledlayout(1,2);

 nexttile;
 plot(L_vec,even_detected_num,'LineWidth',1.5, 'Color',[0 0 0]);
 xlabel('L_vec','Interpreter','none');ylabel('even_detected_num','Interpreter','none');
 grid on;
 legend(sprintf('pc_vec(i)~=0 && parity_error==0\n Even Flips (Undetected)'),'Interpreter','none')

 nexttile;
 plot(L_vec,odd_detected_num,'LineWidth',1.5,'Color',[0 0 0]);
 xlabel('L_vec','Interpreter','none');ylabel('odd_detected_num','Interpreter','none');
 grid on;
 legend(sprintf('pc_vec(i)~=0 && parity_error==1\n Odd Flips (Detected)'),'Interpreter','none')

 title(t,sprintf('Comparison Between Even and Odd Numbers When pc_vec(i)~=0 '),'Interpreter','none','FontWeight','bold');
 subtitle(t,sprintf('figure3,4'));

