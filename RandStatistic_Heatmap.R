# Carregando Pacotes Necessários

# Lista de pacotes requeridos
required_packages <- c("dplyr", "reshape2", "ComplexHeatmap", "viridis")

# Função para instalar pacotes ausentes
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Instalar pacotes ausentes e carregar
invisible(lapply(required_packages, install_if_missing))

# Carregar os pacotes
library(dplyr)
library(reshape2)
library(ComplexHeatmap)
library(viridis)

# Entrada do Usuário para os Arquivos de Dados

cat("Digite o caminho para o arquivo de contagens com metadados (counts):\n")
counts_file <- readline()

cat("Digite o caminho para o arquivo de metadados adicionais:\n")
metadata_file <- readline()

cat("Digite o caminho para o arquivo de características ou cepas:\n")
features_file <- readline()

# Carregando os Dados

counts_data <- read.csv(counts_file)
metadata_data <- read.csv(metadata_file)
features_data <- read.csv(features_file)

# Unindo Tabelas e Preparando Dados

combined_data <- inner_join(counts_data, metadata_data, by = "library_id")
head(combined_data)

# Normalização das Contagens em RPM

combined_data <- combined_data %>%
  mutate(RPM = (read_counts / lib_size) * 1e6)

# Ajustando o Identificador das Características ou Cepas

combined_data$corrected <- sub("NZ_", "", combined_data$feature_id)
combined_data <- inner_join(combined_data, features_data, by = c("corrected" = "AccessionVersion"))

# Transformando Dados em Matriz para o Heatmap

reshaped_data <- dcast(combined_data, library_id + treatment_group ~ corrected + feature_name, value.var = "RPM")

# Converter em matriz numérica e ajustar nomes de linha
reshaped_matrix <- as.matrix(reshaped_data[, c(-1, -2)])
row.names(reshaped_matrix) <- paste0(reshaped_data[, 1], "_", reshaped_data[, 2])

# Visualização: Criando o Heatmap

Heatmap(reshaped_matrix,
        name = "RPM",                                  # Nome da escala referindo-se aos valores de RPM
        row_title = "Bibliotecas de Pequenos RNAs",    # Título das linhas
        row_title_gp = gpar(fontsize = 14, fontface = "bold"),
        row_dend_side = "left",
        row_names_side = "left",
        row_names_gp = gpar(fontsize = 10),
        column_title = "Características/Genes",        # Título das colunas
        column_title_gp = gpar(fontsize = 10, fontface = "bold"),
        column_names_gp = gpar(fontsize = 6),
        col = viridis(100)                             # Paleta de cores viridis
)

# Análise Estatística: Teste ANOVA

# Certificando-se que o grupo de tratamento é um fator
combined_data$treatment_group <- as.factor(combined_data$treatment_group)

# Executar ANOVA com RPM como variável dependente
anova_result <- aov(RPM ~ treatment_group, data = combined_data)

# Obter resumo dos resultados ANOVA
anova_summary <- summary(anova_result)
anova_summary
