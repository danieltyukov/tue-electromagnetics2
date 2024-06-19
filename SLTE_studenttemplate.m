%% Example code for visualizing EM waves (plane wave in z-direction).
% Script meant for student distribution as an example to exercise 6 of SLT-F
% Created by Kevin van Hastenberg. Version 1.0 for EM2 2022-2023

clear all; close all; clc

%% Fill in variables here (some are missing!)
Ex = 1; % amplitude of x-component of E-field
Ey = 0; % amplitude of y-component of E-field (for linear polarization)
Ez = 0; % amplitude of z-component of E-field

f = 461e12; % Frequency in Hz

w = 2*pi*f; % angular frequency
period = 1/f;
N_period = 4; % amount of periods to plot
R_scale = 5; % amount of multiples of 4 points per period to be plotted, makes for a smoother curve but longer calculation

t = linspace(0, N_period*period, R_scale*4*N_period+1); % time vector. keep at least a multiple of 4 per period so that you have the maxima/minima

%% (a) Attenuating-travelling wave in +z-direction
alpha = 0.1; % attenuation constant
kz = 2*pi / (3e8 / f); % wave number
Etx = Ex * exp(-alpha * t) .* cos(w * t - kz * t); % Calculate the time-dependent vector of x with attenuation

%% plotting in 3D for part (a)
if(Ex == 0) % for plotting purposes if Ey or Ex is not defined
    Ex = 0.5;
elseif(Ey == 0)
    Ey = 0.5;
end
maxlim = max([Ex Ey]);
figure
plot3(real(t), real(Etx), zeros(1, length(t))); % for multiple components of the E-field replace the zeros command by the Ety vector
xlim([0 N_period*period]);
ylim([-maxlim maxlim]);
zlim([-maxlim maxlim]);
xlabel('Time (s)');
ylabel('E_x (V/m)');
zlabel('E_y (V/m)');
grid on;
title('Attenuating-travelling wave in +z-direction')

%% animating in 3D for part (a)
if(Ex == 0) % for plotting purposes if Ey or Ex is not defined
    Ex = 0.5;
elseif(Ey == 0)
    Ey = 0.5;
end
f = figure;
% create first frame
plot3(real(t(1)), real(Etx(1)), 0);
grid on;
title('Attenuating-travelling wave in +z-direction')
xlim([0 N_period*period]); % put limits here to stop the axis from moving in the gif
ylim([-Ex Ex]);
xlabel('Time (s)');
ylabel('E_x (V/m)');
zlabel('E_y (V/m)');
grid on;
[imind, cmap] = rgb2ind(getframe(f).cdata, 256, 'dither'); % convert figure in f to image
imwrite(imind, cmap, 'AttenuatingWave.gif', 'gif', 'LoopCount', Inf, 'DelayTime', 0.1); % Writes a gif to AttenuatingWave.gif with infinite loops and delay time 0.1s per frame. Change AttenuatingWave.gif to your desired path+filename

% loop for all additional frames
for index = 2:length(t)
    plot3(real(t(1:index)), real(Etx(1:index)), zeros(1, index));
    grid on;
    title('Attenuating-travelling wave in +z-direction')
    xlim([0 N_period*period]); % put limits here to stop the axis from moving in the gif
    ylim([-Ex Ex]);
    xlabel('Time (s)');
    ylabel('E_x (V/m)');
    zlabel('E_y (V/m)');
    % create frame
    [imind, cmap] = rgb2ind(getframe(f).cdata, 256, 'dither');
    imwrite(imind, cmap, 'AttenuatingWave.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.1); % change AttenuatingWave.gif to your desired path+filename
end

%% (b) Right-handed circularly polarized PW in +z-direction
Etx_circular = Ex * cos(w * t - kz * t);
Ety_circular = Ex * sin(w * t - kz * t);

figure
plot3(real(t), real(Etx_circular), real(Ety_circular));
xlim([0 N_period*period]);
ylim([-maxlim maxlim]);
zlim([-maxlim maxlim]);
xlabel('Time (s)');
ylabel('E_x (V/m)');
zlabel('E_y (V/m)');
grid on;
title('Right-handed circularly polarized PW in +z-direction')

%% (c) Left-handed elliptically polarized PW in +z-direction
Etx_elliptical = Ex * cos(w * t - kz * t);
Ety_elliptical = 0.5 * Ex * sin(w * t - kz * t);

figure
plot3(real(t), real(Etx_elliptical), real(Ety_elliptical));
xlim([0 N_period*period]);
ylim([-maxlim maxlim]);
zlim([-maxlim maxlim]);
xlabel('Time (s)');
ylabel('E_x (V/m)');
zlabel('E_y (V/m)');
grid on;
title('Left-handed elliptically polarized PW in +z-direction')

%% (d) Left-handed polarized PW with phase difference of 60 degrees in +z-direction
phase_diff = pi / 3; % 60 degrees phase difference
Etx_phase = Ex * cos(w * t - kz * t);
Ety_phase = Ex * cos(w * t - kz * t + phase_diff);

figure
plot3(real(t), real(Etx_phase), real(Ety_phase));
xlim([0 N_period*period]);
ylim([-maxlim maxlim]);
zlim([-maxlim maxlim]);
xlabel('Time (s)');
ylabel('E_x (V/m)');
zlabel('E_y (V/m)');
grid on;
title('Left-handed polarized PW with 60 degrees phase difference in +z-direction')

% Animation for (b), (c), (d) can be done similarly by modifying the above code for each scenario.

