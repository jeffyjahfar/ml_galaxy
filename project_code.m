% Load the data into Matlab
cdir = fileparts(mfilename('fullpath')); 
[NUMERIC, TXT, RAW] = xlsread(fullfile(cdir,'../Data/project_data.csv'));

% Extract the rows and columns corresponding to the sensor data, and
% transpose the matrix to have rows correspond to data items
X = NUMERIC(:,1:6);

% Extract attribute names from the first column
attributeNames = RAW(1,1:end);

% Data attributes to be plotted
i = 2;
j = 3;
k = 6;

% Make a simple plot of the i'th attribute against the j'th attribute
mfig('galaxy: Positions'); clf;
plot(X(:,i), X(:,j), '.');
xlabel(attributeNames{i});
ylabel(attributeNames{j});
title('Galaxy positions');



 