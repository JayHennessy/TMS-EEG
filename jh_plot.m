function [ done ] = jh_plot( data, viewmode, demean,detrend )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
done =0;


cfg = [];
cfg.preproc.detrend = detrend;
cfg.preproc.demean = demean;
cfg.viewmode = viewmode;
cfg.preproc.baselinewindow = [-0.5 -0.01];
ft_databrowser(cfg, data);


done =1;
end

