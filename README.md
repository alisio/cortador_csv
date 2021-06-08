# Cortador CSV 
## Overview

Shell script p/divisao de arquivos CSV e insercao dos cabecalhos nos arquivos divididos.

## Uso

Uso em terminal bash para divisao de um arquivo em 2000 linhas (default):
```sh
cortador_csv <arquivo.csv> [num_de_linhas]
```

Uso em container docker para divisao de um arquivo em 1000 linhas:
```sh
docker run --rm -v ${PWD}:/app --name unbuntu-cortador --workdir /app ubuntu ./cortador_csv.sh arquivo.csv 1000
```

saída:
  arquivo_split_aa.csv
  arquivo_split_ab.csv
  arquivo_split_ac.csv
  ...
  
## Limitacoes
Testado no MacOS BigSur e Ubuntu 20.04

## Licença

Checar arquivo LICENSE

## Autor
Antonio alisio de Meneses Cordeiro
