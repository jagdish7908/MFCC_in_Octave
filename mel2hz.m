 function ans = mel2hz(f)
  ans = 700*(exp(f/1125) - 1);
  return
 endfunction