Certamente! Aqui está uma versão melhorada do seu README, incorporando as funcionalidades do script de limpeza de dados que discutimos:

---

# Detecção de Wolbachia em Bibliotecas de Pequenos RNAs

Este repositório abriga códigos e scripts utilizados para a detecção de sequências de Wolbachia em bibliotecas de pequenos RNAs. O processo cobre desde o download das sequências e seu alinhamento com Bowtie, até a visualização dos dados em um mapa de calor no R usando o pacote ComplexHeatmap.

## Estrutura do Projeto

- **Limpeza de Dados:** Utilizamos um script Shell que automatiza a limpeza e o pré-processamento das sequências de RNA. O script permite a avaliação da qualidade das leituras, limpeza de sequências de baixa qualidade e subamostragem.

## Funcionalidades do Script de Limpeza de Dados

1. **Análise de Qualidade com FastQC:** Avalia a qualidade das leituras em arquivos `.fastq`.
   
2. **Limpeza com Trim Galore:** Remove sequências de baixa qualidade com flexibilidade para escolher parâmetros padrão ou personalizados, oferecendo controle total sobre o corte e limpeza das leituras.

3. **Subamostragem com Seqtk:** Facilita a redução de grandes volumes de dados para um tamanho mais gerenciável, ajustando conforme a necessidade do usuário.

4. **Interface Flexível:** Permite:
   - Executar o script em um diretório escolhido pelo usuário.
   - Processar todos os arquivos `.fastq` ou apenas um arquivo específico.
   - Definir parâmetros de corte personalizados para `trim_galore`.

## Instruções de Uso

1. **Configuração Inicial:**
   - Clone este repositório para sua máquina local.
   - Navegue até o diretório do projeto.

2. **Execução do Script:**
   - Use o terminal para rodar o script `limpeza_dados.sh`.
   - Siga as instruções interativas para configurar diretório, seleção de arquivos e parâmetros de limpeza.

3. **Visualização de Dados:**
   - Utilize o R e o pacote ComplexHeatmap para gerar visualizações de mapa de calor com os dados processados.

Este projeto faz parte de exercícios práticos da disciplina que utilizam o **Guia Teórico e Prático de Detecção de Wolbachia em Bibliotecas de Pequenos RNAs** para capacitar estudantes no uso de Git, GitHub e na aplicação de boas práticas em bioinformática.

---

Essa versão proporciona uma visão geral clara e organizada do propósito do repositório e dos recursos do código.
