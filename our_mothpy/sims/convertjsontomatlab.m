clc
clear variables

dataname = 'data9';

firstset = jsondecode(fileread(strcat(dataname,'.json')));

N = length(firstset); % number of male moths
M = zeros(N,1);

mothx = zeros(2000,N);
mothy = zeros(2000,N);

for j = 1:N % moth number
    M(j) = length(firstset(j).diff_list0); % number of time points per male moth
    for i = 1:M(j) % time point
        mothx(i,j) = firstset(j).diff_list0{i}{1};
        mothy(i,j) = firstset(j).diff_list0{i}{2};
    end
end

ind = ceil(linspace(1,N,7));

r = 15; % radius of mating
xcenter = 25;
ycenter = 500;
th = linspace(0,2*pi,1000);
xunit = r * cos(th) + xcenter;
yunit = r * sin(th) + ycenter;

figure
hold on
for i = ind
    scatter(mothx(1:M(i),i),mothy(1:M(i),i),10,'Filled')
end
scatter(25,500,40,'k','d','Filled')
plot(xunit, yunit,'k')
hold off
xlabel('$x$','Interpreter','latex','FontSize',20)
ylabel('$y$','Interpreter','latex','FontSize',20,'Rotation',0)
box on
daspect([1 1 1])
xlim([0,500])
set(gca,'FontSize',12)
set(gcf,'Units','inches','Position',[2,2,6,10],'PaperPositionMode','auto')