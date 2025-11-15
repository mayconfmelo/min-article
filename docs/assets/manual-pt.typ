#import "@preview/min-manual:0.3.0": manual, arg, url

#set text(lang: "pt")

#show: manual.with(
  title: "Minimal Articles",
  description: "Forma simples a fácil de escrever artigos em conformidade com a ABNT",
  authors: "Maycon F. Melo <@mayconfmelo>",
  package: "min-article:0.2.0",
  url: "https://github.com/mayconfmelo/min-article",
  license: "MIT",
  logo: image("manual-logo.png"),
)


#v(1fr)
#outline()
#v(1.2fr)
#pagebreak()


= Início Rápido
```typst
#import "@preview/min-article:0.2.0": *
#show: article.with(
  title: "Título Principal",
  subtitle: "Subtítulo complementar",
  foreign-title: "Main Title",
  foreign-subtitle: "Complementary subtitle",
  foreign-lang: "en",
  authors: (
    ("Autor Principal", "Descrição sucinta do autor."),
    ("Colaborador", "Descrição sucinta do autor."),
  ),
)
```

= Descrição

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


= Opções
```typm
#show: book.with(
  title: none,
  subtitle: none,
  abstract: none,
  foreign-lang: none,
  foreign-title: none,
  foreign-subtitle: none,
  foreign-abstract: none,
  authors: none,
  acknowledgments: none,
  date: auto,
  lang-data: yaml("assets/lang.yaml"),
  typst-defaults: false,
)
```

#arg("title: <- string | conteúdo <required>")[
  Título principal do artigo, em sua língua nativa.
]
#arg("subtitle: <- string | conteúdo")[
  Subtítulo do artigo em sua língua nativa; geralmente com duas linhas ou menos.
]
#arg("abstract: <- conteúdo")[Resumo do artigo.]
#arg("foreign-lang: <- string")[
  Língua estrangeira adicional (geralmente uma _lingua franca_.)
]
#arg("foreign-title: <- string | conteúdo")[Título em língua estrangeira.]
#arg("foreign-subtitle: <- string | conteúdo")[Subtítulo em língua estrangeira.]
#arg("foreign-abstract: <- conteúdo")[Resumo em língua estrangeira.]
#arg("authors: <- array | array de arrays <required>")[
  `(nome, descrição)`\
  Nome e descrição de cada um dos autores do artigo.
]
#arg("acknowledgments: <- conteúdo")[
  Agradecimentos finais, geralmente às pessoas importantes na criação do artigo.
]
#arg("date: <- array | dicionário")[`(ano, mês, dia)`\ Data de publicação do artigo.]
#arg("lang-data: <- yaml | toml | dicionário")[
  Dados de tradução para os idiomas de `#text.lang` e `#article(foreign-lang)`.
]
#arg("typst-defaults: <- booleano")[
  Use os padrões do Typst ao invés dos padrões do _min-article_.
]


= Comandos


== Resumo
```typ
#abstract(
  type,
  body
)
```
Coleta dados para o resumo. Também pode ser definido comm as opções
`#article(abstract, foreign-abstract)`. O resumo principal é obrigatório,
enquanto que o resumo estrangeiro é opcional. O comando pode ser usado múltiplas
vezes em qualquer lugar no código-fonte.

#arg("type <- string")[
  O resumo definido: `"main"` (principal) ou `"foreign"` (língua estrangeira);
  se omitido, o primeiro é usado por padrão.
]

Um resumo é um compilado geral do conteúdo do artigo inteiro, de forma resumida.


== Bibliografia
```typ
#bibliography(..args)
```
Coleta dados bibliográficos de arquivos.Substitui o comando `#bibliography`
padrão, pode ser usado múltiplas vezes e em qualquer lugar no código-fonte.

#arg("args.pos() <- argumentos")[
  Conteúdo de um ou maia arquivos de bibliografia. Use `#read` ou strings.
]
#arg("args.named() <- argumentos")[
  #let docs = "https://typst.app/docs/reference/model/bibliography#parameters"
  Quaisquer opções suportadas pelo comando #url(docs)[`#bibliography`] original.
]


