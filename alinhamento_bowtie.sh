#!/bin/bash

# Mensagem inicial do script
echo "Bem-vindo ao script de alinhamento com Bowtie."
echo "Este script constrói o índice da referência e realiza o alinhamento de sequências com opções de personalização."
echo ""

# Função para realizar o alinhamento com Bowtie para um arquivo específico
alinhamento_bowtie() {
  local arquivo=$1  # Armazena o nome do arquivo
  
  # Construção do índice de alinhamento com Bowtie
  bowtie-build "$referencia" reference_index
  
  # Comentários explicando os parâmetros usados no Bowtie:
  # -f: Indica que o input está em formato fasta.
  # -S: Saída no formato SAM (Sequence Alignment/Map).
  # -a: Relata todos os alinhamentos encontrados.
  # -v 0: Permite até 0 mismatches no alinhamento (estrita similaridade).
  # -p 3: Usa 3 threads para aceleração do processo.
  # -t: Linha de comando de tempo, mostra o tempo que cada etapa do pipeline leva.
  bowtie -f -S -a -v "$v_param" -p "$p_param" -t reference_index "$arquivo" > "${arquivo%.fasta}.sam" 2> "${arquivo%.fasta}_bowtie.log"
}

# Solicitação para o usuário definir o diretório de execução
read -p "Digite o diretório em que deseja executar os scripts: " diretorio
cd "$diretorio" || { echo "Diretório não encontrado"; exit 1; }

# Solicita ao usuário o nome do arquivo de referência
read -p "Digite o nome do arquivo de referência fasta: " referencia

# Solicita ao usuário para usar parâmetros padrão ou personalizados
echo "Deseja usar os parâmetros padrão para o Bowtie ou definir seus próprios?"
echo "1. Usar parâmetros padrão"
echo "2. Definir parâmetros personalizados"

read -p "Digite o número da opção desejada: " parametro_opcao

# Configura os parâmetros do Bowtie com base na escolha do usuário
case $parametro_opcao in
  1)
    v_param=0  # Mismatches permitidos
    p_param=3  # Número de threads
    ;;
  2)
    read -p "Digite o número de mismatches permitidos (-v): " v_param
    read -p "Digite o número de threads a serem usadas (-p): " p_param
    ;;
  *)
    echo "Opção inválida!"
    exit 1
    ;;
esac

# Solicitação para o usuário escolher uma opção de processamento de arquivos
echo "Escolha uma opção:"
echo "1. Alinhar todos os arquivos .fasta no diretório atual"
echo "2. Alinhar um arquivo específico"

# Lê a opção escolhida pelo usuário
read -p "Digite o número da opção desejada: " opcao

# Estrutura case para conduzir a execução com base na escolha do usuário
case $opcao in
  1)
    # Loop que percorre todos os arquivos .fasta no diretório
    for arquivo in *.fasta; do
      alinhamento_bowtie "$arquivo"  # Chama a função para cada arquivo
    done
    ;;
  2)
    # Solicita ao usuário o nome do arquivo específico
    read -p "Digite o nome do arquivo .fasta a ser alinhado: " arquivo_especifico
    if [[ -f "$arquivo_especifico" ]]; then  # Verifica se o arquivo existe
      alinhamento_bowtie "$arquivo_especifico"  # Chama a função para este arquivo
    else
      echo "Arquivo não encontrado: $arquivo_especifico"  # Mensagem de erro se não encontrado
    fi
    ;;
  *)
    echo "Opção inválida!"  # Mensagem de erro para opções não reconhecidas
    ;;
esac
