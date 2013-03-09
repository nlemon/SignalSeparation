load train_bird.mat

N = length(y);
Y = fft(y)/N;
m = abs(Y);
low = zeros(N, 1);
high = zeros(N, 1);

%high pass filter. Zeros out everything in the first and last quarter of Y,
%leaves everything in the midlle two quarters the same. This will isolate
%the bird sounds.

for i = 1 : N
    if i <= (N/4) || i > ((3 * N)/4)
        high(i) = 0;
    else
        high(i) = Y(i);
    end
end

%low pass filter. Zeros out eveything in the midlle two quarters of Y,
%leaves eveything in the first and last quarters the same. This will 
%isolate the train sound.

for i = 1 : N
    if i <= (N/4) || i > ((3 * N)/4)
        low(i) = Y(i);
    else
        low(i) = 0;
    end
end

figure
subplot(2, 1, 1)
stem(y)
title('original signal', 'FontWeight', 'bold')
subplot(2, 1, 2)
stem(m)
title('magnitude of DFT', 'FontWeight', 'bold')

%map the modified dft back to a set of modified data points
high_inverse = real(ifft(high)) * N;

figure
subplot(2, 1, 1)
stem(high_inverse)
title('high filtered data set', 'FontWeight', 'bold')
soundsc(high_inverse, Fs)

%map the modified dft back to a set of modified data points
low_inverse = real(ifft(low)) * N;

subplot(2, 1, 2)
stem(low_inverse)
title('low filtered data set', 'FontWeight', 'bold')
soundsc(low_inverse, Fs)