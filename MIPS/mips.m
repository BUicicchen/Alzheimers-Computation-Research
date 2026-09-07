function [S1,S2,x_change,slope,weightedXY,normalizedXY,sum_x,sum_y,sum_xy,delta_x,mean_y] = mips( ...
    sig_ext1, sig_inh1, sig_ext2, sig_inh2, ...
    sig_ext1_recurrence, sig_inh1_recurrence, sig_ext2_recurrence, sig_inh2_recurrence, ...
    amp_ext1, amp_inh1, amp_ext2, amp_inh2, ...
    amp_ext1_recurrence, amp_inh1_recurrence, amp_ext2_recurrence, amp_inh2_recurrence, ...
    I1, I2, title_of_graph, hasRecurrenceLayer1, hasRecurrenceLayer2, feedback, gating)

    close all
    
    time = 449;
    A = 0.5; % decay rate
    B = 90; % upper bound for depolarization threshold
    D = 10; % lower bound for hyperpolarization threshold
    S1 = zeros(1450,time); % 454ms
    S2 = zeros(1450,time); % 454ms
    S1_2nd = zeros(1450,time); % 240ms
    S2_2nd = zeros(1450,time); % 240ms
    dt = 0.05;
    constant = 1;
    
    k_ext1 = 0.0080;
    g_ext1 = fspecial('gaussian',[1 1450],sig_ext1);
    ext1_norm = g_ext1 ./ max(g_ext1);
    ext1 = (ext1_norm * k_ext1) .* amp_ext1;
    k_inh1 = 0.0040;
    g_inh1 = fspecial('gaussian',[1 1450],sig_inh1);
    inh1_norm = g_inh1 ./ max(g_inh1);
    inh1 = (inh1_norm * k_inh1) * amp_inh1;
    k_ext2 = 0.0080;
    g_ext2 = fspecial('gaussian',[1 1450],sig_ext2);
    ext2_norm = g_ext2 ./ max(g_ext2);
    ext2 = (ext2_norm * k_ext2) * amp_ext2;
    k_inh2 = 0.0040;
    g_inh2 = fspecial('gaussian',[1 1450],sig_inh2);
    inh2_norm = g_inh2 ./ max(g_inh2);
    inh2 = (inh2_norm * k_inh2) * amp_inh2;
    k_ext1_recurrence = 0.099;
    g_ext1_recurrence = fspecial('gaussian',[1 1450],sig_ext1_recurrence);
    ext1_recurrence_norm = g_ext1_recurrence ./ max(g_ext1_recurrence);
    ext1_recurrence = (ext1_recurrence_norm * k_ext1_recurrence) * amp_ext1_recurrence;
    k_inh1_recurrence = 0.0249;
    g_inh1_recurrence = fspecial('gaussian',[1 1450],sig_inh1_recurrence);
    inh1_recurrence_norm = g_inh1_recurrence ./ max(g_inh1_recurrence);
    inh1_recurrence = (inh1_recurrence_norm * k_inh1_recurrence) * amp_inh1_recurrence;
    k_ext2_recurrence = 0.099;
    g_ext2_recurrence = fspecial('gaussian',[1 1450],sig_ext2_recurrence);
    ext2_recurrence_norm = g_ext2_recurrence ./ max(g_ext2_recurrence);
    ext2_recurrence = (ext2_recurrence_norm * k_ext2_recurrence) * amp_ext2_recurrence;
    k_inh2_recurrence = 0.0249;
    g_inh2_recurrence = fspecial('gaussian',[1 1450],sig_inh2_recurrence);
    inh2_recurrence_norm = g_inh2_recurrence ./ max(g_inh2_recurrence);
    inh2_recurrence = (inh2_recurrence_norm * k_inh2_recurrence) * amp_inh2_recurrence;
    recurrence1 = (amp_ext1_recurrence .* ext1_recurrence) - (amp_inh1_recurrence .* inh1_recurrence); % for recurrence of 1st layer
    recurrence2 = (amp_ext2_recurrence .* ext2_recurrence) - (amp_inh2_recurrence .* inh2_recurrence); % for recurrence of 2nd layer
    
    % --- GET PEAKS & polynomial fit ---
    firstPeak_x1 = zeros(1,time);
    secondPeak_x1 = zeros(1,time);
    thirdPeak_x1 = zeros(1,time);
    firstPeak_y1 = zeros(1,time);
    secondPeak_y1 = zeros(1,time);
    thirdPeak_y1 = zeros(1,time);
    currentPeakVal = 0;
    
