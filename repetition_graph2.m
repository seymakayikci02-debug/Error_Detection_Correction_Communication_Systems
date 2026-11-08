
% Sun, J., & Cribbs, A. P. (2025).
% Sequencing meets cryptography: Quadratic substitution error suppression through
% homotrimer redundancy. Research Square.
% https://doi.org/10.21203/rs.3.rs-6710367/v1

clear all;
clear data_received1;
clear data_received2;
clear data_sent;
clear data_sent_rep;
clear data_received_corrected;
clear pc;
clear i;

% *********** figure2 *************

pe = 5e-2;
L = 1000;
rep_num = 3;

L_vec = linspace(1 , L , 1000 );
L_vec = unique(round(L_vec));

zero_vote = zeros(rep_num);
one_vote = zeros(rep_num);
pc_vec = zeros(size(L_vec));
pc_corrected_vec = zeros(size(L_vec));

clear j;

for i = 1:numel(L_vec)

    data_sent = randi([0 1], L_vec(i) ,1);
    data_received = custom_bsc( data_sent(:), pe);
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),rep_num );
    data_received_rep = custom_bsc( data_sent_rep(:), pe);
    data_received_corrected = 0;

    for j=1:L_vec(i)
        zero_vote = zeros(rep_num );
        one_vote = zeros(rep_num );
        zero_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num *j ).' == 0 );
        one_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num*j ).' == 1 );


        if(zero_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=0;
        elseif(one_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=1;
        end

    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("i :")
    disp(i);
end

figure('WindowState',"maximized");
plot(L_vec,pc_vec,'LineWidth',1,'Color',[0 0 1]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
hold on;
plot(L_vec,pc_corrected_vec,'LineWidth',1 , 'Color',[0 1 0]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');
grid on;


clear all;
pe = 5e-2;
L = 1000;

rep_num = 5;

L_vec = linspace(1 , L , 1000 );
L_vec = unique(round(L_vec));

zero_vote = zeros(rep_num);
one_vote = zeros(rep_num);
pc_vec = zeros(size(L_vec));
pc_corrected_vec = zeros(size(L_vec));

clear j;

for i = 1:numel(L_vec)

    data_sent = randi([0 1], L_vec(i) ,1);
    data_received = custom_bsc( data_sent(:), pe)
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),rep_num );
    data_received_rep = custom_bsc( data_sent_rep(:), pe)
    data_received_corrected = 0;

    for j=1:L_vec(i)
        zero_vote = zeros(rep_num );
        one_vote = zeros(rep_num );
        zero_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num *j ).' == 0 );
        one_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num*j ).' == 1 );


        if(zero_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=0;
        elseif(one_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=1;

        end

    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("i :")
    disp(i);
end


plot(L_vec,pc_corrected_vec,'LineWidth',1 , 'Color',[0 0.6 0]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');

clear all;
pe = 5e-2;
L = 1000;

rep_num = 7;

L_vec = linspace(1 , L , 1000 );
L_vec = unique(round(L_vec));

zero_vote = zeros(rep_num);
one_vote = zeros(rep_num);
pc_vec = zeros(size(L_vec));
pc_corrected_vec = zeros(size(L_vec));

clear j;

for i = 1:numel(L_vec)

    data_sent = randi([0 1], L_vec(i) ,1);
    data_received = custom_bsc( data_sent(:), pe);
    pc_vec(i) = custom_calculate_error(data_sent(:).',data_received(:).');

    data_sent_rep = repelem(data_sent(:),rep_num );
    data_received_rep = custom_bsc( data_sent_rep(:), pe);
    data_received_corrected = 0;

    for j=1:L_vec(i)
        zero_vote = zeros(rep_num );
        one_vote = zeros(rep_num );
        zero_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num *j ).' == 0 );
        one_vote = sum ( data_received_rep ( rep_num*j-(rep_num -1) : rep_num*j ).' == 1 );


        if(zero_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=0;

        elseif(one_vote >= ceil(rep_num/2)  )
            data_received_corrected(j,1)=1;

        end
    end

    pc_corrected_vec(i) = custom_calculate_error(data_sent(:).',data_received_corrected(:).');
    fprintf("i :")
    disp(i);
end


plot(L_vec,pc_corrected_vec,'LineWidth',1 , 'Color',[0 0.4 0]);
xlabel('L_vec','Interpreter','none'); ylabel('pc_vec','Interpreter','none');

grid on;
hold off;
title('Repetition Code ','Interpreter','none');

subtitle(sprintf('Comparison between channel error(pc) and correction error using repetition(pc_corrected)\n pe = %.2f; L = %.2f; L_vec = linspace(1 , L , 1000 );',pe,L),'Interpreter','none');
legend( 'pc_vec','rep_num = 3','rep_num = 5;', 'rep_num = 7;','Interpreter','none');

title(sprintf('Comparing pc and pc corrected according to L and different rep_num '),'Interpreter','none','FontWeight','bold');
subtitle(sprintf('Linegraph'),'Interpreter','none');
