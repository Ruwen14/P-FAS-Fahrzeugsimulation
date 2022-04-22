%Environmental conditions
g = 9.81; % Schwerebeschleunigung
roh_air = 1.2; % Luftdichte 
f_roll = 0.013; % Rollwiderstandskoeffizient Reifen PKW-trockener Asphalt
m_Zuladung = 50;  % Zuladung 


% Vehicle constants (Mercedes A180 W176)
c_w = 0.25; % Strömungswiderstandskoeffizient cw-Wert
A_Stirn = 2.19; % Stirnfläche
m_Fzg = 1525; % Leergewicht
m_Ges = m_Fzg+m_Zuladung; 
r_Radradius = 0.32; % Radhalbmesser 
U_Radumfang = 2*pi*r_Radradius; % Radumfang 

% Vehicle powertrain
i_GetriebeUebersetzung = [0.00, 4.31, 2.44, 1.35, 0.94, 0.82, 0.70, 3.38]; % Getriebeübersetzungen [N, 1, 2, 3, 4, 5, 6, R]
i_UebersetzungHinterachsgetriebe = 3.35; % Übersetzung Differential
MassefaktorenGang = [1.04, 1.32, 1.15, 1.10, 1.07, 1.06, 1.05, 1.35]; % Trägheitsmomente Getriebeübersetzungen

% Abtastfrequenz und Simulationszeitschritte (time steps) 
fs = 10; % [Hz] Werte pro Sekunde
ts = 1/fs; % [s] Schrittweite in Sekunden


% Schleppmoment aus Brief Martha
n_Stuetz_Motor_Schlepp = [0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500]; % [U/min] Umdrehungen
M_Schlepp = [10.27 10.53 10.93 11.46 12.12 12.91 13.84 14.90 16.09 17.41 18.86 20.45]; % [Nm] Schleppmoment


n_Stuetz_Motor = [0.00 608.00 640.00 736.00 800.00 992.00 1248.00 1504.00 1760.00 2016.00 2240.00 2496.00 2752.00 3008.00 3264.00 3488.00 3744.00 4000.00 4512.00 4992.00 5248.00 5500.00];

% Motormoment aus torque_request_standard_condition.pdf
torquerequeststandardcondition_pdf = ...
    [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 65.16 63.91 53.88 45.13 15 5.69 5 5 5 5 5 5 5 5 5 5 5 5 5 5 0;
    0 95.22 93.38 78.31 67.94 39.56 19.47 6.34 5 5 5 5 5 5 5 5 5 5 5 5 5 0;
    0 125.28 124.44 111.44 101.91 77.19 51.47 37.72 28.66 21.97 17.47 14.47 ...
    12.22 11.47 10.94 10.56 10.19 9.84 9.31 8.88 5.53 0;
    0 126 126 126 126 109.19 79.09 55.88 43.53 34.91 29.09 24.84 21.69 20.06 ...
    18.88 17.97 17.06 16.28 15.03 14.06 6.22 0;
    0 126 126 126 126 126 101.28 79.63 64.31 53 45.34 39.41 34.88 32.13 ...
    29.97 28.38 26.75 25.34 23.03 21.28 7.19 0;
    0 126 126 126 126 126.5 131.09 109.69 91.28 77.69 68.5 60.75 54.56 50.19 ...
    46.63 43.94 41.22 38.91 35.03 32.13 8.66 0;
    0 126 126 126 126 131.47 182.66 155.41 131.56 113.91 102.03 91.31 82.72 ...
    75.97 70.31 66.13 61.91 58.22 52.16 47.59 10.75 0;
    0 126 126 126 126 133.41 202.47 199.13 173.38 151.53 136.81 123.19 112.16 ...
    103.16 95.63 89.97 84.31 79.38 71.25 65.16 13.13 0;
    0 126 126 126 126 133.41 208.5 248.19 217 189.5 170.91 153.94 140.25 ...
    129.22 119.97 113.09 106.16 100.16 90.19 82.75 15.5 0;
    0 126 126 126 126 133.41 209.59 257.94 254 244.53 202.44 182.63 166.75 ...
    154.31 143.97 136.25 128.47 121.69 110.56 102.19 18.13 0;
    0 126 126 126 126 133.41 209.59 262.69 289.16 257.16 231.78 209.5 191.75 ...
    178.25 167.09 158.75 150.41 143.13 131.06 122.06 20.81 0;
    0 126 126 126 126 133.41 209.59 262.75 290.78 285.94 259.66 235.19 215.75 ...
    201.5 189.78 181.03 172.25 164.59 151.97 142.5 23.59 0;
    0 126 126 126 126 133.41 209.59 262.75 291 291 282.56 260.13 239.22 ...
    224.47 212.44 203.41 194.38 186.5 173.5 153.06 24.91 0;
    0 126 126 126 126 133.41 209.59 262.75 291 291 291 282.41 262.47 247.44 ...
    236.22 226.09 216.97 209 186.31 154.03 24.91 0;
    0 126 126 126 126 133.41 209.59 262.75 291 291 291 291 281.31 266.06 ...
    253.38 241.63 230 218.72 186.69 154.03 24.91 0;
    0 126 126 126 126 133.41 209.59 262.75 291 291 291 291 281.31 266.06 ...
    253.38 241.63 230 218.72 186.69 154.03 24.91 0];

