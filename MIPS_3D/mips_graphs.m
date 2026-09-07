input_stimulus1 = mips_input("right");
input_stimulus2 = mips_input("left");
amp_vec_80 = 1.01:0.01:(1.01 + 0.01*(80-1));

%% ----------------- 1) sig_ext1 & sig_inh1 -----------------
% Figure 4I data generation
normalizedXY_lst_1 = zeros(80,80);
amp_ext1 = 1.01; amp_inh1 = 1.01;
for sig_ext1 = 11:90
    for sig_inh1 = 61:140
        disp(strcat('sig_ext1 = ', num2str(sig_ext1), ' sig_inh1 = ', num2str(sig_inh1)));
        [S1,S2,normalizedXY] = mips( ...
            sig_ext1,sig_inh1,50,100,4,16,4,16, ...
            amp_ext1,amp_inh1,1,1,1,1,1,1, ...
            input_stimulus1,input_stimulus2,"",true,true,true,false);
        normalizedXY_lst_1(sig_ext1-10,sig_inh1-60) = normalizedXY;
        amp_inh1 = amp_inh1 + 0.01;
        if sig_inh1 == 140
            amp_inh1 = 1.01;
        end
    end
    amp_ext1 = amp_ext1 + 0.01;
end

% Figure 4I figure generation
% Post-process and plot using power axes
figure;
y_sig_1_normalizedXY = normalizedXY_lst_1';
max_val = max(max(y_sig_1_normalizedXY)); min_val = min(min(y_sig_1_normalizedXY));
y_sig_1_normalizedXY = (y_sig_1_normalizedXY - min_val) / (max_val - min_val);

