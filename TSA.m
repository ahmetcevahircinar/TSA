function [minimum,bestParams]=TSA(iw,maxrun,N,D,ST,maxFEs,dmin,dmax,func_num)

iterdosyaadi=strcat('F',num2str(func_num),'_IW',num2str(iw*10),'_N',num2str(N),'_D',num2str(D),'_',num2str(maxFEs),'_iters');
dosyaadi=strcat('F',num2str(func_num),'_IW',num2str(iw*10),'_N',num2str(N),'_D',num2str(D),'_',num2str(maxFEs));

low=ceil(N*0.1);
high=ceil(N*0.25);
iterasyonlar=zeros(maxrun,maxFEs);

for run=1:maxrun
    rand('state',sum(100*clock));
    trees=zeros(N,D);
    obj_trees=zeros(1,N);
    
    for i=1:N
        for j=1:D
            trees(i,j)=dmin+(dmax-dmin)*rand;
        end;
        obj_trees(i)=bildiriseti(trees(i,:),func_num);
    end
    FEs = N;
    
    [minimum]=min(obj_trees);
    mins=zeros(1,maxFEs);
    iter=0;
    while(FEs<=maxFEs)
        iter=iter+1;
        for i=1:N
            ns=fix(low+(high-low)*rand)+1;
            FEs = FEs + ns;  
            if(ns>high)
                ns=high;
            end;
            
            seeds=zeros(ns,D);
            obj_seeds=zeros(1,ns);
            
            [minimum,min_indis]=min(obj_trees);
            bestParams=trees(min_indis,:);
            
            for j=1:ns
                komsu=fix(rand*N)+1;
                while(i==komsu)
                    komsu=fix(rand*N)+1;
                end
                seeds(j,:)=trees(j,:);
                for d=1:D
                    if(rand<ST)
                        seeds(j,d)=iw*trees(i,d)+(bestParams(d)-trees(komsu,d))*(rand-0.5)*2;
                        if(seeds(j,d)>dmax)
                            seeds(j,d)=dmax;
                        end;
                        if(seeds(j,d)<dmin)
                            seeds(j,d)=dmin;
                        end;
                    else
                        seeds(j,d)=iw*trees(i,d)+(trees(i,d)-trees(komsu,d))*(rand-0.5)*2;
                        if(seeds(j,d)>dmax)
                            seeds(j,d)=dmax;
                        end;
                        if(seeds(j,d)<dmin)
                            seeds(j,d)=dmin;
                        end;
                    end;
                end;
                obj_seeds(j)=bildiriseti(seeds(j,:),func_num);
                
            end;
            
            [mintohum,mintohum_indis]=min(obj_seeds);
            if(mintohum<obj_trees(i))
                trees(i,:)=seeds(mintohum_indis,:);
                obj_trees(i)=mintohum;                
            end;
        end;        
             
        
        [min_tree,min_tree_index]=min(obj_trees);
        if(min_tree<minimum)
            minimum=min_tree;
            bestParams=trees(min_tree_index,:);
        end;
        iterasyonlar(run,iter)=minimum;
        save(iterdosyaadi,'iterasyonlar');
        fprintf('Iter=%d .... min=%g .... FES=%d .... \n',iter,minimum,FEs);
    end;
    fprintf('Run=%d .... min=%g .... time=%g \n',run,minimum,toc);
    dosya(run,1)=minimum;
end;
dosya(maxrun+1,1)=mean(dosya(1:maxrun,1));
dosya(maxrun+1,2)=std(dosya(1:maxrun,1));
dosya(maxrun+1,3)=median(dosya(1:maxrun,1));
dosya(maxrun+1,4)=min(dosya(1:maxrun,1));
dosya(maxrun+1,5)=max(dosya(1:maxrun,1));
save(dosyaadi,'dosya');
end