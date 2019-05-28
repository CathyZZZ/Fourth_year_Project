
%%Smoke, DUst, and Haze, sheldon K Friedlander P192%% variables
file_name = 'attempt3.csv';         % 3 or attempt6march.csv
length_norm = 2.00;                 % normalised length factor
points_per_x = 101;%101 
xstartat=4; %needs to be integer
x_value =0;
nodesizenumber=4;  %nodesize%%start from3
addition=15;
columnnumber = nodesizenumber + addition; %column of the node in excel
case0 = 0; %% Node size k as function of furnace axis, input is nodesizenumber.
case1 = 0; %% all Nk as function of furnace axis
case2 = 0;  %% Verify the total volume of particles at every x
case3 = 0; %% Verify the total volume of particles at a certain x value defined in x_value in range of 0 to 159
case4 = 1; %% Check node distribution of particles at x.
case5 = 0;
global  columnofpositionY columnofpositionZ columnofrho

% %% data processing
M = csvread(file_name, 1, 0);
S = csvread('vpnodesize.csv', 1, 0);
%figure
%hold on;
%%  Calculate number concentration of size k as function of furnace axis
if case0==1
    k= columnnumber;
for j=0:150
    xstartat= j.* 0.01;
    rowstart=(xstartat/0.01*points_per_x)+1;
    rowend=rowstart+((points_per_x+1)./2)-1;
    P=zeros(((points_per_x+1)./2)+1,3);
    P(((points_per_x+1)./2 + 1),1)=0.0425;
    for i = rowstart:rowend
        m=rem(i,points_per_x);
        m = round(m);
        ii = round(i);
        %fprintf('%d %d\n', i, m)
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end   
    % Plot mass flow at each cross-section
    for i = rowstart:rowend
        m=rem(i,points_per_x);
        m = round(m);
        ii = round(i);
        P(m,2) = M(ii,k) .*pi .*(P(m+1,1).^2-(P(m,1)).^2);%% sum of Nk*dA
        %P(m,2) = M(i,3) .*pi .*(P(m+1,1).^2-(P(m,1)).^2); % sum of Nair dA
        if m>1 
            P(m,3)=P(m-1,3)+P(m,2);
        else
            P(m,3) = P(m,2);
        end
    end
    %%sz = linspace(1,100,200);
    w=scatter(xstartat, log(P(m,3)),36,[0 0 1]);
   
end
hold on

xlabel('Distance along the pipeflow(m)');
ylabel('Number of particles at node 2 at each cross section log(kg/s)');
hold off
end

%% Plot graph Nk against longitudinal axis.
if case1==1
    Z=zeros(151,31);
for k= columnnumber :columnnumber+30
    %%k= columnnumber;
for j=0:150
    xstartat= j.* 0.01;
    rowstart=(xstartat/0.01*points_per_x)+1;
    rowend=rowstart+((points_per_x+1)./2)-1;
    P=zeros(((points_per_x+1)./2)+1,3);
    P(((points_per_x+1)./2 + 1),1)=0.0425;
    for i = rowstart:rowend
        m=rem(i,points_per_x);
        m = round(m);
        ii = round(i);
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end   
    % Plot mass flow at each cross-section
    for i = rowstart:rowend
        m=rem(i,points_per_x);
        m = round(m);
        ii = round(i);
        P(m,2) = M(ii,k) .* pi .*(P(m+1,1).^2-(P(m,1)).^2);%% sum of Nk*dA
        if m>1 
            P(m,3)=P(m-1,3)+P(m,2);
        else
            P(m,3) = P(m,2);
        end
        temp=P(m,3);
    end
    Z(j+1,1)=xstartat;
    Z(j+1,2)= log(temp);
    
%    sz = linspace(1,100,200);
   % w=scatter(xstartat, log(P(m,3)));
   
end
w = plot(Z(:,1),Z(:,2))
hold on
end
xlabel('Distance along the pipeflow(m)');
ylabel('Number of particles of at node 4 at each cross section(kg/s)');
hold off

end
 %% Check total volume of particles at every x.
if case2== 1
volume=zeros(20,2);
for x = 0:150
    xstartat = x * 2./150;
    rowstart=(x * points_per_x)+1;%% the row we start with in original csv file
    rowend=rowstart+((points_per_x+1)./2)-1;%% the row we end with in original csv file
    P=zeros(((points_per_x+1)./2)+1,3);
    %P(((points_per_x+1)./2 + 1),1)=0.0425;
    columnnumber=19; 
    for i = rowstart:rowend
        m=rem(i,points_per_x);
        m = round(m);
        ii = round(i);
        %fprintf('%d %d\n', i, m)
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end  
    P(((points_per_x+1)./2 + 1),1)=P((points_per_x+1)./2,1);
    sumofNk = 0;
    for s= columnnumber : columnnumber+1
        %sumofNk = 0;
        for i = rowstart:rowend
            m=rem(i,points_per_x);
            m = round(m);
            ii = round(i);                
            P(m,s - 14) = (M(ii,s) + M(ii+1,s))./2;% .*pi .*(P(m+1,1).^2 - P(m,1).^2);%% sum of Nk*dA
        end
        
        for sum = 1 : 2
            sumofNk = sumofNk + P(sum,s - 14);
        end
        P(((points_per_x+1)./2 + 2), s-14)=sumofNk;
        
    end
    sumofvolume=0;
    tem=0;
    for temp = 1:2
         tem = P(((points_per_x+1)./2 + 2),temp+1);%% .* S(temp,1);
        sumofvolume = sumofvolume + tem;
    end
