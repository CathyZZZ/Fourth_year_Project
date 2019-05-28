
%%Used to plot graphs of variable(P,T,U) at given xyz position.
%% variables
file_name = 'attempt3.csv';
global  radius num_x num_r length_norm points_per_x columnofD columnofN columnofNair columnofT columnofvx columnofvy columnofvz columnofP columnofrho columnofpositionX columnofpositionY columnofpositionZ Totalofcolumninfile;

z_index = 7;                        % P is 59, T is 6, U is 7,
length_norm = 2.00;                 % normalised length factor
points_per_x = 101;%3
%%%%%%%%%%%%%%%%%%%%%%%%%%final6%%%%%%%%%%%%%%%%%%%%%%
% target_Temperature = 1000;
% columnofD = 2;
% columnofN = 5;
% columnofNair =6;
% columnofT = 8;%4;%6;
% columnofvx = 9;%5;%7;
% columnofvy = 10;%6;%8;
% columnofvz = 11;%7;%9;
% columnofP = 20;%18%%%19%%%57%16;%59;
% columnofrho = 22;%20%%%21%%%59%18;
% columnofpositionX = 26%%%25%%%63%22;%65;
% columnofpositionY =27%%%26%%%64%23;%66;
% columnofpositionZ = 28%%%27%%%65%24;%67;
% Totalofcolumninfile =32%%%31%69 %28;%71;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%attempt3%%%%%%%%%%%%%%%%%%%
target_Temperature = 800;
points_per_x = 101;%3
columnofD = 1;
columnofN = 4;
%columnofNair =6;
columnofT = 6;%4;%6;
columnofvx = 7;%5;%7;
columnofvy = 8;%6;%8;
columnofvz = 9;%7;%9;
columnofP = 59;%18%%%19%%%57%16;%59;
columnofrho = 61;%20%%%21%%%59%18;
columnofpositionX = 65;%%%25%%%63%22;%65;
columnofpositionY =66;%%%26%%%64%23;%66;
columnofpositionZ = 67;%%%27%%%65%24;%67;
Totalofcolumninfile =71;%%%31%69 %28;%71;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%final5%%%%%%%%%%%%%%%%%%%
% target_Temperature = 800;
% columnofD = 1;
% columnofN = 4;
% columnofNair =6;
% columnofT = 6;%4;%6;
% columnofvx = 7;%5;%7;
% columnofvy = 8;%6;%8;
% columnofvz = 9;%7;%9;
% columnofP = 23;%18%%%19%%%57%16;%59;
% columnofrho = 25;%20%%%21%%%59%18;
% columnofpositionX = 29%%%25%%%63%22;%65;
% columnofpositionY =30%%%26%%%64%23;%66;
% columnofpositionZ = 31%%%27%%%65%24;%67;
% Totalofcolumninfile =35%%%31%69 %28;%71;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%final4%%%%%%%%%%%%%%%%%%%%
% target_Temperature = 800;
% columnofD = 2;
% columnofN = 5;
% columnofNair =6;
% columnofT = 8;%4;%6;
% columnofvx = 9;%5;%7;
% columnofvy = 10;%6;%8;
% columnofvz = 11;%7;%9;
% columnofP = 20;%18%%%19%%%57%16;%59;
% columnofrho = 22;%20%%%21%%%59%18;
% columnofpositionX = 26%%%25%%%63%22;%65;
% columnofpositionY =27%%%26%%%64%23;%66;
% columnofpositionZ = 28%%%27%%%65%24;%67;
% Totalofcolumninfile =32%%%31%69 %28;%71;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%final3%%%%%%%%%%%%%%%%%%%%
% target_Temperature = 800;
% columnofD = 1;
% columnofN = 2;
% columnofNair =1;
% columnofT = 3;%4;%6;
% columnofvx = 4;%5;%7;
% columnofvy = 5;%6;%8;
% columnofvz = 6;%7;%9;
% columnofP = 10;%18%%%19%%%57%16;%59;
% columnofrho = 11;%20%%%21%%%59%18;
% columnofpositionX = 12%%%25%%%63%22;%65;
% columnofpositionY =13%%%26%%%64%23;%66;
% columnofpositionZ = 14%%%27%%%65%24;%67;
% Totalofcolumninfile =20%%%31%69 %28;%71;
% %%%%%%%%%%%%%%%%%%%%%%%%
% columnofD = 1;
% columnofN = 2;
% columnofNair =3;
% columnofT = 6;%4;%6;
% columnofvx = 7;%5;%7;
% columnofvy = 8;%6;%8;
% columnofvz = 9;%7;%9;
% columnofP = 59;%18%%%19%%%57%16;%59;
% columnofrho = 61;%20%%%21%%%59%18;
% columnofpositionX = 65%%%25%%%63%22;%65;
% columnofpositionY =66%%%26%%%64%23;%66;
% columnofpositionZ = 67%%%27%%%65%24;%67;
% Totalofcolumninfile =71%%%31%69 %28;%71;
finddeltaT=0;
plotPTU_at_given_xyz_position=1;
plotpath = 0;
plotduration_with_temperature_greater_than_target =0;
findTfile=0;
%% data processing
M = csvread(file_name, 1, 0);
  num_x = (length(M)/points_per_x);
  num_r = (points_per_x + 1)/2;

    M(:,Totalofcolumninfile + 1 ) = sqrt(M(:,columnofpositionY).^2 + M(:,columnofpositionZ).^2); %radius
    M(:,Totalofcolumninfile + 2) = (sqrt(M(:,columnofvy).^2 + M(:,columnofvz).^2)).*sign(M(:,columnofpositionZ)); %velocity in r direction
    radius = M(points_per_x, Totalofcolumninfile + 1);
