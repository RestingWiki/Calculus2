
% Declare varaibles x, y , Lambda;
syms x y lambda;

% Clear the screen;
clc;

% Define the function F(x,y) ----------- G(x,y): The boundary
f = x^2 + y^2+ x*y;       % F(x,y) 
g = x^2 + 2*y^2 - 1; 


% Setup the system of equation
sysOfEqn = [gradient(f) == lambda*gradient(g), 
    g == 0 ];

% Solve the system of equation and store the result's of (x, y, Lambda)
sol_Arr = solve(sysOfEqn,x,y,lambda)

% Evaluate the function for all F(x,y) values
Fxy = double(subs(f,sol_Arr));

% Find the maximum value 
Fmax = Fxy(1); 
for i = 2:length(Fxy)
    if Fxy(i) > Fmax
        Fmax = Fxy(i); 
    end
end

% Find the mainvalue 
Fmin = Fxy(1); 
for i = 2:length(Fxy)
    if Fxy(i) < Fmin
        Fmin = Fxy(i);
    end
end


fprintf('The absolute maximum value of f(x,y) = %f \n', Fmax);
fprintf('The absolute minimum value of f(x,y) = %f \n', Fmin);

% Create a meshgrid within the boundary with polar coordinate
x_Axis = linspace(-5, 5, 200);
y_Axis = linspace(-5, 5, 200);
[X,Y] = meshgrid(x_Axis, y_Axis);
% Evaluate the function for all values of x and y
f_eval = matlabFunction(f);
Z = f_eval(X, Y);



% Create a mask to remove values outside the boundary
mask = (X.^2 + 2.*Y.^2 - 1 <= 0);

% Apply the mask to the Z matrix
Z(~mask) = NaN;

% Plot the surface within the boundary
surf(X, Y, Z);
axis([-1 1 -1/sqrt(2) 1/sqrt(2) Fmin-1 Fmax+1]);            % Lock the view between Fmin and Fmax
xlabel('x');
ylabel('y');
zlabel('z');
