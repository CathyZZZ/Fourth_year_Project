%% variables
file_name = 'final6.csv';
z_index = 3;                        % index of variable listed in 'z_names' to be plotted
length_norm = 2.00;                 % normalised length factor
points_per_x = 101;
target_Temperature=1073;
xstartat=0.46;
verifymassflowrate=0;
verifyDiffusionrate=1;
crosssection = 0;
% %% data processing
global  columnofpositionY columnofpositionZ columnofvx columnofN

if verifymassflowrate == 1
M = csvread(file_name, 1, 0);
figure
hold on;
for j=0:159
    
    xstartat= j.* 0.01;
    x_position = j.* length_norm ./(num_x -1);
    rowstart=(xstartat/0.01*101)+1;
    rowend=rowstart+50;
    P=zeros(52,3);
    P(52,1)=0.0425;
    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        %fprintf('%d %d\n', i, m)
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end   
    % Plot mass flow at each cross-section
    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,2) = M(ii,columnofrho) .* M(ii,columnofvx) .*pi .*(P(m+1,1).^2-(P(m,1)).^2);%% sum of rho*v*dA
        %P(m,2) = M(i,3) .*pi .*(P(m+1,1).^2-(P(m,1)).^2); % sum of Nair dA
        if m>1 
            P(m,3)=P(m-1,3)+P(m,2);
        else
            P(m,3) = P(m,2);
        end
    end
    w=scatter(x_position, P(m,3),'*');
end
xlabel('Longitudinal distance from the inlet,(m)');
ylabel('Mass flow at each cross section,(kg/s)');
%ylim([2*10^(-5) 3*10^(-5)])
grid on
grid minor
hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Calculate N at each cross-section and calculate the total number of particles at different x-distance.
if verifyDiffusionrate ==1
M = csvread(file_name, 1, 0);
figure
hold on;

%D = 1.86 * 10^(-5);
k = 7500000%5942110.212;
tem1 = 14.5;%%19.38637;
for j=0:159
   % j=10;
    xstartat= j ./159 .*2;
    rowstart=(j*101)+1;
    rowend=rowstart+50;
    P=zeros(52,3);
    P(52,1)=0.0425;

    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end

    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,2) = M(ii,columnofN) .*pi .*(P(m+1,1).^2-(P(m,1)).^2); % sum of N dA
        if m>1 
            P(m,3)=P(m-1,3)+P(m,2);
        else
             P(m,3) = P(m,2);
        end
    end
    w=scatter(xstartat, P(m,3)*0.0126./(pi*0.0425^2),'r');
    if j==2
        cat = P(m,3);
    end
end

xlabel('Longitudinal distance from the inlet, x (m)');
ylabel('Number concentration of particle at each cross section, N (#/m^3)');
grid on
grid minor
%y0 = 10^14 * pi * (42.5 *10^(-3))^2;
%y0 =4 *10^11;
y0= 915000000000;%888521015202.73;
for x=0.1:0.01:2
    h = (x-0.1)./tem1;
    if h < 0.0156
        y=y0 *( 1 - 4.07 * h^(2/3) + 2.4 * h + 0.446 * h^(4/3));
    else
        y = y0 * 0.819 * exp(-7.315 * h) + 0.0976 * exp(-44.61 * h) + 0.0325 * exp(-114 * h);
    end
        w=plot(x, y,'-bp');
end
hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%crosssection%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if crosssection ==1
M = csvread(file_name, 1, 0);
figure
hold on;


for j=0:10   
    
   % figure(j+1), hold on;
    xstartat= j.* 0.01;
    rowstart=(xstartat*16/0.01*101)+1;
    rowend=rowstart+50;
    P=zeros(52,3);
    P(52,1)=0.0425;

    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end

    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,2) = M(ii,columnofN)
    end
    w=plot(P(:,2), P(:,1));
    set(w,'LineWidth',4); 
 hold on
end
Legend=cell(10,1)
%Legend{1}=strcat('x =' );
    for iter=1:10
        Legend{iter}=strcat('x =',num2str(2./10 .* iter),'m' );
    end
legend(Legend)

xlabel('Number concentration of particles,N(#/m^3)');
ylabel('Radial distance(m)');
end