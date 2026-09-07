input_stimulus1 = mips_input("right");
input_stimulus2 = mips_input("left");

%% Figure 4A ~ 4H data generation

% ----------------- 1) sig_ext1 -----------------
x_change_lst_sig_ext1 = zeros(80,1);
slope_lst_sig_ext1 = zeros(80,1);
weightedXY_lst_sig_ext1 = zeros(80,1);
normalizedXY_lst_sig_ext1 = zeros(80,1);
amp_ext1 = 1.01;
for sig_ext1 = 11:90
    title_temp = strcat('sig_ext1 = ', num2str(sig_ext1), ' sig_inh1 = 80');
    [S1,S2,x_change,slope,weightedXY,normalizedXY,inputDisp] = mips(sig_ext1,100,50,100,...
                                    4,16,4,16,...
                                    amp_ext1,1,1,1, ...
                                    1,1,1,1, ...
                                    input_stimulus1,input_stimulus2,...
                                    title_temp,true,true,true,false);
    x_change_lst_sig_ext1(sig_ext1-10,1) = x_change;
    slope_lst_sig_ext1(sig_ext1-10,1) = slope;
    weightedXY_lst_sig_ext1(sig_ext1-10,1) = weightedXY;
    normalizedXY_lst_sig_ext1(sig_ext1-10,1) = normalizedXY;
    amp_ext1 = amp_ext1 + 0.01;
end
figure;
x_sig_ext1 = linspace(11,90,80);
% construct amp vector used during the sig_ext1 sweep: starts at 1.01, step 0.01
amp_ext1_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_ext1)-1));
% power (x * amp) used as x-axis
x_power_sig_ext1 = x_sig_ext1 .* amp_ext1_vec;
subplot(8,4,1);
y_sig_ext1_x_change = x_change_lst_sig_ext1;
scatter(x_power_sig_ext1,y_sig_ext1_x_change,'filled')
subplot(8,4,2);
y_sig_ext1_slope = slope_lst_sig_ext1;
scatter(x_power_sig_ext1,y_sig_ext1_slope,'filled')
subplot(8,4,3);
y_sig_ext1_weightedXY = weightedXY_lst_sig_ext1;
scatter(x_power_sig_ext1,y_sig_ext1_weightedXY,'filled')
subplot(8,4,4);
y_sig_ext1_normalizedXY = normalizedXY_lst_sig_ext1;
scatter(x_power_sig_ext1,y_sig_ext1_normalizedXY,'filled')

% ----------------- 2) sig_inh1 -----------------
x_change_lst_sig_inh1 = zeros(80,1);
slope_lst_sig_inh1 = zeros(80,1);
weightedXY_lst_sig_inh1 = zeros(80,1);
normalizedXY_lst_sig_inh1 = zeros(80,1);
amp_inh1 = 1.01;
sum_x_list = zeros(1,80);
sum_y_list = zeros(1,80);
sum_xy_list = zeros(1,80);
for sig_inh1 = 61:140
    title_temp = strcat('sig_ext1 = 50 sig_inh1 = ', num2str(sig_inh1));
    [S1,S2,x_change,slope,weightedXY,normalizedXY,sum_x,sum_y,sum_xy] = mips(50,sig_inh1,50,100,...
                                      4,16,4,16,...
                                      1,amp_inh1,1,1, ...
                                      1,1,1,1, ...
                                      input_stimulus1,input_stimulus2,...
                                      title_temp,true,true,true,false);
    x_change_lst_sig_inh1(sig_inh1-60,1) = x_change;
    slope_lst_sig_inh1(sig_inh1-60,1) = slope;
    weightedXY_lst_sig_inh1(sig_inh1-60,1) = weightedXY;
    normalizedXY_lst_sig_inh1(sig_inh1-60,1) = normalizedXY;
    amp_inh1 = amp_inh1 + 0.01;

    sum_x_list(1,sig_inh1-60) = sum_x;
    sum_y_list(1,sig_inh1-60) = sum_y;
    sum_xy_list(1,sig_inh1-60) = sum_xy;
