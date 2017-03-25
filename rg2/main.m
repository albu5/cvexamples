%% EE 766: Random Graphs, Ashish Goyal, 12D070051
% Problem Set 2

%%
n = 200;
nexp = 100;
meanlen = [];
nedge = [];
for m = 1:n/10:0.25*n*(n-1)/2
    tic
    temp = [];
    for i = 1:nexp
        G = gnm(n,m);
        bins = conncomp(graph(G));
        [~,temp(end+1)] = mode(bins);
    end
    display(sprintf('%d experiments, %d nodes, %d edges, %f secs elapsed',...
        nexp, n, m, toc))
    meanlen(end+1) = mean(temp);
    nedge(end+1) = m;
end

%%
% Clearly, a threshold like beahavior is observed
figure
plot(nedge, meanlen), title('average length (# vertices) of the largest connected component vs the number of edges m')
xlabel('number of edges m')
ylabel(sprintf('average length of largest connected comp in %d experiments',nexp))
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%%
nexp = 1000;
meanlen1 = [];
meanlen2 = [];
nnode = [];
for n = 10:10:200
    m = round(0.3*n);
    tic
    temp1 = [];
    temp2 = [];
    for i = 1:nexp
        G = gnm(n,m);
        bins = conncomp(graph(G));
        [larg,temp1(end+1)] = mode(bins);
        [~,temp2(end+1)] = mode(bins(bins~=larg));
    end
    display(sprintf('%d experiments, %d nodes, %d edges, %f secs elapsed',...
        nexp, n, m, toc))
    meanlen1(end+1) = mean(temp1);
    meanlen2(end+1) = mean(temp2);
    nnode(end+1) = n;
end

%%
figure
plot(nnode, meanlen1), hold on, plot(nnode, meanlen2), title('average length (# vertices) of the largest and the second largest connected component vs the number of nodes n (m = 0.3n)')
xlabel('number of nodes n')
ylabel(sprintf('average length of largest connected comp in %d experiments',nexp))
legend({'Largest Component','Second Largest Component'})
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%%
nexp = 1000;
meanlen1 = [];
meanlen2 = [];
nnode = [];
for n = 10:10:200
    m = round(0.6*n);
    tic
    temp1 = [];
    temp2 = [];
    for i = 1:nexp
        G = gnm(n,m);
        bins = conncomp(graph(G));
        [larg,temp1(end+1)] = mode(bins);
        [~,temp2(end+1)] = mode(bins(bins~=larg));
    end
    display(sprintf('%d experiments, %d nodes, %d edges, %f secs elapsed',...
        nexp, n, m, toc))
    meanlen1(end+1) = mean(temp1);
    meanlen2(end+1) = mean(temp2);
    nnode(end+1) = n;
end

%%
figure
plot(nnode, meanlen1), hold on, plot(nnode, meanlen2), title('average length (# vertices) of the largest and the second largest connected component vs the number of nodes n (m = 0.6n)')
xlabel('number of nodes n')
ylabel(sprintf('average length of largest connected comp in %d experiments',nexp))
legend({'Largest Component','Second Largest Component'})
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%%
nexp = 33;
mstar = [];
nnode = [];
break_thresh = 0.9;
for n = 20:20:400
    tic
    prob_m = [];
    mstar_m = [];
    for m = 1:max(1,round(n/50)):n*(n-1)/2
       temp = [];
       for i = 1:nexp
          G = gnm(n,m);
          bins = conncomp(graph(G));
          [~,f] = mode(bins);
          temp(end+1) = 2*f>n;
       end
       prob_m(end+1) = mean(double(temp));
       mstar_m(end+1) = m;
       if mean(double(temp))>break_thresh, break, end
    end
    plot(mstar_m, prob_m), drawnow
    display(sprintf('%d experiments, %d nodes, %d edges, %f secs elapsed',...
        nexp, n, m, toc))
    prob_m = prob_m<0.5;
    idx = sum(prob_m)+1;
    mstar(end+1) = mstar_m(idx);
    nnode(end+1) = n;
end

%%
figure
plot(nnode, mstar), title('m* vs the number of nodes n (m* = smallest value of m for which the largest connected component >n/2)')
xlabel('number of nodes n')
ylabel(sprintf('m* (%d experiments)',nexp))
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%%
nexp = 100;
mstar = [];
nnode = [];
break_thresh = 0.9;
for n = 20:20:400
    tic
    prob_m = [];
    mstar_m = [];
    for m = 1:max(1,round(n/50)):n*(n-1)/2
       temp = [];
       for i = 1:nexp
          G = gnm(n,m);
          bins = conncomp(graph(G));
          temp(end+1) = max(bins) == 1;
       end
       prob_m(end+1) = mean(double(temp));
       mstar_m(end+1) = m;
       if mean(double(temp))>break_thresh, break, end
    end
    plot(mstar_m, prob_m), drawnow
    display(sprintf('%d experiments, %d nodes, %d edges, %f secs elapsed',...
        nexp, n, m, toc))
    prob_m = prob_m<0.5;
    idx = sum(prob_m)+1;
    mstar(end+1) = mstar_m(idx);
    nnode(end+1) = n;
end

%%
figure
plot(nnode, mstar), title('m~ vs the number of nodes n (m~ = smallest value of m for which the graph is connected)')
xlabel('number of nodes n')
ylabel(sprintf('m~ (%d experiments)',nexp))
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%%
figure
plot(nnode, mstar./nnode), title('m~/n vs the number of nodes n (m~ = smallest value of m for which the graph is connected)')
xlabel('number of nodes n')
ylabel(sprintf('m~/n (%d experiments)',nexp))
set(gcf,'units','normalized','outerposition',[0 0 1 1])
