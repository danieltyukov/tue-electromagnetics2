% Define the dimensions of the waveguide
a = 0.2; % meters
b = 0.1; % meters
c = 0.05; % meters

% Speed of light
c0 = 3e8; % meters/second

% Initialize an array to store the modes
modes = [];

% Iterate over possible values of n, m, p
for n = 1:10
    for m = 1:10
        for p = 1:10
            % Calculate the resonant frequency for each combination of n, m, p
            freq = (c0 / 2) * sqrt((n / a)^2 + (m / b)^2 + (p / c)^2);
            % Store the mode and its frequency
            modes = [modes; n, m, p, freq];
        end
    end
end

% Sort the modes by frequency
modes = sortrows(modes, 4);

% Display the first 100 modes
first_100_modes = modes(1:100, :)
