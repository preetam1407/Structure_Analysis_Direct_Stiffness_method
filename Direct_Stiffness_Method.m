clc
clearvars

% Analysis of a 2-D frame using Direct stiffness Matrix.

%{
No. of stories: 5
Story Height: 3.5 m
Grade of concrete: M25
Fixed support at base
Ignore self-weight of members

Member Load
Load at each floor: 12 kN/m UDL on all beams

Joint Load
➢ For 3
rd story roof:
Joint load = 7.5 kN along X-direction at all nodes.
➢ For 4th story roof:
Joint load = 15 kN along X-direction at all nodes.
➢ For 5th story roof:
Joint load = 30 kN along X-direction at all nodes.
 
Identifying Associated unrestricted Degrees of Freedom, Reactions at the restricted Degrees of Freedom and the Member end forces.
%}

% defining number of members.
Number_of_elements = 45;


% Cross-sectional Area, Young Modulus of Elasticity, Moment of inertia,
% Member orientation of each member in anti-clock wise direction. Degree of
% Freedom, External_ Forces, 

% Properties_Matrix = ["Member";"Node_1";"Node_2";"Lenght";"Cross sectional Area";"Moment of inertia";"Young Modulu of Elasticity"];

% Defining Members
Member = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45];

% member_nodes_connectivity.
Node_1 = [1	2	3	4	6	7	8	9	10	6	7	8	9	11	12	13	14	15	11	12	13	14	16	17	18	19	20	16	17	18	19	21	22	23	24	25	21	22	23	24	26	27	28	29	30]';
Node_2 = [2	3	4	5	1	2	3	4	5	7	8	9	10	6	7	8	9	10	12	13	14	15	11	12	13	14	15	17	18	19	20	16	17	18	19	20	22	23	24	25	21	22	23	24	25]';

% Length of Beams and Frames.
Length= [4;3;3;4;3.5;3.5;3.5;3.5;3.5;4;3;3;4;3.5;3.5;3.5;3.5;3.5;4;3;3;4;3.5;3.5;3.5;3.5;3.5;4;3;3;4;3.5;3.5;3.5;3.5;3.5;4;3;3;4;3.5;3.5;3.5;3.5;3.5;]; 

% Cross-sectional Area of Beams and Frames.
Area = [.15;.15;.15;.15;.16;.16;.16;.25;.25;.15;.15;.15;.15;.16;.16;.16;.25;.25;.15;.15;.15;.15;.16;.16;.16;.25;.25;.15;.15;.15;.15;.16;.16;.16;.25;.25;.15;.15;.15;.15;.16;.16;.16;.25;.25];

% Young Modulus of Elasticity.
YMOE = [25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000;25000000];

% Moment of inertia.
MOI = 1.0e-12*[3125000000;3125000000;3125000000;3125000000;2133333333.333;2133333333.333;2133333333.333;5208333333.333;5208333333.333;3125000000;3125000000;3125000000;3125000000;2133333333.333;2133333333.333;2133333333.333;5208333333.333;5208333333.333;3125000000;3125000000;3125000000;3125000000;2133333333.333;2133333333.333;2133333333.333;5208333333.333;5208333333.333;3125000000;3125000000;3125000000;3125000000;2133333333.333;2133333333.333;2133333333.333;5208333333.333;5208333333.333;3125000000;3125000000;3125000000;3125000000;2133333333.333;2133333333.333;2133333333.333;5208333333.333;5208333333.333;];

% Member Orientation anti-clock wise.
Theta = [0;0;0;0;90;90;90;90;90;0;0;0;0;90;90;90;90;90;0;0;0;0;90;90;90;90;90;0;0;0;0;90;90;90;90;90;0;0;0;0;90;90;90;90;90];

% Associated Degree of Freedom
DOF = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65;66;67;68;69;70;71;72;73;74;75;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];

% External_forces = [30;0;0;30;0;0;30;0;0;30;0;0;30;0;0;15;0;0;15;0;0;15;0;0;15;0;0;15;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.5;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;76;77;78;79;80;81;82;83;84;85;86;87;88;89;90];
Beams_members = [1;2;3;4;false;false;false;false;false;10;11;12;13;false;false;false;false;false;19;20;21;22;false;false;false;false;false;28;29;30;31;false;false;false;false;false;37;38;39;40;false;false;false;false;false];


T1 = table(Member,Node_1,Node_2,Length,Area,MOI,YMOE,Theta);
Properties_Matrix_1 = table2array(T1);

% span Uniformely distributed Load.
UDL = 12;

% Definning Null matrixs.

K_B = zeros(90,90);      % Building Stiffness Matrix.
F_B = zeros(90,1);       % Building Joint forces and Fixed end forces matrix.
K_G = zeros(6,6,45);     % 3-d matrix to convert local to global stiffness matrix.
F_G = zeros(6,45);       % 3-d matrix to convert local to global Joint forces and Fixed end forces matrix.
F_L = zeros(6,45);       % local 3-d matrix of forces.
T_L = zeros(6,6,45);     % 3-d transformation matrix.
K_L = zeros(6,6,45);     % % Local Stiffness Matrix.
C = zeros(6,45);         % Connectivity matrix.