end
x_sig_inh1 = linspace(61,140,80);
% amp vector and power axis for sig_inh1 sweep
amp_inh1_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_inh1)-1));
x_power_sig_inh1 = x_sig_inh1 .* amp_inh1_vec;
sgtitle('Varying sig_{inh}1')
subplot(8,4,5);
y_sig_inh1_x_change = x_change_lst_sig_inh1;
scatter(x_power_sig_inh1,y_sig_inh1_x_change,'filled')
subplot(8,4,6);
y_sig_inh1_slope = slope_lst_sig_inh1;
scatter(x_power_sig_inh1,y_sig_inh1_slope,'filled')
subplot(8,4,7);
y_sig_inh1_weightedXY = weightedXY_lst_sig_inh1;
scatter(x_power_sig_inh1,y_sig_inh1_weightedXY,'filled')
subplot(8,4,8);
y_sig_inh1_normalizedXY = normalizedXY_lst_sig_inh1;
scatter(x_power_sig_inh1,y_sig_inh1_normalizedXY,'filled')

% ----------------- 3) sig_ext1_recurrence -----------------
x_change_lst_sig_ext1_recurrence = zeros(80,1);
slope_lst_sig_ext1_recurrence = zeros(80,1);
weightedXY_lst_sig_ext1_recurrence = zeros(80,1);
normalizedXY_lst_sig_ext1_recurrence = zeros(80,1);
amp_ext1_recurrence = 1.01;
delta_x_list = zeros(1,80);
mean_y_list = zeros(1,80);
for sig_ext1_recurrence = 0.1:0.1:8.0
    title_temp = strcat('sig_ext1_recurrence = ', num2str(sig_ext1_recurrence), ' sig_inh1_recurrence = 16');
    [S1,S2,x_change,slope,weightedXY,normalizedXY,sum_x,sum_y,sum_xy,delta_x,mean_y] = mips(50,100,50,100,...
                                      sig_ext1_recurrence,16,4,16,...
                                      1,1,1,1, ...
                                      amp_ext1_recurrence,1,1,1, ...
                                      input_stimulus1,input_stimulus2,...
                                      title_temp,true,true,true,false);
    x_change_lst_sig_ext1_recurrence(int64(sig_ext1_recurrence*10),1) = x_change;
    slope_lst_sig_ext1_recurrence(int64(sig_ext1_recurrence*10),1) = slope;
    weightedXY_lst_sig_ext1_recurrence(int64(sig_ext1_recurrence*10),1) = weightedXY;
    normalizedXY_lst_sig_ext1_recurrence(int64(sig_ext1_recurrence*10),1) = normalizedXY;
    amp_ext1_recurrence = amp_ext1_recurrence + 0.01;

    delta_x_list(1,int64(sig_ext1_recurrence*10)) = delta_x;
    mean_y_list(1,int64(sig_ext1_recurrence*10)) = mean_y;
end

x_sig_ext1_recurrence = linspace(0.1,8.0,80);
% amp vector and power axis for ext1 recurrence sweep
amp_ext1_recurrence_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_ext1_recurrence)-1));
x_power_sig_ext1_recurrence = x_sig_ext1_recurrence .* amp_ext1_recurrence_vec;
subplot(8,4,9);
y_sig_ext1_recurrence_x_change = x_change_lst_sig_ext1_recurrence;
scatter(x_power_sig_ext1_recurrence,y_sig_ext1_recurrence_x_change,'filled')
% use power axis for recurrence plots
subplot(8,4,10);
y_sig_ext1_recurrence_slope = slope_lst_sig_ext1_recurrence;
scatter(x_power_sig_ext1_recurrence,y_sig_ext1_recurrence_slope,'filled')
subplot(8,4,11);
y_sig_ext1_recurrence_weightedXY = weightedXY_lst_sig_ext1_recurrence;
scatter(x_power_sig_ext1_recurrence,y_sig_ext1_recurrence_weightedXY,'filled')
subplot(8,4,12);
y_sig_ext1_recurrence_normalizedXY = normalizedXY_lst_sig_ext1_recurrence(1:80);
scatter(x_power_sig_ext1_recurrence,y_sig_ext1_recurrence_normalizedXY,'filled')

