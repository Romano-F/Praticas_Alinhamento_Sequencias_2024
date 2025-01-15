# Análise de Sequências de Wolbachia em Bibliotecas de Pequenos RNAs

Este repositório contém scripts para a análise de sequências de Wolbachia em bibliotecas de pequenos RNAs. As etapas cobrem desde a limpeza inicial dos dados, passando pelo alinhamento das sequências, até a visualização de resultados de análise estatística em um heatmap.

## Estrutura do Projeto

1. **Limpeza de Dados:**
   - **Script:** `limpeza_dados.sh`
   - **Descrição:** Automatiza a avaliação de qualidade e a limpeza das sequências de RNA. Os usuários podem optar por processar todos os arquivos `.fastq` em um diretório ou selecionar arquivos individuais, usando parâmetros padrões ou personalizados.
   - **Comandos Principais:**
     - `FastQC` para avaliação de qualidade.
     - `Trim Galore` para corte de sequências de baixa qualidade.
     - `Seqtk` para subamostragem.

2. **Alinhamento de Sequências:**
   - **Script:** `alinhamento_bowtie.sh`
   - **Descrição:** Fornece um fluxo de trabalho para o alinhamento das sequências contra uma referência de Wolbachia, permitindo personalização de parâmetros no Bowtie. O script suporta o alinhamento de arquivos individuais ou múltiplos.
   - **Comandos Principais:**
     - `Bowtie-build` para construção do índice da referência.
     - `Bowtie` para realizar o alinhamento, com opções para definir mismatches e número de threads.

3. **Geração de Heatmap:**
   - **Script:** `heatmap_anova.R`
   - **Descrição:** Realiza análises ANOVA em dados de expressão de RNA e visualiza os valores p em um heatmap. Permite que o usuário escolha dados de entrada e salve a saída como arquivo de imagem.
   - **Funções Principais:**
     - Calcula valores p de ANOVA para cada linha dos dados.
     - Utiliza `ComplexHeatmap` para visualização dos resultados.

## Instruções de Uso

### 1. Limpeza de Dados
- Execute o `limpeza_dados.sh` seguindo os prompts interativos para definir diretório, escolhas de arquivos, e parâmetros de limpeza específicos.

### 2. Alinhamento de Sequências
- Rodar `alinhamento_bowtie.sh` e seguir as instruções para selecionar diretórios, arquivos, e parâmetros de alinhamento. Consulte a documentação interna para qualquer ajuste necessário ao Bowtie.

### 3. Geração de Heatmap
- Execute `heatmap_anova.R` e forneça os detalhes necessários do arquivo de dados. Após a análise, escolha o formato de saída desejado (PNG ou PDF) para armazenar o heatmap gerado.

## Importante

- Certifique-se de que todos os pacotes e softwares necessários estão instalados no seu ambiente para executar os scripts sem problemas.
- Revise a documentação interna e os comentários dos scripts para personalizar etapas de acordo com as especificidades do seu conjunto de dados e fluxo de trabalho.

Este repositório destina-se a facilitar a análise integrada dos dados do Wolbachia, oferecendo automação em cada etapa crítica do processo de análise de pequenas sequências de RNA.
