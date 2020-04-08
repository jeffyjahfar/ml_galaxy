% Index of the principal components
i = 2;
j = 5;

% Compute the projection onto the principal components
Z = U*S;

% Extract unique class names from the first row
classLabels = RAW(2:end,1);

% Plot PCA of data
mfig('Galaxy: PCA 3&5'); clf; hold all; 
C = length(classLabels);
for c = 0:C-1
    plot(Z(:,i), Z(:,j), 'o');
end
%legend(classLabels);
xlabel(sprintf('PC %d', i));
ylabel(sprintf('PC %d', j));
title('PCA of Galaxy data');