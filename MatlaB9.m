% Clear the screen
clc;

% Clear the graph
clf;

% Declare variables x, y
syms x y;

% Define the function F(x,y)
f = 2*x^4 + y^4 -x^2 - 2*y^2;

% Set up the system of equations
sysOfEqn = [gradient(f) == 0];

% Solve the system of equations
sol_Arr = solve(sysOfEqn,x,y);

% Second partial derivative
fxx = diff(f, x, 2);
fxy = diff(diff(f, x), y);
fyy = diff(f, y, 2);

% Create an array to store critical points
crit = [];
for i = 1:length(sol_Arr.x)

    % Convert from vector to value
    x_scale = double(sol_Arr.x(i));
    y_scale = double(sol_Arr.y(i));

    % Upadate the old array with new x_scale, y_scale
    crit = [crit; x_scale, y_scale];
    length(crit)
end   

% Evaluate critical points for maxima, minima, saddle points
for i = 1:length(crit)
    x_scale = crit(i,1);
    y_scale = crit(i,2);

    % Check if x_scale, y_scale is a Real number the continue, or else move
    % to the next iteration
    if (isreal(x_scale) && isreal(y_scale))
        delta = subs(fxx*fyy - fxy^2, [x y], [x_scale y_scale]);
        temp = subs(delta, [x y], [x_scale y_scale]);

        if    (double(temp) > 0 && double(delta) > 0) 
            fprintf('(%f, %f) is a local minimum\n', x_scale, y_scale);
        elseif (double(temp) < 0 && double(delta) > 0) 
            fprintf('(%f, %f) is a local maximum\n', x_scale, y_scale);
        elseif (double(delta) < 0)
            fprintf('(%f, %f) is a saddle point\n', x_scale, y_scale);
        elseif(double(delta) == 0)
            fprintf('The point (%f, %f) is undetermined!\n', x_scale, y_scale); 
        end
    end
end

% Skech the surface
x_Axis = linspace(-10,10,100);
y_Axis = linspace(-10,10,100);
[X,Y] =  meshgrid(x_Axis,y_Axis);
f_eval = matlabFunction(f);
Z = f_eval(X, Y);

% Plot the surface within the boundary
surf(X, Y, Z);   
xlabel('x');
ylabel('y');
zlabel('z');

