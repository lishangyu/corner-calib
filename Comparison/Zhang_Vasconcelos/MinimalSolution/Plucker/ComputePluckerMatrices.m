function [P,D]=ComputePluckerMatrices();
 P=zeros(6,16);
 P(1,4)=-1;P(1,13)=1;
 P(2,8)=-1;P(2,14)=1;
 P(3,12)=-1;P(3,15)=1;
 P(4,7)=-1;P(4,10)=1;
 P(5,3)=1;P(5,9)=-1;
 P(6,2)=-1;P(6,5)=1;
 D=diag([2 2 2 2 2 2]);