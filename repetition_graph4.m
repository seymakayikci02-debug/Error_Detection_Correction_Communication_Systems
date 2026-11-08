
% Sun, J., & Cribbs, A. P. (2025).
% Sequencing meets cryptography: Quadratic substitution error suppression through
% homotrimer redundancy. Research Square.
% https://doi.org/10.21203/rs.3.rs-6710367/v1

% % parameters
% pe = 0.5;
% L = 100000;
clear data_received1;
clear data_received2;
clear data_sent;
clear data_sent_rep;
clear data_received_corrected;
clear pc;
clear i;


% *********** figure3 *************
clear all;
pe = 5e-3;
L = 5000;

pe_vec = logspace(0 , -6 , 5000 );
zero_vote = zeros(3);
one_vote = zeros(3);
pc_vec = zeros(size(pe_vec));
pc_corrected_vec = zeros(size(pe_vec));

clear j;

for i = 1 : numel(pe_vec)

    data_sent = randi([0 1], L ,1);
    data_received = custom_bsc(data_sent(:) ,pe_vec(i) );
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),3);
    data_received_rep = custom_bsc(data_sent_rep(:) , pe_vec(i) );

    for j=1:L
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
    fprintf("(i) :")
    disp(i);


end



figure('WindowState',"maximized");
loglog(pe_vec,pc_vec,'LineWidth',1.5,'Color',[0 0 1]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
hold on;

loglog(pe_vec,pc_corrected_vec,'LineWidth',1.5 , 'Color',[0 1 0]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');

grid on;
hold off;
title('Repetetion code (Log scale) ','Interpreter','none');
subtitle(sprintf('comparison between channel error(pc) and correction error using repetition(pc_corrected) in log scale\n  L = %.2f; ',L),'Interpreter','none');
legend( 'pc_vec','pc_corrected_vec','Interpreter','none');



figure('WindowState',"maximized");
loglog(pe_vec,pc_vec,'o', 'MarkerSize',1, 'Color',[0 0 1]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
hold on;

loglog(pe_vec,pc_corrected_vec,'o', 'MarkerSize',1,'Color',[0 1 0]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');

grid on;
hold off;
title('Repetition code (Log scale) ','Interpreter','none');
subtitle(sprintf('Comparison between channel error(pc) and correction error using repetition(pc_corrected) in log scale\n  L = %.2f; ',L),'Interpreter','none');
legend( 'pc_vec','pc_corrected_vec','Interpreter','none');
