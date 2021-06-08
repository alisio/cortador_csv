#!/bin/bash
# Shell script p/divisao de arquivos CSV e insercao dos cabecalhos nos arquivos divididos.
#
# uso :
#   cortador_csv <arquivo.csv> [num_de_linhas:-2000]
#
# uso em docker:
#   docker run --rm -v ${PWD}:/app --name unbuntu-cortador --workdir /app ubuntu ./cortador_csv.sh arquivo.csv
#
# saída:
#   arquivo__split_aa.csv
#   arquivo__split_ab.csv
#   arquivo__split_ac.csv
#   ...
#
# Limitacoes:
#   Testado no MacOS BigSur e Ubuntu 20.04
#
# Autor: Antonio alisio de Meneses Cordeiro
arquivo=$1
linhas=${2:-2000}
uid=$(echo `date +%s`-$RANDOM)
pegar_cabecalho() {
  local arquivo=$1
  head -n 1 $arquivo
}

insere_cabecalho(){
  local arquivo=$1
  local cabecalho=$2
  printf '%s\n' $cabecalho | cat - $arquivo > $arquivo.$uid
  mv -f $arquivo.$uid $arquivo
}

divide_arquivo(){
  local arquivo=$1
  local linhas=${2:-2000}
  local extensao="${arquivo##*.}"
  local cabecalho=$(pegar_cabecalho $arquivo)
  split -l $linhas $arquivo $(basename ${arquivo%.*})_split_
  for arquivo_gerado in `ls $(basename ${arquivo%.*})_split_*`; do
    ! egrep -q $cabecalho $arquivo_gerado && insere_cabecalho $arquivo_gerado $cabecalho
    mv $arquivo_gerado $arquivo_gerado.$extensao
  done
}

divide_arquivo $arquivo $linhas
