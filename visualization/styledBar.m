function[]=styledBar(bdata,xLabl,yLabl,Titl,lgnd)
%     global res
figure
hold on
sz=size(bdata,2);
colors =[[0 0 1];[0 1 0];[0 1 1];[1 0 0];[1 0 1];[1 1 0];[0 1 0.533];[1 0.733 0]];
for i = 1:sz
    bar(i,bdata(i),'FaceColor',colors(i,:))
end
title(Titl,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',12);
 xlabel(xLabl,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',12);
ylabel(yLabl,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',12);
legend(lgnd,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',12,'Location','EastOutside');
xlim([0 sz+1])
% set(gcf,'units','normalized','outerposition',[0 0 1 1])
% export_fig(['figures/' Titl] ,'-jpg',res)
% saveas(gca,['Images\' Titl '.png'])

