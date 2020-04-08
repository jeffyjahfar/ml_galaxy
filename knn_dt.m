close all
clear all
% Load the data into Matlab
cdir = fileparts(mfilename('fullpath')); 
[NUMERIC, TXT, RAW] = xlsread(fullfile(cdir,'../Data/redefined_galaxy.xlsx'));

% Extract the rows and columns corresponding to the sensor data, and

% transpose the matrix to have rows correspond to data items
X = NUMERIC(:,2:5);
Xr = [X(:,1:4)];
% , X(:,1).* X(:,2), X(:,3).* X(:,4) 
%, X(:,3).* X(:,4), sqrt(X(:,1).^2 + X(:,2).^2)
Y = NUMERIC(:,6);
M = size(NUMERIC,2) -2;
N = size(NUMERIC,1);

m = size(Xr,2);
% Extract attribute names from the first column
attributeNames = RAW(1,2:end);
attributeNamesFeaTran = [attributeNames(1:4),'east.west*north.south','radial.position*angle'];
%%
K = 5;
CV = cvpartition(N, 'Kfold', K);
X_train1 = X(CV.training(1), :);
Y_train1 = Y(CV.training(1));
X_test1 = X(CV.test(1), :);
Y_test1 = Y(CV.test(1));

% K-nearest neighbors parameters
for k = 1:1 % For each crossvalidation fold

    CV2 = cvpartition(size(X_train1,1), 'Kfold', K);
    X_train2 = X_train1(CV2.training(k), :);
    y_train2 = Y_train1(CV2.training(k));
    X_test2 = X_train1(CV2.test(k), :);
    y_test2 = Y_train1(CV2.test(k));
    fprintf('Crossvalidation fold %d/%d\n', k, K);
    Distance = 'euclidean'; % Distance measure
    L = 40; % Maximum number of neighbors
    
    % Variable for classification error
    test_Error = nan(1,L);

    % Extract training and test set
   
    for l = 1:L % For each number of neighbors
        
        % Use knnclassify to find the l nearest neighbors
        y_test_est2 = knnclassify(X_test2, X_train2, y_train2, l, Distance);
        
        % Compute number of classification errors
        % Error(k,l) = sum(y_test~=y_test_est); % Count the number of errors
        test_Error(l) =  sum(y_test2~=y_test_est2);
    end
     NumK = find(test_Error==min(test_Error));
     NumK = NumK(1);
     y_test_est1 = knnclassify(X_test1, X_train1, Y_train1, NumK, Distance);
     Error_KNN =  sum(Y_test1~=y_test_est1)
     %%decision tree
     

% Load data

cN = {'a';'b'}; 
aNN = {'a';'b';'c';'d'};
aN = transpose(aNN);


% Number of folds for crossvalidation
K = 10;


% Create holdout crossvalidation partition
CV = cvpartition(cN(Y_train1+1), 'Kfold', K);

% Pruning levels
prune = 0:10;

% Variable for classification error
Error_train2 = nan(K,length(prune));
Error_test2 = nan(K,length(prune));

for k = 1:K
    fprintf('Crossvalidation fold %d/%d\n', k, K);

    % Extract training and test set
    X_train2 = X_train1(CV.training(1), :);
    Y_train2 = Y_train1(CV.training(1));
    X_test2 = X_train1(CV.test(1), :);
    Y_test2 = Y_train1(CV.test(1));
   
    
   
    % Fit classification tree to training set
    T = classregtree(X_train2, cN(Y_train2+1), ...
        'method', 'classification', ...
        'splitcriterion', 'gdi', ...
        'categorical', [], ...
        'names',aN , ...
        'prune', 'on', ...
        'minparent', 10);

    % Compute classification error
    for n = 1:length(prune) % For each pruning level
        Error_train2(k,n) = sum(~strcmp(cN(Y_train2+1), eval(T, X_train2, prune(n))));
        Error_test2(k,n) = sum(~strcmp(cN(Y_test2+1), eval(T, X_test2, prune(n))));
    end    
end
    
    

% Plot classification error
mfig('Wine decision tree: K-fold crossvalidatoin'); clf; hold all;
plot(prune, sum(Error_train2)/sum(CV.TrainSize));


