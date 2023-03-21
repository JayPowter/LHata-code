% Define parameters
d = 1:0.1:10; % distance in km
f = 1800; % frequency in MHz
h_BS = 8; % height of base station in meters
h_MS = 1; % height of mobile station in meters

% Hata model
%AHM_suburban = 3.2 * (log10(11.75*h_MS))^2 - 4.97;
%AHM_open_rural = 3.2 * (log10(11.75*h_MS))^2 - 2.7;
%AHM_medium_cities = 3.2 * (log10(11.75*h_MS))^2 - 1.1;
%AHM_large_cities = 3.2 * (log10(11.75*h_MS))^2 - 0.7;

%LH_suburban = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - AHM_suburban ...
   % + (44.9 - 6.55*log10(h_BS))*log10(d);
%LH_open_rural = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - AHM_open_rural ...
   % + (44.9 - 6.55*log10(h_BS))*log10(d);
% Suburban area
LH_suburban = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - (1.1*log10(f)-0.7)*h_MS + 1.56*log10(f)- 0.8 - 2*(log10(f/28))^2 - 5.4 + (44.9 - 6.55*log10(h_BS))*log10(d); 
    
% Open rural area
LH_open_rural =  69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - (1.1*log10(f)-0.7)*h_MS + 1.56*log10(f)- 0.8 - 4.78* (log10(f))^2 + 18.33*log10(f) - 40.98 + (44.9 - 6.55*log10(h_BS))*log10(d); 

% Path loss for small-medium sized cities
LH_medium_cities = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - (1.1*log10(f)-0.7)*h_MS + 1.56*log10(f)- 0.8 + (44.9 - 6.55*log10(h_BS))*log10(d);


% Path loss for large cities

LH_large_cities_1 = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - 8.29*(log10(1.54*h_MS))^2 + 1.1 + (44.9 - 6.55*log10(h_BS))*log10(d);
LH_large_cities_2 = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - 3.2*(log10(11.75*h_MS))^2 + 4.92 + (44.9 - 6.55*log10(h_BS))*log10(d);


%LH_medium_cities = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - AHM_medium_cities ...
   % + (44.9 - 6.55*log10(h_BS))*log10(d);
%LH_large_cities = 69.55 + 26.16*log10(f) - 13.82*log10(h_BS) - AHM_large_cities ...
   % + (44.9 - 6.55*log10(h_BS))*log10(d);

% Theoretical Free Space Path Loss
lambda = 3e8 / (f*1e6); % Wavelength in meters
FSPL = 20*log10(4*pi*d./lambda);


figure;
plot(d, LH_suburban, 'g-', d, LH_open_rural, 'y-', d, LH_medium_cities, 'm-', d, LH_large_cities_1, 'r-', d, LH_large_cities_2,'b--', d, FSPL, 'r--', 'LineWidth', 2);
grid on;
xlabel('Distance (km)');
ylabel('Path Loss (dB)');
title('Path Loss vs Distance for Different Environments for 1800MHz');
legend('Hata Model (Suburban)', 'Hata Model (Open Rural)','Hata Model (Medium-sized Cities)', 'Hata Model (Large Cities f<200MHz)','Hata Model (Large Cities f>200MHz)', 'Free Space Path Loss') 

