%To create Window
clc

%Read data for file
filename = ('WashingData.xlsx');
Data = xlsread(filename);

% To Create a FIS
a = newfis('Washing_Machine');

%The membership Functions:

%%%Level of dirt:
a = addvar (a,'input','Dirty(levels of Dirt Content)', [0 10]);
a = addmf(a, 'input', 1, 'Not very Dirty', 'gaussmf', [1 2]);
a = addmf(a, 'input', 1, 'Dirty', 'gaussmf', [1 5]);
a = addmf(a, 'input', 1, 'Very Dirty', 'gaussmf', [1 8]);
%%% Weight of load(kg's):
a = addvar (a,'input','Weight(Clothing(Kg))', [0 50]);
a = addmf(a, 'input', 2, 'Light', 'trapmf', [0 0 5 10]);
a = addmf(a, 'input', 2, 'Medium', 'trimf', [5 15 25]);
a = addmf(a, 'input', 2, 'Heavy', 'trimf', [20 30 40]);
a = addmf(a, 'input', 2, 'very Heavy', 'trapmf', [35 45 50 50]);
%%%Lenght of Wash(time):
a = addvar (a,'input','Length of Cycle(Minutes)', [0 180]);
a = addmf(a, 'input', 3, 'Short', 'trapmf',[0 0 20 45]);
a = addmf(a, 'input', 3, 'Medium', 'trimf',[35 65 95]);
a = addmf(a, 'input', 3, 'Long', 'trimf', [85 115 145]);
a = addmf(a, 'input', 3, 'Very Long', 'trapmf', [135 160 180 180]);
%The output fuctions:
a = addvar(a,'output', 'Water Usage(litres)', [0 200]);
a = addmf(a, 'output', 1, 'Low ', 'gaussmf', [25 35]);
a = addmf(a, 'output', 1, 'Moderate', 'gaussmf', [25  105]);
a = addmf(a, 'output', 1, 'Extensive', 'gaussmf', [25 200]);%170


%Creating rules the fis.
%Using the and operators
rule1 = [1 1 1 1 1 1];
rule2 = [2 2 2 2 1 1];

rule3 = [3 3 3 2 1 1];
rule4 = [3 4 4 3 1 1];

%Using the Or operator

rule5 = [1 1 1 1 1 2];
rule6 = [2 2 2 2 1 2];

rule7 = [3 3 3 3 1 2];
rule8 = [3 4 4 3 1 2];

%Using the Then operator

%rule9 = [];

%listing rules
ruleList =[rule1;rule2;rule3;rule4;...
rule5;rule6;rule7;rule8];
                   
%adding the to Washing machine fis
a = addrule(a,ruleList);

%To print rules 
rules = showrule(a)
                   
                   
% insert for loop here:
for i=1:size(Data,1)
        eval = evalfis([Data(i, 1), Data(i, 2), Data(i, 3) ], a);
        fprintf('%d) In(1): %.2f, In(2) %.2f, In(3) %.2f => Out: %.2f \n\n',i,Data(i, 1),Data(i, 2),Data(i, 3), eval);
end

%The Plot function for DataGraphic:
figure(1)
subplot(4,1,1), plotmf(a, 'input' ,1)
subplot(4,1,2), plotmf(a, 'input' ,2)
subplot(4,1,3), plotmf(a, 'input' ,3)
subplot(4,1,4), plotmf(a, 'output',1)