% Fahrpedalstellung
k_Stuetz_Pedal = [0.00 0.13 6.25 12.50 18.75 25.00 31.25 37.50 43.75 50.00 56.25 62.50 68.75 75.00 81.25 90.63 100.00];

% LoopUp
[X,Y] = meshgrid(0:100:5500,0:2:100);
V = griddata(n_Stuetz_Motor,k_Stuetz_Pedal,torquerequeststandardcondition_pdf,X,Y);

EngTrq = [0 25 50 75 100 125 150 175 200 225 250 275 300];
Getriebefaktoren = [0.950000000000000	1	1.08000000000000	1.18000000000000	1.26000000000000	1.40000000000000	1.56000000000000	1.13000000000000];

% Drehmomentverlust aus torque_loss_gear_box.xlsx
torque_gear1_excel = ...
  [1 0.95 0.92 0.86 0.85 0.8 0.74 0.73 0.74 0.69 0.65 0.62;
   1.37 1.31 1.24 1.18 1.14 1.08 1.02 1 0.99 0.94 0.89 0.84;
   1.71 1.64 1.57 1.5 1.42 1.35 1.29 1.27 1.24 1.18 1.12 1.06;
   2.08 1.99 1.89 1.8 1.7 1.63 1.56 1.53 1.49 1.42 1.35 1.28;
   2.47 2.36 2.26 2.15 2.04 1.95 1.86 1.83 1.8 1.72 1.64 1.56;
   2.91 2.77 2.64 2.5 2.39 2.29 2.18 2.14 2.09 2.02 1.94 1.86;
   3.29 3.15 3.02 2.89 2.74 2.63 2.5 2.46 2.4 2.33 2.24 2.15;
   3.7 3.55 3.4 3.25 3.08 2.96 2.82 2.77 2.7 2.61 2.51 2.41;
   4.12 3.95 3.77 3.6 3.41 3.28 3.14 3.05 2.97 2.87 2.77 2.67;
   4.57 4.37 4.17 3.97 3.77 3.61 3.46 3.36 3.27 3.17 3.08 2.98;
   5.05 4.81 4.57 4.32 4.12 3.94 3.78 3.66 3.57 3.47 3.39 3.3;
   5.53 5.25 4.96 4.68 4.48 4.26 4.11 3.96 3.86 3.77 3.69 3.62;
   6.01 5.69 5.36 5.04 4.84 4.59 4.43 4.26 4.16 4.07 4 3.94];


neutral = torque_gear1_excel*Getriebefaktoren(1);
gear_1 = torque_gear1_excel;
gear_2 = torque_gear1_excel*Getriebefaktoren(3);
gear_3= torque_gear1_excel*Getriebefaktoren(4);
gear_4 = torque_gear1_excel*Getriebefaktoren(5);
gear_5 = torque_gear1_excel*Getriebefaktoren(6);
gear_6 = torque_gear1_excel*Getriebefaktoren(7);
reverse = torque_gear1_excel*Getriebefaktoren(8);


% Modelierung Rad- und Bremsen
r_brems = 0.1;   % [m] Mittlerer Radius der Bremsscheibe
i_brems = 12;    % [1] Kraftverstärkung der Bremsanlage
mu_brems = 0.8;  % [1] Reibungskoeffizient der Bremsbeläge
n_brems = 2;     % [1] Anzahl der Bremskolben pro Rad