%     --- print ext v.s. inh gaussian ---
%     figure
%     hold on
%     plot(ext1,'b'); % degree of visual angle: 1/sig_ext1
%     hold on
%     plot(inh1,'r');
%     legend('ext1','inh1')
%     hold off
%     set(gcf,'name',title_of_graph,'numbertitle','off')
    
    
    for t = 2:time
        ds_dt1 = zeros(1,1450); ds_dt2 = zeros(1,1450);
        
        
        
        % layer 1, yes recurrence
        ds_dt1 = (-A*S1(:,t-1)) + (B-S1(:,t-1))*constant.*(conv(I1(:,t),ext1,'same')+conv(0.01.*S1_2nd(:,t-1),ext1,'same'))...
                                - (D+S1(:,t-1))*constant.*(conv(I1(:,t),inh1,'same')+conv(0.01.*S1_2nd(:,t-1),inh1,'same'))...
                                + (conv(S1(:,t-1),recurrence1,'same'));
        S1(:,t) = S1(:,t-1) + ds_dt1 .* dt;

        % layer 2, yes recurrence
        ds_dt_2nd1 = (-A*S1_2nd(:,t-1)) + (B-S1_2nd(:,t-1))*constant.*conv(0.01.*S1(:,t),ext2,'same')...
                                        - (D+S1_2nd(:,t-1))*constant.*conv(0.01.*S1(:,t),inh2,'same')...
                                        + (conv(S1_2nd(:,t-1),recurrence2,'same'));
        S1_2nd(:,t) = S1_2nd(:,t-1) + ds_dt_2nd1 .* dt;
        
        
        % --- DISPLAY SIMULATION ANIMATION ---
% %         if t < 80
%         figure(2);
%         hold on
%         x = 1:1:1450;
%         plot(x,S1(:,t),'b'); % degree of visual angle: 1/sig_ext1
% %         plot(x,S2(:,t),'r'); % degree of visual angle: 1/sig_ext1
% %         plot(x,I1(:,t)*50);
% %         set(gcf,'name',title_of_graph,'numbertitle','off')
%         title(num2str(t));
%         set(gca,"FontSize",16);
%         xlabel("Neuron Number", 'FontSize', 20);
%         ylabel("Neuronal Activity", 'FontSize', 20);
%         xlim([250,1250]);
% %         end

        % --- GET PEAKS & polynomial fit ---
        % --- RIGHT ---
        minmax1 = find(islocalmax(S1(501:950,t)));
        
        for i = 1:length(minmax1)
            if t == 2       % to determine location of first peak
                if 224 <= minmax1(i) && minmax1(i) <= 228
%                 if 127 <= minmax1(i) && minmax1(i) <= 131
                    currentPeakVal = minmax1(i);
                    firstPeak_x1(t) = minmax1(i) + 500;
                    firstPeak_y1(t) = S1(firstPeak_x1(t),t);
%                     disp("time "+t);
%                     disp("currentPeakVal: "+currentPeakVal);
                end
            else           % to determine location of next peak based on previous peak
                if currentPeakVal - 2 <= minmax1(i) && minmax1(i) <= currentPeakVal + 2
                    currentPeakVal = minmax1(i);
                    firstPeak_x1(t) = minmax1(i) + 500;
                    firstPeak_y1(t) = S1(firstPeak_x1(t),t);
%                     disp("time "+t);
%                     disp("currentPeakVal: "+currentPeakVal);
                end
            end
        end
    end

