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

[filename,pathname]=uigetfile('*.hdr','Abrir Documento');
caden=imread(filename);
imgsx=rgb2gray(caden);
imgsx=double(imgsx);
imshow(imgsx)
%histogram(imgsx)
[x y]=kmeans(caden(:,:,1),5)
x=reshape(x,size(imgsx))
y=y/255;
img=label2rgb(x,y);
imshow(img)
imshow(idx)
    for n=0:255
        Lr=imgsx(:,:,1)==n;
        Hr(n+1)=sum(double(Lr(:)));
    end
    try
    for n=1:255
    Mr(n)= mean(Hr(n:n+13));
    end
    catch  ex
    end
    figure(1)
    plot(Hr)
    figure(2)
    plot(Mr)
    %IsmaDotWAV
    