% computing transformation & stiffness matrices
for i = 1:45
    % definningTranformation Matrix
    T_L(:,:,i) = [cosd(Theta(i)), sind(Theta(i)), 0, 0, 0, 0;
                  -sind(Theta(i)), cosd(Theta(i)), 0, 0, 0, 0;
                  0, 0, 1, 0, 0, 0;
                  0, 0, 0, cosd(Theta(i)), sind(Theta(i)), 0;
                  0, 0, 0, -sind(Theta(i)), cosd(Theta(i)), 0;
                  0, 0, 0, 0, 0, 1];

    % definning Stiffness Matrix.
    K_L(:,:,i) = [(T1.YMOE(i)*T1.Area(i))/(T1.Length(i)), 0, 0, -(T1.YMOE(i)*T1.Area(i))/(T1.Length(i)), 0, 0;
                   0, (12*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(3)), (6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(2)), 0, -(12*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(3)), (6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(2));
                   0, (6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)).^(2), (4*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)), 0, -((6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)).^(2)), (2*(T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)));
                  -(T1.YMOE(i)*T1.Area(i))/(T1.Length(i)), 0, 0, (T1.YMOE(i)*T1.Area(i))/(T1.Length(i)), 0, 0;
                   0, -(12*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(3)), -(6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)).^(2), 0, (12*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)).^(3), -(6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)).^(2);
                   0, (6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(2)), (2*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i)), 0, -(6*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i).^(2)), (4*T1.YMOE(i)*T1.MOI(i))/(T1.Length(i))];

    % Converting local stiffness matrix to global stiffness matrix.
    K_G(:,:,i) = ((T_L(:,:,i)).')*(K_L(:,:,i))*(T_L(:,:,i));
    
    % Connectivity Matrix.
    C(:,i) = [3*(T1.Node_1(i))-2; 3*(T1.Node_1(i))-1;3*(T1.Node_1(i)); 
              3*(T1.Node_2(i))-2;3*(T1.Node_2(i))-1;3*(T1.Node_2(i))]; 
    
    % Connecting Members of STIFFNESS MATRIX to Building matrix. Assiging global stiffness matrix to building matrix.
    K_B(C(:,i),C(:,i)) = K_B(C(:,i),C(:,i)) + K_G(:,:,i);
    
    % Local Fixed end Forces Matrix.
    if Beams_members(i)
    F_L(:,i) = [0; (UDL*T1.Length(i))/2; (UDL*(T1.Length(i)).^2)/12; 0; (UDL*T1.Length(i))/2; -(UDL*(T1.Length(i)).^2)/12 ];
    end
   
    % Converting local Fixed end forces matrix to global Fixed end forces matrix.
    F_G(:,i) = ((T_L(:,:,i)).')*(F_L(:,i)); 
    F_B(C(:,i),1) = F_B(C(:,i),1) + F_G(:,i);
end


% definning NULL matrix for force assciated with degree of freedom where r denote the restraint and u denotes unrestraint.
Kuu = zeros(75,75);
Kur= zeros(75,15);
Kru = zeros(15,75);
Krr = zeros(15,15);

% definning NULL matrix for degree of freedom where r denote the restraint and u denotes unrestraint.
Uu= zeros(75,1);
Ur = zeros(15,1);

% definning NULL matrix for external joint forces where r denote the restraint and u denotes unrestraint.
%External_forces_a = zeros(75,1);
%External_forces_b = zeros(15,1);

% definning NULL matrix for fixed end forces where a is known forces and b denotes reactions at the fixed supports.
%FEF_a = zeros(75,1);
%FEF_b = zeros(15,1);

% Separating stiffness matrix associated with restraints and unrestraints DOF.
    K_uu = K_B(1:75,1:75);
    K_ur = K_B(1:75,76:90);
    K_ru = K_B(76:90,1:75);
    K_rr = K_B(76:90,76:90);

% Definning matrix of restricted and unresitricted DOFs.
    Uu = DOF(1:75);
    Ur = DOF(76:90);

% Definning matrix of Fixed end forces.
    FEF_a = F_B(1:75);
    FEF_b = F_B(76:90);
 
% Known and unknown joints forces

    External_forces_a = [30;0;0;30;0;0;30;0;0;30;0;0;30;0;0;15;0;0;15;0;0;15;0;0;15;0;0;15;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.50000000000000;0;0;7.5;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
    External_forces_b = [76;77;78;79;80;81;82;83;84;85;86;87;88;89;90];

% Net forces on joints due to span loading and joints loading. 
    F = ((External_forces_a)-(FEF_a));
    R = ((External_forces_b)-(FEF_b));
   
 % identifying unrestraining degrees of freedom
    Uu = (inv(K_uu))*F;

%  identifying reactions at restricted DOFs.
    External_forces_b = K_ru*Uu;
    
%  identifying member end forces 
    % Conversion of Global DOFs to Local DOFs associated with each members.   
        % Below code shows Member end forces of Member 1.
        M1_Global_DOFs = Uu(C(:,1),1);
        M1_Local_DOFs = ((T_L(:,:,1)).')*M1_Global_DOFs;
        M1_end_Forces = K_L(:,:,1)*M1_Local_DOFs+F_L(:,1);



%....................................................................................................




%     for member end forces
%         for i = 1:45
%          U_G_1 = Uu(C(:,i),1);
%     
% en
%       take subset of u_global
%       convert u_global to u_local
%       THEN find k*u;
%       then find FlocalFi = k*u + F;


%     K_B*DOF = External_forces*-F_B; 
% 
% Beams_members = [1;2;3;4;10;11;12;13;19;20;21;22;28;29;30;31;37;38;39;40];
%     if Beams_members(i)
%     F_G(:,i) = ((T_L(:,:,i)).')*(F_L(:,i)); 
% %     else
% %     F_G(:,i) = [0;0;0;0;0;0];
%     end
%     F_B(C(:,i),1) = F_B(C(:,i),1) + F_G(:,i);
% end

