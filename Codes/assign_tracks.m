function [ relt, centd,oret,majx,ovp] = assign_tracks( cord_pre,cord_curr,oret_curr,maja_curr )

ovp = dist_centd(cord_curr,cord_pre);
relt=[];

 for wrm_nmb=1:size(cord_curr,1)
    k= find(ovp(wrm_nmb,:)==min(ovp(wrm_nmb,:)));
    while ismember(k(1),relt)==1
        ovp(wrm_nmb,k(1))=NaN;
        k= find(ovp(wrm_nmb,:)==min(ovp(wrm_nmb,:)));
    end
    relt(wrm_nmb,1)=k(1);
 end
 
for wrm_nmb=1:size(cord_curr,1)
    centd(relt(wrm_nmb),:)=cord_curr((wrm_nmb),:);
    oret(relt(wrm_nmb))=oret_curr((wrm_nmb));
    majx(relt(wrm_nmb))=maja_curr((wrm_nmb));
end
end

