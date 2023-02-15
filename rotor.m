function [] = rotor(omega0,x,y,v0x,v0y)
% Rotor billiard. See Péter Bálint and Serge Troubetzkoy. "Rotor interaction in the annulus billiard." J. Stat. Phys. 117.3-4 (2004): 681-702.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% omega0 : initial angular velocity of the rotating circle
% x : initial x coordinates of particles
% y : initial y coordinates of particles
% v0x : initial x velocity component of particles
% v0y : initial y velocity component of particles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE INPUT: rotor(1,[3 1],[2 2],[5 7],[8 9])

eta = 1.1; % normalized moment of inertia
tstep = 0.01;
T = 500;

cx = cos(linspace(0,2*pi,100));  % static circle
cy = sin(linspace(0,2*pi,100));

rx = 4*cos(linspace(0,2*pi,100));  % rotating circle
ry = 4*sin(linspace(0,2*pi,100));

color = colormap(lines);

vx = v0x';
vy = v0y';
vt = [NaN NaN]';
omega = omega0;
theta = 0; % position of the line in the rotating circle

for i = 2:1:T
   sz = [1000 1100]/2;                                         % set plot window 
   screensize = get(0,'ScreenSize');
   xpos = ceil((screensize(3)-sz(2))/2); 
   ypos = ceil((screensize(4)-sz(1))/2); 
   hFig = figure(1);
   set(hFig, 'Position', [xpos ypos sz(2) sz(1)])
   
   axis([-4.5 4.5 -4.5 4.5]);
   ax = gca;
   ax.Visible = 'off';

   plot(cx,cy,'k-',rx,ry,'k-')
   
   hold on
   
   axis([-4.5 4.5 -4.5 4.5]);
   ax = gca;
   ax.Visible = 'off';
   
   for n = 1:1:length(x)

        if x(n)^2 + y(n)^2 > 16 % collision at static circle
            B = [-x(n) y(n);-y(n) -x(n)];
            Binv = 1/(x(n)^2 + y(n)^2)*[-x(n) -y(n);y(n) -x(n)];
    
            v = [vx(n) vy(n)]';
            w = Binv*v; %convert to normal-tangential coordinates
    
            v = -w(1)*B(:,1)+w(2)*B(:,2); 
            vx(n) = v(1);
            vy(n) = v(2);
    
            x(n) = x(n) + tstep*vx(n);
            y(n) = y(n) + tstep*vy(n);
            theta = theta - tstep*omega; 

        elseif x(n)^2 + y(n)^2 < 1 %collision at rotating circle
            B = [-x(n) y(n);-y(n) -x(n)];
            Binv = 1/(x(n)^2 + y(n)^2)*[-x(n) -y(n);y(n) -x(n)];
    
            v = [vx(n) vy(n)]';
            w = Binv*v;
    
            vt(n) = w(2)-2*eta/(1+eta)*(w(2)-omega);
            omega = omega + 2/(1+eta)*(w(2)-omega);
    
            v = -w(1)*B(:,1)+vt(n)*B(:,2);   
            vx(n) = v(1);
            vy(n) = v(2);
    
            x(n) = x(n) + tstep*vx(n);
            y(n) = y(n) + tstep*vy(n);
            theta = theta - tstep*omega;   
        else %no collision
            x(n) = x(n) + tstep*vx(n);
            y(n) = y(n) + tstep*vy(n);
            theta = theta - tstep*omega;   
        end

   plot(x(n),y(n),'ko','MarkerFaceColor',color(n,:)) %plot particle

   end
   
   plot([cos(theta) cos(theta + pi)],[sin(theta) sin(theta + pi)],'k-') %plot line in rotating circle
   M = getframe;
   
   hold off
end

end

