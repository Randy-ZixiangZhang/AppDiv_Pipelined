%
close all;

x = 0.1:0.01:0.2;
y = 0:0.01:0.1;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));

Z = create_surface1(X,Y);

% for i = 1:size(x,2)
%     for j = 1:size(y,2)
%         Z(i,j) = create_surface1(x(i),y(j));
%     end
% end

%surf(X,Y,Z);
xlabel('m_a');
ylabel('m_b')


%options = fitoptions('Method', 'LinearLeastSquares')

[za,goodness] = fit([X(:),Y(:)],Z(:),'poly11')


plot(za,[X(:),Y(:)],Z(:));

c = coeffvalues(za)


b = [1.00534308 0.95311638 -1.04453393];
fmatlab = @(x,y) c(1) + c(2)*x + c(3) * y;
fpython = @(x,y) b(1) + x*b(2) + y*(b(3));

m_a = 0.19, m_b = 0.02;
(1+m_a)/(1+m_b)
fmatlab(m_a,m_b)
fpython(m_a,m_b)

function z = create_surface1(ma,mb)


        z = (1+ma)./(1+mb);%.*2;


end