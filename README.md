# Análise de Sequências de RNA com Scripts Automatizados

Este repositório contém scripts projetados para realizar análises completas de dados de RNA, desde a limpeza inicial dos dados até o alinhamento e visualização através de heatmaps. Esses scripts são projetados para serem aplicáveis a uma ampla variedade de estudos genômicos.

## Estrutura do Projeto

1. **Limpeza de Dados:**
   - **Script:** `limpeza_dados.sh`
   - **Descrição:** Automatiza o processo de avaliação de qualidade e limpeza das sequências de RNA. O usuário pode processar todos os arquivos `.fastq` em um diretório ou selecionar individualmente, com opções para ajustar os parâmetros de limpeza.
   - **Ferramentas Utilizadas:**
     - `FastQC` para avaliação de qualidade inicial.
     - `Trim Galore` para a remoção de sequências de baixa qualidade.
     - `Seqtk` para subamostragem das sequências.

2. **Alinhamento de Sequências:**
   - **Script:** `alinhamento_bowtie.sh`
   - **Descrição:** Realiza alinhamentos de sequências contra uma biblioteca de referência, oferecendo flexibilidade nos parâmetros de alinhamento com Bowtie.
   - **Ferramentas Utilizadas:**
     - `Bowtie-build` para criar um índice da referência.
     - `Bowtie` para alinhar as sequências.

3. **Geração de Heatmap:**
   - **Script:** `RandStatistic_Heatmap.R`
   - **Descrição:** Permite a análise e visualização estatística dos dados de expressão de RNA. O usuário pode carregar seus próprios datasets, realizar ANOVA, e visualizar os resultados em um heatmap.
   - **Funcionalidades:**
     - Integração com ANOVA para análise estatística de grupo.
     - Utilização de `ComplexHeatmap` para criar visualizações detalhadas dos dados processados.

## Instruções de Uso

### 1. Limpeza de Dados
- Execute `limpeza_dados.sh` e siga as instruções fornecidas. Defina diretórios, selecione arquivos e configure parâmetros de limpeza de forma interativa.

### 2. Alinhamento de Sequências
- Utilize `alinhamento_bowtie.sh` para alinhar suas sequências aos dados de referência especificados. O script oferece flexibilidade para modificar parâmetros de alinhamento conforme necessário.

### 3. Geração de Heatmap e Análise Estatística
- Execute `RandStatistic_Heatmap.R` e defina os caminhos dos arquivos de dados solicitados. Após a geração do heatmap, escolha os formatos de arquivos para salvar as análises.

## Importante

- Certifique-se de instalar todas as dependências e pacotes requeridos antes de executar os scripts.
- Examine cada script individualmente para ajustar qualquer parâmetro que possa ser específico ao seu conjunto de dados ou projeto.

Com esta coleção de scripts, estamos fornecendo uma abordagem poderosa e adaptável para análise de RNA, permitindo automação e controle a cada etapa do processo de análise.
