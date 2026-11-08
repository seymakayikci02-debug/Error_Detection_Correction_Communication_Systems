
% Sun, J., & Cribbs, A. P. (2025).
% Sequencing meets cryptography: Quadratic substitution error suppression through
% homotrimer redundancy. Research Square.
% https://doi.org/10.21203/rs.3.rs-6710367/v1

% clear all;

clear data_received1;
clear data_received2;
clear data_sent;
clear data_sent_rep;
clear data_received_corrected;
clear pc;
clear i;

% *********** figure1 *************

pe = 5e-2;
L = 10000;

L_vec = linspace(1 , L , 1000 );
L_vec = unique(round(L_vec));
zero_vote = zeros(3);
one_vote = zeros(3);
pc_vec = zeros(size(L_vec));
pc_corrected_vec = zeros(size(L_vec));

clear j;

for i = 1:numel(L_vec)

    data_sent = randi([0 1], L_vec(i) ,1);
    data_received = custom_bsc(data_sent(:)  ,pe );
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),3);
    data_received_rep = custom_bsc(pe,data_sent_rep(:));

    for j=1:L_vec(i)
        zero_vote = zeros(3);
        one_vote = zeros(3);
        zero_vote = sum(data_received_rep(3*j-2:3*j).'==0);
        one_vote = sum(data_received_rep(3*j-2:3*j).'==1);

        if(zero_vote >= 3-1 )
            data_received_corrected(j,1)=0;

        elseif(one_vote >= 3-1 )
            data_received_corrected(j,1)=1;
        end
    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("pc_corrected_vec(i) :")
    disp(pc_corrected_vec(i));


end


figure('WindowState',"maximized");
plot(L_vec,pc_vec,'LineWidth',1.5,'Color',[0 0 1]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
hold on;

plot(L_vec,pc_corrected_vec,'LineWidth',1.5 , 'Color',[0 1 0]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');

grid on;
hold off;
title('Repetition code ','Interpreter','none');
subtitle(sprintf('Comparison between channel error(pc) and correction error using repetition(pc_corrected)\n pe = %.2f; L = %.2f; L_vec = linspace(1 , L , 1000 );',pe,L),'Interpreter','none');
legend( 'pc_vec','pc_corrected_vec','Interpreter','none');
