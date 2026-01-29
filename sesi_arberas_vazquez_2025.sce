//Andoni Vázquez eta Beñat Arberas

//VARIABLES:
mezua="Egun on      "
disp(mezua)
srate = 1 // karaktere igortzeko rate(Hz)
hexperascii = 2 // 2 Hamaseitar ASCII bakoitzeko
bandaelem=8//=m
modw=40
modbandaelem=1000
Kz = 30// zarata proportzioa
wc = 50 // Hz. Hortik ezabatzeko maiztasuna
iragazki_ideala_on = 1 // 1=>Iragazki ideala On;
                       // 0=>     ""         Off
//Aldagaiak end

//Programa
data=ascii(mezua)
datah=dec2hex1(data)
IQ=hex2IQ(datah)

f133=figure(133);clf(f133)
xtitle("IQ konstelazioa","I(NA)","Q(NA)")
plot(IQ(:,1),IQ(:,2),'*')

N=length(IQ(:,1))
dt=srate/hexperascii
T=N*dt
t=0:dt:T-dt

df=1/T
F=1/dt
f=0:df:F-df

Iw=fft(IQ(:,1))
f10=figure(10);clf(f10)
xtitle("|I FFT|", "f(Hz)", "I(dB)")
plot2d(f,20*log10(Iw))

Qw=fft(IQ(:,2))
f41=figure(41);clf(f41)
xtitle("|Q FFT|", "f (Hz)", "Q (dB)")
plot2d(f,20*log10(Qw))

//I eta Q grafikoak:
f49=figure(49); clf(f49)
xtitle("I","t [s]","I(t)")
plot2d3(t,IQ(:,1),-3)

f48=figure(48); clf(f48)
xtitle("Q","t [s]","Q(t)")
plot2d3(t,IQ(:,2),-3)

// dt txikitu F handitzeko: zeroak elementuen artean gehitu
//kasu honetan 2 zeru elementu bakoitzeko
m=bandaelem //elementu + zero kopurua

Nm=N*m
Tm=T
dtm=dt/m
tm=0:dtm:Tm-dtm
Fm=1/dtm
dfm=1/Tm
fm=0:dfm:Fm-dfm


//UPSAMPLE
IBW=upsample(IQ(:,1),bandaelem)
QBW=upsample(IQ(:,2),bandaelem)

NBW=bandaelem*N //bandaelem=m
dtBW=dt/bandaelem
TBW=NBW*dtBW
tBW=0:dtBW:TBW-dtBW
f2=figure(2);clf(f2)
xtitle("I BW","t(s)","I(NA)")
plot2d3(tBW,IBW,-3)
f42=figure(42);clf(f42)
xtitle("Q BW", "t (s)","Q (NA)")
plot2d3(tBW,QBW,-3)

//Grafikoa zeroak gehituta, F handitzen da
Iw2=fft(IBW(:,1))
f11=figure(11);clf(f11)
xtitle("|I FFT|", "f(Hz)", "I(dB)") 
plot2d(fm,20*log10(Iw2))

Qw2=fft(QBW(:,1))
f112=figure(112);clf(f112)
xtitle("|Q FFT|", "f(Hz)", "Q(dB)") 
plot2d(fm,20*log10(Qw2))

FBW=1/TBW
dfBW=1/dtBW
fBW=0:dfBW:FBW-dfBW

//IRAGAZKIA
rrc_iragazkia.dt=dtBW
//disp(rrc_iragazkia) 
IBWH=flts(IBW',rrc_iragazkia)
QBWH=flts(QBW',rrc_iragazkia)
IwBWH=fft(IBWH)
f30=figure(39); clf(f30)
xtitle("|I FFT BW Hrrc|", "f(Hz)","I(dB)")
plot2d(fBW,20*log10(IwBWH))
QwBWH=fft(QBWH)
f44=figure(44); clf(f44)
xtitle("|Q FFT BW Hrrc|", "f (Hz)","Q (dB)")
plot2d(fBW,20*log10(QwBWH))

//MODULATU
[xmod,tp]=modulazioa([IBWH',QBWH'],srate,modw,bandaelem,modbandaelem)
f3=figure(3);clf(f3)
xtitle("Seinalea modulatuta", "t(s)","seinalea(NA)")
plot2d(tp,xmod)
Nmod=modbandaelem*bandaelem*N //bandaelem=m
dtmod=dt/bandaelem/modbandaelem
Tmod=Nmod*dtmod
tmod=0:dtmod:Tmod-dtmod

dfmod=1/Tmod
Fmod=1/dtmod
fmod=0:dfmod:Fmod-dfmod

// IGORRI SEINALEA

xmod = xmod + Kz*(rand(xmod)-0.5) //zarata gehitzeko

f900=figure(900);clf(f900)
xtitle("Seinalea modulatuta zaratarekin", "t(s)","seinalea(NA)")
plot2d(tmod,xmod)
//ETA HARTU SEINALEA

//IRAGAZKI IDEALAREKIN (KONPUTAZIONALKI RRC BAINO ERAGINKORRAGO)
if iragazki_ideala_on then

Imod=fft(xmod)
f3000=figure(3000); clf(f3000)
xtitle("|I FFT mod zaratarekin|", "f(Hz)","I(dB)")
plot2d(fmod,20*log10(Imod))

L = wc/dfm
xmod = iragazkia_fft(xmod,L)
Imod=fft(xmod)
f300=figure(300); clf(f300)
xtitle("|I FFT mod|", "f(Hz)","I(dB)")
plot2d(fmod,20*log10(Imod))

f600=figure(600); clf(f600)
xtitle("|I FFT mod|", "f(Hz)","I(dB)")
plot2d(fmod,20*log10(Imod),rect=[0,-300,200,300])
end
// DEMODULATU
IBWHr=xmod.*cos(modw*tp)
QBWHr=xmod.*sin(modw*tp)

// IRAGAZKIA BERRIRO PASATU ETA BANDA MURRIZTU
Ir=flts(IBWHr(1:modbandaelem:$),rrc_iragazkia)
Qr=flts(QBWHr(1:modbandaelem:$),rrc_iragazkia)

// SINKRONIZATU, BANDA MURRIZTU ETA IRABAZIA EGOKITU
atzerapena=length(iragazkia)
IQr=[2*Ir(atzerapena:bandaelem:$)',2*Qr(atzerapena:bandaelem:$)'] //*2 modulatzean /2 
//egiten delako

f100=figure(100);clf(f100)
xtitle("IQ konstelazioa", "I(NA)", "Q(NA)")
plot(IQ(:,1),IQ(:,2),'*')
plot(IQr(:,1),IQr(:,2),'*')

// IQ-TIK SEINALEA LORTU (IQ TO ASCII)
datahr=IQ2hex(IQr)
datasr=hex2data(datahr)
datar=ascii(datasr)
disp(datar)

