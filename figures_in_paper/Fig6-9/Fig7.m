data = 0;
fig = 1;

if data == 0
  load('Decrease_Time.mat')
else
  T = linspace(8,0.5,7)*60*60; %in seconds
  D = logspace(-4,-1,10);
  rt = linspace(0.01,0.99,20);
  R0 = 1;

  %calculate mating probability for each D, rt, and T
  C = zeros(length(rt),length(D),length(T));
  for i = 1:length(rt)
    for j = 1:length(D)
      parfor k = 1:length(T)
        C(i,j,k) = getAbsProb(T(k),R0,rt(i),D(j));
      end
    end
  end

  [X,Y] = ndgrid(rt,log10(D));

  %day-by-day mating probs
  P = zeros(size(C));
  TempProd = ones(size(C(:,:,1)));
  for ell = 1:7
    if ell == 1
      P(:,:,ell) = C(:,:,ell);
    else
      for k = 1:ell-1
        TempProd = TempProd.*(1-P(:,:,k));
      end
      P(:,:,ell) = C(:,:,ell).*TempProd;
    end
  end
  save('Decrease_Time.mat')
end

if fig == 1
  close all
  width=12;
  height=4;
  x0 = 5;
  y0 = 5;
  fontsize = 10;
  f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
  titles = {'$\mathcal{M}_1$','$\mathcal{M}_2$','$\mathcal{M}_3$','$\mathcal{M}_4$','$\mathcal{M}_5$','$\mathcal{M}_6$','$\mathcal{M}_7$','$\mathcal{M}$'}

  for k = 1:length(T)
    subplot(2,4,k)
    contourf(X,Y,P(:,:,k))
    title(titles{k},'FontWeight','normal','fontsize',fontsize,'Interpreter','latex')
    xlim([0 1])
    xticks([0,0.5,1])
    xlabel('$R$','fontsize',fontsize,'Interpreter','latex')
    ylabel('$D$','fontsize',fontsize,'Interpreter','latex')
    yticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}'})
    colorbar
    % axis square
    % caxis([0 1])
    % print(k,sprintf('P(day = %d)_increase.png',k),'-dpng','-r600')
  end

  % close all
  TotalProb = sum(P,3)
  subplot(2,4,8)
  contourf(X,Y,TotalProb)
  title(titles{8},'FontWeight','normal','fontsize',fontsize,'Interpreter','Latex')
  xlim([0 1])
  xticks([0,0.5,1])
  xlabel('$R$','fontsize',fontsize,'Interpreter','latex')
  ylabel('$D$','fontsize',fontsize,'Interpreter','latex')
  yticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}'})
  colorbar

  print(1,'Fig7.png','-dpng','-r600')
  print(1,'Fig7.eps','-depsc')
end
