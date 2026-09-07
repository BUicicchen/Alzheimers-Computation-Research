%% Figure 5H ~ 5K data generation

theta = 22.5;
title = "";
[I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);

repulsion_sig_ext_sum = zeros(1,9);
index = 1;
for sig_ext = 10.2:0.1:11.0
    repulsion = mr(sig_ext,12.4,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
    repulsion_sig_ext_sum(index) = repulsion;
    index = index + 1;
    disp(repulsion);
end
% 10.7 -> 11.4 / 26.2781 -> 19.4267

repulsion_sig_inh_sum = zeros(1,9);
index = 1;
for sig_inh = 12.0:0.1:12.8
    repulsion = mr(10.6,sig_inh,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
    repulsion_sig_inh_sum(index) = repulsion;
    index = index + 1;
    disp(repulsion);
end
% 12.0 -> 12.9 / 19.8727 -> 24.9953

repulsion_amp_ext_sum = zeros(1,9);
index = 1;
for amp_ext = 29.2:0.2:30.8
    repulsion = mr(10.6,12.4,amp_ext,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
    repulsion_amp_ext_sum(index) = repulsion;
    index = index + 1;
    disp(repulsion);
end
% 29.2 -> 30.8 / 22.5995 -> 19.1676

repulsion_amp_inh_sum = zeros(1,9);
index = 1;
for amp_inh = 24.2:0.2:25.8
    repulsion = mr(10.6,12.4,30.0,amp_inh,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
    repulsion_amp_inh_sum(index) = repulsion;
    index = index + 1;
    disp(repulsion);
end
% 24.2 -> 25.8 / 19.1676 -> 22.5995

% BASE: 10.6,12.4,30.0,25.0

%% Figure 5H ~ 5K figure generation

figure;
set(gcf,'color','w');

subplot(1,4,1);
scatter(10.2:0.1:11.0,repulsion_sig_ext_sum,'filled')
xlabel('{\sigma}_{ext}','FontSize',16,'FontWeight','bold'); ylabel('Motion Repulsion Representation (deg)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

subplot(1,4,2);
scatter(12.0:0.1:12.8,repulsion_sig_inh_sum,'filled')
xlabel('{\sigma}_{inh}','FontSize',16,'FontWeight','bold'); ylabel('Motion Repulsion Representation (deg','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

subplot(1,4,3);
scatter(29.2:0.2:30.8,repulsion_amp_ext_sum,'filled')
xlabel('{\alpha}_{ext}','FontSize',16,'FontWeight','bold'); ylabel('Motion Repulsion Representation (deg','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

subplot(1,4,4);
scatter(24.2:0.2:25.8,repulsion_amp_inh_sum,'filled')
xlabel('{\alpha}_{inh}','FontSize',16,'FontWeight','bold'); ylabel('Motion Repulsion Representation (deg','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

%% Figure 5A ~ 5G data generation

angles = [0 5.6 11.2 22.5 45 67.5 90 135 180];
Q3_x = [0 5.6 11.2 22.5 45 67.5 90 135 180];

% powerEIRatio: 1.0560 / base
Q3_y_Base = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_Base(i) = mr(10.6,12.4,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
k = 22 / max(Q3_y_Base); % SCALE BASE PEAK TO 22, Old Control's max on literature
Q3_y_Base = Q3_y_Base .* k;

% powerEIRatio: 1.0900 / increase E/I ratio, decrease E & I (decrease I more than E)
Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) = mr(10.4,12.0,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI = Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI .* k;

% powerEIRatio: 1.0762 / increase E/I ratio, increase E & I (increase E more than I)
Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) = mr(11.0,12.5,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI = Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI .* k;

% powerEIRatio: 1.0848 / increase E/I ratio, increase E (increase E)
Q3_y_IncreaseEIRatio_IncreaseE = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_IncreaseEIRatio_IncreaseE(i) = mr(11.0,12.4,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_IncreaseEIRatio_IncreaseE = Q3_y_IncreaseEIRatio_IncreaseE .* k;

% powerEIRatio: 1.1000 / increase E/I ratio, decrease I (decrease I)
Q3_y_IncreaseEIRatio_DecreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_IncreaseEIRatio_DecreaseI(i) = mr(10.6,12.0,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_IncreaseEIRatio_DecreaseI = Q3_y_IncreaseEIRatio_DecreaseI .* k;

% powerEIRatio: 1.1115 / increase E/I ratio, increase E & decrease I
Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i) = mr(10.8,12.2,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI = Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI .* k;

% powerEIRatio: 1.0355 / decrease E/I ratio, decrease E & I (decrease E more than I)
Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i) = mr(10.2,12.3,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI = Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI .* k;

% powerEIRatio: 1.0326 / decrease E/I ratio, increase E & I (increase I more than E)
Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i) = mr(10.7,12.8,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI = Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI .* k;

% powerEIRatio: 1.0272 / decrease E/I ratio, decrease E
Q3_y_DecreaseEIRatio_DecreaseE = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_DecreaseEIRatio_DecreaseE(i) = mr(10.2,12.4,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_DecreaseEIRatio_DecreaseE = Q3_y_DecreaseEIRatio_DecreaseE .* k;

% powerEIRatio: 1.0233 / decrease E/I ratio, increase I
Q3_y_DecreaseEIRatio_IncreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_DecreaseEIRatio_IncreaseI(i) = mr(10.6,12.8,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_DecreaseEIRatio_IncreaseI = Q3_y_DecreaseEIRatio_IncreaseI .* k;

% powerEIRatio: 1.0299 / decrease E/I ratio, decrease E & increase I
Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI = zeros(1,9);
for i = 2:7
    theta = angles(i);
    [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta);
    Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i) = mr(10.4,12.6,30.0,25.0,I,I_x1,I_y1,I_x2,I_y2,title,false,false,theta);
end
Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI = Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI .* k;


%% Figure 5A ~ 5G figure generation

C = linspecer(10);
close all
figure

plot(Q3_x, Q3_y_Base, '-x', 'color', 'k', 'LineWidth', 3); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI, '-o', 'color', C(10,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', C(9,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE, '-o', 'color', C(8,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseI, '-o', 'color', C(7,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI, '-o', 'color', C(6,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', C(1,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI, '-^', 'color', C(2,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE, '-^', 'color', C(3,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_IncreaseI, '-^', 'color', C(4,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI, '-^', 'color', C(5,:), 'LineWidth', 2);
txt1 = "① {\uparrow} E/I ratio ({\downarrow} E {\downarrow} I)";
txt2 = "② {\uparrow} E/I ratio ({\uparrow} E {\uparrow} I)";
txt3 = "③ {\uparrow} E/I ratio ({\uparrow} E)";
txt4 = "④ {\uparrow} E/I ratio ({\downarrow} I)";
txt5 = "⑤ {\uparrow} E/I ratio ({\uparrow} E {\downarrow} I)";
txt6 = "⑥ {\downarrow} E/I ratio ({\downarrow} E {\downarrow} I)";
txt7 = "⑦ {\downarrow} E/I ratio ({\uparrow} E {\uparrow} I)";
txt8 = "⑧ {\downarrow} E/I ratio ({\downarrow} E)";
txt9 = "⑨ {\downarrow} E/I ratio ({\uparrow} I)";
txt10 = "⑩ {\downarrow} E/I ratio ({\downarrow} E {\uparrow} I)";
lgd = legend("BASE", txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9, txt10);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
xlim([0 180]);
xticks(Q3_x);
set(gca, 'FontSize', 16);
box off

figure
plot(Q3_x, Q3_y_Base, '-x', 'color', 'k', 'LineWidth', 3); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI, '-o', 'color', [0.7725 0.1922 0.3176], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', [0.7725 0.1922 0.3176], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE, '-o', 'color', [0.7725 0.1922 0.3176], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseI, '-o', 'color', [0.7725 0.1922 0.3176], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI, '-o', 'color', [0.7725 0.1922 0.3176], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', [0.400000 0.600000 0.800000], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI, '-^', 'color', [0.400000 0.600000 0.800000], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE, '-^', 'color', [0.400000 0.600000 0.800000], 'LineWidth', 2); hold on;
plot(Q3_x+1, Q3_y_DecreaseEIRatio_IncreaseI, '-^', 'color', [0.400000 0.600000 0.800000], 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI, '-^', 'color', [0.400000 0.600000 0.800000], 'LineWidth', 2);
txt1 = "{\uparrow} E/I ratio";
txt2 = "";
txt3 = "";
txt4 = "";
txt5 = "";
txt6 = "{\downarrow} E/I ratio";
txt7 = "";
txt8 = "";
txt9 = "";
txt10 = "";
lgd = legend("BASE", txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9, txt10);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
xlim([0 180]);
xticks(Q3_x);
set(gca, 'FontSize', 16);
box off

figure
plot(Q3_x, Q3_y_Base, '-x', 'color', 'k', 'LineWidth', 3); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', C(8,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', C(8,:), 'LineWidth', 2); hold on;
plot(Q3_x+1, Q3_y_DecreaseEIRatio_IncreaseI, '-o', 'color', C(8,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI, '-o', 'color', C(8,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', C(1,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseI, '-^', 'color', C(1,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI, '-^', 'color', C(1,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', C(1,:), 'LineWidth', 2);
txt1 = "{\uparrow} I";
txt2 = "";
txt3 = "";
txt4 = "";
txt5 = "{\downarrow} I";
txt6 = "";
txt7 = "";
txt8 = "";
lgd = legend("BASE", txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
xlim([0 180]);
xticks(Q3_x);
set(gca, 'FontSize', 16);
box off

figure
plot(Q3_x, Q3_y_Base, '-x', 'color', 'k', 'LineWidth', 3); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', C(7,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE, '-o', 'color', C(7,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI, '-o', 'color', C(7,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI, '-o', 'color', C(7,:), 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', "#77AC30", 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI, '-^', 'color', "#77AC30", 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE, '-^', 'color', "#77AC30", 'LineWidth', 2); hold on;
plot(Q3_x, Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI, '-^', 'color', "#77AC30", 'LineWidth', 2); hold on;
txt1 = "{\uparrow} E";
txt2 = "";
txt3 = "";
txt4 = "";
txt5 = "{\downarrow} E";
txt6 = "";
txt7 = "";
txt8 = "";
lgd = legend("BASE", txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
xlim([0 180]);
xticks(Q3_x);
set(gca, 'FontSize', 16);
box off


%% Table 3 data generation - Standard Error of Mean

% list of scenarios:
% Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI, Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI, Q3_y_IncreaseEIRatio_IncreaseE, Q3_y_IncreaseEIRatio_DecreaseI, Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI, 
% Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI, Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI, Q3_y_DecreaseEIRatio_DecreaseE, Q3_y_DecreaseEIRatio_IncreaseI, Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI

x = Q3_x;
y_base = Q3_y_Base;
y_increase_ratio = zeros(1,9);
y_decrease_ratio = zeros(1,9);
y_increase_I = zeros(1,9);
y_decrease_I = zeros(1,9);
y_increase_E = zeros(1,9);
y_decrease_E = zeros(1,9);
err_base = zeros(1,9);
err_increase_ratio = zeros(1,9);
err_decrease_ratio = zeros(1,9);
err_increase_I = zeros(1,9);
err_decrease_I = zeros(1,9);
err_increase_E = zeros(1,9);
err_decrease_E = zeros(1,9);

figure
plot(x, y_base, '-x', 'color', 'k', 'LineWidth', 2);
xticks(Q3_x);
hold on
for i = 1:9
    y_increase_ratio(1,i) = mean([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE(i) Q3_y_IncreaseEIRatio_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i)]);
    err_increase_ratio(1,i) = std([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE(i) Q3_y_IncreaseEIRatio_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i)]) / (sqrt(5)*2);
end
errorbar(x, y_increase_ratio, err_increase_ratio, '-o', 'color', C(4,:), 'LineWidth', 2);
hold on
for i = 1:9
    y_decrease_ratio(1,i) = mean([Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE(i) Q3_y_DecreaseEIRatio_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]);
    err_decrease_ratio(1,i) = std([Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE(i) Q3_y_DecreaseEIRatio_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]) / (sqrt(5)*2);
end
errorbar(x, y_decrease_ratio, err_decrease_ratio, '-^', 'color', C(3,:), 'LineWidth', 2);
txt1 = "{\uparrow} E/I ratio";
txt2 = "{\downarrow} E/I ratio";
lgd = legend("BASE", txt1, txt2);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
box off

figure
plot(x, y_base, '-x', 'color', 'k', 'LineWidth', 2);
xticks(Q3_x);
hold on
for i = 1:9
    y_increase_I(1,i) = mean([Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]);
    err_increase_I(1,i) = std([Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_DecreaseEIRatio_IncreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]) / (sqrt(4)*2);
end
errorbar(x, y_increase_I, err_increase_I, '-o', 'color', C(8,:), 'LineWidth', 2);
hold on
for i = 1:9
    y_decrease_I(1,i) = mean([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_IncreaseEIRatio_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i)]);
    err_decrease_I(1,i) = std([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_IncreaseEIRatio_DecreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i)]) / (sqrt(4)*2);
end
errorbar(x, y_decrease_I, err_decrease_I, '-^', 'color', C(7,:), 'LineWidth', 2);
txt3 = "{\uparrow} I";
txt4 = "{\downarrow} I";
lgd = legend("BASE", txt3, txt4);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
box off

figure
plot(x, y_base, '-x', 'color', 'k', 'LineWidth', 2);
xticks(Q3_x);
hold on
for i = 1:9
    y_increase_E(1,i) = mean([Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i)]);
    err_increase_E(1,i) = std([Q3_y_IncreaseEIRatio_IncreaseE_IncreaseI(i) Q3_y_IncreaseEIRatio_IncreaseE(i) Q3_y_IncreaseEIRatio_IncreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_IncreaseE_IncreaseI(i)]) / (sqrt(4)*2);
end
errorbar(x, y_increase_E, err_increase_E, '-o', 'color', C(2,:), 'LineWidth', 2);
hold on
for i = 1:9
    y_decrease_E(1,i) = mean([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]);
    err_decrease_E(1,i) = std([Q3_y_IncreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE_DecreaseI(i) Q3_y_DecreaseEIRatio_DecreaseE(i) Q3_y_DecreaseEIRatio_DecreaseE_IncreaseI(i)]) / (sqrt(4)*2);
end
errorbar(x, y_decrease_E, err_decrease_E, '-^', 'color', C(1,:), 'LineWidth', 2);
txt5 = "{\uparrow} E";
txt6 = "{\downarrow} E";
lgd = legend("BASE", txt5, txt6);
lgd.FontSize = 14;
lgd.FontWeight = 'bold';
set(lgd, 'FontName', 'Arial');
box off

%% ---------------- Scatterplot ext power v.s. inh power ----------------
figure
scatter([36, 48.3, 44, 37.8, 32.25], [3.61, 8.8, 10.5, 4, 10.25], '^', 'MarkerFaceColor', 'b');
hold on
scatter([36.1, 76.8, 44, 50.6, 47.25], [2.72, 6.3, 3.705, 4, 3.705], 'o', 'MarkerFaceColor', 'r');
hold on
m = 4/44;
y_endpoint80 = m * 80 + 0;
plot(44, 4, 'x', 'color', 'k', 'LineWidth', 2);
hold on
plot([0 44 80],[0 4 y_endpoint80], 'color', 'k');
xlabel('{power}_{inh}','FontSize',18,'FontWeight','bold');
ylabel('{power}_{ext}','FontSize',18,'FontWeight','bold');
% xlim([0 80]);
ylim([2 11]);
legend({'{\uparrow} E/I ratio','{\downarrow} E/I ratio','BASE',''},'FontSize',18)

