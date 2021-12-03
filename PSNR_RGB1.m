function y=PSNR_RGB1(X,Y)
 

 
if size(X)~=size(Y)
    error('The images must have the same size');
end

 
% begin
d1=max(X(:));
d2=max(Y(:));
d=max(d1,d2);
sigma=mean2((X-Y).^2);
 
y=10*log((d.^2)./sigma);