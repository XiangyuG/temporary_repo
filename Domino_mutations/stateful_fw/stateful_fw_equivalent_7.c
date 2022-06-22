struct Packet{
int drop;
int src;
int dst;
int array_index;
};
int established[1000000] = {0};
void func(struct Packet p){
p.array_index=p.src+p.dst;
if (!(!(!(!(p.src==20&&1==1))&&1==1))) {if (1==1&&!(!(p.src==20&&1==1))) {if (1==1&&1==1&&p.src==20) {established[p.array_index]=1;

;}

;}

 ;}else if (!(!(!(p.src==20&&1==1))&&1==1)) {if (1==1&&!(p.src==20&&1==1)) {if (1==1&&1==1&&p.dst==20) {p.drop=(established[p.array_index]==0);

;}

;}

 ;}
}
