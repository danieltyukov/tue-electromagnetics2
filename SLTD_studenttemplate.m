%% Student template for SLT-D Snells law.
% Template used for SLT-D exercise 6. Contains placeholders and plotting
% for subquestions of exercise 6

% Created by Kevin van Hastenberg. Version 1.0 for EM2 2023-2024

%% General Values
close all;
clear;
clc;

% Resolution value
resolution = 10^3;

%% Exercise 6a
close all;
clear;
clc;

% Define refractive indices
n1_1 = 1.5;
n2_1 = 2;
n1_2 = 3;
n2_2 = 1.2;

% Define angle of incidence
theta1 = linspace(0, pi/2, 1000);

% Calculate angle of refraction
theta2_1 = asin((n1_1/n2_1) * sin(theta1));
theta2_2 = asin((n1_2/n2_2) * sin(theta1));

% Plot the results
figure;
plot(theta1, theta2_1, 'b', 'LineWidth', 2);
hold on;
plot(theta1, theta2_2, 'r', 'LineWidth', 2);
grid on;
xlabel('Angle of Incidence \theta_1 (rad)');
ylabel('Angle of Refraction \theta_2 (rad)');
legend('n1 = 1.5, n2 = 2', 'n1 = 3, n2 = 1.2');
title('Snell''s Law: Angle of Refraction vs. Angle of Incidence');
xlim([0 pi/2]);
ylim([0 pi/2]);
%% Exercise 6b
resolution = 10^3;
theta1 = linspace(0, pi/2, resolution);
theta2 = linspace(0, pi/2, resolution);
[THETA1, THETA2] = meshgrid(theta1, theta2);

% Calculate the contrast n2/n1
contrast = sin(THETA1) ./ sin(THETA2);

% Plot the contour
figure;
contourf(theta1, theta2, log10(contrast), 10, 'linewidth', 3);
colorbar;
xlabel('Angle of Incidence \theta_1 (rad)');
ylabel('Angle of Refraction \theta_2 (rad)');
title('Contour Plot of log10(n2/n1)');


%% Exercise 6c

% Parameters
theta1 = pi/4;
n1 = 1;
a = 1.5;
b = 0.5;
t = 4;

% Define wavelengths (in micrometers)
lambda = linspace(0.4, 0.7, 7);

% Calculate the refractive index for each wavelength
n2 = a + b ./ lambda.^2;

% Calculate angle of refraction for each wavelength
theta2 = asin((n1 ./ n2) * sin(theta1));

% Plot the dispersion
figure;
% Create a black rectangle to represent the medium below the interface
patch([-1 4 4 -1], [0 0 -10 -10], 'k'); 

% Create a cyan rectangle to represent the medium above the interface
patch([-1 4 4 -1], [0 0 1 1], 'c'); 

% Set the transparency of the patches to 20%
alpha(0.2); 

% Hold the current plot so that the next plot commands don't erase the existing plot
hold on; 

% Draw a line representing the incident wave, starting at (-sin(theta1), cos(theta1)) and ending at (0, 0)
line([-sin(theta1) 0], [cos(theta1) 0], 'color', 'k', 'LineWidth', 3); 

% Set the axes limits for the plot
axis([-1 4 -10 1]); 

% Plot the refracted rays for each wavelength
% x-coordinates go from 0 to 10*sin(theta2) and y-coordinates go from 0 to -10*cos(theta2)
h = plot([zeros(1,7); 10*sin(theta2)], [zeros(1,7); -10*cos(theta2)], 'LineWidth', 3); 

% Set the colors of the refracted rays to represent the colors of the visible spectrum
set(h, {'color'}, num2cell([143 0 255; 0 0 255; 0 255 255; 0 255 0; 255 255 0; 255 165 0; 255 0 0]/255, 2)); 

xlabel('x (m)');
ylabel('z (m)');
title('Dispersion of Visible Light');


%% Function A
function theta_2=functiona%(??)
%     theta_2 = 
end

function [] = plota(Theta_1, Theta_2)
    figure();
    plot(Theta_1, Theta_2);





    % Figure settings
    grid on
    xlabel('Angle of Incidence \Theta_1')
    ylabel('Angle of Refraction \Theta_2')
    xlim([0 pi/2])
    ylim([0 pi/2])
    set(gca, 'XTick', 0: pi/4: pi/2)
    set(gca, 'XTickLabel', {'0', '\pi/4', '\pi/2'})
    set(gca, 'YTick', 0: pi/4: pi/2)
    set(gca, 'YTickLabel', {'0', '\pi/4', '\pi/2'})
end


%% Function C
function []=functionC%(??)
%     lambda = linspace(??,??,7); % Hint: split 'white' light up in it's wavelength, for this code consider just seven colors in the visible spectrum

%     n2 = 
%     theta_2 = 




    % Figure settings
    figure
    patch([-1 4 4 -1],[0 0 -10 -10],'k')
    patch([-1 4 4 -1],[0 0 1 1],'c')
    alpha(0.2)
    hold on
    line([-sin(theta1) 0],[cos(theta1),0],'color','k','LineWidth',3);
    axis([-1 4 -10 1])
    h = plot([zeros(1,7);10*sin(theta_2)],[zeros(1,7);-10*cos(theta_2)],'LineWidth',3);
    set(h, {'color'}, num2cell([143 0 255;0 0 255;0 255 255;0 255 0;255 255 0;255 165 0;255 0 0]/255, 2));
    xlabel('x (m)');
    ylabel('z (m)');
end
