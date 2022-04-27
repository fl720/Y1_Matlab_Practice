% Solve wave-equation d^2 z dt^2 + d^2 z dx^2 = 0 in one Dimension.
% Andreas M Kempf, 4th of March 2007
% Written for use in the 1M Computing Course of
% Imperial College London, Mechanical Engineering

% Avoid nasty surprises...
clear;

% Setup of the case, to be set by the user
nSteps=2100;    % Number of timesteps
dt=0.3;         % Length of a timestep
c1=0.1;         % Inertia constant
c2=1.0;         % Stiffness constant
w=200;           % Width of initial profile
nx=200;	        % Number of support points

dx=w/nx;

% Initialise the arrays with original values
a(1:nx)=0;
v(1:nx)=0;


% Initial displacements (perturbation)
for i = 1:nx
    r=(i-nx/2);
    z(i)=2*exp(-(r/w)^2)-exp(-(r/(2*w))^2);
end
        

% Loop over timesteps
for step=0:nSteps
    
    % Compute new acceleration
    for i=2:nx-1;
        a(i)=c2/c1*(z(i-1)-2*z(i)+z(i+1))/dx^2;
    end
    
    % Update velocity
    for i=2:nx-1;
        v(i)=v(i)+a(i)*dt;
    end
       
    % Compute the new position z
    for i=2:nx-1;
        z(i)=z(i)+v(i)*dt;
    end

    
    % Output
    if (mod(step,2)==0)
        plot(z,'Linewidth',3); axis([1 nx -1 1])
        pause(0.001);
        if (step==0); pause(); end       % Show initial fields!
    end
end