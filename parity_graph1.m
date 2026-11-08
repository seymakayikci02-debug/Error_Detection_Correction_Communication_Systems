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


         % fprintf("i:");
         % disp(i);
         %
         % fprintf("parity_error:");
         % disp(parity_error);
         %
         % fprintf("pc_vec(i):");
         % disp(pc_vec(i));


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

     % fprintf("error_detected:");
     % disp(error_detected);
     %
     % fprintf("even_detected :");
     % disp(even_detected);
     %
     % fprintf("odd_detected:");
     % disp(odd_detected);
     %
     %
     % fprintf("j:");
     % disp(j);

     error_detected_num(j) = error_detected;
     odd_detected_num(j) = odd_detected;
     even_detected_num(j) = even_detected;
     error_free_detected_num(j) = error_free_detected;
     error_free_correct_detected_num(j) = error_free_correct_detected ;
     error_free_incorrect_detected_num(j) = error_free_incorrect_detected ;

     ratio_of_incorrect_error_free(j) = abs(error_free_incorrect_detected_num(j)) / abs(error_free_detected_num(j));
     ratio_of_correct_error_free(j)   = abs(error_free_correct_detected_num(j)) / abs(error_free_detected_num(j));


     % fprintf("error_detected_num(j):");
     % disp(error_detected_num(j));
     %
     % fprintf("ratio_of_incorrect_error_free(j):");
     % disp(ratio_of_incorrect_error_free(j));
     % fprintf("ratio_of_correct_error_free(j):");
     % disp(ratio_of_correct_error_free(j));

     fprintf("j:");
     disp(j);
 end

% figure1

 figure('WindowState','maximized')

 plot(L_vec,pc_vec_mean,'LineWidth',1.5,'Color',[0 0 0.3] );
 xlabel(sprintf('L_vec'),'Interpreter','none');ylabel(sprintf('pc_vec_mean'),'Interpreter','none');
 grid on;
 legend(sprintf('pe = %.8f\n real error of the system pc_vec_mean',pe),'Interpreter','none')

 title(sprintf('Real Error(pc)'),'Interpreter','none','FontWeight','bold');
 subtitle(sprintf('figure1'));