%     % peak tracing dots figure
%     figure
% %     plot(firstPeak_x1(2:31),firstPeak_y1(2:31),'o');
%     plot(firstPeak_x1,firstPeak_y1,'r.', 'MarkerSize', 15, 'color', [0.870000 0.190000 0.390000, 0.8]);
%     xlim([700,850]);
%     ylim([0,4.6]);
%     set(gca,"FontSize",24);
%     xlabel("Neuron Number", 'FontSize', 30);
%     ylabel("Neuronal Activity", 'FontSize', 30);
% %     figure
% %     plot(firstPeak_x1(2:31),firstPeak_y1(2:31),'o');
% %     set(gca,"FontSize",16);
% %     xlabel("Neuron Number", 'FontSize', 20);
% %     ylabel("Neuronal Activity", 'FontSize', 20);
% %     disp(firstPeak_x1);
% %     xlim([600,850]);


%     --- GET PEAKS & polynomial fit ---
    endpoint = 60;
%     disp(length(firstPeak_x1));
    firstPeak_x1_bipartite = firstPeak_x1(2:endpoint+1);
    firstPeak_y1_bipartite = firstPeak_y1(2:endpoint+1);
    start_point_x = firstPeak_x1_bipartite(1);
    start_point_y = firstPeak_y1_bipartite(1);
    if length(firstPeak_x1_bipartite) < endpoint
        x_change = 0;
        slope = 0;
        weightedXY = 0;
        normalizedXY = 0;
    else
        end_point_x = firstPeak_x1_bipartite(endpoint);
        end_point_y = firstPeak_y1_bipartite(endpoint);
        x_change = end_point_x - start_point_x;
    %     disp("change in x:")
    %     disp(x_change)
    %     disp('end to start point slope (y2-y1)/(x2-x1):')
        slope = (end_point_y - start_point_y) / (end_point_x - start_point_x);
    %     disp(slope)
    %     disp("xfyf - xiyi: " + end_point_x + " * " + end_point_y + " - " + start_point_x + " * " + start_point_y)
        weightedXY = end_point_x*end_point_y - start_point_x*start_point_y;
    %     disp(weightedXY)
    %     disp("sum(xiyi) / sum(yi)")
%         normalizedXY = sum(firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint))/sum(firstPeak_y1_bipartite(1:endpoint));
%         normalizedXY = sum(firstPeak_x1_bipartite(1:endpoint))/sum(firstPeak_y1_bipartite(1:endpoint));
%         normalizedXY = (firstPeak_x1_bipartite(endpoint) - firstPeak_x1_bipartite(1)) / mean(firstPeak_y1_bipartite(1:endpoint));
%         normalizedXY = 8 / mean(firstPeak_y1_bipartite(1:endpoint));
        normalizedXY = 8 / (firstPeak_y1_bipartite(endpoint) - firstPeak_y1_bipartite(1));
%         normalizedXY = (end_point_y - start_point_y) / (end_point_x - start_point_x);
%         disp("sig_inh1 = "+sig_inh1+"");
%         disp(normalizedXY+"")
%         disp("sum(x): " + sum(firstPeak_x1_bipartite(1,endpoint)) + " , sum(y): " + sum(firstPeak_y1_bipartite(1,endpoint)));
%         disp("normalizedXY: " + sum(firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint)) + " / " + sum(firstPeak_y1_bipartite(1:endpoint)) + " = " + sum(firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint))/sum(firstPeak_y1_bipartite(1:endpoint)));
%         disp("firstPeak_x1_bipartite:");
%         disp(firstPeak_x1_bipartite);
%         disp("firstPeak_y1_bipartite:");
%         disp(firstPeak_y1_bipartite);
        sum_x = sum(firstPeak_x1_bipartite(1,endpoint));
        sum_y = sum(firstPeak_y1_bipartite(1,endpoint));
        sum_xy = sum(firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint));
        delta_x = firstPeak_x1_bipartite(endpoint) - firstPeak_x1_bipartite(1);
        mean_y = mean(firstPeak_y1_bipartite(1:endpoint));
%         disp("normalizedXY: " + sum(firstPeak_x1_bipartite(1:endpoint)) + " / " + sum(firstPeak_y1_bipartite(1:endpoint)) + " = " + normalizedXY);
%         if sig_inh1 == 64
%             figure
%             scatter(1:30, firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint) ./ sum(firstPeak_y1_bipartite(1:endpoint)));
%             disp(firstPeak_x1_bipartite(1:endpoint).*firstPeak_y1_bipartite(1:endpoint) ./ sum(firstPeak_y1_bipartite(1:endpoint)));
%         end
    end
end
