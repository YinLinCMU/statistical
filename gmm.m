k=2;%k class
data=importdata('data.csv');%import the data
[m n]=size(data); %m=line n=2
pi1=0.5;
pi2=0.5;
N1=zeros(m,1);
N2=zeros(m,1);
r1=zeros(m,1);
r2=zeros(m,1);
label=zeros(m,1);

for i=1:m/2
    label(i)=1;
end
for i=1:m
    r1(i)=0.5;
    r2(i)=0.5;
end


for a=1:20
% initialize %
n1=0;
n2=0;
for i=1:m
      n1=n1+r1(i);
      n2=n2+r2(i); 
end
n1;
n2;
mu1=zeros(2,1);
mu2=zeros(2,1);
for i=1:m
   if label(i)==1
       mu1(1,1)=mu1(1,1)+r1(i)*data(i,1);
       mu1(2,1)=mu1(2,1)+r1(i)*data(i,2);
   else if label(i)==0
       mu2(1,1)=mu2(1,1)+r2(i)*data(i,1);
       mu2(2,1)=mu2(2,1)+r2(i)*data(i,2);
       end
   end
end
mu1=mu1/n1;
mu2=mu2/n2;
pi1=n1/m;
pi2=n2/m;
% calculate the convariance %
      cov1=bsxfun(@times,r1',bsxfun(@minus,data,mu1')')*bsxfun(@minus,data,mu1')/(n1-1);
      conv1=det(cov1);
            
      cov2=bsxfun(@times,r2',bsxfun(@minus,data,mu2')')*bsxfun(@minus,data,mu2')/(n2-1);
      conv2=det(cov2);
% calculate the probability %
for i=1:m
     N1(i)=1/(2*pi*sqrt(conv1))*exp(-0.5*(data(i,:)-mu1')*inv(cov1)*(data(i,:)-mu1')');
     N2(i)=1/(2*pi*sqrt(conv2))*exp(-0.5*(data(i,:)-mu2')*inv(cov2)*(data(i,:)-mu2')');
end

for i=1:m
    r1(i,:)=pi1*N1(i,:)/(pi1*N1(i,:)+pi2*N2(i,:));
    r2(i,:)=pi2*N2(i,:)/(pi1*N1(i,:)+pi2*N2(i,:));
end
% label %
for i=1:m
    if r1(i)>r2(i)
        label(i)=1;
    else
        label(i)=0;
    end
end
end
% plot data after classed
figure;
hold on;
for i=1:m 
    x=data(i,1);
    y=data(i,2);
    if label(i)==0
        plot(x,y,'*r');
        hold on;
    else
        plot(x,y,'*b')
        hold on;
    end
end
grid on;
mu1
mu2
cov1
cov2
% plot ellipse
sita=0:pi/20:2*pi; 
plot(mu1(1)+(cov1(1,1)-cov1(1,2))*cos(sita),mu1(2)+12*(cov1(2,2)-cov1(2,1))*sin(sita),'b')
plot(mu2(1)+2.5*(cov2(1,1)-cov2(1,2))*cos(sita),mu2(2)+0.8*(cov2(2,2)-cov2(2,1))*sin(sita),'r')
