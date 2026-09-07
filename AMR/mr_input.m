function [I,I_x1,I_y1,I_x2,I_y2] = mr_input(theta)
    close all
    M(80) = struct('cdata',[],'colormap',[]);
    I = zeros(400,400,80);
    disp(size(I));
    I_x1 = zeros(1,400);
    I_y1 = zeros(1,400);
    I_x2 = zeros(1,400);
    I_y2 = zeros(1,400);
    p = 5;
    pos = 1:400;
    y_d = 200 - (200-pos) .* tand(theta/2);
    for t = 1:400
        if (p <= 400)
            I_x1(p) = p;
            I_y1(p) = y_d(p);
            I_x2(p) = p;
            I_y2(p) = 400-y_d(p);
            if (I_y1(p) > 0 && I_y1(p) <= 400)
                I(round(I_y1(p)),round(I_x1(p)),t) = 1;
            else
                I(t,t,t) = 1;
            end
            if (I_y2(p) > 0 && I_y2(p) <= 400)
                I(round(I_y2(p)),round(I_x2(p)),t) = 1;
            else
                I(t,t,t) = 0;
            end
            p = p + 5;
            
            % % display input movie
            % [X,Y] = meshgrid((1:400),(1:400));
            % pcolor(X,Y,I(:,:,t));
            % set(gcf,'name','','numbertitle','off')
            % axis square
            % title(num2str(t));
            % shading interp
            % drawnow
            % M(t) = getframe;
        end
    end
    
    if theta == 90 % solve index out of bound
        I_y2(400) = 1;
    end
    I_x1 = nonzeros(I_x1)';
    I_y1 = nonzeros(I_y1)';
    I_x2 = nonzeros(I_x2)';
    I_y2 = nonzeros(I_y2)';
end