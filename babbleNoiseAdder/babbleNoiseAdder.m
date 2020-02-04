% Babble noise adder
% Author: eulogio g. h.		04/02/2020 
% #########################################
clear, clc, close all

% command path
path0='testing_set_babble_11_20db/';
word='stop'; % commands 'backward', 'forward', etc
path = [path0 word];

% signal read
List = dir(path);
N = size(List);

for i=3:N(1)
    filename = strcat(path,'/',List(i).name)
    
    %add noise    
    [au,Fs] = audioread(filename);
    % signal read Fs=16kHz
    if Fs ~= 16000
        error('Sample frequency of input file is incorrect.');
    end
    s = au';
    
    % signal parameters
    N = length(s);              % number of samples
    t = (0:N-1)/Fs;             % time vector

    % noise generation
    a = 11; b = 20;              % SNR, dB. Generate values from the uniform distribution  
    SNR = a + (b-a).*rand(1,1); % on the interval (a, b)
    Ps = 10*log10(std(s).^2);   % signal power, dBV^2
    Pn = Ps - SNR;              % noise power, dBV^2
    Pn = 10^(Pn/10);            % noise power, V^2
    sigma = sqrt(Pn);           % noise RMS, V
    
    % babble noise
    [b8,Fs8] = audioread('babble_8kHz.wav');
    % babble noise signal read Fs=8kHz
    if Fs8 ~= 8000
        error('Sample frequency of input file is incorrect.');
    end
    
    % interpolate, R=2
    b16 = interp(b8,2);
    % b16 of lenght N
    No = randi(length(b16)+1-N);
    y = b16(No:No-1+N)';
    y = reshape(y, [1, N]);
    y = bsxfun(@minus, y, mean(y));
    y = bsxfun(@rdivide, y, std(y));
    n = sigma*y;                % babble noise generation
    x = s + n;                  % signal + noise mixture

    %signal write
    audiowrite(filename,x,Fs);
end

% [a,Fs] = audioread(filename);
% sound(a,Fs);
