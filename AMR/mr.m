function [repulsion, S, s] = mr(sig_ext, sig_inh, amp_ext, amp_inh, I, I_xh_lst, I_yh_lst, I_xd_lst, I_yd_lst, title_of_graph, hasRecurrence, feedback, theta)
    close all
    
    A = 5; % decay rate
    B = 90; % upper bound for depolarization threshold
    D = 10; % lower bound for hyperpolarization threshold
    S = zeros(400,400,80); % 80ms
    S_2nd = zeros(400,400,80); % 80ms
    dt = 0.05;
    constant = 0.001;
    
    M(80) = struct('cdata',[],'colormap',[]);
    [X,Y] = meshgrid((1:400),(1:400));

    g_ext = fspecial('gaussian',[200 200],sig_ext);
    k_ext = amp_ext ./ max(max(g_ext));
    ext = g_ext .* k_ext .* constant;
    g_inh = fspecial('gaussian',[200 200],sig_inh);
    k_inh = amp_inh ./ max(max(g_inh));
    inh = g_inh .* k_inh .* constant .* 9;
    recurrence = ((amp_ext .* ext) - (amp_inh .* inh)) .* constant;
    
    max_vals_1 = zeros(1,80);
    max_vals_2 = zeros(1,80);
    
    for t = 2:80
        ds_dt = (-A*S(:,:,t-1)) + (B-S(:,:,t-1))*constant.*(conv2(I(:,:,t),ext,'same')+conv2(S_2nd(:,:,t-1),ext,'same'))...
                                - (D+S(:,:,t-1))*constant.*(conv2(I(:,:,t),inh,'same')+conv2(S_2nd(:,:,t-1),inh,'same'))...
                                + (conv2(S(:,:,t-1),recurrence,'same'));
        S(:,:,t) = S(:,:,t-1) + ds_dt .* dt;

        ds_dt = (-A*S_2nd(:,:,t-1)) + (B-S_2nd(:,:,t-1))*constant.*conv2(S(:,:,t),ext,'same')...
                                    - (D+S_2nd(:,:,t-1))*constant.*conv2(S(:,:,t),inh,'same')...
                                    + (conv2(S_2nd(:,:,t-1),recurrence,'same'));
        S_2nd(:,:,t) = S_2nd(:,:,t-1) + ds_dt .* dt;
        
        disp(t)

        % layer 1 quantification
        if t <= 80
            if t <= 40
                [max_1,index_1] = max(S(200:400,I_xh_lst(t),t));
                [max_2,index_2] = max(S(1:200,round(I_xd_lst(t)),t));

                if max_vals_1(t-1) == 200 && (abs(index_1+199-max_vals_1(t-1)) > 0 && abs(index_1+199-max_vals_1(t-1)) <= 4 && abs(index_2-max_vals_2(t-1)) < 2) && (theta >= 22.5 && theta < 90)
                    max_vals_1(t) = 200;
                elseif (abs(index_1+199-max_vals_1(t-1)) > 70 && t > 2) && (theta ~= 135 && theta ~= 180)
                    [max_1,index_1] = max(S(max_vals_1(t-1)-10:max_vals_1(t-1)+10,I_xh_lst(t),t));
                    max_vals_1(t) = index_1 + max_vals_1(t-1)-10;
                else
                    max_vals_1(t) = index_1 + 199;
                end

                if max_vals_2(t-1) == 200 && (abs(index_2-max_vals_2(t-1)) > 0 && abs(index_2-max_vals_2(t-1)) <= 4 && abs(index_1+199-max_vals_1(t-1)) < 2) && (theta >= 22.5 && theta < 90)
                    max_vals_2(t) = 200;
                elseif (abs(index_2-max_vals_2(t-1)) > 70 && t > 2) && (theta ~= 135 && theta ~= 180)
                    [max_2,index_2] = max(S(max_vals_2(t-1)-10:max_vals_2(t-1)+10,round(I_xd_lst(t)),t));
                    max_vals_2(t) = index_2 + max_vals_2(t-1)-10;
                else
                    max_vals_2(t) = index_2;
                end
            else
                [max_1,index_1] = max(S(1:200,I_xh_lst(t),t));
                [max_2,index_2] = max(S(200:400,round(I_xd_lst(t)),t));

                if max_vals_1(t-1) == 200 && (abs(index_1-max_vals_1(t-1)) > 0 && abs(index_1-max_vals_1(t-1)) <= 4 && abs(index_2+199-max_vals_2(t-1)) < 2) && (theta >= 22.5 && theta < 90)
                    max_vals_1(t) = 200;
                elseif (abs(index_1-max_vals_1(t-1)) > 70 && t > 2) && (theta ~= 135 && theta ~= 180)
                    [max_1,index_1] = max(S(max_vals_1(t-1)-10:min(200,max_vals_1(t-1)+10),I_xh_lst(t),t));
                    max_vals_1(t) = index_1 + max_vals_1(t-1)-10;
                else
                    max_vals_1(t) = index_1;
                end
                
                if max_vals_2(t-1) == 200 && (abs(index_2+199-max_vals_2(t-1)) > 0 && abs(index_2+199-max_vals_2(t-1)) <= 4 && abs(max_vals_1(t)-max_vals_1(t-1)) < 2) && (theta >= 22.5 && theta < 90)
                    max_vals_2(t) = 200;
                elseif (abs(index_2+199-max_vals_2(t-1)) > 70 && t > 2) && (theta ~= 135 && theta ~= 180)
                    [max_2,index_2] = max(S(max(200,max_vals_2(t-1)-10):max_vals_2(t-1)+10,round(I_xd_lst(t)),t));
                    max_vals_2(t) = index_2 + max(200,max_vals_2(t-1)-10);
                else
                    max_vals_2(t) = index_2 + 199;
                end
            end
        end
        
