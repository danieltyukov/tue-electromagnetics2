%% Student template for visualizing bounces on PEC SLT-F Exercise 6.

% Created by Kevin van Hastenberg. Version 1.0 for EM2 2023-2024

clear all; close all; clc

%This code is a simplified representation of EM waves bouncing on a medium.
%The parameters width and velocity for instance are in unit wavelength so
%that the code does not take frequency into account. Please play with the
%parameters and don't forget to define the equations in the second section
%of this code!
%% Animation of wave reflection and tranmission in a planar discontinuity
%user settings
n1 = ; n2 = ; %medium refractive indeces

v1 = ; %velocity (is defined here as a integer, use 2 for instance. Is not related to speed of light as this would be too fast to see)

width1 = ; %width/wavelength of Sin/Triangular/Block pulse

skew = ; %skew of triangular pulse


waveform='sin'; %block,triangular,sin,step

%% Fill in these equations:
R = ; %reflection
T = ;  %Transmission

v2 = ; %velocity 2nd medium

width2 = ; %width of wave 2nd medium (for block wave etc)


%% setup 
fig = figure;
linkdata on
set(fig,'units','normalized','outerposition',[0 0 1 1]);
z = linspace(-10,10,2000);

if(n2==0)
    width2=0;
end

for ii = 0:0.1:300 %time loop
    switch waveform
        case 'triangular'
            wave_i = tripulse(z-v1*ii+10,skew,width1).*(z<0);
            wave_r = R*(tripulse(-(z+v1*ii-10),skew,width1)).*(z<0);
            wave_t = T*(tripulse(z-v2*(ii-10/v1),skew,width2)).*(z>0);

        case 'sin'
            wave_i = sinpulse(z-v1*ii+10,width1).*(z<0);
            wave_r = R*(sinpulse(-(z+v1*ii-10),width1)).*(z<0);
            wave_t = T*(sinpulse(z-v2*(ii-10/v1),width2)).*(z>0);

        case 'step'
            wave_i= steppulse(z-v1*ii+10).*(z<0);
            wave_r=R*(steppulse(-(z+v1*ii-10))).*(z<0);
            wave_t=T*(steppulse(z-v2*(ii-10/v1))).*(z>0);

        case 'block'
            wave_i= blockpulse(z-v1*ii+10,width1).*(z<0);
            wave_r=R*(blockpulse(-(z+v1*ii-10),width1)).*(z<0);
            wave_t=T*(blockpulse(z-v2*(ii-10/v1),width2)).*(z>0);
    end


    wave_i(1001:end)=NaN;
    wave_r(1001:end)=NaN;
    wave_t(1:1000)=NaN;


    plot(z,wave_r,'b','linewidth',3); hold on;
    plot(z,wave_r+wave_i,'--k','LineWidth',3);
    plot(z,wave_i,'r','linewidth',3);

    plot(z,wave_t,'c','linewidth',3);
    hold off;
    title(strcat('t=',num2str(ii)))
    patch([0 0 10 10],[-3 3 3 -3],'k')
    alpha(.1)
    axis([-10 10 -3 3]);
    h = text(-6,1.1,['n_1 = ' num2str(n1)]);
    set(h,'fontsize',22,'fontweight','bold')
    h=text(4,1.1,['n_2 = ' num2str(n2)]);
    set(h,'fontsize',22,'fontweight','bold')
    legend('Reflected wave','Total wave (medium 1)','Incident wave','Transmitted wave')
    drawnow
%     pause(.05);
%     exportgraphics(gcf,'testAnimated.gif','Append',true);
end

%% Functions
function wave = blockpulse(z,width)
wave = (z<=0).*(z>=(0-width));
end

function wave = steppulse(z)
wave = (z<=0);
end

function wave = tripulse(z,skew,width)
wave = max(min((z+width)/(skew*width/(skew-1)+width),-z/(skew*width/(1-skew))),0);
end

function wave = sinpulse(z,width)
wave = sin(2*pi*z/width).*(z<=0);
end