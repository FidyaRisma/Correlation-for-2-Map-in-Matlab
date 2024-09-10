function [corr2d,rsq,p_corr2d] = corr2D_map(var1,var2)

SIZE = size(var1);
var1_2d = reshape(var1,[SIZE(1)*SIZE(2),SIZE(3)]);
var2_2d = reshape(var2,[SIZE(1)*SIZE(2),SIZE(3)]);

var1_2d_z = zscore(var1_2d');
var2_2d_z = zscore(var2_2d');
corr1d = sum(var1_2d_z.*var2_2d_z)/(SIZE(3)-1);
corr2d  = reshape(corr1d,[SIZE(1),SIZE(2)]);
rsq = corr2d.^2;
N = SIZE(3);
t_corr2d = sqrt(N-2).*corr2d./sqrt(1-corr2d.^2);
s_corr2d = tcdf(t_corr2d,N-2);
p_corr2d = 2 * min(s_corr2d,1-s_corr2d);

figure
subplot(1,3,1);
imagesc(corr2d,'AlphaData',corr2d>-1);
cmap=cbrewer2('RdYlGn');
caxis([-1 1]);
colormap(cmap);
colorbar;
title('Coefficient of Correlation');
subplot(1,3,2)
imagesc(rsq,'AlphaData',rsq>0);
caxis([0 1]);
cmap=cbrewer2('RdYlGn');
colormap(cmap);
colorbar;
title('Coefficient of Determination');
subplot(1,3,3)
imagesc(p_corr2d,'AlphaData',p_corr2d>0);
caxis([0 0.05]);
colormap(cmap);
colorbar;
title('p-value');




end