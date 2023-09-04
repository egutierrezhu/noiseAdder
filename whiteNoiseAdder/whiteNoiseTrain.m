% White noise adder
% Author: eulogio g. h.		04/02/2020 
% #########################################
clear, clc, close all

% command path
path0='testing_set_white_5_35db/';
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
    a = 5; b = 35;              % SNR, dB. Generate values from the uniform distribution  
    SNR = a + (b-a).*rand(1,1); % on the interval (a, b)
    Ps = 10*log10(std(s)^2+mean(s)^2);   % signal power, dBV^2
    x = awgn(s,SNR,Ps);         % signal + white Gaussian noise

    %signal write
    audiowrite(filename,x,Fs);
end

% [a,Fs] = audioread(filename);
% sound(a,Fs);