% grids (sigma values)
x_sig_ext1 = repmat(linspace(11,90,80),80,1);
x_sig_inh1 = repmat(linspace(61,140,80),80,1)';
% amp matrices matching sweep ordering
amp_ext1_mat = repmat(amp_vec_80,80,1);
amp_inh1_mat = repmat(amp_vec_80',1,80);
% power axes
x_power_ext1 = x_sig_ext1 .* amp_ext1_mat;
x_power_inh1 = x_sig_inh1 .* amp_inh1_mat;
% scale response (z) by local amp product
z_power_1 = y_sig_1_normalizedXY .* (amp_ext1_mat .* amp_inh1_mat);

mesh(x_power_ext1,x_power_inh1,z_power_1,'FaceAlpha','0.5')
xlabel('{\sigma}_{ext}^{1} * {\alpha}_{ext}^{1}','FontSize',16,'FontWeight','bold');
ylabel('{\sigma}_{inh}^{1} * {\alpha}_{inh}^{1}','FontSize',16,'FontWeight','bold');
zlabel('Model Illusion Representation (a.u.) (amp-scaled)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

hold on
% scatter border points using power coordinates (z scaled)
scatter3(x_power_ext1(end,:), x_power_inh1(end,:), z_power_1(end,:),'filled','MarkerFaceColor','r');
hold on
scatter3(x_power_ext1(:,1), x_power_inh1(:,1), z_power_1(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');

% correlations along ext axis: mean response across inh (use amp-scaled z)
ext1_power_vec = mean(x_power_ext1,1)';
resp_by_ext1_power = mean(z_power_1,1)';
[rho_sig_ext1_pearson,pval_sig_ext1_pearson] = corr(ext1_power_vec,resp_by_ext1_power,'Type','Pearson','Rows','complete');
[rho_sig_ext1_kendall,pval_sig_ext1_kendall] = corr(ext1_power_vec,resp_by_ext1_power,'Type','Kendall','Rows','complete');
[rho_sig_ext1_spearman,pval_sig_ext1_spearman] = corr(ext1_power_vec,resp_by_ext1_power,'Type','Spearman','Rows','complete');

%% ----------------- 2) sig_ext1_recurrence & sig_inh1_recurrence ----------------
% Figure 4J data generation
% recurrence sweep uses smaller sigma ranges but same amp sweep structure
normalizedXY_lst_1_recurrence = zeros(80,80);
amp_ext1_recurrence = 1.01; amp_inh1_recurrence = 1.01;
for sig_ext1_recurrence = 0.1:0.1:8.0
    for sig_inh1_recurrence = 12.1:0.1:20
        disp(strcat('sig_ext1_recurrence = ', num2str(sig_ext1_recurrence), ' sig_inh1_recurrence = ', num2str(sig_inh1_recurrence)));
        [S1,S2,normalizedXY] = mips( ...
            50,100,50,100, ...                     % sig_ext1, sig_inh1, sig_ext2, sig_inh2 (fixed)
            sig_ext1_recurrence,sig_inh1_recurrence,4,16, ... % recurrence sigs (ext1_recurrence, inh1_recurrence, ext2_rec fixed=4, inh2_rec fixed=16)
            1,1,1,1, ...                             % main layer amps (keep 1)
            amp_ext1_recurrence, amp_inh1_recurrence, 1, 1, ... % recurrence amps: vary ext1_recurrence & inh1_recurrence as before
            input_stimulus1,input_stimulus2,"",true,true,true,false);
        normalizedXY_lst_1_recurrence(int64(sig_ext1_recurrence*10),int64((sig_inh1_recurrence-12)*10)) = normalizedXY;
        amp_inh1_recurrence = amp_inh1_recurrence + 0.01;
        if sig_inh1_recurrence == 20
            amp_inh1_recurrence = 1.01;
        end
    end
    amp_ext1_recurrence = amp_ext1_recurrence + 0.01;
end

% Figure 4J figure generation
% figure;
% y_sig_1_recurrence_normalizedXY = normalizedXY_lst_1_recurrence';
% max_val = max(max(y_sig_1_recurrence_normalizedXY)); min_val = min(min(y_sig_1_recurrence_normalizedXY));
% y_sig_1_recurrence_normalizedXY = (y_sig_1_recurrence_normalizedXY - min_val) / (max_val - min_val);
% 
% % construct power matrices for ext1 recurrence / inh1 recurrence
% x_sig_ext1_recurrence = repmat(linspace(0.1,8.0,80),80,1);
% x_sig_inh1_recurrence = repmat(linspace(12.1,20,80),80,1)';
% amp_ext1_recurrence_mat = repmat(amp_vec_80,80,1);
% amp_inh1_recurrence_mat = repmat(amp_vec_80',1,80);
% x_power_ext1_recurrence = x_sig_ext1_recurrence .* amp_ext1_recurrence_mat;
% x_power_inh1_recurrence = x_sig_inh1_recurrence .* amp_inh1_recurrence_mat;
% % here we keep recurrence z unscaled (use normalized response) to match prior figures
% z_recurrence_1 = y_sig_1_recurrence_normalizedXY;
% 
% mesh(x_power_ext1_recurrence,x_power_inh1_recurrence,z_recurrence_1,'FaceAlpha','0.5')
% xlabel('{\\sigma}_{ext}^{rec1} * amp','FontSize',16,'FontWeight','bold');
% ylabel('{\\sigma}_{inh}^{rec1} * amp','FontSize',16,'FontWeight','bold');
% zlabel('Model Illusion Representation (a.u.)','FontSize',13,'FontWeight','bold');
% set(gca,'FontSize',15)
% 
% hold on
% scatter3(linspace(0.1,8.0,80).*amp_vec_80, linspace(20,20,80).*amp_vec_80, z_recurrence_1(80,:),'filled','MarkerFaceColor','r');
% hold on
% scatter3(linspace(0.1,0.1,80).*amp_vec_80, linspace(12.1,20,80).*amp_vec_80, z_recurrence_1(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');
% 
% [rho_sig_ext1_recurrence_pearson,pval_sig_ext1_recurrence_pearson] = corr(mean(x_power_ext1_recurrence,1)',mean(z_recurrence_1,1)','Type','Pearson','Rows','complete');
% [rho_sig_ext1_recurrence_kendall,pval_sig_ext1_recurrence_kendall] = corr(mean(x_power_ext1_recurrence,1)',mean(z_recurrence_1,1)','Type','Kendall','Rows','complete');
% [rho_sig_ext1_recurrence_spearman,pval_sig_ext1_recurrence_spearman] = corr(mean(x_power_ext1_recurrence,1)',mean(z_recurrence_1,1)','Type','Spearman','Rows','complete');

figure;
% subset indices 21:70 correspond to sigma ranges 2.1:7.0 and 14.1:19
% recompute normalized subset z and corresponding power matrices for clean plotting
y_sig_1_recurrence_normalizedXY = normalizedXY_lst_1_recurrence';
max_val = max(max(y_sig_1_recurrence_normalizedXY)); min_val = min(min(y_sig_1_recurrence_normalizedXY));
y_sig_1_recurrence_normalizedXY = (y_sig_1_recurrence_normalizedXY - min_val) / (max_val - min_val);

idx = 21:70; % subset index range
% construct consistent power grids for the subset (match how full matrices were built)
amp_subset = amp_vec_80(idx);          % 1x50
ext_vals = linspace(2.1,7.0,50);       % 1x50
inh_vals = linspace(14.1,19,50);       % 1x50

% ext varies across columns, inh across rows; build full 50x50 matrices
ext_mat = repmat(ext_vals,50,1);                    % 50x50
inh_mat = repmat(inh_vals',1,50);                   % 50x50
amp_ext_mat_sub = repmat(amp_subset,50,1);          % 50x50 (amp per column)
amp_inh_mat_sub = repmat(amp_subset',1,50);         % 50x50 (amp per row)

X_sub = ext_mat .* amp_ext_mat_sub;    % ext power coordinates (50x50)
Y_sub = inh_mat .* amp_inh_mat_sub;    % inh power coordinates (50x50)
z_sub = y_sig_1_recurrence_normalizedXY(idx,idx);   % 50x50

mesh(X_sub,Y_sub,z_sub,'FaceAlpha','0.5')
xlabel('{\sigma}_{ext}^{rec1} * {\alpha}_{ext}^{rec1}','FontSize',16,'FontWeight','bold');
ylabel('{\sigma}_{inh}^{rec1} * {\alpha}_{inh}^{rec1}','FontSize',16,'FontWeight','bold');
zlabel('Model Illusion Representation (a.u.)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

hold on
% scatter border points using the exact edges of the constructed grids
scatter3(X_sub(end,:),Y_sub(end,:),z_sub(end,:),'filled','MarkerFaceColor','r','MarkerEdgeColor','r');
hold on
scatter3(X_sub(:,1),Y_sub(:,1),z_sub(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');

% correlations computed on the subset power vectors and subset responses
[rho_sig_ext1_recurrence_pearson,pval_sig_ext1_recurrence_pearson] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Pearson','Rows','complete');
[rho_sig_ext1_recurrence_kendall,pval_sig_ext1_recurrence_kendall] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Kendall','Rows','complete');
[rho_sig_ext1_recurrence_spearman,pval_sig_ext1_recurrence_spearman] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Spearman','Rows','complete');

%% ----------------- 3) sig_ext2 & sig_inh2 -----------------
% Figure 4K data generation
normalizedXY_lst_2 = zeros(80,80);
amp_ext2 = 1.01; amp_inh2 = 1.01;
for sig_ext2 = 11:90
    for sig_inh2 = 61:140
        disp(strcat('sig_ext2 = ', num2str(sig_ext2), ' sig_inh2 = ', num2str(sig_inh2)));
        [S1,S2,normalizedXY] = mips( ...
            50,100,sig_ext2,sig_inh2,4,16,4,16, ...
            1,1,amp_ext2,amp_inh2,1,1,1,1, ...
            input_stimulus1,input_stimulus2,"",true,true,true,false);
        normalizedXY_lst_2(sig_ext2-10,sig_inh2-60) = normalizedXY;
        amp_inh2 = amp_inh2 + 0.01;
        if sig_inh2 == 140
            amp_inh2 = 1.01;
        end
    end
    amp_ext2 = amp_ext2 + 0.01;
end

% Figure 4K figure generation
figure;
y_sig_2_normalizedXY = normalizedXY_lst_2';
max_val = max(max(y_sig_2_normalizedXY)); min_val = min(min(y_sig_2_normalizedXY));
y_sig_2_normalizedXY = (y_sig_2_normalizedXY - min_val) / (max_val - min_val);

% power grids for ext2/inh2
x_sig_ext2 = repmat(linspace(11,90,80),80,1);
x_sig_inh2 = repmat(linspace(61,140,80),80,1)';
amp_ext2_mat = repmat(amp_vec_80,80,1);
amp_inh2_mat = repmat(amp_vec_80',1,80);
x_power_ext2 = x_sig_ext2 .* amp_ext2_mat;
x_power_inh2 = x_sig_inh2 .* amp_inh2_mat;
z_power_2 = y_sig_2_normalizedXY .* (amp_ext2_mat .* amp_inh2_mat);

mesh(x_power_ext2,x_power_inh2,z_power_2,'FaceAlpha','0.5')
xlabel('{\sigma}_{ext}^{2} * {\alpha}_{ext}^{2}','FontSize',16,'FontWeight','bold');
ylabel('{\sigma}_{inh}^{2} * {\alpha}_{inh}^{2}','FontSize',16,'FontWeight','bold');
zlabel('Model Illusion Representation (a.u.) (amp-scaled)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

hold on
scatter3(x_power_ext2(end,:), x_power_inh2(end,:), z_power_2(end,:),'filled','MarkerFaceColor','r');
hold on
scatter3(x_power_ext2(:,1), x_power_inh2(:,1), z_power_2(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');

ext2_power_vec = mean(x_power_ext2,1)';
resp_by_ext2_power = mean(z_power_2,1)';
[rho_sig_ext2_pearson,pval_sig_ext2_pearson] = corr(ext2_power_vec,resp_by_ext2_power,'Type','Pearson','Rows','complete');
[rho_sig_ext2_kendall,pval_sig_ext2_kendall] = corr(ext2_power_vec,resp_by_ext2_power,'Type','Kendall','Rows','complete');
[rho_sig_ext2_spearman,pval_sig_ext2_spearman] = corr(ext2_power_vec,resp_by_ext2_power,'Type','Spearman','Rows','complete');

%% ----------------- 4) sig_ext2_recurrence & sig_inh2_recurrence ----------------
% Figure 4L data generation
normalizedXY_lst_2_recurrence = zeros(80,80);
amp_ext2_recurrence = 1.01; amp_inh2_recurrence = 1.01;
for sig_ext2_recurrence = 0.1:0.1:8.0
    for sig_inh2_recurrence = 12.1:0.1:20
        disp(strcat('sig_ext2_recurrence = ', num2str(sig_ext2_recurrence), ' sig_inh2_recurrence = ', num2str(sig_inh2_recurrence)));
        [S1,S2,normalizedXY] = mips( ...
            50,100,50,100,4,16,sig_ext2_recurrence,sig_inh2_recurrence, ...
            1,1,1,1,1,1,amp_ext2_recurrence,amp_inh2_recurrence, ...
            input_stimulus1,input_stimulus2,"",true,true,true,false);
        normalizedXY_lst_2_recurrence(int64(sig_ext2_recurrence*10),int64((sig_inh2_recurrence-12)*10)) = normalizedXY;
        amp_inh2_recurrence = amp_inh2_recurrence + 0.01;
        if sig_inh2_recurrence == 20
            amp_inh2_recurrence = 1.01;
        end
    end
    amp_ext2_recurrence = amp_ext2_recurrence + 0.01;
end

% Figure 4L figure generation
% figure;
% y_sig_2_recurrence_normalizedXY = normalizedXY_lst_2_recurrence';
% max_val = max(max(y_sig_2_recurrence_normalizedXY)); min_val = min(min(y_sig_2_recurrence_normalizedXY));
% y_sig_2_recurrence_normalizedXY = (y_sig_2_recurrence_normalizedXY - min_val) / (max_val - min_val);
% 
% % construct power matrices for ext2 recurrence / inh2 recurrence
% x_sig_ext2_recurrence = repmat(linspace(0.1,8.0,80),80,1);
% x_sig_inh2_recurrence = repmat(linspace(12.1,20,80),80,1)';
% amp_ext2_recurrence_mat = repmat(amp_vec_80,80,1);
% amp_inh2_recurrence_mat = repmat(amp_vec_80',1,80);
% x_power_ext2_recurrence = x_sig_ext2_recurrence .* amp_ext2_recurrence_mat;
% x_power_inh2_recurrence = x_sig_inh2_recurrence .* amp_inh2_recurrence_mat;
% z_power_2_recurrence = y_sig_2_recurrence_normalizedXY .* (amp_ext2_recurrence_mat .* amp_inh2_recurrence_mat);
% 
% mesh(x_power_ext2_recurrence,x_power_inh2_recurrence,z_power_2_recurrence,'FaceAlpha','0.5')
% xlabel('{\sigma}_{ext}^{rec2} * {\alpha}_{ext}^{rec2}','FontSize',16,'FontWeight','bold');
% ylabel('{\sigma}_{inh}^{rec2} * {\alpha}_{inh}^{rec2}','FontSize',16,'FontWeight','bold');
% zlabel('Model Illusion Representation (a.u.) (amp-scaled)','FontSize',13,'FontWeight','bold');
% set(gca,'FontSize',15)
% 
% hold on
% scatter3(x_power_ext2_recurrence(end,:), x_power_inh2_recurrence(end,:), z_power_2_recurrence(end,:),'filled','MarkerFaceColor','r');
% hold on
% scatter3(x_power_ext2_recurrence(:,1), x_power_inh2_recurrence(:,1), z_power_2_recurrence(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');
% 
% ext2_rec_power_vec = mean(x_power_ext2_recurrence,1)';
% resp_by_ext2_rec_power = mean(z_power_2_recurrence,1)';
% [rho_sig_ext2_recurrence_pearson,pval_sig_ext2_recurrence_pearson] = corr(ext2_rec_power_vec,resp_by_ext2_rec_power,'Type','Pearson','Rows','complete');
% [rho_sig_ext2_recurrence_kendall,pval_sig_ext2_recurrence_kendall] = corr(ext2_rec_power_vec,resp_by_ext2_rec_power,'Type','Kendall','Rows','complete');
% [rho_sig_ext2_recurrence_spearman,pval_sig_ext2_recurrence_spearman] = corr(ext2_rec_power_vec,resp_by_ext2_rec_power,'Type','Spearman','Rows','complete');

figure;
% subset indices 21:70 correspond to sigma ranges 2.1:7.0 and 14.1:19
% recompute normalized subset z and corresponding power matrices for clean plotting
y_sig_2_recurrence_normalizedXY = normalizedXY_lst_2_recurrence';
max_val = max(max(y_sig_2_recurrence_normalizedXY)); min_val = min(min(y_sig_2_recurrence_normalizedXY));
y_sig_2_recurrence_normalizedXY = (y_sig_2_recurrence_normalizedXY - min_val) / (max_val - min_val);

idx = 21:75; % subset index range
% construct consistent power grids for the subset (match how full matrices were built)
amp_subset = amp_vec_80(idx);          % 1x55
ext2_vals = linspace(2.1,8.0,55);       % 1x55
inh2_vals = linspace(14.1,20,55);       % 1x55
% ext varies across columns, inh across rows; build full 55x55 matrices
ext2_mat = repmat(ext2_vals,55,1);                    % 55x55
inh2_mat = repmat(inh2_vals',1,55);                   % 55x55
amp_ext2_mat_sub = repmat(amp_subset,55,1);          % 55x55 (amp per column)
amp_inh2_mat_sub = repmat(amp_subset',1,55);         % 55x55 (amp per row)
X_sub = ext2_mat .* amp_ext2_mat_sub;    % ext power coordinates (55x55)
Y_sub = inh2_mat .* amp_inh2_mat_sub;    % inh power coordinates (55x55)
z_sub = y_sig_2_recurrence_normalizedXY(idx,idx);   % 55x55
mesh(X_sub,Y_sub,z_sub,'FaceAlpha','0.5')
xlabel('{\sigma}_{ext}^{rec2} * {\alpha}_{ext}^{rec2}','FontSize',16,'FontWeight','bold');
ylabel('{\sigma}_{inh}^{rec2} * {\alpha}_{inh}^{rec2}','FontSize',16,'FontWeight','bold');
zlabel('Model Illusion Representation (a.u.)','FontSize',13,'FontWeight','bold');
set(gca,'FontSize',15)

hold on
% scatter border points using the exact edges of the constructed grids
scatter3(X_sub(end,:),Y_sub(end,:),z_sub(end,:),'filled','MarkerFaceColor','r','MarkerEdgeColor','r');
hold on
scatter3(X_sub(:,1),Y_sub(:,1),z_sub(:,1),'filled','MarkerFaceColor','k','MarkerEdgeColor','k');

% correlations computed on the subset power vectors and subset responses
[rho_sig_ext2_recurrence_pearson,pval_sig_ext2_recurrence_pearson] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Pearson','Rows','complete');
[rho_sig_ext2_recurrence_kendall,pval_sig_ext2_recurrence_kendall] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Kendall','Rows','complete');
[rho_sig_ext2_recurrence_spearman,pval_sig_ext2_recurrence_spearman] = corr(mean(X_sub,1)',mean(z_sub,1)','Type','Spearman','Rows','complete');