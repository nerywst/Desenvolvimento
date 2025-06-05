#!/bin/bash

################### Variáveis #####################
RED='\033[0;31m'
NC='\033[0m' # Sem Cor
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
TYPE="$1"
MAIL="$2"
ATTACHMENT="/root/scanreport.txt"
HOSTNAME=$(hostname)

################### Verificações ###################
if [[ -z "$TYPE" || -z "$MAIL" ]]; then
  echo -e "${RED}Uso: $0 <tipo> <email_destino>${NC}"
  echo -e "${YELLOW}Exemplo: $0 malware cliente@exemplo.com${NC}"
  exit 1
fi

if [[ ! -f "$ATTACHMENT" ]]; then
  echo -e "${RED}Arquivo de relatório não encontrado em: $ATTACHMENT${NC}"
  exit 1
fi

##################### Corpo do E-mail ######################
body='Olá,

O scan de seu servidor foi finalizado.

Para obter detalhes se foram encontrados arquivos infectados ou aplicações CMSs desatualizadas, por favor verifique o arquivo anexo.

IMPORTANTE:
Se constar "Infected files: 0" e "No Applications Found", significa que nada foi localizado.

Atenciosamente, 
Equipe HostGator.

Essa é uma mensagem automática, não responda.
Qualquer dúvida entre em contato através do seu portal do cliente.'
############################################################

################### Função de Envio ########################
_send_mail(){
  /usr/bin/mail -r "monitoramento@$HOSTNAME" \
    -s "$HOSTNAME - Scan Finalizado $(date)" \
    -a "$ATTACHMENT" "$MAIL" <<< "$body"
}
############################################################

################### Executar envio #########################
_send_mail

# Verificação de sucesso
if [[ $? -eq 0 ]]; then
  echo -e "${GREEN}E-mail enviado com sucesso para $MAIL${NC}"
else
  echo -e "${RED}Falha ao enviar o e-mail.${NC}"
fi
