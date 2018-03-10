% Author: Jagdish Chaudhary
% jchaudhary7908@gmail.com

clc;
clear all;
close all;
pkg load signal;

% record audio
Fs = 44100;
y = record(3,44100);
% OR %
% Load existing file
%[y, Fs] = wavread('../FILE_PATH/');
%y = y(44100:2*44100);
 
 % create mel filterbanks
 minFreq = 500;   % minimum cutoff frequency in Hz
 maxFreq = 10000;   % maximum cutoff frequency in Hz
% melbank(number_of_banks, minFreq, mazFreq, sampling_rate)
 foo = melbank(30,minFreq,maxFreq,Fs);

 % create frames
 frames = create_frames(y, Fs, 0.025, 0.010);
 % calculate periodogram of each frame
 NF = length(frames(1,:));
 [P,F] = periodogram(frames(:,1),[], 1024, Fs);
 % apply mel filters to the power spectra
 P = foo.*P(1:512);
 % sum the energy in each filter and take the logarithm
 P = log(sum(P));
 % take the DCT of the log filterbank energies
 % discard the first coeff 'cause it'll be -Inf after taking log
 L = length(P);
 P = dct(P(2:L));
 PXX = P;

 for i = 2:NF
  P = periodogram(frames(:,i),[], 1024, Fs);
   % apply mel filters to the power spectra
  P = foo.*P(1:512);
  % sum the energy in each filter and take the logarithm
  P = log(sum(P));
  % take the DCT of the log filterbank energies
  % discard the first coeff 'cause it'll be -Inf after taking log
  P = dct(P(2:L));
  % coeffients are stacked row wise for each frame
  PXX = [PXX; P];
 endfor
 % stack the coeffients column wise
 PXX = PXX';
 plot(PXX);

