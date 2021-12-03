function [out]=Biter(orgsig,exsig)
% BER bit error Rate
% out    = output that is BER
% orgsig = orignal signal
% exsig  = extracted signal
orgsig=double(orgsig);
exsig=double(exsig);
[m n]=size(orgsig);
errate=0;
for i=1:m
    for j=1:n
        if(orgsig(i,j)==exsig(i,j))
            errate=errate+0;
        else
            errate=errate+1;
        end
    end
end


out=(errate)/numel(orgsig);