% ----------------- 4) sig_inh1_recurrence -----------------
x_change_lst_sig_inh1_recurrence = zeros(80,1);
slope_lst_sig_inh1_recurrence = zeros(80,1);
weightedXY_lst_sig_inh1_recurrence = zeros(80,1);
normalizedXY_lst_sig_inh1_recurrence = zeros(80,1);
amp_inh1_recurrence = 1.01;
for sig_inh1_recurrence = 12.1:0.1:20
    title_temp = strcat('sig_ext1_recurrence = 4 sig_inh1_recurrence = ', num2str(sig_inh1_recurrence));
    [S1,S2,x_change,slope,weightedXY,normalizedXY] = mips(50,100,50,100,...
                                      4,sig_inh1_recurrence,4,16,...
                                      1,1,1,1, ...
                                      1,amp_inh1_recurrence,1,1, ...
                                      input_stimulus1,input_stimulus2,...
                                      title_temp,true,true,true,false);
    x_change_lst_sig_inh1_recurrence(int64((sig_inh1_recurrence-12)*10),1) = x_change;
    slope_lst_sig_inh1_recurrence(int64((sig_inh1_recurrence-12)*10),1) = slope;
    weightedXY_lst_sig_inh1_recurrence(int64((sig_inh1_recurrence-12)*10),1) = weightedXY;
    normalizedXY_lst_sig_inh1_recurrence(int64((sig_inh1_recurrence-12)*10),1) = normalizedXY;
    amp_inh1_recurrence = amp_inh1_recurrence + 0.01;
end
x_sig_inh1_recurrence = linspace(12.1,20,80);
% amp vector and power axis for inh1 recurrence sweep
amp_inh1_recurrence_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_inh1_recurrence)-1));
x_power_sig_inh1_recurrence = x_sig_inh1_recurrence .* amp_inh1_recurrence_vec;
subplot(8,4,13);
y_sig_inh1_recurrence_x_change = x_change_lst_sig_inh1_recurrence;
scatter(x_power_sig_inh1_recurrence,y_sig_inh1_recurrence_x_change,'filled')
subplot(8,4,14);
y_sig_inh1_recurrence_slope = slope_lst_sig_inh1_recurrence;
scatter(x_power_sig_inh1_recurrence,y_sig_inh1_recurrence_slope,'filled')
subplot(8,4,15);
y_sig_inh1_recurrence_weightedXY = weightedXY_lst_sig_inh1_recurrence;
scatter(x_power_sig_inh1_recurrence,y_sig_inh1_recurrence_weightedXY,'filled')
subplot(8,4,16);
y_sig_inh1_recurrence_normalizedXY = normalizedXY_lst_sig_inh1_recurrence;
scatter(x_power_sig_inh1_recurrence,y_sig_inh1_recurrence_normalizedXY,'filled')

% ----------------- 5) sig_ext2 -----------------
x_change_lst_sig_ext2 = zeros(80,1);
slope_lst_sig_ext2 = zeros(80,1);
weightedXY_lst_sig_ext2 = zeros(80,1);
normalizedXY_lst_sig_ext2 = zeros(80,1);
amp_ext2 = 1.01;
for sig_ext2 = 11:90
    title_temp = strcat('sig_ext2 = ', num2str(sig_ext2), ' sig_inh2 = 80');
    [S1,S2,x_change,slope,weightedXY,normalizedXY] = mips(50,100,sig_ext2,100,...
                                      4,16,4,16,...
                                      1,1,amp_ext2,1,...
                                      1,1,1,1, ...
                                      input_stimulus1,input_stimulus2,...
                                      title_temp,true,true,true,false);
    x_change_lst_sig_ext2(sig_ext2-10,1) = x_change;
    slope_lst_sig_ext2(sig_ext2-10,1) = slope;
    weightedXY_lst_sig_ext2(sig_ext2-10,1) = weightedXY;
    normalizedXY_lst_sig_ext2(sig_ext2-10,1) = normalizedXY;
    amp_ext2 = amp_ext2 + 0.01;
end
x_sig_ext2 = linspace(11,90,80);
% amp vector and power axis for sig_ext2 sweep
amp_ext2_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_ext2)-1));
x_power_sig_ext2 = x_sig_ext2 .* amp_ext2_vec;
subplot(8,4,17);
y_sig_ext2_x_change = x_change_lst_sig_ext2;
scatter(x_power_sig_ext2,y_sig_ext2_x_change,'filled')
subplot(8,4,18);
y_sig_ext2_slope = slope_lst_sig_ext2;
scatter(x_power_sig_ext2,y_sig_ext2_slope,'filled')
subplot(8,4,19);
y_sig_ext2_weightedXY = weightedXY_lst_sig_ext2;
scatter(x_power_sig_ext2,y_sig_ext2_weightedXY,'filled')
subplot(8,4,20);
y_sig_ext2_normalizedXY = normalizedXY_lst_sig_ext2;
scatter(x_power_sig_ext2,y_sig_ext2_normalizedXY,'filled')