== Apêndice
```typ
#appendix(data)
```
Coleta dados de apêndice. Dentro do ambiente, cada titulo de nível 1 inicia um
novo apêndice individual. Pode ser usado múltiplas vezes e em qualquer lugar
no código-fonte.

#arg("dados <- conteúdo")[Ambiente do apêndice.]

Um apêndice é qualquer dado adicional que não faz parte do conteúdo principal do
artigo, mas que é referenciado ou relacionado a ele.


== Anexo
```typ
#annex(data)
```
Coleta dados de anexos. Dentro do ambiente, cada titulo de nível 1 inicia um
novo anexo individual. Pode ser usado múltiplas vezes e em qualquer lugar no
código-fonte.

#arg("dados <- conteúdo")[Ambiente do anexo.]

Um anexo é qualquer dado de terceiros referenciado ou relacionado ao conteúdo do
artigo.


== Agradecimentos
```typ
#acknowledgments(data)
```
Coleta dados de agradecimentos. Também pode ser definido com a opção
`#article(acknowledgments)`. Pode ser usado múltiplas vezes e em qualquer lugar
no código-fonte.

#arg("dados <- conteúdo")[Ambiente do agradecimento.]

Um agradecimento é uma mensagem final dirigida a alguém, geralmente pessoas
importante na produção do artigo.


== Abreviações
```typ
#abbreviations(data)
```
Coleta dados de abreviações e/ou glossário. Todas as abreviações  encontradas no
conteúdo do artigo (sem distinção entre maiúsculas e minúsculas) são
automaticamente substituídas conforme exigido pela ABNT. Pode ser usado múltiplas
vezes e em qualquer lugar no código-fonte.

#arg("data <- dictionary")[
  `(abrev: (extenso, definição))`\
  Define cada abreviação e seu nome por extenso; opcionalmente, uma definição de
  glossário também pode ser incluída.
]

O ABNT exige que uma abreviação apareça como _abreviação (abrev)_ na primeira
aparição e apenas _abbrev_ nas apariçôes seguintes.


== Glossário
```typ
#glossary(data)
```
Coleta dados de glossário. Pode ser usado múltiplas vezes em qualquer lugar no
código-fonte.

#arg("data <- dictionário")[
  `(termo: definição)`\
  Define cada termo do glossário e sua definição.
]


== Figura
```typ
#figure(
  body,
  caption: none,
  source: none, /// reference | string | content <required>
    /// The figure source.
  align: center, /// alignment
    /// Align the figure — does not replace `#figure(placement)`.
  ..args, /// arguments
)
```
Substitui o comando `#figure` original para adicionar uma opção de fonte,
exigida pela ABNT para figuras.

#arg("source: <- referência | string | conteúdo")[Fonte da figura.]
#arg("align: <- alinhamento")[Alinha a figura — não substitui `#figure(placement)`.]
#arg("..args <- argumentos")[
  #let docs = "https://typst.app/docs/reference/model/figure/#parameters"
  Quaisquer argumentos suportados pelo comando #url(docs)[`#figure`] original.
]


== Ajuda
```typ
#cmd.help(new-page: true)
```
Imprime uma tabela que ajuda a lembrar quais comandos são usados para cada
elemento do artigo, funcionando como um lembrete rápido.

#arg("new-page <- booleano")[Imprime a tabela em uma página separada.]


== Quadro
```typ
#board(..args)
```
Um wrapper simples em torno do comando original `#table` com contornos, usado
para criar quadros em figuras, com suporte para múltiplos painéis.

#arg("args <- argumentos")[Quaisquer argumentos suportados pelo comando `#table`.]


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
Este manual é licenciado segundo os termos e direitos da licença MIT \
O código-fonte do manual é software livre: sinta-se a vontade para modificá-lo
ou redistribuí-lo. Não ha NENHUMA GARANTIA, na medida que a lei permitir.

O logo foi obtido do site #link("https://flaticon.com")[Flaticon].

Este projeto não possui qualquer relação com a Associação Brasileira de Normas
Técnicas, e as — caras — normas citadas aqui são todas de propriedade da ABNT.
Este não é um projeto oficial.