cdir = fileparts(mfilename('fullpath')); 
[NUMERIC, TXT, RAW] = xlsread(fullfile(cdir,'../Data/project_data.csv'));
velocities = NUMERIC(:,6);
mfig('galaxy: Box Plot'); clf;
boxplot(velocities);
title('Galaxy velocities');