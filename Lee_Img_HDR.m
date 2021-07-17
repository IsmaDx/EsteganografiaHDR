clear all;
clc;
close all;

Ihdr = hdrread('office.hdr'); % Ihdr = (r,g,b,e)RGBE en punto flotante
[N,M,Z] = size(Ihdr);
hdr_range = [min(Ihdr(:)) max(Ihdr(:))];

%Convertir a RGBE en forma enteros
for i=1:N
    for j=1:M
        e(i,j) = ceil(log2(max(Ihdr(i,j,:)))+128);
        r(i,j) = floor((256.*Ihdr(i,j,1))./(2.^(e(i,j)-128)));
        g(i,j) = floor((256.*Ihdr(i,j,2))./(2.^(e(i,j)-128)));
        b(i,j) = floor((256.*Ihdr(i,j,3))./(2.^(e(i,j)-128)));
    end
end


%Convertir a RGBE en flotante
for i=1:N
    for j=1:M
        R(i,j) = ((r(i,j)+0.5)./256).*(2.^(e(i,j)-128));
        G(i,j) = ((g(i,j)+0.5)./256).*(2.^(e(i,j)-128));
        B(i,j) = ((b(i,j)+0.5)./256).*(2.^(e(i,j)-128));
    end
end

Ihdr_rgbe(:,:,1) = R; 
Ihdr_rgbe(:,:,2) = G; 
Ihdr_rgbe(:,:,3) = B; 
hdr_range_rgbe = [min(Ihdr_rgbe(:)) max(Ihdr_rgbe(:))];


Ihdr_rgb(:,:,1)=r;
Ihdr_rgb(:,:,2)=g;
Ihdr_rgb(:,:,3)=b;

Ihdr_rgb=uint8(Ihdr_rgb);

rgb = tonemap(Ihdr); %remapeo a rgb
%para rgb


%color rojo
Icrrgb(:,:,1) = rgb(1:100,1:100,1);
Icrrgb(:,:,2) =0;
Icrrgb(:,:,3) =0;

imshow(Icrrgb)


%MIO
msg='hola'
x=1
i=1
k=1
while x<=strlength(msg) 
   z1=dec2bin(msg(x));
   z=dec2bin(Icrrgb(1,i,1))
   z(end)=z1(k);
   stego(i)=bin2dec(transpose(z(:)));
   i=i+1;
   k=k+1;
   if k==8
       x=x+1;
       k=1;
   end
end
h=length(stego);
Icrrgb(1,1:h,1)=transpose(stego(:));
figure
imshow(Icrrgb)



%IsmaDotWav & HDT Fernando


       
       
       

%4321
%0101



