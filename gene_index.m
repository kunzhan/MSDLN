close all;
clear all;
clc;
%dataset = 'PaviaU';
%dataset = 'IndiaP';
dataset = 'Salinas';

load(['datasets/',dataset,'.mat']); 
load (['datasets/',dataset,'_gt.mat']); 

dir=['data/',dataset,'/val/h5files'];
savepath_train = strcat(dir,'/train.h5'); 
savepath_test = strcat(dir,'/');
savepath_val = strcat(dir,'/val.h5');

if strcmp('PaviaU',dataset)
    pad_size=11;                               %paviau-11,indiapines-12,salinas-13
    num_bands=5;                               %paviau-5,indiapines-3,salinas-10
    input_size=2*pad_size+1;                   %input_size=23,indiapines-25,salinas-27
    no_classes=9;                              %paviau-9,indiapines-16,salinas-16
end
if strcmp('IndiaP',dataset)
    pad_size=12;                              
    num_bands=3;                              
    input_size=2*pad_size+1;                   
    no_classes=16;                            
end
if strcmp('Salinas',dataset)
    pad_size=13;                              
    num_bands=10;                               
    input_size=2*pad_size+1;                  
    no_classes=16;                              
end


[I_row,I_line,I_high] = size(img); 


%% average fusion
dims=num_bands;
im=zeros(I_row,I_line,dims);
for i=1:dims-1
    for j=1:floor(I_high/dims)
        im(:,:,i) = im(:,:,i) + img(:,:,(i-1)*floor(I_high/dims)+j);
    end
    im(:,:,i)=im(:,:,i)/floor(I_high/dims);
end
n=0;
for i=(dims-1)*floor(I_high/dims)+1:I_high
	im(:,:,dims)=im(:,:,dims)+img(:,:,i);
	n=n+1;
end
im(:,:,dims)=im(:,:,dims)/n;

[I_row,I_line,I_high] = size(im);  
im=reshape(im,I_row*I_line,I_high);
im = mat2gray(im);
im =reshape(im,[I_row,I_line,dims]);
[I_row,I_line,I_high] = size(im); 

%%%%%  scale the image from -1 to 1
im=reshape(im,I_row*I_line,I_high); 
[im ] = scale_func(im); 
im =reshape(im,[I_row,I_line,I_high]); 

%%%%%% extending the image %%%%%%%%
im_extend=padarray(im,[pad_size,pad_size],'symmetric');
[r,l,b]=size(im_extend);
im_extend=reshape(im_extend,[r*l,b]);
im_extend=im_extend-repmat(mean(im_extend),r*l,1);
im_extend=reshape(im_extend,[r,l,b]);


%[train_label,test_label,unlabeled_label,train_index,test_index,unlabeled_index] ...
%      = new_index(dataset,GroundT,no_classes);

[train_label,test_label,val_label,train_index,test_index,val_index] ...
      = generate_sets(dataset,GroundT,no_classes);


%[TRAIN_DATA, TRAIN_LABEL, TRAIN_INDEX] = write_save_h5('train', input_size,pad_size, ...
%                     I_row, I_high,train_label,train_index, savepath_train, im_extend) ;

%[TEST_DATA, TEST_LABEL, TEST_INDEX] = write_save_h5('test', input_size,pad_size, ...
%                     I_row, I_high,test_label,test_index, savepath_test, im_extend) ;

%[VAL_DATA, VAL_LABEL, VAL_INDEX] = write_save_h5('train', input_size,pad_size, ...
%                     I_row, I_high,val_label,val_index, savepath_val, im_extend) ;



[TRAIN_DATA, TRAIN_LABEL, TRAIN_INDEX] = write_save_all('train', input_size,pad_size, ...
                     I_row, I_high,train_label,train_index, savepath_train, im_extend) ;

[TEST_DATA, TEST_LABEL, TEST_INDEX] = write_save_all('test', input_size,pad_size, ...
                     I_row, I_high,test_label,test_index, savepath_test, im_extend) ;

[VAL_DATA, VAL_LABEL, VAL_INDEX] = write_save_all('train', input_size,pad_size, ...
                     I_row, I_high,val_label,val_index, savepath_val, im_extend) ;
     
clearvars -except TRAIN_INDEX TEST_INDEX  VAL_INDEX VAL_LABEL TEST_LABEL TRAIN_LABEL  dataset

save(['data/',dataset,'/val/data/data.mat'])