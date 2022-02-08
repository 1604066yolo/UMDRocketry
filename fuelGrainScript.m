%% Fuel Grain Script
%Dominic Adamo 2/8/2022
%Goal is to iterate Area of bore to solve for Length of grain

%% First Try, N circular ports
clear;
clc;



%Constants
%mdotox constants
OFratio = 7;
Aox = 5.938e-6; %m^2
Cdox = .61; %spooky? check this in textbook
rho_ox = 920; %kg/m^3   TOTAL GUESS GET NUMBER
rhof = 920; %kg/m^3
Pox = 3e6;     % TOTAL GUESS GET NUMBER
P0 = 2.3e6; %Pa, TOTAL GUESS GET NUMBER
N = 1; %Number of circular ports
R0 = 0.0889;%outer grain radius meters
a = .198;
n = .325;




%Start off with finding mdotox
mdotox = Aox*Cdox*sqrt(2*rho_ox*(Pox-P0));

%O/F Ratio is known, use to find mdotf
%OFratio = mdotox/mdotf
mdotf = mdotox/OFratio; %want OF ratio of 7, to get this need this mdotF

%iterate through bore radius
for Ri = [6.35:6.35:31.75]/1000 %meters (inner radius of chamber is 3.5 inches)
    for t = [0:.1:60] %s             %set long burn time and only keep values that are real? check back
    %have an initial Ab0, then an Ab in the loop since Ab changes
    %throughout the burn

    %Get regression rate from mdotox (16-10)
    rdot = a*(mdotox/(pi*Ri^2))^n;
    
    %Combustion port radius over time (16-13)
    R = (a*(2*n+1) * (mdotox/(pi*N))^n * t + Ri^(2*n+1))^(1/(2*n+1));
    
    if R>R0
        disp("Ri = "+Ri*39.37+", t_burn = "+t+", L = "+L*39.37) %39.37 is conversion from m to in
       break; %Burn done, breaks burn time loop, test this
    end
    
    %Length based off mdotf
    L = mdotf/(2*pi*rhof*Ri*rdot);
    end
end



%     %use other rdot eqn to solve for L
%     L = mu*(((rdot*Pr^.153*rhof)/(.047*((Cp*T0-Tf)/hvf)^.23*(mdotox/Achamber)^(4/5)))^5;

%Length based on fuel consumed (16-14)
%L = mdotf/(2*pi*N*rhof*a*(mdotox/(pi*N))^n*(a*(2*n+1)*(mdotox/(pi*N))^n*t+Ri^(2*n+1))^((1-2*n)/(1+2*n)));


