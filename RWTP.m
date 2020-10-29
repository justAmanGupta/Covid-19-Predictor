%clearing console and variables
clear all; clc;
close all;

Pre_infec = 5.1;% Time taken by a person to show symptoms, i.e. person is infected but doesn't know
f = 1/Pre_infec;%Reciprocal gives rate

Duration = 7;%Duration for which a person remains infected category
r=1/Duration;%again, reciprocal gives rate

R_0 = 1.23; %Initial rate of infection i.e. a single infected person will infect about 1.23 others in a totally susceptible population

N = 135.26e7; % Population of  India (2020)
beta = R_0/(N*Duration); %growth rate estimate by deducing infection rate per person per day


tspan = 0:1:365; % We will observe what happens for next 365 days or 1 year
y0 = [N-8.04e6, 16e6, 599e3, 7.32e6, 121e3]; % Coronavirus count of India (Oct 28, 2020)
%y0 = [Succeptable exposed infectious recovered dead]

%Total population - infected gives susceptible.
%Other data values as of Oct 28, 2020

[t,y]=ode45(@(t,y) ode_fun_simple(t,y,beta), tspan, y0);
% ode45 is the built in Numerical Differential Equations solver in MATLAB and will help us fill our matrix for next 365 days using our beta rate.

%%NOW WE WILL QUANTIZE OUR GENERATED VALUES COLUMN BY COLUMN where each
%%column represents values for single category like Infectious, Death and
%%so on. I am using different loops for each column to get a more precise representation
%%becuase the range of values of different categories differ.

%%%%%%%%%%%%             COLUMN 1                %%%%%%%%%%%%
x = y(:,[1]); % taking first category data into x
x=x';%transposing x

%quantization
enc=[]%empty array
for i=1:length(x)
if x(i)>0 && x(i)<=2e8
aq(i)=0;%assign the value of x 0 when it is b/w 0 and 2e8
e=[0 0 0];%assign it binary 0
elseif x(i)>2e8 && x(i)<=4e8
aq(i)=1;%assign the value of x 1 when it is b/w 2e8 and 4e8
e=[0 0 1];%assign it binary 1
elseif x(i)>4e8 && x(i)<=6e8
aq(i)=2;%assign the value of x 2 when it is b/w 4e8 and 6e8
e=[0 1 0];%assign it binary 2
elseif x(i)>6e8 && x(i)<=8e8
aq(i)=3;%assign the value of x 3 when it is b/w 6e8 and 8e8
e=[0 1 1];%assign it binary 3
elseif x(i)>8e8 && x(i)<=10e8
aq(i)=4;%assign the value of x 4 when it is b/w 8e8 and 10e8
e=[1 0 0];%assign it binary 4
elseif x(i)>10e8 && x(i)<=12e8
aq(i)=5;%assign the value of x 5 when it is b/w 10e8 and 12e8
e=[1 0 1];%assign it binary 5
elseif x(i)>12e8 && x(i)<=14e8
aq(i)=6;%assign the value of x 6 when it is b/w 12e8 and 14e8
e=[1 1 0];%assign it binary 6
end
enc=[enc e];%append all the binary values
end

%% FOR THE SUBSEQUENT COLUMNS, SAME THING HAS BEEN DONE WITH DIFFERENT VALUES/LEVELS AND STORED IN DIFFERENT ARRAYS

%%%%%%%%%%%%             COLUMN 2                %%%%%%%%%%%%
x = y(:,[2]);
x=x';

%quantization
enc=[]
for i=1:length(x)
if x(i)>0 && x(i)<=2e7
bq(i)=0;
e=[0 0 0];
elseif x(i)>2e7 && x(i)<=4e7
bq(i)=1;
e=[0 0 1];
elseif x(i)>4e7 && x(i)<=6e7
bq(i)=2;
e=[0 1 0];
elseif x(i)>6e7 && x(i)<=8e7
bq(i)=3;
e=[0 1 1];
elseif x(i)>8e7 && x(i)<=10e7
bq(i)=4;
e=[1 0 0];
elseif x(i)>10e7 && x(i)<=12e7
bq(i)=5;
e=[1 0 1];
elseif x(i)>12e7 && x(i)<=14e7
bq(i)=6;
e=[1 1 0];
end
enc=[enc e];
end

%%%%%%%%%%%%             COLUMN 3                %%%%%%%%%%%%
x = y(:,[3]);
x=x';

