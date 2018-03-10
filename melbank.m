function bank = melbank(n, min, max, sr)
  % n = number of banks
  % min = min frequency in hertz
  % max = max frequency in hertz 
  % convert the min and max freq in mel scale
  NFFT = 512;
  % figure out bin value of min and max freq
  minBin = floor((NFFT)*min/(sr/2));
  maxBin = floor((NFFT)*max/(sr/2));
  % convert the min, max in mel scale
  min_mel = hz2mel(min);
  max_mel = hz2mel(max);
  m = [min_mel:(max_mel-min_mel)/(n+2-1):max_mel];
  %disp(m);
  h = mel2hz(m);
  % replace frequencies in h with thier respective bin values
  fbin = floor((NFFT)*h/(sr/2));

  %disp(h);
  % create triangular melfilter vectors
  H = zeros(NFFT,n);
  for vect = 2:n+1
    for k = minBin:maxBin
      
      if k >= fbin(vect-1) && k <= fbin(vect)
        H(k,vect) = (k-fbin(vect-1))/(fbin(vect)-fbin(vect-1));  
      elseif k >= fbin(vect) && k <= fbin(vect+1)
        H(k,vect) = (fbin(vect+1) - k)/(fbin(vect+1)-fbin(vect));
      endif
      
    endfor
  endfor
  bank = H;
  return
 endfunction     