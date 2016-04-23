%%
close all , clear all, clc;
%% Path

% this path is given by the 
targets=[		0,  46,      4.5,0;
    0,  16,      4.0,0;
    2,  7,       4.5,0;
    1,  76,      4.5,0;
    41,  50,     4.5,1;
    43,  16,     4.5,1;
    68,  61,     4.5,1;
    46,  92,     4.5,1;
    105,  90 ,   4.5,0;
    101,  56 ,   4.5,1;
    88,  25,     4.5,1;
    104,  1,     4.5,0  ];
%% sorting the list
temp=targets;
for i=1:size(targets,1)
    
    output=pdist2(temp(i,:),temp);
    [minimum,index]=min(output(2:end));
    output=[output;temp(index)];
    
    temp=temp(temp~=output);
end

%[output,I]=pdist2(targets(1,:),targets(2:end,:),'euclidean','Smallest',2)

%sorting=sort(targets,4);
%%
image_size=[1.5 1.5];

% image_size=[20 15]
% height1=targets(1,3);
% angle_of_camera=atand((image_size(1,1)/2)/height1);


%% constant image_size

% cause for changing size there should be a condition about the rotation 
image_size=image_size.*10; % for cm conversion of the camera .. 
targets=[targets(:,1)+(image_size(1,1)/2), -(targets(:,2)+(image_size(1,2)/2)),targets(:,3),targets(:,4)];



%% image_size with different orientation 

% image_size=[20,15];
% orientation=t(:,4);
% t_out=[];
% for i=1:size(t(:,4),1)    
%     if(orientation(i)==0)
%         t_out=[t_out;t(i,1)+(image_size(1)/2),t(i,2)+(image_size(2)/2),t(i,3),t(i,4)];
%      
%     else
%         t_out=[t_out;t(i,1)+(image_size(2)/2),t(i,2)+(image_size(1)/2),t(i,3),t(i,4)];
%     end
% end

%%
%%%%%%%%%%%%%%%%
% try interpolation by matlab instead : 
% t = 0:0.001:1;
% x = sin(2*pi*30*t) + sin(2*pi*60*t);
% y = interp(x,4);
%%%%%%%%%%%%%%%%

a=[];
b=[];
c=[];
d=[];
threshold_interpolation=8;
for i=1:size(targets,1)-1
    
    if (abs(targets(i,2)-targets(i+1,2))>abs(targets(i,1)-targets(i+1,1)))
        if (abs(targets(i,2)-targets(i+1,2))>threshold_interpolation)
    a=[a;linspace(targets(i,2),targets(i+1,2),threshold_interpolation)'];
    b=[b;linspace(targets(i,1),targets(i+1,1),threshold_interpolation)'];
    c=[c;targets(i,3)*ones(threshold_interpolation,1)];
    d=[d;targets(i,4)*ones(threshold_interpolation,1)];

        else 
    a=[a;linspace(targets(i,2),targets(i+1,2),abs(targets(i,2)-targets(i+1,2)))'];
    b=[b;linspace(targets(i,1),targets(i+1,1),abs(targets(i,2)-targets(i+1,2)))'];
    c=[c;targets(i,3)*ones(abs(targets(i,2)-targets(i+1,2)),1)];
    d=[d;targets(i,4)*ones(abs(targets(i,2)-targets(i+1,2)),1)];
        end 
    scale=linspace(targets(i+1,2),targets(i,2),targets(i,2)-targets(i+1,2))';
      
    else
        if (abs(targets(i,1)-targets(i+1,1))>threshold_interpolation)
    a=[a;linspace(targets(i,2),targets(i+1,2),threshold_interpolation)'];
    b=[b;linspace(targets(i,1),targets(i+1,1),threshold_interpolation)'];
    c=[c;targets(i,3)*ones(threshold_interpolation,1)];
    d=[d;targets(i,4)*ones(threshold_interpolation,1)];

        else
     a=[a;linspace(targets(i,2),targets(i+1,2),abs(targets(i,1)-targets(i+1,1)))'];
     b=[b;linspace(targets(i,1),targets(i+1,1),abs(targets(i,1)-targets(i+1,1)))'];       
     c=[c;targets(i,3)*ones(abs(targets(i,1)-targets(i+1,1)),1)];
     d=[d;targets(i,4)*ones(abs(targets(i,2)-targets(i+1,2)),1)];
        end
    end
    
end

% so that i can take the proper orientation 
d=[d(1:size(d,1)-1,:);targets(size(targets,1),4)];

%% Finalize the Path

path_finalized=[b,a];
% path_finalized_3d=[path_finalized(:,1),path_finalized(:,2),3.5*ones(size(path_finalized,1),1)];
path_finalized_3d_2=[path_finalized(:,1),path_finalized(:,2),c];

path_finalized_3d_3=[path_finalized(:,1)+75,path_finalized(:,2)+70,c];
path_finalized_3d_4=[path_finalized(:,1),path_finalized(:,2),c,d];
%% Plot the path 

% plot the 2D path 

figure(1),plot2(path_finalized);
figure(2),plot3(path_finalized_3d_2(:,1),path_finalized_3d_2(:,2),path_finalized_3d_2(:,3),'ro'),
hold on,
plot2(path_finalized,'b-');

hold off
figure(3),plot3(targets(:,1),targets(:,2),targets(:,3),'b-')

%% Save Path to text file
 fileID = fopen('path.txt','w');
 
 for iii=1:size(path_finalized_3d_4,1)
     
 fprintf(fileID,'%f ,%f , %f , %f , \n',path_finalized_3d_4(iii,1),path_finalized_3d_4(iii,2),path_finalized_3d_4(iii,3),path_finalized_3d_4(iii,4));
 
 end
%  fprintf(fileID,'%f , %f , %f , \n',path_finalized_3d_2(:,1),path_finalized_3d_2(:,2),path_finalized_3d_2(:,3))


