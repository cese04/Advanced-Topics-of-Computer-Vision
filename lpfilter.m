function H=lpfilter(tipus, M,N,D0,n)

[U,V]=dftuv(M,N);
D=sqrt(U.^2+V.^2);

%Hb=1/(1+(D(u,v)/D0)^2*n);

switch tipus
    case 'ideal'
        H=double(D<=D0);
    case 'btw'
%         if margin==4
%             n=1;
%         end
        H=1./(1+(D./D0).^(2*n));
    case 'gauss'
        H=exp(-((D.^2)/(2*D0^2)));
    otherwise
        error('Tipus desconocido')
end