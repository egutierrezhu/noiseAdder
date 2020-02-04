% Color noise adder
% Author: eulogio g. h.		04/02/2020 
% #########################################
clear, clc, close all

% command path
path0='testing_set_color_5_35db/';
word='stop'; % commands 'backward', 'forward', etc
path = [path0 word];

% signal read
List = dir(path);
N = size(List);

for i=3:N(1)
    filename = strcat(path,'/',List(i).name)
    
    %add noise
    [au,Fs] = audioread(filename);
    s=au';

    % signal parameters
    N=length(s);        % number of samples
    t = (0:N-1)/Fs;     % time vector
    
    % noise generation
    a = 5; b = 35;                  % SNR, dB. Generate values from the uniform distribution  
    SNR = a + (b-a).*rand(1,1);     % on the interval (a, b)
    Ps = 10*log10(std(s).^2);       % signal power, dBV^2
    Pn = Ps - SNR;                  % noise power, dBV^2
    Pn = 10^(Pn/10);                % noise power, V^2
    sigma = sqrt(Pn);               % noise RMS, V
    if mod(i,4) == 1
        n = sigma*bluenoise(1, N);      % blue noise generation
    elseif mod(i,4) == 2
        n = sigma*pinknoise(1, N);      % pink noise generation
    elseif mod(i,4) == 3
        n = sigma*rednoise(1, N);       % red noise generation
    else
        n = sigma*violetnoise(1, N);    % violet noise generation
    end
    x = s + n;                      % signal + noise mixture

    %signal write
    audiowrite(filename,x,Fs);
end

% [a,Fs] = audioread(filename);
% sound(a,Fs);