% ----------------- 6) sig_inh2 -----------------
x_change_lst_sig_inh2 = zeros(80,1);
slope_lst_sig_inh2 = zeros(80,1);
weightedXY_lst_sig_inh2 = zeros(80,1);
normalizedXY_lst_sig_inh2 = zeros(80,1);
amp_inh2 = 1.01;
for sig_inh2 = 61:140
    title_temp = strcat('sig_ext2 = 120 sig_inh2 = ', num2str(sig_inh2));
    [S1,S2,x_change,slope,weightedXY,normalizedXY] = mips(50,100,50,sig_inh2,...
                                      4,16,4,16,...
                                      1,1,1,amp_inh2, ...
                                      1,1,1,1, ...
                                      input_stimulus1,input_stimulus2,...
                                      title_temp,true,true,true,false);
    x_change_lst_sig_inh2(sig_inh2-60,1) = x_change;
    slope_lst_sig_inh2(sig_inh2-60,1) = slope;
    weightedXY_lst_sig_inh2(sig_inh2-60,1) = weightedXY;
    normalizedXY_lst_sig_inh2(sig_inh2-60,1) = normalizedXY;
    amp_inh2 = amp_inh2 + 0.01;
end
x_sig_inh2 = linspace(61,140,80);
% amp vector and power axis for sig_inh2 sweep
amp_inh2_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_inh2)-1));
x_power_sig_inh2 = x_sig_inh2 .* amp_inh2_vec;
subplot(8,4,21);
y_sig_inh2_x_change = x_change_lst_sig_inh2;
scatter(x_power_sig_inh2,y_sig_inh2_x_change,'filled')
subplot(8,4,22);
y_sig_inh2_slope = slope_lst_sig_inh2;
scatter(x_power_sig_inh2,y_sig_inh2_slope,'filled')
subplot(8,4,23);
y_sig_inh2_weightedXY = weightedXY_lst_sig_inh2;
scatter(x_power_sig_inh2,y_sig_inh2_weightedXY,'filled')
subplot(8,4,24);
y_sig_inh2_normalizedXY = normalizedXY_lst_sig_inh2;
scatter(x_power_sig_inh2,y_sig_inh2_normalizedXY,'filled')

% ----------------- 7) sig_ext2_recurrence -----------------
x_change_lst_sig_ext2_recurrence = zeros(80,1);
slope_lst_sig_ext2_recurrence = zeros(80,1);
weightedXY_lst_sig_ext2_recurrence = zeros(80,1);
normalizedXY_lst_sig_ext2_recurrence = zeros(80,1);
amp_ext2_recurrence = 1.01;
for sig_ext2_recurrence = 0.1:0.1:8.0
    title_temp = strcat('sig_ext2_recurrence = ', num2str(sig_ext2_recurrence), ' sig_inh2_recurrence = 16');
    [S1,S2,x_change,slope,weightedXY,normalizedXY] = mips(50,100,50,100,...
                         4,16,sig_ext2_recurrence,16,...
                         1,1,1,1, ...
                         1,1,amp_ext2_recurrence,1, ...
                         input_stimulus1,input_stimulus2,...
                         title_temp,true,true,true,false);
    x_change_lst_sig_ext2_recurrence(int64(sig_ext2_recurrence*10),1) = x_change;
    slope_lst_sig_ext2_recurrence(int64(sig_ext2_recurrence*10),1) = slope;
    weightedXY_lst_sig_ext2_recurrence(int64(sig_ext2_recurrence*10),1) = weightedXY;
    normalizedXY_lst_sig_ext2_recurrence(int64(sig_ext2_recurrence*10),1) = normalizedXY;
    amp_ext2_recurrence = amp_ext2_recurrence + 0.01;
end
x_sig_ext2_recurrence = linspace(0.1,8.0,80);
% amp vector and power axis for ext2 recurrence sweep
amp_ext2_recurrence_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_ext2_recurrence)-1));
x_power_sig_ext2_recurrence = x_sig_ext2_recurrence .* amp_ext2_recurrence_vec;
subplot(8,4,25);
y_sig_ext2_recurrence_x_change = x_change_lst_sig_ext2_recurrence;
scatter(x_power_sig_ext2_recurrence,y_sig_ext2_recurrence_x_change,'filled')
subplot(8,4,26);
y_sig_ext2_recurrence_slope = slope_lst_sig_ext2_recurrence;
scatter(x_power_sig_ext2_recurrence,y_sig_ext2_recurrence_slope,'filled')
subplot(8,4,27);
y_sig_ext2_recurrence_weightedXY = weightedXY_lst_sig_ext2_recurrence;
scatter(x_power_sig_ext2_recurrence,y_sig_ext2_recurrence_weightedXY,'filled')
subplot(8,4,28);
y_sig_ext2_recurrence_normalizedXY = normalizedXY_lst_sig_ext2_recurrence;
scatter(x_power_sig_ext2_recurrence,y_sig_ext2_recurrence_normalizedXY,'filled')

