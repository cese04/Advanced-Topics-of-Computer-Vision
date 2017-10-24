
% X=zeros(125,30);
C(1:6)={'objetct 1'};
C(7:12)={'object 2'};
C(13:18)={'object 3'};
C(19:24)={'object 4'};

save ('tags.mat', 'C')
%%
load 'trV.mat'
X(:,24)=n;
%%
save('trV.mat','X')


%%
Y=fitcdiscr(X',C,'discrimType','pseudoLinear')