library(tidyverse)
library(pdftools)

# Extracao de PDF

arquivo <- "~/Marcos/Aula_Git/Atividades/Atividade_2_PDF_Ext/cadastro.pdf"

conteudo <- pdftools::pdf_text(arquivo)

# Separando linhas

conteudo <- str_split(conteudo, "\\n")

conteudo <- Reduce(c, conteudo)

nome_bruto <- str_extract(conteudo, "(?<=[nN]ome:\\s)[A-Za-zÀ-ÿ\\s,]+")
nome <- nome_bruto[!is.na(nome_bruto)]

apelido_bruto <- str_extract(conteudo, "(?<=aka\\s)[A-Za-zÀ-ÿ\\s,']+")
apelido <- apelido_bruto[!is.na(apelido_bruto)]

data_bruto <- str_extract(conteudo, "(?<=Data\\sde\\snascimento:\\s|Dt\\snasc:\\s)(\\d{2}[-/](\\d{2}|[a-z]{3})[-/].*)")
data_nasc <- data_bruto[!is.na(data_bruto)]

endereco_bruto <- str_extract(conteudo, "(?<=Endereço:\\s).*?(?=\\sCEP|$)")
endereco <- endereco_bruto[!is.na(endereco_bruto)]

CEP_bruto <- str_extract(conteudo, "((?<=CEP:\\s)((\\d{5}|\\d{2}[.]\\d{3})-\\d{3}))")
CEP <- CEP_bruto[!is.na(CEP_bruto)]

tel_bruto <- str_extract(conteudo, "(?<=Tel(efone)?:\\s).*")
tel <- tel_bruto[!is.na(tel_bruto)]

CPF_bruto <- str_extract(conteudo, "(?<=[Cc][Pp][Ff]:\\s).*")
CPF <- CPF_bruto[!is.na(CPF_bruto)]


df <- tibble(nome, apelido, data_nasc, endereco, CEP, tel, CPF)

