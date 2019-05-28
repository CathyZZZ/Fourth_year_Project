%%This code is able to find the edge between cells with a given xyz
%%location

function FinPath=findposition(IniPath,M)
global Totalofcolumninfile columnofvx columnofvy columnofT columnofP radius length_norm num_x num_r points_per_x;
y_direction_interval=radius /(num_r -1);
x_direction_interval=length_norm/(num_x-1); %%total furnace length/number of cells in the longtudinal axis
x_position=IniPath(1);
r_position=IniPath(2);
v_y=M(1,columnofvy);

%% Set the edge of the cell
    edge_x_l=(x_position-rem(x_position,x_direction_interval));
    edge_x_r = edge_x_l +x_direction_interval;
    
%         
if v_y<=0 && rem(r_position, y_direction_interval)==0
    edge_y_d=(r_position-y_direction_interval);
    edge_y_u=r_position;
else
    edge_y_d=(r_position-rem(r_position, y_direction_interval));
    edge_y_u=edge_y_d+y_direction_interval;
    
end
Row= round((edge_x_l/x_direction_interval)*points_per_x+1 + edge_y_d/y_direction_interval);

v_x=(M(Row,columnofvx)+ M(Row+1,columnofvx))/2;
v_y=(M(Row,Totalofcolumninfile + 2)+ M(Row+1,Totalofcolumninfile + 2))/2;
T= (M(Row,columnofT)+ M(Row+1,columnofT))/2;
P= (M(Row,columnofP)+ M(Row+1,columnofP))/2;
%% time  needed to bound on front boundary

deltaT_x=(edge_x_r-x_position)./v_x;
%% time needed to bound on upper or lower boundary. 

if v_y <0
    deltaT_y= (r_position-edge_y_d)./ (-1*v_y);
     boundary=edge_y_d;
elseif v_y >0
    deltaT_y=(edge_y_u - r_position) ./v_y;
     boundary=edge_y_u;
else
    deltaT_y= deltaT_x +1;
end

%% Obtain next position
if deltaT_x < deltaT_y
    deltaT=deltaT_x;
    new_x_position=edge_x_r;
    new_y_position=r_position+deltaT * v_y;
else
    deltaT=deltaT_y;
    new_x_position=x_position +deltaT * v_x;
    new_y_position=boundary;
    
end

%%  Save all data

FinPath(1)=new_x_position;
FinPath(2)=new_y_position;
FinPath(3)=deltaT;
FinPath(4)=IniPath(4)+deltaT;
FinPath(5)=v_y;
FinPath(6)=v_x;
FinPath(7)=T;
FinPath(8)=P;
end

    

 

