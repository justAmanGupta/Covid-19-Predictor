function dydt = ode_fun_simple(t, y,beta)

Death = 0.015;  % Death rate of COVID-19 India(Oct, 2020)
Pre_infec = 5.1;%exposed period
f = 1/Pre_infec;%exposed rate
Duration = 14;%duration of infection period
r = 1/Duration;%rate of infection period
S = y(1);
E= y(2);
I = y(3);

dS = -beta*I.*S;
dE = beta*I.*S -  f.*E;
dI = f*E - r*I;
dR = r*(1-Death)*I;
dD = (Death)*r*I;

dydt = [dS; dE; dI; dR; dD];%growth rate
end