plot(prune, sum(Error_test2)/sum(CV.TestSize));
xlabel('Pruning level');
ylabel('Classification error');
legend('Training error', 'Test error');
          
     
end
xx = prune;
yy = sum(Error_test2)/sum(CV.TestSize)
indexmin = find(min(yy) == yy);
xxmin = xx(indexmin);
yymin = yy(indexmin);
fprintf('the prune should be %d',xxmin)



%% Plot the classification error rate
% mfig('Error rate');
% plot(sum(Error)./sum(CV.TestSize)*100);
% xlabel('Number of neighbors');
% ylabel('Classification error rate (%)');


% Load data

cN = {'a';'b'}; 
aNN = {'a';'b';'c';'d'};
aN = transpose(aNN);


% Number of folds for crossvalidation
K = 10;


% Create holdout crossvalidation partition
CV = cvpartition(cN(Y_train1+1), 'Kfold', K);

% Pruning levels
prune = 0:10;

% Variable for classification error
Error_train2 = nan(K,length(prune));
Error_test2 = nan(K,length(prune));

for k = 1:K
    fprintf('Crossvalidation fold %d/%d\n', k, K);

    % Extract training and test set
    X_train2 = X_train1(CV.training(1), :);
    Y_train2 = Y_train1(CV.training(1));
    X_test2 = X_train1(CV.test(1), :);
    Y_test2 = Y_train1(CV.test(1));
   
    
   
    % Fit classification tree to training set
    T = classregtree(X_train2, cN(Y_train2+1), ...
        'method', 'classification', ...
        'splitcriterion', 'gdi', ...
        'categorical', [], ...
        'names',aN , ...
        'prune', 'on', ...
        'minparent', 10);

    % Compute classification error
    for n = 1:length(prune) % For each pruning level
        Error_train2(k,n) = sum(~strcmp(cN(Y_train2+1), eval(T, X_train2, prune(n))));
        Error_test2(k,n) = sum(~strcmp(cN(Y_test2+1), eval(T, X_test2, prune(n))));
    end    
end
    
    

% Plot classification error
mfig('Wine decision tree: K-fold crossvalidatoin'); clf; hold all;
plot(prune, sum(Error_train2)/sum(CV.TrainSize));


plot(prune, sum(Error_test2)/sum(CV.TestSize));
xlabel('Pruning level');
ylabel('Classification error');
legend('Training error', 'Test error');
          
     

xx = prune;
yy = sum(Error_test2)/sum(CV.TestSize)
indexmin = find(min(yy) == yy);
xxmin = xx(indexmin);
yymin = yy(indexmin);
fprintf('the prune should be %d',xxmin)



%% Plot the classification error rate
% mfig('Error rate');
% plot(sum(Error)./sum(CV.TestSize)*100);
% xlabel('Number of neighbors');
% ylabel('Classification error rate (%)');

% Load data

cNa = {'a';'b'}; 
aNNa = {'a';'b';'c';'d'};
aNa = transpose(aNNa);


% Number of folds for crossvalidation
K = 10;


% Create holdout crossvalidation partition
CV = cvpartition(cN(Y_train2+1), 'Kfold', K);

% Pruning levels
prunea = max(xxmin)

% Variable for classification error
Error_train3 = nan(K,length(prunea));
Error_test3 = nan(K,length(prunea));

for k = 1:K
    fprintf('Crossvalidation fold %d/%d\n', k, K);

    % Extract training and test set
    X_train3 = X_train2(CV.training(2), :);
    Y_train3 = Y_train2(CV.training(2));
    X_test3 = X_train2(CV.test(2), :);
    Y_test3 = Y_train2(CV.test(2));
   
    
   
    % Fit classification tree to training set
    T = classregtree(X_test3, cNa(Y_test3+1), ...
        'method', 'classification', ...
        'splitcriterion', 'gdi', ...
        'categorical', [], ...
        'names',aNa , ...
        'prune', 'on', ...
        'minparent', 10);

    % Compute classification error
    for n = prunea % For each pruning level
        Error_train3(k,n) = sum(~strcmp(cNa(Y_train3 +1), eval(T, X_train3, prunea)));
        Error_test3(k,n) = sum(~strcmp(cNa(Y_test3 +1), eval(T, X_test3, prunea)));
        
    end    
end
    
    fprintf('Decision tree test error is %d',Error_test3(k,n));    
    
    
    