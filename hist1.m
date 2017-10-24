function hist2=hist1(Ima);
R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
[fil,col,capa]=size(Ima);

rojo=zeros(1,fil,col);
verde=zeros(1,fil,col);
azul=zeros(1,fil,col);


rojo=R(:);
verde=G(:);
azul=B(:);

a=10;
for i=1:a
    hist2(i,1)=length(find(rojo<(i+1)*300/a & rojo>=(i)*300/a));
end
for i=1:10
    hist2(i,2)=length(find(verde<(i+1)*300/a & verde>=(i)*300/a));
end
for i=1:10
    hist2(i,3)=length(find(azul<(i+1)*300/a & azul>=(i)*300/a));
end