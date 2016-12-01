%%================================================================%%
%%  Computational Neuroscience (EC60007) Project 3
%%
%%  Siddharth S Jha,  14EE30022
%%  Adarsh Mukesh,    13BT3
%%  
%%================================================================%%
%%  Question no 1: Gaussian Estimation
k=zeros(100);
j=zeros(100);

for i = -49:50
    if(i>0)
    for l=1:20000-i
        j(i+49)=j(i+49)+(Stimulus(l)*Stimulus(l+i));
    end
    j(i+49)=j(i+49)/(20000-i);
    end
    if (i<0)
    for l=-1*i+1:20000
        j(i+50)=j(i+50)+(Stimulus(l)*Stimulus(l+i));
    end
    j(i+50)=j(i+50)/(20000+1*i-1);
    end
end

t=linspace(-50,50,100);
figure(1)
plot(t,j);

%%================================================================%%
%%  Question no 2: PSTH Evaluation

psth=zeros(4,20000);
for i = 1:4
   for j = 1:50
        [m,n]=size(All_Spike_Times{i,j});
        for p = 1:n
            temp=ceil(All_Spike_Times{i,j}(p)*1000);
            psth(i,temp)=psth(i,temp)+1;
        end
    end
end

figure(2)
%PSTH for 4 neurons
    ax1=subplot(4,1,1);
    plot(1000*psth(1,1:20000),'r');
    xlabel(ax1,'time (ms)');
    ylabel(ax1,'r(t)');
    ax2=subplot(4,1,2);
    plot(1000*psth(2,1:20000));
    xlabel(ax2,'time (ms)');
    ylabel(ax2,'r(t)');
    ax3=subplot(4,1,3);
    plot(1000*psth(3,1:20000),'r');
    xlabel(ax3,'time (ms)');
    ylabel(ax3,'r(t)');
    ax4=subplot(4,1,4);
    plot(1000*psth(4,1:20000));
    xlabel(ax4,'time (ms)');
    ylabel(ax4,'r(t)');
    
%%================================================================%%
%%  Question no 3: Poisson or Non-Poisson

bintimes=[10, 20, 50, 100, 200, 500];

for i = 1:6
    noofbin(i)=20000/bintimes(i);
    binfreq(i)=1000/bintimes(i);
end

spikes=zeros(4,6,2000);

varmat=[];
meanmat=[];
for neur_no=1:4
    for freq_no=1:6
        for j = 1:50
        [m,n]=size(All_Spike_Times{neur_no,j});
            for p = 1:n
                temp=ceil(All_Spike_Times{neur_no,j}(p)*binfreq(freq_no));
                spikes(neur_no,freq_no,temp)=spikes(neur_no,freq_no,temp)+1;
            end
            poissonmat{neur_no,freq_no}=spikes(neur_no,freq_no,1:noofbin(freq_no));
            varmat(neur_no,freq_no,j)=  var(poissonmat{neur_no,freq_no});
            meanmat(neur_no,freq_no,j)= mean(poissonmat{neur_no,freq_no});
        end
    end
end
figure(4)
subplot(2,2,1)
scatter(varmat(1,1,:),meanmat(1,1,:))
subplot(2,2,2)
scatter(varmat(2,1,:),meanmat(2,1,:))
subplot(2,2,3)
scatter(varmat(3,1,:),meanmat(3,1,:))
subplot(2,2,4)
scatter(varmat(4,1,:),meanmat(4,1,:))

% for neur_no=1:4
%     for freq_no=1:6
%          poissonmat{neur_no,freq_no}=spikes(neur_no,freq_no,1:noofbin(freq_no));
%     end
% end


% 

% 
% for neur_no=1:4
%     for freq_no=1:6
%         meanmat=[meanmat,mean(poissonmat{neur_no,freq_no})];
%         varmat=[varmat,var(poissonmat{neur_no,freq_no})];
%     end
% end
% figure(3)
% scatter(meanmat,varmat,'r') %NEED TO MULTIPLY SOME CONSTANTS TO MAKE VARIANCE OKAY
% 
% %%================================================================%%
% %%  Question no 4: Spike Triggered Average




