 t=[62, 65, 1.5, 1  ;
 86, 73, 1.5, 1  ;
 35, 97, 1.5, 0  ;
 21, 18, 1.5, 1  ;
 117, 107, 1.5, 0;
 119, 5, 1.5, 0	 ;
 34, 76, 1.5, 0	 ;
 110, 112, 1.5, 1;
 109, 85, 1.5, 0 ;
 1, 88, 1.5, 1   ;
 81, 31, 1.5, 0  ;
 0, 21, 1.5, 1   ;
 87, 53, 1.5, 0	 ;
 33, 55, 1.5, 0	 ;
 117, 54, 1.5, 1 ;
 3, 68, 1.5, 0   ;
 41, 28, 1.5, 1  ;
 62, 88, 1.5, 1  ;
 108, 0, 1.5, 1  ;
 3, 47, 1.5, 0   ;
 112, 27, 1.5, 1 ;
 15, 90, 1.5, 1];

positions=[t(:,1),t(:,2),t(:,3)];
[atour,areal,atourlength]=tsp(positions);
figure(10),subplot(122),title('path planned'),plot3(areal(:,1),areal(:,2),areal(:,3));
subplot(121),title('original path without plan'),plot3(positions(:,1),positions(:,2),positions(:,3));

