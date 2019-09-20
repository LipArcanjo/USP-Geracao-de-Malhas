function DM = pdist2(dsites,ctrs)
M = size(dsites,1); 
N = size(ctrs,1);
DM = repmat(sum(dsites.*dsites,2),1,N) - ...
    2*dsites*ctrs' + ...
    repmat((sum(ctrs.*ctrs,2))',M,1);
DM = sqrt(DM);
end