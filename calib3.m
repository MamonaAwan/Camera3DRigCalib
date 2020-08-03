%% Loading Input files
[Points2D]=textread('2DPoints.txt');
[Points3D]=textread('3DPoints.txt');
 
%% Displaying the Data in Plots
[Row3D,Col3D]=size(Points3D);
[Row2D,Col2D]=size(Points2D);
figure;
plot3(Points3D(:,1),Points3D(:,2),Points3D(:,3),'.');
figure;
plot(Points2D(:,1),Points2D(:,2),'.');
 
%% Extracting and Naming the Points Respectively
X= Points3D(:,1);
Y= Points3D(:,2);
Z= Points3D(:,3);
u= Points2D(:,1);
v= Points2D(:,2);
% Taking ones and zeros to add desired columns
o= ones(size(u));
z= zeros(size(u));
 
%% Constructing A Matrix and Calculating all parts
A_part1= [X Y Z o z z z z -u.*X -u.*Y -u.*Z -u];
A_part2= [z z z z X Y Z o -v.*X -v.*Y -v.*Z -v];
A=[A_part1; A_part2];
[U, S, V] = svd(A,0);
cm = V(:,end);
CalibMat = reshape(cm,4,3)';
MC=CalibMat(:,4);
M=CalibMat(:,1:3);
Minv=inv(M);
CamCen=-Minv*MC;
[R,K]=qr(M);
K = flipud(K');
K = fliplr(K);
R=R';
R = flipud(R);
T=-R*CamCen;
 
%% Displaying the Output Matrices on Main Window
Camera_Center=CamCen
Intrinsic_Matrix=K
Rotation_Matrix=R
Translation_Matrix=T
Given_Ground=[166.20;141.46;170.08]
Error=abs(Given_Ground-Camera_Center)
 
%%End
