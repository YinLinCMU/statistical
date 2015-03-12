k=2;%k class
data=importdata('data.csv');%import the data
[m n]=size(data); %m=line n=2
num=round(rand(k,1)*(m-1))+1;%produce k number randomly
c=zeros(k,2);

for i=1:k
    c(i,:)=data(num(i),:)
end

re=zeros(k,1);%store the distance with each center
for a=1:200%terminate condition
    
%each data compare with the each center
label=zeros(m,1);%label the class

for i=1:m % 
    for j=1:k
        re(j)=sqrt((data(i,1)-c(j,1))^2+(data(i,2)-c(j,2))^2);%distance       
    end
    [x,y]=min(re);
    label(i)=y;
end

%calculate the center again
n=zeros(k,1);
count=zeros(k,2);
for i=1:m
      count(label(i),:)=count(label(i),:)+data(i,:);
      n(label(i))=n(label(i))+1;
end
for i=1:k
    c(i,:)=count(i,:)/n(i);
end

end

%input and define every classes' color
color=cell(k,1);
color{1}='*r';
color{2}='*b';
%plot
figure;
hold on;
for i=1:m 
    x=data(i,1);
    y=data(i,2);    
    plot(x,y,color{label(i)});
    hold on;
end
grid on;
