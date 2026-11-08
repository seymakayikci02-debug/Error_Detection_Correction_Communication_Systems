
% Sun, J., & Cribbs, A. P. (2025).
% Sequencing meets cryptography: Quadratic substitution error suppression through
% homotrimer redundancy. Research Square.
% https://doi.org/10.21203/rs.3.rs-6710367/v1

clear data_received1;
clear data_received2;
clear data_sent;
clear data_sent_rep;
clear data_received_corrected;
clear pc;
clear i;


% *********** figure6 *************
clear all;

L = 10000;

pe_vec = logspace(0 ,-6 , 1000 );
rep_num = 3;
zero_vote = zeros(rep_num);
one_vote = zeros(rep_num);
pc_vec = zeros(size(pe_vec));
pc_corrected_vec = zeros(size(pe_vec));

clear j;

for i = 1 : numel(pe_vec)

    data_sent = randi([0 1], L ,1);
    data_received = custom_bsc( data_sent(:) ,pe_vec(i));
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),rep_num );
    data_received_rep = custom_bsc(data_sent_rep,pe_vec(i)  );
    data_received_corrected=0;

    for j=1:L
        zero_vote = zeros(rep_num);
        one_vote = zeros(rep_num);
        zero_vote = sum( data_received_rep ( rep_num*j-(rep_num -1) : rep_num *j ).' == 0 );
        one_vote = sum( data_received_rep ( rep_num*j-(rep_num -1) : rep_num*j ).' == 1);

        if(zero_vote >=  ceil(rep_num/2)  )
            data_received_corrected(j,1)=0;

        elseif(one_vote >=  ceil(rep_num/2)  )
            data_received_corrected(j,1)=1;
        end


    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("(i) :")
    disp(i);


end



figure('WindowState',"maximized");
loglog(pe_vec,pc_vec,'o','MarkerFaceColor',[0 0 0.2], 'MarkerSize',5,'Color',[0 0 0.2]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
ylim([1e-5,1e0]);
hold on;

loglog(pe_vec,pc_corrected_vec,'o','MarkerFaceColor',[0 0 0.5],'MarkerSize',4,'Color',[0 0 0.5]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_corrected_vec','Interpreter','none');
ylim([1e-5,1e0]);



% *********** figure6 *************
clear all;

L = 10000;

pe_vec = logspace(0 ,-6 , 1000 );
rep_num = 5;
zero_vote = zeros(rep_num);
one_vote = zeros(rep_num);
pc_vec = zeros(size(pe_vec));
pc_corrected_vec = zeros(size(pe_vec));

clear j;

for i = 1 : numel(pe_vec)

    data_sent = randi([0 1], L ,1);
    data_received = custom_bsc(data_sent(:)  ,pe_vec(i));
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),rep_num );
    data_received_rep = custom_bsc(data_sent_rep(:), pe_vec(i)  );
    data_received_corrected=0;

    for j=1:L
        zero_vote = zeros(rep_num);
        one_vote = zeros(rep_num);
        zero_vote = sum( data_received_rep ( rep_num*j-(rep_num -1) : rep_num *j ).' == 0 );
        one_vote = sum( data_received_rep ( rep_num*j-(rep_num -1) : rep_num*j ).' == 1);

        if(zero_vote >=  ceil(rep_num/2)  )
            data_received_corrected(j,1)=0;

        elseif(one_vote >=  ceil(rep_num/2)  )
            data_received_corrected(j,1)=1;
        end
    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("(i) :")
    disp(i);

end


loglog(pe_vec,pc_corrected_vec,'o','MarkerFaceColor',[0 0 0.8],'MarkerSize',3,'Color',[0 0 0.8]);
xlabel('pe_vec','Interpreter','none'); ylabel('pc_corrected_vec','Interpreter','none');
ylim([1e-5,1e0]);

legend( 'pc_vec','rep_num = 3','rep_num = 5','Interpreter','none');
title(sprintf('Comparing pc and pc corrected according to logarithmic pe_vec '),'Interpreter','none','FontWeight','bold');
subtitle(sprintf('Dotgraph'),'Interpreter','none');

grid on;
hold off;
