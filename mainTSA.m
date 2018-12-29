D=[10 20 30 40 50];
dmin=[-100 -10 -5.12 -600 -32];
dmax=[100 10 5.12 600 32];
N=10;
maxrun=30;
ST=0.1;
iw=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2];
for w=1:21
    for d=1:5
        maxFEs=D(d)*10000;
        for func_num=1:5
            [minimum,bestParams]=TSA(iw(w),maxrun,N,D(d),ST,maxFEs,dmin(func_num),dmax(func_num),func_num);
        end
    end
end
