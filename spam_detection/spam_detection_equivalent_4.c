struct Packet{
int smtp_mta;
};
int mail_counter[1000000] = {0};
int mta_dir[1000000] = {1};
void func(struct Packet p){
p.smtp_mta=p.smtp_mta;
if (1==1&&mta_dir[p.smtp_mta]==1&&1==1&&1==1) {mta_dir[p.smtp_mta]=2;
mail_counter[p.smtp_mta]=0;

;}
if (1==1&&mta_dir[p.smtp_mta]==2&&1==1&&1==1) {mail_counter[p.smtp_mta]=mail_counter[p.smtp_mta]+1;
if (1==1&&mail_counter[p.smtp_mta]==1000&&1==1&&1==1) {mta_dir[p.smtp_mta]=3;

;}

;}
}