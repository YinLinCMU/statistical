m=4; %feture number
c=3; %class
%--------------------- train data ---------------------%
train=textread('train_data.txt');%read trainning_data.txt
train=sortrows(train,5);% sort the matrix acording to class
class=train(:,5);
size_m=size(class);
p1=0;%store every class's number of lines
p2=0;
p3=0;
mu=zeros(m,c);%conditional mean
sigma=zeros(m,c);%conditional standard deviation
%split matrix to three part
for i=1:size_m(1)
    if class(i)==1
        p1=p1+1;
    end
    if class(i)==2
         p2=p2+1;
    end
    if class(i)==3
        p3=p3+1;
    end
end
class1=train(1:p1,1:5);%class1
class2=train(p1+1:p1+p2,1:5);%class2
class3=train(p1+p2+1:p1+p2+p3,1:5);%class3
% prior probability of class %
p1=p1/size_m(1);
p2=p2/size_m(1);
p3=p3/size_m(1);
%calculate mean and standard deviation
for i=1:4
       mu(i,1)=mean(class1(:,i));
       mu(i,2)=mean(class2(:,i));
       mu(i,3)=mean(class3(:,i));
       sigma(i,1)=std(class1(:,i));
       sigma(i,2)=std(class2(:,i));
       sigma(i,3)=std(class3(:,i));
end
mu;
sigma2=sigma.*sigma;%variance
%--------------------- test data ---------------------%
nb1=1;%gaussian naive bayes
nb2=1;
nb3=1;
test=textread('test_data.txt');
size_r=size(test);
result=zeros(size_r(1),1);
accuracy=0;
for i=1:size_r(1)
nb1=1;
nb2=1;
nb3=1;
     for j=1:4
         nb1=nb1*normpdf(test(i,j),mu(j,1),sigma(j,1));
         nb2=nb2*normpdf(test(i,j),mu(j,2),sigma(j,2));
         nb3=nb3*normpdf(test(i,j),mu(j,3),sigma(j,3));
      end
    [p,index]=max([p1*nb1,p2*nb2,p3*nb3]);
    result(i)=index;    
    if result(i)==test(i,5)
        accuracy=accuracy+1;
    end
end
result=[test(:,1:5),result];
accuracy=accuracy/size_r(1);
%--------------------- output data ---------------------%

f=fopen('result.txt','wt');
% Q1. output prior probabilities %
fprintf(f,'(1) P(class1)=%4.3f  P(class2)=%4.3f  P(class3)=%4.3f\n',p1,p2,p3);
% Q2. output mu & sigma %
fprintf(f,'(2)\nmu=\n');
for i=1:4
    for j=1:3
        fprintf(f,'%10g',mu(i,j));
    end
    fprintf(f,'\n');
end
fprintf(f,'\nsigma=\n');
for i=1:4
    for j=1:3
        fprintf(f,'%10g',sigma2(i,j));
    end
    fprintf(f,'\n');
end
% Q3. output test data result %
fprintf(f,'\n(3)\n    feture1   feture2   feture3    feture4  supporsed  my result\n');
for i=1:size_r(1)
    for j=1:size_r(2)+1
        fprintf(f,'%10g',result(i,j));
    end
    fprintf(f,'\n');
end
% Q4. output accuracy %
fprintf(f,'\n(4) Accuracy is %3.2f.',accuracy);
fclose(f);