%         surf(X,Y,S(:,:,t)); % 3D view
%         % zlim([-0.1 0.5]);
% %         zlim([-0.001 0.004]);
%         % pcolor(X,Y,S(:,:,t)); % bird's eye view
%         set(gcf,'name',title_of_graph,'numbertitle','off')
%         axis square
%         title(num2str(t));
%         xlabel('Neuron number')
%         ylabel('Neuron number')
%         zlabel('Neuronal response')
% %         zlim([0 0.1]);
% %         zlim([-0.5 0.7]);
%         shading interp
%         drawnow
%         M(t-1) = getframe;
    end
    
    % Quantification #3: Angle
    before_crossing = []; % for Q3, the dot right before crossing the expected angle trajectory (red line)
    release = false; % for Q3
    after_crossing = []; % for Q3
    for i = 2:length(max_vals_1) - 1
        if (i > 40)
            % for Q2 & Q3
            x = i * 5;
            if max_vals_2(i) == 200 && max_vals_2(i+1) ~= 200 && release == false
                before_crossing = [x max_vals_2(i)];
                release = true;
            elseif release == true && length(after_crossing) < 8
                after_crossing = [after_crossing; [x max_vals_2(i)]]; % for Q3
            end
        end
    end
    
    % Quantification (add weight to length of attraction) (multiple by different alpha for each of the 4 release points)
    alpha_1 = 0.05; alpha_2 = 0.05; alpha_3 = 0.4; alpha_4 = 0.5;
    try
        start = 200/5; last = before_crossing(1)/5;
        angle_diff = zeros(1,8);
        current_attract_point = last;
        for i = 1:length(after_crossing) % only for angle from before_crossing to dots after_crossing
            weight_attraction = round((current_attract_point-40) * 0.3); % weight of 30% for the length of attraction
            attract_point = (current_attract_point - weight_attraction);
            alpha = atand((after_crossing(i,2)-max_vals_2(attract_point))/(after_crossing(i,1)-attract_point*5));
            temp = (alpha - theta/2) * 2;
            angle_diff(i) = temp;
        end
        repulsion = angle_diff(1)*alpha_1 + angle_diff(2)*alpha_2 + angle_diff(3)*alpha_3 + angle_diff(4)*alpha_4;
    catch
        repulsion = 0;
    end

    % response star fig
    figure;
    plot(I_xd_lst, I_yd_lst, '-', 'MarkerEdgeColor','b')
    hold on
    plot(I_xh_lst, I_yh_lst, '-', 'MarkerEdgeColor','r')
    hold on
    plot(I_xh_lst, max_vals_1, '*', 'MarkerEdgeColor','b')
    hold on
    plot(I_xd_lst, max_vals_2, '*', 'MarkerEdgeColor','r')
    legend('Reference Trajectory','Test Trajectory','Reference Trajectory Response','Test Trajectory Response')
    xlim([0 400])
    ylim([0 400])
    axis square
end