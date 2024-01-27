function [] = mastercat(n)
% Discrete cat map. See https://en.wikipedia.org/wiki/Arnold%27s_cat_map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% n : number of iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE INPUT: mastercat(40) pusheen231.png

A=imread('pusheen231.png');                      %input image

sz = [400 400];                                 %set screensize
screensize = get(0,'ScreenSize');
xpos = ceil((screensize(3)-sz(2))/2); 
ypos = ceil((screensize(4)-sz(1))/2); 
hFig = figure(1);
set(hFig, 'Position', [xpos ypos sz(2) sz(1)])  %set screen position

image(A) 
title('k = 0','FontSize',20)
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', [])
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', [])
    set(gca,'xtick',[])
    set(gca,'ytick',[])

for i=1:n
    pause(0.5)
    M(i) = getframe;
    im{i} = frame2im(M(i));
    A=catmap(A);
    image(A)
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', [])
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', [])
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    title(['k = ',num2str(i)],'FontSize',20)
end

for idx = 1:n
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,"pusheen.gif","gif","LoopCount",Inf,"DelayTime",0.5);
    else
        imwrite(A,map,"pusheen.gif","gif","WriteMode","append","DelayTime",0.5);
    end
end

end

