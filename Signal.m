Fs = 44100;
image = imread('imageImported.jpg');
image = imresize(image, [32 32]);
image = double(image);
image = image / max(image(:));
[rows, columns] = size(image);

scale = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25];
numNotes = length(scale);
t = 0:1/Fs:0.2;

musicSignal = [];
for r = 1:rows
    rowSignal = zeros(size(t));
    for c = 1:columns
        noteIdx = mod(c-1, numNotes) + 1;
        freq = scale(noteIdx);
        amp = image(r, c);
        rowSignal = rowSignal + amp * sin(2*pi*freq*t);
    end
    musicSignal = [musicSignal, rowSignal];
end

musicSignal = musicSignal / max(abs(musicSignal));
Sound(musicSignal, Fs);
audiowrite('image_to_music.wav', musicSignal, Fs);

figure;
spectrogram(musicSignal, 256, 250, 256, Fs, 'yaxis');
title('Spectrogram of Image-Music Signal');






















