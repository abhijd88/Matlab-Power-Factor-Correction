Vr=input('Enter rms value of supply voltage:');
Qv=input('Enter phase angle of supply voltage in degree:');
f=input('Enter the frequency of supply voltage:');
n=input('Enter the number of Load:');
Z=input('Enter the loads in a row vector  [ each R+jX form ]:');

Qvr=Qv*(pi/180);      %PHASE ANGLE of VOLTAGE IN RADIAN
V=Vr*exp(i*Qvr);      %VOLTAGE IN RECTANGULAR FORM

Y=Z.^(-1);
Yt=sum(Y);            %TOTAL ADMITTANCE
I=V*Yt;               %TOTAL CURRENT
Qi=phase(I);          %PHASE ANGLE OF CURRENT
pf=cos(Qvr-Qi);       %POWER FACTOR

if pf>=0.9
fprintf('\nThe overall power factor before correction is %6.6f which is already greater or equal to 0.9. No correction is needed.',pf)

elseif pf<0.9
fprintf('\n The overall power factor before correction is %6.6f which is less than 0.9.\n\n POWER FACTOR SHOULD BE CORRECTED.',pf)

S=Vr*abs(I);             %APPARENT POWER
P=S*pf;                  %REAL POWER
QQ=sqrt(S^2-P^2);        %REACTIVE POWER
pf1=input('\n\n Enter the desired value of power factor that is more than or equal to 0.9: ');
Snew=P/pf1;              %DESIRED APPARENT POWER TO CORRECT THE POWER FACTOR TO 0.9
QQnew=sqrt(Snew^2-P^2);  %DESIRED REACTIVE POWER  TO CORRECT THE POWER FACTOR TO 0.9
QQc=QQ-QQnew;            %DESIRED REACTIVE POWER ACROSS THE CAPACITOR

Xc=Vr^2/QQc;             %REACTANCE OF THE CAPACITOR
C=1/(2*pi*f*Xc);         %VALUE OF CAPACITANCE IN FARAD TO CORRECT THE POWER FACTOR TO 0.9

%CALCULATING THE POWER FACTOR AGAIN TO VERIFY THE CORRECTION
newYt=Yt+(2*pi*f*C)*i;         %ADMITTANCE AFTER CONNECTING THE CAPACITOR IN PARALLEL  
newI=V*newYt;                  %TOTAL CURRENT AFTER CONNECTING THE CAPACITOR
newQi=phase(newI);             %PHASE ANGLE OF THE NEW CURRENT
newpf=cos(Qvr-newQi);          %POWER FACTOR AFTER CORRECTION
fprintf('\n\n A capacitor bank of %6.8f Farad is needed to be parallely connected that will improve powerfactor to%6.2f.\n',C,newpf)
end