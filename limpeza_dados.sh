#!/bin/bash

# Mensagem de boas-vindas e explicação do programa
echo "Olá! Bem-vindo ao Script de Limpeza de Dados com FastQC e Trim Galore."
echo "Este script permite que você limpe sequências de baixa qualidade."
echo "Você pode processar todos os arquivos .fastq em um diretório ou escolher apenas um arquivo específico para processar."
echo ""

# Função que processa um único arquivo fastq
processar_arquivo() {
  local arquivo=$1  # Variável local para armazenar o nome do arquivo

  # Avaliação de qualidade das leituras com FastQC
  fastqc "$arquivo"

  # Executa Trim Galore usando parâmetros determinados
  trim_galore --fastqc $trim_galore_parametros "$arquivo"

  # Subamostragem de leituras usando seqtk (ajuste conforme necessário)
  seqtk sample -s100 "$arquivo" 1000 > "subsampled_$arquivo"
}

# Solicita ao usuário para definir o diretório de execução
read -p "Digite o diretório em que deseja executar os scripts: " diretorio
cd "$diretorio" || { echo "Diretório não encontrado"; exit 1; }

# Solicita ao usuário para usar parâmetros padrão ou personalizados
echo "Deseja usar os parâmetros padrão para o Trim Galore ou definir seus próprios?"
echo "1. Usar parâmetros padrão"
echo "2. Definir parâmetros personalizados"

read -p "Digite o número da opção desejada: " parametro_opcao

# Configura os parâmetros do Trim Galore com base na escolha do usuário
case $parametro_opcao in
  1)
    trim_galore_parametros="-q 25 --trim-n --max_n 0 -j 1 --length 18 --dont_gzip"
    ;;
  2)
    read -p "Digite o valor para -q: " q_param
    read -p "Digite o valor para --trim-n (sim/não): " trim_n_param
    read -p "Digite o valor para --max_n: " max_n_param
    read -p "Digite o valor para -j: " j_param
    read -p "Digite o valor para --length: " length_param
    dont_gzip_param="--dont_gzip"
    
    trim_galore_parametros="-q $q_param ${trim_n_param:+--trim-n} --max_n $max_n_param -j $j_param --length $length_param $dont_gzip_param"
    ;;
  *)
    echo "Opção inválida!"
    exit 1
    ;;
esac

# Solicitação para o usuário escolher uma opção de processamento de arquivos
echo "Escolha uma opção:"
echo "1. Processar todos os arquivos .fastq no diretório atual"
echo "2. Processar um arquivo específico"

# Lê a opção escolhida pelo usuário
read -p "Digite o número da opção desejada: " opcao

# Estrutura case para conduzir a execução com base na escolha do usuário
case $opcao in
  1)
    # Loop que percorre todos os arquivos .fastq no diretório
    for arquivo in *.fastq; do
      processar_arquivo "$arquivo"  # Chama a função para cada arquivo
    done
    ;;
  2)
    # Solicita ao usuário o nome do arquivo específico
    read -p "Digite o nome do arquivo .fastq a ser processado: " arquivo_especifico
    if [[ -f "$arquivo_especifico" ]]; then  # Verifica se o arquivo existe
      processar_arquivo "$arquivo_especifico"  # Chama a função para este arquivo
    else
      echo "Arquivo não encontrado: $arquivo_especifico"  # Mensagem de erro se não encontrado
    fi
    ;;
  *)
    echo "Opção inválida!"  # Mensagem de erro para opções não reconhecidas
    ;;
esac
