%To create Window
clc
% To Create a FIS 
a = newfis('Washing_Machine');

%The input functions:
a = addvar (a,'input','Dirty(levels of Dirt Content', [0 10]);
a = addvar (a,'input','Weight(Clothing(Kg))', [0 50]);
a = addvar (a,'input','Length of Cycle(Minutes)', [0 45]);

%The output fuctions:
a = addvar(a, 'output', 'Water Usage(litres)', [0 200]);

%The membership Functions:

%%%Level of dirt:
a = addvar (a, 'input','Dirty',[0 10]); 
a = addmf(a, 'input', 1, 'Not very Dirty', 'gaussmf', [1.5 3]);%0
a = addmf(a, 'input', 1, 'Dirty', 'gaussmf', [1.5 5]);%1
a = addmf(a, 'input', 1, 'Very Dirty', 'gaussmf', [1.5 10]);%2
%%% Weight of load(kg's):
a = addvar(a, 'input','Weight',[0 50]); 
a = addmf(a, 'input', 2, 'Light', 'trimf', [0 0 5]);%0
a = addmf(a, 'input', 2, 'Medium', 'trimf', [10 15 20]);%1
a = addmf(a, 'input', 2, 'Heavy', 'trimf', [25 35 45]);%2
a = addmf(a, 'input', 2, 'very Heavy', 'trapmf', [35 45 50 50]);%3
%%%Lenght of Wash(time):
a = addvar(a, 'input','Length',[0 45]); 
a = addmf(a, 'input', 3, 'Short', 'trapmf',[0 0 5 10]);%0
a = addmf(a, 'input', 3, 'Medium', 'trimf',[10 15 20]);%1
a = addmf(a, 'input', 3, 'Long', 'trimf', [20 25 30]);%2
a = addmf(a, 'input', 3, 'Very Long', 'trapmf', [35 40 45 45]);%3
%The output function of Membership function :
a = addvar (a,'outout','Water usage',[0 200]); 
a = addmf(a, 'output', 1, 'Low ', 'trapmf', [0 10 15 25]);%0
a = addmf(a, 'output', 1, 'Moderate', 'gaussmf', [25  100]);%1
a = addmf(a, 'output', 1, 'Extensive', 'gaussmf', [100 200]);%2

%[1] = and [2] = or 
%Creating rules for the fis.
rule1 = [1 1 0 1 1 1];
rule2 = [1 1 1 1 1 1];
rule3 = [2 2 2 1 1 1];
%rule4 = [];


%To print rules 
rules = showrule(a)


%The Plot function for DataGraphic:
figure(1)
subplot(4,1,1), plotmf(a, 'input' ,1)
subplot(4,1,2), plotmf(a, 'input' ,2)
subplot(4,1,3), plotmf(a, 'input' ,3)
subplot(4,1,4), plotmf(a, 'output',1)
