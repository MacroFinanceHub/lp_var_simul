%% COMBINE RESULTS FOR MULTIPLE DGP CHOICE SETS
% Dake Li, Mikkel Plagborg-M�ller and Christian Wolf
% This version: 02/23/2021

clear all;

%% SET UP DESTINATION FOLDER AND FILES

spec_id_array = 1:2; % specification choice set id array
dgp_type = 'G'; % Either 'G' or 'MP'
estimand_type = 'IV'; % Either 'ObsShock', 'Recursive', or 'IV'
lag_type = NaN; % No. of lags to impose in estimation, or NaN (meaning AIC)
winsor_percent = 0.025; % winsorize each tail with this percentage to compute winsorized mean and std
quantiles = [0.1,0.25,0.5,0.75,0.9]; % summarize MCs in the order of mean, std, winsorized mean, winsorized std, and these quantiles
% the name of each summary statistic is stored in settings.simul.summ_stat_name

save_pre = fullfile('..', 'Results');
if isnan(lag_type)
    save_suff = '_aic';
else
    save_suff = num2str(lag_type);
end
save_folder = fullfile(save_pre, strcat('lag', save_suff));


%% COMBINE ALL THE RESULTS

% combine results across all spec_ids

[DFM_estimate, DF_model, settings, results] = combine_struct(save_folder, strcat('DFM_', dgp_type, '_', estimand_type), spec_id_array, winsor_percent, quantiles);

% save combined results

save(fullfile(save_folder, strcat('DFM_', dgp_type, '_', estimand_type)), ...
    'DFM_estimate','DF_model','settings','results',...
    'dgp_type','estimand_type','lag_type','-v7.3');

clear save_folder save_pre save_suff