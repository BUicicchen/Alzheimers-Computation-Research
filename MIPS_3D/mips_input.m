function [I] = mips_input(direction)
    % 455 sinosoid
    % 300 grayscale left, 100 grayscale right
    % total aperture + grayscale size: 656
    
    close all
    A = 10;
    ft = 1;
    fs = 1;
    x = 0.01:0.01:4.5;
    count = 1;
    I = zeros(1450,455);
    gaus = fspecial('gaussian',[1 450],170);
    
%     figure(1);
%     plot(t,A*sin(2*pi*ft*t - 2*pi*fs*0) + 10.* gaus);
    for t = 0.01:0.01:4.49
        if direction == "right"
            L = A*sin(2*pi*fs*x - 2*pi*ft*t) + 10;
        elseif direction == "left"
            L = A*sin(2*pi*fs*x + 2*pi*ft*t) + 10;
        end
        L = L .* gaus;
        
        I(1:500,count) = 0.012;
        I(501:950,count) = L;
        I(950:1450,count) = 0.012;
        count = count + 1;
%         figure(1);
%         plot(x,L);
%         title(num2str(t*100));
%         set(gcf,'name','Input motion: '+direction,'numbertitle','off')
    end
%     figure(1);
%     plot(-7.24:0.01:7.25,I(:,448));
end