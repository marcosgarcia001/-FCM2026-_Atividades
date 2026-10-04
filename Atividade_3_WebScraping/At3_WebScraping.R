library(chromote)
library(rvest)
library(dplyr)

b <- ChromoteSession$new()
webpage <- "https://www.scrapethissite.com/pages/ajax-javascript/"

b$Page$navigate(webpage)
Sys.sleep(2)

html_inicial <- b$Runtime$evaluate("document.documentElement.outerHTML")$result$value
anos <- read_html(html_inicial) %>%
  html_elements(".year-link") %>%
  html_attr("id") %>%
  unique()

lista_tabelas <- list()

for (ano in anos) {
  b$Runtime$evaluate(sprintf("document.getElementById('%s').click()", ano))
  
  Sys.sleep(2)
  
  html_atualizado <- b$Runtime$evaluate("document.documentElement.outerHTML")$result$value
  page <- read_html(html_atualizado)
  
  linhas <- html_elements(page, "tr.film")
  
  if (length(linhas) == 0) {
    Sys.sleep(2) 
    html_atualizado <- b$Runtime$evaluate("document.documentElement.outerHTML")$result$value
    page <- read_html(html_atualizado)
    linhas <- html_elements(page, "tr.film")
  }
  
  if (length(linhas) == 0) {
    warning(paste("Não foi possível carregar os dados do ano:", ano))
    next
  }
  
  df_ano <- data.frame(
    Title = html_element(linhas, ".film-title") %>% html_text(trim = TRUE),
    Nominations = html_element(linhas, ".film-nominations") %>% html_text(trim = TRUE) %>% as.numeric(),
    Awards = html_element(linhas, ".film-awards") %>% html_text(trim = TRUE) %>% as.numeric(),
    Best_Picture = html_element(linhas, ".film-best-picture i") %>% {!is.na(.)},
    Year = ano,
    stringsAsFactors = FALSE
  )
  
  lista_tabelas[[ano]] <- df_ano
}

b$close()

dados_finais <- bind_rows(lista_tabelas)

head(dados_finais)
