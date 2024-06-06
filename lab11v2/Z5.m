clear all; close all;
rng(0);
x4 = randi([1,5],1,10);

%coding
% x4_codes = ["1111","1110","110","10","0"];
x4_codes = ["011","010","001","000","1"];
x4_num = {2,3,4,1,5};
coder = containers.Map(x4_num,x4_codes);

huf_code = "";
for i=1:length(x4)
    huf_code = huf_code + coder(x4(i));
end
disp(huf_code);

%decoding
% decode_codes = ["1111","1110","110","10","0"];
decode_codes = ["011","010","001","000","1"]; % tablica kodów huffmana do dekodowania
decode_numbers = {2,3,4,1,5};
decoder = containers.Map(decode_codes,decode_numbers);

x_decoded = "";
temp_str = "";
% przechodzimy przez huf_code tworzac temp_str az znajdziemy odpowiadajacy
% mu kod w decode_codes po czym dajemy ja do x_decoded
for i=1:strlength(huf_code)
    temp_str = temp_str + extract(huf_code,i);
    if ismember(temp_str,decode_codes)
        x_decoded = x_decoded + decoder(temp_str);
        temp_str = "";
    end
end 
disp(x_decoded);

%part2
% dynamiczny koder huffmana
% x_2_ = x4;
x_2_ = z5_e;
[x_symb,x_prawd] = sortuj(x_2_); % funkcja sortująca symbole i obliczajaca ich prawdopodobienstwo
tr = drzewo(x_symb,x_prawd); % funkcja tworzaca drzewo huffmana na podstawie symboli i prawdopodobienstw
kod = tablicaKodera(struct('symbol', tr.symbol, 'bits', []),tr); %funkcja tworzaca tablice kodowania huffmana

x_codes_2 = strings();
for i = 1:length(x_symb)
    x_codes_2 = [x_codes_2, num2str(kod(i).bits)];
end
x_codes_2 = x_codes_2(2:end);
x_num_2 = {kod.symbol};
coder_2 = containers.Map(x_num_2,x_codes_2);

huf_code_2 = "";
for i=1:length(x_2_)
    huf_code_2 = huf_code_2 + coder_2(x_2_(i));
end
disp(huf_code_2);