%quantization
enc=[]
for i=1:length(x)
if x(i)>0 && x(i)<=0.5e8
cq(i)=0;
e=[0 0 0];
elseif x(i)>0.5e8 && x(i)<=1e8
cq(i)=1;
e=[0 0 1];
elseif x(i)>1e8 && x(i)<=1.5e8
cq(i)=2;
e=[0 1 0];
elseif x(i)>1.5e8 && x(i)<=2e8
cq(i)=3;
e=[0 1 1];
elseif x(i)>2e8 && x(i)<=2.5e8
cq(i)=4;
e=[1 0 0];
elseif x(i)>2.5e8 && x(i)<=3e8
cq(i)=5;
e=[1 0 1];
elseif x(i)>3e8 && x(i)<=3.5e8
cq(i)=6;
e=[1 1 0];
end
enc=[enc e];
end

%%%%%%%%%%%%             COLUMN 4                %%%%%%%%%%%%
x = y(:,[4]);
x=x';

%quantization
enc=[]
for i=1:length(x)
if x(i)>0 && x(i)<=2e8
dq(i)=0;
e=[0 0 0];
elseif x(i)>2e8 && x(i)<=4e8
dq(i)=1;
e=[0 0 1];
elseif x(i)>4e8 && x(i)<=6e8
dq(i)=2;
e=[0 1 0];
elseif x(i)>6e8 && x(i)<=8e8
dq(i)=3;
e=[0 1 1];
elseif x(i)>8e8 && x(i)<=10e8
dq(i)=4;
e=[1 0 0];
elseif x(i)>10e8 && x(i)<=12e8
dq(i)=5;
e=[1 0 1];
elseif x(i)>12e8 && x(i)<=14e8
dq(i)=6;
e=[1 1 0];
end
enc=[enc e];
end

%%%%%%%%%%%%             COLUMN 5                %%%%%%%%%%%%
x = y(:,[5]);
x=x';

%quantization
enc=[]
for i=1:length(x)
if x(i)>0 && x(i)<=0.5e7
eq(i)=0;
e=[0 0 0];
elseif x(i)>0.5e7 && x(i)<=1e7
eq(i)=1;
e=[0 0 1];
elseif x(i)>1e7 && x(i)<=1.5e7
eq(i)=2;
e=[0 1 0];
elseif x(i)>1.5e7 && x(i)<=2e7
eq(i)=3;
e=[0 1 1];
elseif x(i)>2e7 && x(i)<=2.5e7
eq(i)=4;
e=[1 0 0];
elseif x(i)>2.5e7 && x(i)<=3e7
eq(i)=5;
e=[1 0 1];
elseif x(i)>3e7 && x(i)<=3.5e7
eq(i)=6;
e=[1 1 0];
end
enc=[enc e];
end

%%plotting the indivual and combined analog and digital graphs

figure(1)
plot(t,y(:,[1]),'LineWidth', 1.5, 'MarkerSize', 18)
legend('Susceptible','Exposed','Infectious','Recovered','Death')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Susceptible - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(2)
plot(t,y(:,[2]),'LineWidth', 1.5, 'MarkerSize', 18)
legend('Exposed')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Exposed - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(3)
plot(t,y(:,[3]),'LineWidth', 1.5, 'MarkerSize', 18)
legend('Infectious')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Infectious - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(4)
plot(t,y(:,[4]),'LineWidth', 1.5, 'MarkerSize', 18)
legend('Recovered')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Recovered - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(5)
plot(t,y(:,[5]),'LineWidth', 1.5, 'MarkerSize', 18)
legend('Death')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Death - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(6)
plot(t,y,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Susceptible','Exposed','Infectious','Recovered','Death')
xlabel('Days after Oct 28, 2020')
ylabel('Population')
title('Predicted Spread of COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

%% DIGITAL PLOT STARTS HERE

figure(7)
plot(t,aq,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Susceptible')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Susceptible - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)


figure(8)
plot(t,bq,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Exposed')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Exposed - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(9)
plot(t,cq,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Infectious')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Infectious - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(10)
plot(t,dq,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Recovered')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Recovered - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(11)
plot(t,eq,'LineWidth', 1.5, 'MarkerSize', 18)
legend('Death')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Death - COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)

figure(12)
plot(t,[aq' bq' cq' dq' eq'],'LineWidth', 1.5, 'MarkerSize', 18)%taking transpose of all quantised values and combining into one 
legend('Susceptible','Exposed','Infectious','Recovered','Death')
xlabel('Days after Oct 28, 2020')
ylabel('Population Distribution')
title('Predicted Spread of COVID-19')
grid on;
grid minor;
set(gca, 'FontSize', 14)