volume(x+1,1)=xstartat;
volume(x+1,2)=sumofvolume;

end
      plot(volume(1:151,1),log(volume(1:151,2)));
      xlabel('furnace axis');
      ylabel('log(total volume of particles)');
      hold off
end

 %% Check total volume of particles at x.
if case3== 1

    rowstart=(xstartat/0.01*points_per_x)+1;%% the row we start with in original csv file
    rowend=rowstart+((points_per_x+1)./2)-1;%% the row we end with in original csv file
    P=zeros(((points_per_x+1)./2)+1,3);
    P(((points_per_x+1)./2 + 1),1)=0.0425;
    columnnumber=18; 
    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        %fprintf('%d %d\n', i, m)
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end  
    P(52,1)=P(51,1);
    sumofNk = 0;
    for s= columnnumber : columnnumber+40
        sumofNk = 0;
        for i = rowstart:rowend
            m=rem(i,101);
            m = round(m);
            ii = round(i);                
            P(m,s - 16) = (M(ii,s) + M(ii+1,s))./2 .*pi .*(P(m+1,1).^2 - P(m,1).^2);%% sum of Nk*dA
        end
        for sum = 1 : 51
            sumofNk = sumofNk + P(sum,s - 16);
        end
        P(53, s-16)=sumofNk;
        
    end
    sumofvolume = 0;
    tem = 0;
    for temp = 1:41
         tem = P(53,temp+1) .* S(temp,1);
        sumofvolume = sumofvolume + tem;
    end
end
 %% Check node distribution of particles at x.
 
if case4== 1
    figure
    for mm = 0:9
        xstartat = 0.01*16*mm
    rowstart=(xstartat/0.01*points_per_x)+1;%% the row we start with in original csv file
    rowend=rowstart+((points_per_x+1)./2)-1;%% the row we end with in original csv file
    P=zeros(((points_per_x+1)./2)+1,3);
    P(((points_per_x+1)./2 + 1),1)=0.0425;
    columnnumber=18; 
    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end  
    P(52,1)=P(51,1);
    sumofNk = 0;
    for s= columnnumber : columnnumber+40
        sumofNk = 0;
        for i = rowstart:rowend
            m=rem(i,101);
            m = round(m);
            ii = round(i);                
            P(m,s - 16) = (M(ii,s) + M(ii+1,s))./2 .*pi .*(P(m+1,1).^2 - P(m,1).^2);%% sum of Nk*dA
        end
        for sum = 1 : 51
            sumofNk = sumofNk + P(sum,s - 16);
        end
        P(53, s-16)=sumofNk;
        P(54, s-16)= s-17;
        
    end
    %w= scatter(P(54,:),log(P(53,:))*0.0126./(pi*0.0425^2),'k','filled');
    %set(w,'LineWidth',0.1); 
    %figure
    v= semilogy(P(54,:), P(53,:)*0.0126./(pi*0.0425^2),'-');
    xlabel('Node number');
    ylabel('log(Number concentration of particles at this node(#/m^3))');
    %xlim([0 ,1 ,40])
    set(v,'LineWidth',2); 
    hold on
    end
    grid on
    grid minor
    hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if case5== 1
    

    rowstart=(xstartat*points_per_x)+1;%% the row we start with in original csv file
    rowend=rowstart+((points_per_x+1)./2)-1;%% the row we end with in original csv file
    P=zeros(((points_per_x+1)./2)+1,41);
    P(((points_per_x+1)./2 + 1),1)=0.0425;
    for m= 1:40
        P(1,m+1)=m;
    end
    columnnumber=18; 
    for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m+1,1) = sqrt(M(ii,columnofpositionY).^2 + M(ii,columnofpositionZ).^2); %radius
    end  
   for node =1 :40 
   for i = rowstart:rowend
        m=rem(i,101);
        m = round(m);
        ii = round(i);
        P(m+1,node+1) = (M(ii,node +18) + M(ii+1,node +18))/2;
   end
   end
for row = 2:10 :51
    w= plot (P(1,:), P(row,:))
    set(w,'LineWidth',2.5); 
end
%     x= P(1,:);
%     y= P(:,1);
%     [X,Y] = meshgrid(x, y);
%     Z = P(:,:);
%     w = surf(X,Y,Z)
Legend=cell(10,1)
Legend{1}=strcat('r=' );
    for iter=1:10
        Legend{iter}=strcat('r=',num2str(0.0425*0.2*iter- 0.002125),'m' );
    end
legend(Legend)
    xlabel('Node number');
    ylabel('Number concentration of particles at this node(#/m^3)');
    grid on
    grid minor
    hold off
end