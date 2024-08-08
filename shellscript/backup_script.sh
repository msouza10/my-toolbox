#!/bin/bash

# Variáveis de configuração
SOURCE_DIR=""
BACKUP_DIR=""
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE=""

# Cria o diretório de backup se não existir
mkdir -p $BACKUP_DIR

# Cria o arquivo de backup
tar -czf $BACKUP_FILE -C $(dirname $SOURCE_DIR) $(basename $SOURCE_DIR)

# Verifica se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Backup realizado com sucesso: $BACKUP_FILE"
else
    echo "Erro ao realizar o backup" >&2
    exit 1
fi

# Remove backups antigos (mais de 7 dias)
find $BACKUP_DIR -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;

echo "Backups antigos removidos com sucesso"
