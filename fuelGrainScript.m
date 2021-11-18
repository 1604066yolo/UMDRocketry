%% Fuel Grain Script
%Dominic Adamo 11/17/2021
%Goal is to iterate Area of bore to solve for Length of grain

%% First Try

%Constants
%mdotox constants
    OFratio = 7;
    Aox = 5.938e-6 %m^2
    Cdox = .61; %spooky? check this in textbook
    rho_ox = 920; %kg/m^3
    Pox = 
    P0 = 
%




%Start off with finding mdotox
mdotox = Aox*Cdox*sqrt(2*rho_ox*(Pox-P0));

%O/F Ratio is known, use to find mdotf
%OFratio = mdotox/mdotf
mdotf = mdotox/OFratio;

%iterate through Abs, add some constraints - pick around isp and stuff
for Ab = [.1:.001:1] %pick actual numbers in correct units

    %Get regression rate from mdotf
    rdot = mdotf/(Ab*rhof);          %does this Ab change through the burn?

    %use other rdot eqn to solve for L
    L = mu*(((rdot*Pr^.153*rhof)/(.047*((Cp*T0-Tf)/hvf)^.23*(mdotox/Achamber)^(4/5)))^5;

end








