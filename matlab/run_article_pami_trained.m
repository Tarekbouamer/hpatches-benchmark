% Recompute all scores for all descriptors.
% Requires approximately at least 64GB RAM, unless `num_neg` is decreased.

descs = {};

descs{end+1} = struct('name', 'hp-train-a', 'split', {{'full'}}); 
descs{end+1} = struct('name', 'hp-train-illum', 'split', {{'full'}}); 
descs{end+1} = struct('name', 'hp-train-view', 'split', {{'full'}}); 

descs{end+1} = struct('name', 'tfeat-n-train-a', 'split', {{'full'}}); 
descs{end+1} = struct('name', 'tfeat-n-train-illum', 'split', {{'full'}}); 
descs{end+1} = struct('name', 'tfeat-n-train-view', 'split', {{'full'}}); 
descs = cell2mat(descs);

global_args = {'num_neg', inf, 'numtype', 'double', ...
  'scoresroot', fullfile(hb_path, 'matlab', 'scores', 'scores_pami_trained')};

%%
args = {};
for di = 1:numel(descs)
    args{end+1} = [{descs(di).name, 'norm', false, ...
      'split', descs(di).split}, global_args];
end
fprintf('%d tasks.\n', numel(args));

%%
sel = utls.parallelise(1:numel(args));
for ai = 1:size(sel, 1)
  hb('all', args{sel(ai)}{:});
end
