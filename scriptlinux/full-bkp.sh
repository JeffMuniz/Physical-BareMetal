#!/bin/bash

# Vars
shortdate=`date +%Y%m%d`
mes=`date +%b`
ano=`date +%Y`
hora=`date +%HH-%MM`
source="/flex/dv1/backup"
destin="/flex/dv1/processed/$ano/$mes"
file="$destin/dayli-incremen@$dia$hora@$shortdate"
log_dir="$destin/log"
log_file="$log_dir/log_dayli-incremen@$dia$hora@$shortdate.log"

# Funções
mkdir -p "$destin/log" "$log_dir"
# log antes
echo "antes" >> "$log_file"
ls -lhtr "$source" >> "$log_file"
du -h "$source" >> "$log_file"
df -h "$source" >> "$log_file"

# backup diário
tar crzfd "$file" "$source"
echo "depois" >> "$log_file"
ls -lhtr "$source" >> "$log_file"
du -h "$source" >> "$log_file"
df -h "$source" >> "$log_file"



diff "$log_dir/*" >> "$log_file"



tar zdfvv "$source"/* "$file".zip

log_dir_data="$log_dir/$ano/$mes"

log_erro="$log_dir_data/erros_backup_${dia}_$hora.log"
log_rpt="$log_dir_data/rpt_${dia}_$hora.log"




# 
    mkdir -p /flex/dv1/backup_processed/
    mkdir -p /flex/dv1/backup/

    
    
mkdir -p "$destin" "$source"
    tar -zcfvr "$destin" "$source"

    gzip -rl   "$destin" "$source"  
    ls -lhtr "$destin"
    source="/flex/dv1/backup_processed"
    destin="/bkp/test.zip"

    
	
cp -r /var/log/* "$source"
mv -r /var/log/* "$source"






    zip -r /flex/dv1/backup_processed/ /flex/dv1/backup_processed/bkptest.zip'

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

































































































#!/bin/bash
SOURCE_DIR="/caminho/do/diretorio"
DEST_DIR="/caminho/do/diretorio/de/backup"
DATE=$(date +%Y%m%d)
tar -czvf "${DEST_DIR}/backup_${DATE}.tar.gz" "${SOURCE_DIR}"
if [ $? -eq 0 ]; then
	echo "backup done"
else
	echo "backup fail"
fi

#!/bin/bash



source_dir="/flex/dv1/backup"
destination_dir="/flex/dv1/backup_processed"

# Nome do arquivo de backup
backup_file="backup_$(date +%Y%m%d%H%M%S).zip"

# Compactar os arquivos
zip -r "$backup_file" "$source_dir"
zip "pasta-existe" /caminho-pasta/meuzip.zip

zip -rc "source_dir" "destination_dir"/"backup_file"

# Mover o arquivo compactado para o diretório de destino
mv "$backup_file" "$destination_dir"

# Excluir os arquivos originais do diretório de origem
rm -r "$source_dir"/*

# Descompactar os arquivos do backup
unzip "$destination_dir/$backup_file" -d "$destination_dir"

# Mover o arquivo compactado para o diretório de destino
mv "$backup_file" "$destination_dir"

# Excluir os arquivos originais do diretório de origem
rm -r "$source_dir"/*

# Descompactar os arquivos do backup
unzip "$destination_dir/$backup_file" -d "$destination_dir"


