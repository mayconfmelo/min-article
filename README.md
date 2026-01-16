# Minimal articles


<div align="center">
<p class="hidden">
  Simple and easy way to write ABNT-compliant articles.
</p>

<p class="hidden">
  <a href="https://typst.app/universe/package/min-article">
    <img src="https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Fmin-article&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%23239DAE&labelColor=%23353c44" /></a>
  <a href="https://github.com/mayconfmelo/min-article/tree/dev/">
    <img src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmayconfmelo%2Fmin-article%2Frefs%2Fheads%2Fdev%2Ftypst.toml&query=%24.package.version&logo=github&label=Development&logoColor=%2397978e&color=%23239DAE&labelColor=%23353c44" /></a>
</p>

[![Manual](https://img.shields.io/badge/Manual-%23353c44)](https://raw.githubusercontent.com/mayconfmelo/min-article/refs/tags/0.2.0/docs/manual.pdf)
[![Manual pt-BR](https://img.shields.io/badge/Manual-pt--BR-%23777?labelColor=%23353c44)](https://raw.githubusercontent.com/mayconfmelo/min-article/refs/tags/0.2.0/docs/manual-pt.pdf)
[![Example PDF](https://img.shields.io/badge/Example-.pdf-%23777?labelColor=%23353c44)](https://raw.githubusercontent.com/mayconfmelo/min-article/refs/tags/0.2.0/docs/example.pdf)
[![Example SRC](https://img.shields.io/badge/Example-.typ-%23777?labelColor=%23353c44)](https://github.com/mayconfmelo/min-article/blob/0.2.0/template/manual.typ)
[![Changelog](https://img.shields.io/badge/Changelog-%23353c44)](https://github.com/mayconfmelo/min-article/blob/main/docs/changelog.md)
[![Contribute](https://img.shields.io/badge/Contribute-%23353c44)](https://github.com/mayconfmelo/transl/blob/main/docs/contributing.md)

<p class="hidden">
  <a href="https://github.com/mayconfmelo/min-article/actions/workflows/tests.yml">
    <img alt="Tests" src="https://github.com/mayconfmelo/min-article/actions/workflows/tests.yml/badge.svg" /></a>
  <a href="https://github.com/mayconfmelo/min-article/actions/workflows/build.yml">
    <img alt="Build" src="https://github.com/mayconfmelo/min-article/actions/workflows/build.yml/badge.svg" /></a>
  <a href="https://github.com/mayconfmelo/min-article/actions/workflows/spellcheck.yml">
    <img alt="Spellcheck" src="https://github.com/mayconfmelo/min-article/actions/workflows/spellcheck.yml/badge.svg" /></a>
</p>
</div>


<details><summary>Português</summary>

## Início Rápido

```typst
#import "@preview/min-article:0.2.0": article
#show: article.with(
  title: "Título Principal",
  subtitle: "Subtítulo complementar",
  foreign-title: "Main Title",
  foreign-subtitle: "Complementary subtitle",
  foreign-lang: "en"
  authors: (
    ("Autor Principal", "Doutor em Procrastinação, etc."),
    ("Colaborador", "Formado em Fazer Nada, etc."),
    ("Colaborador", "Estudante de Procrastinação.")
  ),
)
```


## Descrição

Gere artigos estruturados e padronizados, em conformidade com os requisitos da
Associação Brasileira de Normas Técnicas (ABNT). Este pacote também inclui os
chamados "comandos coletores", que simplesmente obtém dados para serm usados pelo
_min-article_; isso permite declarar dados estruturais em qualquer lugar do
código-fonte, sem se preocupar com a complexa estrutura do documento e suas
regras: basta escrever e o _min-article_ se encarregará do resto.

Em geral, este pacote visa seguir os padrões da ABNT o mais fielmente possível,
utilizando personalizações mínimas apenas quando estritamente necessário.
Consulte o arquivo `docs/changelog.md` para verificar quais documentos normativos
ABNT são utilizados.


## Sobre Referências Bibliográficas

Devido à [limitações no processamento de referências do Typst](https://github.com/mayconfmelo/min-article/issues/1),
nem todos os tipos de referência suportados pelo BibLaTeX/CSL são reconhecidos
diretamente; recomendamos escrever bibliografias diretamente em [Hayagriva](https://github.com/typst/hayagriva)
para obter melhores resultados.

Mesmo o Hayagriva apresenta limitações em comparação com o CSL, portanto, para
contornar possíveis problemas tentando seguir a norma ABNT NBR 6023:2025 o mais
fielmente possível, um estilo CSL personalizado com algumas soluções alternativas
(gambiarras) é fornecido.

------------

</details>


## Quick Start

```typst
#import "@preview/min-article:0.2.0": article
#show: article.with(
  title: "Main Title",
  subtitle: "Complementary subtitle",
  foreign-title: "Título Principal",
  foreign-subtitle: "Subtítulo complementar",
  foreign-lang: "pt",
  authors: (
    ("Main Author", "PhD in Procrastination, etc."),
    ("Collaborator", "Degree in Doing Nothing, etc."),
    ("Collaborator", "Procrastination Student.")
  ),
)
```


## Description

Generate structured and standardized articles, compliant with the requirements
of the Brazilian Association of Technical Standards (ABNT, in Portuguese). This
package also features what is called "collector commands", which just obtain
data for _min-article_; this allows to declare structural data anywhere in
source code, without worrying about the mind-frying document structure and its
rules at all: just write it and _min-article_ will figure it out.

Overall, this package aims to follow the ABNT standards as closelly as possible,
using minimum customizations only when strictly necessary. Refer to the
`docs/changelog.md` file to check out which ABNT normative documents are used.


## Regarding Bibliographic References

Due to [limitations in Typst's reference processing](https://github.com/mayconfmelo/min-article/issues/1),
not all reference types supported by BibLaTeX/CSL are directly recognized; que
recommend writing bibliographies directly in [Hayagriva](https://github.com/typst/hayagriva)
for better results.

Even Hayagriva has limitations compared to CSL, so to circumvent potential
problems while trying to follow the ABNT NBR 6023:2025 standard as closely as
possible, a customized CSL style with some workarounds is provided.