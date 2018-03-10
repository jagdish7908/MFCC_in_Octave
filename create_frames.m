 function frame = create_frames(y, Fs, Fsize, Fstep)
  N = length(y);
  % divide the signal into frames with overlap = framestep
  samplesPerFrame = floor(Fs*Fsize);
  samplesPerFramestep = floor(Fs*Fstep);
  i = 1;
  frame = [];
  while(i <= N-samplesPerFrame)
    frame = [frame y(i:(i+samplesPerFrame-1))];
    i = i+samplesPerFramestep;
  endwhile
  return 
 endfunction