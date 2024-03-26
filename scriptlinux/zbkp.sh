#!/bin/sh: It is used to execute the file using sh, which is a Bourne shell, or a compatible shell
#!/bin/csh: It is used to execute the file using csh, the C shell, or a compatible shell.
#!/usr/bin/perl -T: It is used to execute using Perl with the option for taint checks.
#!/usr/bin/php: It is used to execute the file using the PHP command-line interpreter.
#!/usr/bin/python -O: It is used to execute using Python with optimizations to code.
#!/usr/bin/ruby: It is used to execute using Ruby.
#!/bin/bash



# Variaveis #$!
dia=`date +%d-%m-%Y`
mail_aviso="jefferson.munizdemoura@fiserv.com"
head="/root/scripts/head.txt"
divisor="/root/scripts/divisor.txt"
cmd_tar="/bin/tar"
cmd_mt="/bin/mt"
bkp_banco="/root/scripts/backup_banco.txt"
bkp_rede="/root/scripts/backup_rede.txt"
tape="/dev/nst0"
log_dir="/var/log/backup"
mes=`date +%b`
ano=`date +%Y`
hora=`date +%HH-%MM`
log_dir_data="$log_dir/$ano/$mes"
log="$log_dir_data/backup_${dia}_$hora.log"
log_erro="$log_dir_data/erros_backup_${dia}_$hora.log"
log_rpt="$log_dir_data/rpt_${dia}_$hora.log"
mkdir -p $log_dir/$ano/$mes
touch $log
touch $log_erro
touch $log_rpt
cat $head > $log_rpt
echo "+- Data do backup:   $dia" >> $log_rpt
echo "+- Inicio do script de backup:   $(date +%T)" >> $log_rpt
wcat $divisor  >> $log_rpt
echo Diretorios do backup banco >> $log_rpt
while read line
do
   du -sh "$line" >> $log_rpt
done < $bkp_banco

/bin/sleep 15
cat $divisor  >> $log_rpt

echo "+- Inicio do backup banco:   $(date +%T)" >> $log_rpt

$cmd_tar -cvp -T $bkp_banco -f $tape >> $log 2>> $log_erro ##########################################

echo "+- Fim do backup banco:   $(date +%T)" >> $log_rpt
cat $divisor  >> $log_rpt

echo "+- Inicio status fita:   $(date +%T)" >> $log_rpt
$cmd_mt -f $tape status >> $log_rpt 2>> $log_erro ###########################################
echo "+- Fim status fita:   $(date +%T)" >> $log_rpt
cat $divisor  >> $log_rpt
echo "+- Erros (Se houver)"  >> $log_rpt
cat $divisor  >> $log_rpt
echo " ">> $log_rpt
tac $log_erro >> $log_rpt
echo " ">> $log_rpt
cat $divisor  >> $log_rpt
echo "+ Fim dos erros (Se houver)"  >> $log_rpt
cat $divisor  >> $log_rpt 
echo "+- Enviar e-mail de backup:   $(date +%T)" >> $log_rpt
mail -s "Backup ora_cecmi:: $dia" $mail_aviso < $log_rpt


echo "+- Bons Backups:   $(date +%T)" >> $log_rpt