% ----------------- 8) sig_inh2_recurrence -----------------
x_change_lst_sig_inh2_recurrence = zeros(80,1);
slope_lst_sig_inh2_recurrence = zeros(80,1);
weightedXY_lst_sig_inh2_recurrence = zeros(80,1);
normalizedXY_lst_sig_inh2_recurrence = zeros(80,1);
amp_inh2_recurrence = 1.01;
for sig_inh2_recurrence = 12.1:0.1:20
    title_temp = strcat('sig_ext2_recurrence = 10 sig_inh2_recurrence', num2str(sig_inh2_recurrence));
    [S1,S2,x_change,slope,weightedXY,normalizedXY] = mips(50,100,50,100,...
                         4,16,4,sig_inh2_recurrence,...
                         1,1,1,1, ...
                         1,1,1,amp_inh2_recurrence, ...
                         input_stimulus1,input_stimulus2,...
                         title_temp,true,true,true,false);
    x_change_lst_sig_inh2_recurrence(int64((sig_inh2_recurrence-12)*10),1) = x_change;
    slope_lst_sig_inh2_recurrence(int64((sig_inh2_recurrence-12)*10),1) = slope;
    weightedXY_lst_sig_inh2_recurrence(int64((sig_inh2_recurrence-12)*10),1) = weightedXY;
    normalizedXY_lst_sig_inh2_recurrence(int64((sig_inh2_recurrence-12)*10),1) = normalizedXY;
    amp_inh2_recurrence = amp_inh2_recurrence + 0.01;
end
x_sig_inh2_recurrence = linspace(12.1,20,80);
% amp vector and power axis for inh2 recurrence sweep
amp_inh2_recurrence_vec = 1.01:0.01:(1.01 + 0.01*(length(x_sig_inh2_recurrence)-1));
x_power_sig_inh2_recurrence = x_sig_inh2_recurrence .* amp_inh2_recurrence_vec;
subplot(8,4,29);
y_sig_inh2_recurrence_x_change = x_change_lst_sig_inh2_recurrence;
scatter(x_power_sig_inh2_recurrence,y_sig_inh2_recurrence_x_change,'filled')
subplot(8,4,30);
y_sig_inh2_recurrence_slope = slope_lst_sig_inh2_recurrence;
scatter(x_power_sig_inh2_recurrence,y_sig_inh2_recurrence_slope,'filled')
subplot(8,4,31);
y_sig_inh2_recurrence_weightedXY = weightedXY_lst_sig_inh2_recurrence;
scatter(x_power_sig_inh2_recurrence,y_sig_inh2_recurrence_weightedXY,'filled')
subplot(8,4,32);
y_sig_inh2_recurrence_normalizedXY = normalizedXY_lst_sig_inh2_recurrence;
scatter(x_power_sig_inh2_recurrence,y_sig_inh2_recurrence_normalizedXY,'filled')

