function X=dec2hex1(x)
  X=[]
  for i=1:length(x)
    if x(i)<16 then
      X(i)='0'+dec2hex(x(i))
    else
      X(i)=dec2hex(x(i))
    end
  end
  X1=part(X,1);
  X2=part(X,2);
  X=[];
  X(1:2:length(x)*2)=X1;
  X(2:2:length(x)*2)=X2;
endfunction

function x=hex2data(X)
  x=[]
  tmp=size(X);
  for i=1:tmp(1)/2
    x(i)=hex2dec(X(i*2-1))*16+hex2dec(X(i*2));
  end
  x=x';
endfunction

function IQ=hex2IQ(x)
  M=[-9 9;-9 3;-9 -9;-9 -3;-3 9;-3 3;-3 -9;-3 -3;9 9;9 3;9 -9;9 -3;3 9;3 3;3 -9;3 -3]
  IQ=M(hex2dec(x)+1,:)
endfunction

function x=IQ2hex(IQ)
  M=[-9 9;-9 3;-9 -9;-9 -3;-3 9;-3 3;-3 -9;-3 -3;9 9;9 3;9 -9;9 -3;3 9;3 3;3 -9;3 -3]
  M=M(:,1)+M(:,2)*%i;
  x=[]
  for ii=1:length(IQ(:,1))
    tmp=IQ(ii,:)*[1;%i];
    [balioa,indizea]=min(abs(M-tmp))
    x(ii)=dec2hex(indizea-1)
  end
endfunction

function  xfil=iragazkia_fft(x,L)
  X=fft(x);
  X1=zeros(X);
  X1(1:L)=X(1:L);X1($-L:$)=X($-L:$);
  xfil=real(ifft(X1));
endfunction

function xup=upsample(x,zenbat)
  xup=zeros(length(x)*zenbat,1);
  xup(1:zenbat:$)=x;
endfunction


function [xmod, tm, x_luze_I]=modulazioa(x, T, w_mod, bandaelem, modbandaelem)
    
  //Nm = modbandaelem*bandaelem*N
  Nm = modbandaelem*length(x(:,1)) //length(x(:,1))=bandaelem*N
  hexperascii = 2 // 2 Hamaseitar ASCII bakoitzeko
  //dtm = dt/bandaelem/modbandaelem
  dtm = T/hexperascii/bandaelem/modbandaelem
  Tm = Nm*dtm
  tm = 0:dtm:Tm-dtm

  x_luze_I=[]
  x_luze_Q=[]
  for ii=1:length(x(:,1))
      x_luze_I=[x_luze_I, ones(1,modbandaelem)*x(ii,1)]
      x_luze_Q=[x_luze_Q, ones(1,modbandaelem)*x(ii,2)]
  end
  
  xmod=x_luze_I.*cos(w_mod*tm)+x_luze_Q.*sin(w_mod*tm)
endfunction




iragazkia=[0.00322539637593
0.00147799443607
-0.000792413593937
-0.00283951447591
-0.00398191046401
-0.00382555896721
-0.0023975220061
-0.000146837721972
0.00219085502916
0.00382555896721
0.00417102133642
0.00304717437379
0.000759845043743
-0.00197348524312
-0.00423601659831
-0.00520185203696
-0.00441595031392
-0.00197348524312
0.00146605129894
0.00484735441711
0.00703181535891
0.00716717823255
0.00500201569886
0.0010393344326
-0.00353709950174
-0.00716717823255
-0.00838296450607
-0.00631719526753
-0.00110061359533
0.00598916512551
0.0127098633008
0.0163664017216
0.0145580488702
0.00598916512551
-0.0088676464192
-0.0274549426082
-0.0452940762256
-0.0566567753185
-0.0556493948181
-0.0375041490623
0.000197957766764
0.0566567753185
0.127561951706
0.205493818857
0.280982330654
0.344044036392
0.38590523679
0.400568747019
0.38590523679
0.344044036392
0.280982330654
0.205493818857
0.127561951706
0.0566567753185
0.000197957766764
-0.0375041490623
-0.0556493948181
-0.0566567753185
-0.0452940762256
-0.0274549426082
-0.0088676464192
0.00598916512551
0.0145580488702
0.0163664017216
0.0127098633008
0.00598916512551
-0.00110061359533
-0.00631719526753
-0.00838296450607
-0.00716717823255
-0.00353709950174
0.0010393344326
0.00500201569886
0.00716717823255
0.00703181535891
0.00484735441711
0.00146605129894
-0.00197348524312
-0.00441595031392
-0.00520185203696
-0.00423601659831
-0.00197348524312
0.000759845043743
0.00304717437379
0.00417102133642
0.00382555896721
0.00219085502916
-0.000146837721972
-0.0023975220061
-0.00382555896721
-0.00398191046401
-0.00283951447591
-0.000792413593937
0.00147799443607
0.00322539637593];

rrc_iragazkia=0;
z=%z;
for ii=1:length(iragazkia)
  rrc_iragazkia=rrc_iragazkia+iragazkia($+1-ii)*z^(-ii+1);
end
