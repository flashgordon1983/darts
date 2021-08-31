
 
N = 100; %set population size

pop = normrnd(100,15,N,1); %set up population (high is good skill)

[pop_sortet, rank] = sort(pop); %find the best in the population

iSD = 1:5:31; %set up within subject SD

subsample_size = 10; %set amount of player in the subsample

darts_available = 100; %set how many darts are available 

sims = 1000; %decide how many cases to simulate
rank100 = zeros(sims,size(iSD,2)); %prepare variable
rank10 = zeros(sims,size(iSD,2)); %prepare variable

for m = 1:size(iSD,2)
for k = 1:sims %start simulation loop 
sample1 = zeros(N,1);
for i = 1:N %start sampling loop for the 1 dart per player case
   
   sample1_temp = normrnd(pop(i),iSD(m),darts_available/N,1); %pick random performance based on 
                                         %player performance data and iSD 
   sample1(i) = mean(sample1_temp); %average the throws
    
    
end %end sampling loop for the 1 dart per player case

[sample1_sorted, sample1_rank] = sort(sample1); %find the best throw in sample 1

rank100(k,m) = find(sample1_rank(N)== rank); %find the population rank of the best throw in sample 1

sample2_1 = datasample(pop,subsample_size,'Replace',false); %set up subsample for 10 darts for 10 player case
sample2_2 = zeros(subsample_size,1);
for i  = 1:size(sample2_1,1) %start loop for 10 darts for 10 player case
   
    sample2_temp = normrnd(sample2_1(i), iSD(m), darts_available/subsample_size,1); %pick random performance based on 
                                                     %player performance data and iSD
    sample2_2(i) = mean(sample2_temp); %average the 10 throws
    
    
end
[sample2_sorted, sample2_rank] = sort(sample2_2); %find the best player in the subsample



rank10(k,m) = find(rank == find(pop == sample2_1(sample2_rank(subsample_size)))); %find the population rank of the best player in sample 2

end

end

mean_rank100 = mean(rank100); %average the rank for case 1 (high is good)
mean_rank10 = mean(rank10);  %average the rank for case 2 (high is good)

%plot the results
plot(iSD,mean_rank100);
hold on;
plot(iSD,mean_rank10);
ylabel("average rank");
xlabel("intraindividual SD");
legend("one dart per player","10 darts subsample");








