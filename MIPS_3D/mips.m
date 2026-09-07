function [S1,S2,normalizedXY] = mips( ...
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
    firstPeak_y1 = zeros(1,time);
    currentPeakVal = 0;

    for t = 2:time
        ds_dt1 = zeros(1,1450); ds_dt2 = zeros(1,1450);

        % layer 1, yes recurrence
        ds_dt1 = (-A*S1(:,t-1)) + (B-S1(:,t-1))*constant.*(conv(I1(:,t),ext1,'same')+conv(0.01.*S1_2nd(:,t-1),ext1,'same'))...
                                - (D+S1(:,t-1))*constant.*(conv(I1(:,t),inh1,'same')+conv(0.01.*S1_2nd(:,t-1),inh1,'same'))...
                                + (conv(S1(:,t-1),recurrence1,'same'));
        ds_dt2 = (-A*S2(:,t-1)) + (B-S2(:,t-1))*constant.*(conv(I2(:,t),ext1,'same')+conv(0.01.*S2_2nd(:,t-1),ext1,'same'))...
                                - (D+S2(:,t-1))*constant.*(conv(I2(:,t),inh1,'same')+conv(0.01.*S2_2nd(:,t-1),inh1,'same'))...
                                + (conv(S2(:,t-1),recurrence1,'same'));
        S1(:,t) = S1(:,t-1) + ds_dt1 .* dt;
        S2(:,t) = S2(:,t-1) + ds_dt2 .* dt;

        % layer 2, yes recurrence
        ds_dt_2nd1 = (-A*S1_2nd(:,t-1)) + (B-S1_2nd(:,t-1))*constant.*conv(0.01.*S1(:,t),ext2,'same')...
                                        - (D+S1_2nd(:,t-1))*constant.*conv(0.01.*S1(:,t),inh2,'same')...
                                        + (conv(S1_2nd(:,t-1),recurrence2,'same'));
        ds_dt_2nd2 = (-A*S2_2nd(:,t-1)) + (B-S2_2nd(:,t-1))*constant.*conv(0.01.*S2(:,t),ext2,'same')...
                                        - (D+S2_2nd(:,t-1))*constant.*conv(0.01.*S2(:,t),inh2,'same')...
                                        + (conv(S2_2nd(:,t-1),recurrence2,'same'));
        S1_2nd(:,t) = S1_2nd(:,t-1) + ds_dt_2nd1 .* dt;
        S2_2nd(:,t) = S2_2nd(:,t-1) + ds_dt_2nd2 .* dt;
        
        % --- GET PEAKS & polynomial fit ---
        % --- RIGHT ---
        minmax1 = find(islocalmax(S1(501:950,t)));
        
        for i = 1:length(minmax1)
            if t == 2       % to determine location of first peak
                if 224 <= minmax1(i) && minmax1(i) <= 228
                    currentPeakVal = minmax1(i);
                    firstPeak_x1(t) = minmax1(i) + 500;
                    firstPeak_y1(t) = S1(firstPeak_x1(t),t);
                end
            else           % to determine location of next peak based on previous peak
                if currentPeakVal - 2 <= minmax1(i) && minmax1(i) <= currentPeakVal + 2
                    currentPeakVal = minmax1(i);
                    firstPeak_x1(t) = minmax1(i) + 500;
                    firstPeak_y1(t) = S1(firstPeak_x1(t),t);
                end
            end
        end
    end

%     --- GET PEAKS & polynomial fit ---
    endpoint = 60;
    firstPeak_x1_bipartite = firstPeak_x1(2:endpoint+1);
    firstPeak_y1_bipartite = firstPeak_y1(2:endpoint+1);
    if length(firstPeak_x1_bipartite) < endpoint
        normalizedXY = 0;
    else
        normalizedXY = 8 / (firstPeak_y1_bipartite(endpoint) - firstPeak_y1_bipartite(1));
    end
end
