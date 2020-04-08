% Subtract the mean from the data
cdir = fileparts(mfilename('fullpath')); 
[NUMERIC, TXT, RAW] = xlsread(fullfile(cdir,'../Data/project_data.csv'));
X = NUMERIC(:,2:6);
Y = bsxfun(@minus, X, mean(X));

% Obtain the PCA solution by calculate the SVD of Y
[U, S, V] = svd(Y);

% Compute variance explained
rho = diag(S).^2./sum(diag(S).^2);

% Plot variance explained
mfig('Galaxy: Var. explained'); clf;
plot(rho, 'o-');
title('Variance explained by principal components');
xlabel('Principal component');
ylabel('Variance explained value');