if plotPTU_at_given_xyz_position==1
    r = M(1:num_r, Totalofcolumninfile + 1)./radius;      % range of radius/length
    x = M(1:points_per_x:end, columnofpositionX)./length_norm;   % range of axial distance/total length
    % r = M(1:num_r, 12);      % range of radius/length
    % x = M(1:101:end, 7);
    [X,Y] = meshgrid(x, r);

    Z = 0*X;
    for i = 1:num_x
        Z(:,i) = M(1 + points_per_x*(i-1) : num_r + points_per_x*(i-1),z_index);
    end

    %plot
    surf(X, Y, Z);
    xlabel('longitudinal distance,x / L_0');
    ylabel('radial distance,r / R_0');
    zlabel('Temperature,K');
    c=colorbar;
    c.Label.String = 'Temperature,K';
    hold on

    %%%%%contour plot%%%%%%%%%%%%%%%%
    % figure; pcolor(X,Y,Z);
    % shading interp
    % colorbar;
    % caxis([300, 1700])
    % caxis([1, 2.5])
    % caxis([0, 0.5])
    % xlabel('length/pipelength');
    % ylabel('radius / piperadius');
    % hold on;
    % contour(X,Y,Z,'k', 'ShowText' ,'on');
    % hold off;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Find maximum temperature difference
if finddeltaT == 1
    for i= 0:num_x-1
        deltaT(i+1,1) = M(i*101+1,columnofpositionX);
        deltaT(i+1,2) = M (i*101+1,columnofT );
        deltaT(i+1,3) = M (i*101+45,columnofT );
        deltaT(i+1,4) = deltaT(i+1,3) - deltaT(i+1,2);
        
    end
    xi = linspace(min(deltaT(1:4:end,1)), max(deltaT(1:4:end,1)), 2);                     % Evenly-Spaced Interpolation Vector
    yi = interp1(deltaT(1:4:end,1), deltaT(1:4:end,4), xi, 'spline', 'extrap');
    plot(deltaT(1:4:end,1),deltaT(1:4:end,4),'*');
    hold on
   % plot(xi, yi, '-r')
    hold off
    xlabel('Longitudinal distance along the reactor(m)');
    ylabel('Temperature difference between the 0.9*R0 and centreline(K)');
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if findTfile ==1
    figure
%   for mm= 0:8
       figure(mm+1), hold on
        x = 8;
      %  x= mm .* 2./8
        rowstart= (x * 19*101)+1;
        rowend = rowstart + 50
        for s = rowstart:rowend
            s1 =rem(s,101);
        deltaT(s1,1) = M(s,Totalofcolumninfile + 1);
        deltaT(s1,2) = M (s,columnofT )- M(rowstart, columnofT);
        end
        w = plot(deltaT(:,2),deltaT(:,1))
        set(w,'LineWidth',4); 
        xlim([-350 450])
        grid on
       % hold off
