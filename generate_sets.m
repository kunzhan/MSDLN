function [train_label,test_label,val_label,train_index,test_index,val_index] ...
          = index_all(dataset,dataset_gt,no_classes)
      
switch dataset
    case 'IndiaP'   
        per_class_num=[5,143,83,24,49,73,3,48,2,98,245,60,21,126,39,10];  % For Indian Pines: 10% sampling.  
    case 'PaviaU'
        per_class_num=[132,372,42,62,27,101,27,74,19];   % For University of Pacia: 2% sampling.
    case 'Salinas'
        per_class_num=[11,19,10,7,14,20,18,57,32,17,6,10,5,6,37,10];   % For Salinas: 0.5% sampling.
end

train_label=[];
test_label=[];
val_label=[];
train_index=[];
test_index=[];
val_index=[];

for ii = 1: no_classes

   label_gt=dataset_gt;
   index_ii =  find(label_gt(:,2) == ii)';  

   index_ii = label_gt(index_ii);   %index_ii = label_gt(index_ii,1)

   rand_order=randperm(length(index_ii));
   class_ii = ones(1,length(index_ii))* ii;

   num_train=per_class_num(ii);
   train_ii=rand_order(:,1:num_train);
   train_index=[train_index index_ii(train_ii)];

   res_index_temp=index_ii;
   res_index_temp(train_ii)=[]; % test_index_temp(:,train_ii)=[]; 

%%   test_index=[test_index test_index_temp];
   
   train_label=[train_label class_ii(:,1:num_train)];
   num_val=per_class_num(ii);
   rand_order_val=randperm(length(res_index_temp));
   val_ii=rand_order_val(1:num_val);
   val_index_temp=res_index_temp(val_ii);
   res_index_temp(val_ii)=[];
   
   val_index=[val_index val_index_temp];
   test_index=[test_index res_index_temp];
   val_label=[val_label class_ii(1:num_val)];
   test_label=[test_label class_ii(1+2*num_val:end)]; 
end