%% Figure 4A ~ 4D figure generation
figure;
subplot(1,4,1);
y_sig_ext1_normalizedXY = normalizedXY_lst_sig_ext1;
max_val = max(y_sig_ext1_normalizedXY); min_val = min(y_sig_ext1_normalizedXY);
y_sig_ext1_normalizedXY = (y_sig_ext1_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_ext1,y_sig_ext1_normalizedXY,'filled')
xlabel('{\sigma}_{ext}^{1} * {\alpha}_{ext}^{1}','FontSize',16,'FontWeight','bold'); ylabel('Neural Response (a.u.)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
[rho_sig_ext1_pearson,pval_sig_ext1_pearson] = corr(x_sig_ext1',y_sig_ext1_normalizedXY,'Type','Pearson','Rows','complete');
[rho_sig_ext1_kendall,pval_sig_ext1_kendall] = corr(x_sig_ext1',y_sig_ext1_normalizedXY,'Type','Kendall','Rows','complete');
[rho_sig_ext1_spearman,pval_sig_ext1_spearman] = corr(x_sig_ext1',y_sig_ext1_normalizedXY,'Type','Spearman','Rows','complete');

subplot(1,4,2);
y_sig_inh1_normalizedXY = normalizedXY_lst_sig_inh1;
max_val = max(y_sig_inh1_normalizedXY); min_val = min(y_sig_inh1_normalizedXY);
y_sig_inh1_normalizedXY = (y_sig_inh1_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_inh1,y_sig_inh1_normalizedXY,'filled')
xlabel('{\sigma}_{inh}^{1} * {\alpha}_{inh}^{1}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
subplot(1,4,3);
[rho_sig_inh1_pearson,pval_sig_inh1_pearson] = corr(x_sig_inh1',y_sig_inh1_normalizedXY,'Type','Pearson');
[rho_sig_inh1_kendall,pval_sig_inh1_kendall] = corr(x_sig_inh1',y_sig_inh1_normalizedXY,'Type','Kendall');
[rho_sig_inh1_spearman,pval_sig_inh1_spearman] = corr(x_sig_inh1',y_sig_inh1_normalizedXY,'Type','Spearman');

y_sig_ext1_recurrence_normalizedXY = normalizedXY_lst_sig_ext1_recurrence(1:74); x_power_sig_ext1_recurrence = x_power_sig_ext1_recurrence(1:74); x_sig_ext1_recurrence = x_sig_ext1_recurrence(1:74);
max_val = max(y_sig_ext1_recurrence_normalizedXY); min_val = min(y_sig_ext1_recurrence_normalizedXY);
y_sig_ext1_recurrence_normalizedXY = (y_sig_ext1_recurrence_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_ext1_recurrence,y_sig_ext1_recurrence_normalizedXY,'filled')
xlabel('{\sigma}_{ext}^{rec1} * {\alpha}_{ext}^{rec1}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
subplot(1,4,4);
[rho_sig_ext1_recurrence_pearson,pval_sig_ext1_recurrence_pearson] = corr(x_sig_ext1_recurrence',y_sig_ext1_recurrence_normalizedXY,'Type','Pearson');
[rho_sig_ext1_recurrence_kendall,pval_sig_ext1_recurrence_kendall] = corr(x_sig_ext1_recurrence',y_sig_ext1_recurrence_normalizedXY,'Type','Kendall');
[rho_sig_ext1_recurrence_spearman,pval_sig_ext1_recurrence_spearman] = corr(x_sig_ext1_recurrence',y_sig_ext1_recurrence_normalizedXY,'Type','Spearman');

y_sig_inh1_recurrence_normalizedXY = normalizedXY_lst_sig_inh1_recurrence;
max_val = max(y_sig_inh1_recurrence_normalizedXY); min_val = min(y_sig_inh1_recurrence_normalizedXY);
y_sig_inh1_recurrence_normalizedXY = (y_sig_inh1_recurrence_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_inh1_recurrence,y_sig_inh1_recurrence_normalizedXY,'filled')
xlabel('{\sigma}_{inh}^{rec1} * {\alpha}_{inh}^{rec1}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',14)
yticks([0 0.5 1])
[rho_sig_inh1_recurrence_pearson,pval_sig_inh1_recurrence_pearson] = corr(x_sig_inh1_recurrence',y_sig_inh1_recurrence_normalizedXY,'Type','Pearson');
[rho_sig_inh1_recurrence_kendall,pval_sig_inh1_recurrence_kendall] = corr(x_sig_inh1_recurrence',y_sig_inh1_recurrence_normalizedXY,'Type','Kendall');
[rho_sig_inh1_recurrence_spearman,pval_sig_inh1_recurrence_spearman] = corr(x_sig_inh1_recurrence',y_sig_inh1_recurrence_normalizedXY,'Type','Spearman');

%% Figure 4E ~ 4H figure generation

figure;
subplot(1,4,1);
y_sig_ext2_normalizedXY = normalizedXY_lst_sig_ext2;
max_val = max(y_sig_ext2_normalizedXY); min_val = min(y_sig_ext2_normalizedXY);
y_sig_ext2_normalizedXY = (y_sig_ext2_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_ext2,y_sig_ext2_normalizedXY,'filled')
xlabel('{\sigma}_{ext}^{2} * {\alpha}_{ext}^{2}','FontSize',16,'FontWeight','bold'); ylabel('Neural Response (a.u.)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
[rho_sig_ext2_pearson,pval_sig_ext2_pearson] = corr(x_sig_ext2',y_sig_ext2_normalizedXY,'Type','Pearson');
[rho_sig_ext2_kendall,pval_sig_ext2_kendall] = corr(x_sig_ext2',y_sig_ext2_normalizedXY,'Type','Kendall');
[rho_sig_ext2_spearman,pval_sig_ext2_spearman] = corr(x_sig_ext2',y_sig_ext2_normalizedXY,'Type','Spearman');

subplot(1,4,2);
y_sig_inh2_normalizedXY = normalizedXY_lst_sig_inh2;
max_val = max(y_sig_inh2_normalizedXY); min_val = min(y_sig_inh2_normalizedXY);
y_sig_inh2_normalizedXY = (y_sig_inh2_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_inh2,y_sig_inh2_normalizedXY,'filled')
xlabel('{\sigma}_{inh}^{2} * {\alpha}_{inh}^{2}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
[rho_sig_inh2_pearson,pval_sig_inh2_pearson] = corr(x_sig_inh2',y_sig_inh2_normalizedXY,'Type','Pearson');
[rho_sig_inh2_kendall,pval_sig_inh2_kendall] = corr(x_sig_inh2',y_sig_inh2_normalizedXY,'Type','Kendall');
[rho_sig_inh2_spearman,pval_sig_inh2_spearman] = corr(x_sig_inh2',y_sig_inh2_normalizedXY,'Type','Spearman');

subplot(1,4,3);
y_sig_ext2_recurrence_normalizedXY = normalizedXY_lst_sig_ext2_recurrence(1:74); x_power_sig_ext2_recurrence = x_power_sig_ext2_recurrence(1:74); x_sig_ext2_recurrence = x_sig_ext2_recurrence(1:74);
max_val = max(y_sig_ext2_recurrence_normalizedXY); min_val = min(y_sig_ext2_recurrence_normalizedXY);
y_sig_ext2_recurrence_normalizedXY = (y_sig_ext2_recurrence_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_ext2_recurrence,y_sig_ext2_recurrence_normalizedXY,'filled')
xlabel('{\sigma}_{ext}^{rec2} * {\alpha}_{ext}^{rec2}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
[rho_sig_ext2_recurrence_pearson,pval_sig_ext2_recurrence_pearson] = corr(x_sig_ext2_recurrence',y_sig_ext2_recurrence_normalizedXY,'Type','Pearson');
[rho_sig_ext2_recurrence_kendall,pval_sig_ext2_recurrence_kendall] = corr(x_sig_ext2_recurrence',y_sig_ext2_recurrence_normalizedXY,'Type','Kendall');
[rho_sig_ext2_recurrence_spearman,pval_sig_ext2_recurrence_spearman] = corr(x_sig_ext2_recurrence',y_sig_ext2_recurrence_normalizedXY,'Type','Spearman');

subplot(1,4,4);
y_sig_inh2_recurrence_normalizedXY = normalizedXY_lst_sig_inh2_recurrence;
max_val = max(y_sig_inh2_recurrence_normalizedXY); min_val = min(y_sig_inh2_recurrence_normalizedXY);
y_sig_inh2_recurrence_normalizedXY = (y_sig_inh2_recurrence_normalizedXY - min_val) / (max_val - min_val);
scatter(x_power_sig_inh2_recurrence,y_sig_inh2_recurrence_normalizedXY,'filled')
xlabel('{\sigma}_{inh}^{rec2} * {\alpha}_{inh}^{rec2}','FontSize',16,'FontWeight','bold');
set(gca,'FontSize',15)
yticks([0 0.5 1])
[rho_sig_inh2_recurrence_pearson,pval_sig_inh2_recurrence_pearson] = corr(x_sig_inh2_recurrence',y_sig_inh2_recurrence_normalizedXY,'Type','Pearson');
[rho_sig_inh2_recurrence_kendall,pval_sig_inh2_recurrence_kendall] = corr(x_sig_inh2_recurrence',y_sig_inh2_recurrence_normalizedXY,'Type','Kendall');
[rho_sig_inh2_recurrence_spearman,pval_sig_inh2_recurrence_spearman] = corr(x_sig_inh2_recurrence',y_sig_inh2_recurrence_normalizedXY,'Type','Spearman');