%    end
   hold off
   % xlabel('Longitudinal distance along the reactor(m)');
   % ylabel('Temperature difference between the 0.9*R0 and centreline(K)');
 
end 

%% Plot path of a particle
if plotpath ==1

% x = input(prompt);
% Path=zeros(num_x,6);
% Path(1,1)='x';
% Path(1,2)='r';
% Path(1,3)='delta T';
% Path(1,4)='Time';
% Path(1,5)='v_y';
% Path(1,6)='v_x';
% Path(1,7)='T';
% Path(1,8)='P';
figure
for m=1:10
%     m=1
    r=radius*0.1*m;
    Path=zeros(num_x,8);
    Path(1,2)=r;
    for i=1:num_x+160
        Path(i+1,:) = findposition(Path(i,:),M);
          if Path(i+1,1)>=length_norm
            break;
         end
        
    end
    w=plot(Path(1:160,1),Path(1:160,2));
    %w=plot(Path(1:2:165,1),Path(1:2:165,2));%% Shows Path
    %w=plot(Path(:,4),Path(:,7));%% T vs time
    %%w=plot(Path(:,4),Path(:,1));%% X vs Time
    %%w=plot(Path(:,4),Path(:,8)); %%P vs time
    %%w=plot(Path(:,4),Path(:,2));%% Y vs Time
    set(w,'LineWidth',2);  
    hold on
end
% Legend=cell(10,1)
% Legend{1}=strcat('streamlines start at r=' );
%     for iter=1:10
%         Legend{iter}=strcat('streamlines start at r=',num2str(0.0425*0.1*iter),'m' );
%     end
% legend(Legend)
xlabel('longitudinal distance(m)');
ylabel('radial distance(m)');
hold off
end
%% Find the time duration the particle experience temperature higher than
if plotduration_with_temperature_greater_than_target == 1
time=zeros(20,2);
figure
for m=1:20  
  
    r=radius*0.05*m;
    Path=zeros(num_x,8);
    Path(1,2)=r;
    time_begin=0;
    time_end=0;
    s1 =0;
    s2 = 0;
    for i=1:num_x+160
        Path(i+1,:)=findposition(Path(i,:),M);
        if Path(i+1,1)>length_norm
            time_end=Path(i,4);
            break;
        end
        if s1==0 & s2==0
            if Path(i,7)<target_Temperature && Path(i+1,7)>=target_Temperature
                time_begin=Path(i+1,4);
                s1=1;
            end
            if Path(i,7)>target_Temperature && Path(i+1,7)<=target_Temperature
                time_end=Path(i+1,4);
                s2=1;
            end
            if time_end==0 && i==num_x+20
                time_end=Path(i,4);
                s2=1;
            end
            
        end
    end
    duration=time_end-time_begin;
    time(m,1)=r;
    time(m,2)=duration;


end
w=plot(time(:,1)- 0.002125,time(:,2),'-b');%% Y vs Time
 set(w,'LineWidth',3); 
  xlim([0 0.0425])
hold on
w=scatter(time(:,1)-0.002125,time(:,2),'ro');
set(w,'LineWidth',4);  
xlabel('radial distance from the centreline(m)');
ylabel('Duration of time the particle has T over 1000 celsius(s)');
hold off
end

%% 
% figure
% 
%     r=0.04053;
%     Path=zeros(88,8);
%     Path(1,2)=r;
%     for i=1:num_x+50
%         if Path(i,1)>=length_norm
%             break;
%         end
%         Path(i+1,:)=findposition(Path(i,:),M);
%         
%     end
%     w=plot(Path(:,1),Path(:,2));%% Shows Path
%     %%w=plot(Path(:,4),Path(:,7));%% T vs time
%     %%w=plot(Path(:,4),Path(:,1));%% X vs Time
%     %%w=plot(Path(:,4),Path(:,8)); %%P vs time
%     %%w=plot(Path(:,4),Path(:,2));%% Y vs Time
%     set(w,'LineWidth',2);  

