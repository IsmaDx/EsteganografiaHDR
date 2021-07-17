clear all;
clc;
close all;

Ihdr = hdrread('office_2.hdr'); % Ihdr = (r,g,b,e)RGBE en punto flotante
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

rgb = tonemap(Ihdr); %remapeo a rgb
%para rgb
figure %color rojo
Icrrgb(:,:,1) = rgb(1:100,1:100,1);
Icrrgb(:,:,2) =0;
Icrrgb(:,:,3) =0;
imshow(Icrrgb)

figure %color verde
Icgrgb(:,:,2) = rgb(1:100,1:100,2);
Icgrgb(:,:,1) = 0;
Icgrgb(:,:,3) = 0;
imshow(Icgrgb)


figure %color azul
Icbrgb(:,:,3) = rgb(1:100,1:100,3);
Icbrgb(:,:,1) = 0;
Icbrgb(:,:,2) = 0;
imshow(Icbrgb)


figure %color rojo
Icr(:,:,1) = uint8(r(1:100,1:100,1));
Icr(:,:,2) =0;
Icr(:,:,3) =0;
imshow(Icr)

figure %color verde
Icg(:,:,2) = uint8(r(1:100,1:100,1));
Icg(:,:,1) = 0;
Icg(:,:,3) =0;
imshow(Icg)

figure %color azul
Icb(:,:,3) = uint8(r(1:100,1:100,1));
Icb(:,:,1) = 0;
Icb(:,:,2) =0;
imshow(Icb)


Ihdr_rgb(:,:,1)=r;
Ihdr_rgb(:,:,2)=g;
Ihdr_rgb(:,:,3)=b;

Ihdr_rgb=uint8(Ihdr_rgb);

% hdrwrite(Ihdr_rgbe,'office_2.hdr');
% Ihdr_2 = hdrread('office_2.hdr'); % Ihdr = (r,g,b,e)RGBE
