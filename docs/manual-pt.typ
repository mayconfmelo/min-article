
// Article Manual
#import "@preview/min-manual:0.1.0": manual, arg, univ

#show: manual.with(
  title: "Minimal Articles",
  description: "Forma simples a fácil de escrever artigos em conformidade com a ABNT",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  cmd: "min-article",
  version: "0.1.0",
  license: "MIT",
  toc: true,
  logo: image("assets/manual-logo.png"),
  lang: "pt"
)

#pagebreak()


= Início Rápido

```typ
#import "@preview/min-article:0.1.0": article
#show: article.with(
	title: "Título Principal",
	subtitle: "Subtítulo complementar",
	foreign-title: "Main Title",
	foreign-subtitle: "Complementary subtitle",
	authors: (
	  ("Main Author", "Doctor in Procrastination, etc, etc."),
	  ("Main Collaborator", "Graduate in Doing Nothing, etc, etc."),
	  ("Collaborator", "Student of Procrastination, etc, etc.")
	),
	lang: "pt",
	lang-foreign: "en"
)
```

= Descrição

Gere artigos autênticos, estruturados, e no padrão, em conformidade com os
requerimentos da Associação Brasileira de Normas Técnicas (ABNT). O principal
diferencial deste pacote, além de seguir os padrões ABNT definidos pelas normas
NBR 6022 e NBR 14724, é ser capaz de gerenciar por conta própria a praticamente
toda a estressante estruturação do documento e suas regrinhas: apenas insira os
dados em qualquer local que o _min-article_ encontrará onde eles devem estar no
artigo, e os colocará la.

Este manual será atualizado apenas quando novas versões quebrarem ou modificarem
algo; do contrário, este será válido para todas as novas versões, a partir desta
documentada aqui.


= Opções

Esta é a lista completa de opções disponíveis, e seus valores padrão:

```typm
#show: book.with(
  title: none,
  foreign-title: none,
  subtitle: none,
  foreign-subtitle: none,
  authors: none,
  abstract: none,
  foreign-abstract: none,
  acknowledgments: none,
  date: auto,
  paper: "a4",
  lang: "en",
  lang-foreign: none,
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.3em,
  par-margin: 1.5em,
  margin: (
    top: 3cm,
    bottom: 2cm,
    left: 3cm,
    right: 2cm
  ),
  font: ("Book Antiqua", "Times New Roman"),
  font-size: 12pt,
)
```

Parece set muita coisa logo de cara, mas vamos por partes pra entender tudo isto
melhor:

#arg("title: <- string | conteúdo <required>")[
  O título principal do artigo, em sua língua nativa.
]

#arg("foreign-title: <- string | conteúdo")[
  O título do artigo em uma língua estrangeira --- geralmente uma _lingua franca_:
  um idioma conhecido e usado universalmente (atualmente é o inglês).
]

#arg("subtitle: <- string | conteúdo | none")[
  O subtítulo do artigo; geralmente com duas linhas ou menos.
]

#arg("foreign-subtitle: <- string | conteúdo | none")[
  O subtítulo do artigo na língua estrangeira.
]

#arg("authors: <- array <required>")[
  Um array de arrays contendo o nome e breve currículo de cada autor, no formato
  `( (NOME, CURRÍCULO), (NOME, CURRÍCULO) )`. Se um array simples for usado, seu
  primeiro elemento será tratado como `NOME` e seu segundo como `CURRÍCULO`.
]

#arg("abstract: <- conteúdo")[
  A forma mais feia de definir o resumo formal de tudo que o documento fala. É
  mais bonito e intuitivo usar o comando `#abstract("main")` ao invés deste
  argumento.
]

#arg("foreign-abstract: <- conteúdo")[
  A forma mais feia de definir o resumo do artigo em língua estrangeira. É
  mais bonito e intuitivo usar o comando `#abstract("foreign")` ao invés deste
  argumento.
]

#arg("acknowledgments: <- conteúdo")[
  A forma mais feia de definir os agradecimentos finais do artigo. É mais bonito
  e intuitivo usar o comando `#acknowledgments` ao invés deste argumento.
]

#arg("date: <- array | auto")[
  A data de publicação do artigo, no formato `(yyyy, mm, dd)`. Se não definida,
  ou definida como `auto`, será usads a data atual.
]

#arg("paper: <- string")[
  Define o tipo de papel da página --- e seu tamanho, por consequência.
]

#arg("lang: <- string")[
  Define o idioma principal do texto.
]

#arg("foreign-lang: <- string")[
  Define o idioma estrangeiro, usado no título e resumo secundários.
]

#arg("lang-data: <- arquivo")[
  Define um arquivo do #univ("linguify") customizado com traduções para as seções
  geradas automaticamente. O arquivo padrão oficialmente possui total suporte
  para o português e o inglês, além de algumas outras linguagens obtidas de tradução
  por IA.
]

#arg("justify: <- booleano")[
  Define se o texto terá alinhamento justificado.
]

#arg("line-space: <- tamanho")[
  Define o eapaço entre linhas no documento.
]

#arg("par-margin: <- tamanho")[
  Define o espaço de margrm após cada parágrafo. Defina o mesmo valor de
  `line-space` oara obter parágrafos sem espaço adicional entre si.
]

#arg("margin: <- tamanho")[
  Define as margens do documento.
]

#arg("font: <- string | array")[
  Define as faílias de fontes usadas no texto: uma fonte principal e suas suplentes.
]

#arg("font-size: <- tamanho")[
  Define o tamaho do texto no documento.
]


= Comando Abstract

```typ
#import "@preview/min-article:0.1.0": abstract
#abstract(
  type,
  body
)
```

Esta é a melhor maneira de definir os resumos dos artigos. Este comando apenas
captura o conteúdo do resumo e o envia para o comando `article`, onde os resumos
são gerados de fato. Por isso, você pode colocar este comando em qualquer lugar
dentro do corpo do documento, e ele será gerado no local correto, logo após os
títulos, conforme determina a ABNT NBR 6022.

#arg("type <- string")[
  Define de qual resumo se trata: o resumo principal `"main"`, ou o resumo
  estrangeiro `"foreign"`; apenas strings com esses valores são aceitas.
]

#arg("body <- conteúdo")[
  O conteúdo do resumo
]


= Comando Abbreviations

```typ
#import "@preview/min-article:0.1.0": abbrev
#abrev(
  abbreviation,
  long,
  definition
)
```

Este comando gerencia abreviações conforme exigido pela ABNT NBR 14724: na
primeira vez em que é utilizado, imprime o nome completo seguido da abreviação
entre parênteses; a partir de então, ao ser usado novamente com a mesma
abreviação, imprime apenas a abreviação. Além disso, cada nova abreviação é
coletada para ser incluída em um glossário gerado automaticamente, juntamente
com uma definição mais extensa da abreviação (opcional), e seu nome completo.

#arg("abbreviation <- string | conteúdo <required>")[
  A abreviação em si. Não suporta qualquer estilização ou aspas --- até mesmo
  apóstrofes. É recomendado o uso de apenas letras minúsculas — automaticamente
  tranformadas em maiúsculas, — e realizar quaisquer estilizações necessárias
  no texto fora do comando `abbrev`.
]

#arg("long <- string | conteúdo")[
  O nome extenso completo, que é representado pela abreviação.
]

#arg("definition <- string | conteúdo")[
  Uma definição opcional da abreviação e seu nome, para ser usada  no glossário.
  Quando nenhuma definicão é dada, o nome completo por extenso é usado como
  definição de sua abreviação.
]



= Comando Glossary Term

```typ
#import "@preview/min-article:0.1.0": gloss
#gloss(
  term-name
  definition
)
```

Este comando funciona junto com `#abbrev`, coletando termos para um glossário
gerado automaticamente. Enquanto abbrev coleta apenas abreviações, gloss pode
coletar qualquer palavra ou expressão. Ele apenas obtém os dados e imprime o
termo no local onde o comando é escrito; posteriormente, o comando article usa
esses dados para gerar um glossário automático após o corpo principal do texto,
conforme determina a ABNT NBR 6022. Se nenhum dado for coletado por `#gloss` ou
`#abbrev`, nenhum glossário será gerado.


#arg("term-name <- string | conteúdo <required>")[
  O nome do terml no glossário; é o quê será definido. Se o nome possui
  quaisquer caracteres espeicias como apóstrofes ou aspas, é recomendado usar
  uma string ao invés de conteúdo.
]

#arg("definition <- string | conteúdo <required>")[
  A definição de `term-name`; um texto sucinto que o descreve e o explica.
]


= Comando Appendix

```typ
#import "@preview/min-article:0.1.0": appendix
#appendix(
  appendix
)
```

Este comando apenas captura os apêndices inseridos ao longo do corpo do texto e
os envia para o comando `article`, onde os apêndices são gerados de fato. Por
isso, você pode colocar este comando em qualquer lugar dentro do corpo do
documento, e ele será gerado no local correto, logo após o glossário, se houver,
conforme determina a ABNT NBR 6022. É possível usar o comando várias vezes para
coletar múltiplos apêndices. Os apêndices contêm dados e informações adicionais
que não foram incluídos no documento em si, mas que foram citados ou estão
relacionados a ele.

#arg("appendix <- conteúdo <required>")[
  O conteúdo do apêndice em si. Em documentos mais extensos, é recomendado usar
  arquivos _typ_ separados para apêndices e incluí-los aqui. Dentro do conteúdo, toda seção
  primária (título de nível 1) é tratada como um novo apêndice.
]


= Comando Annex

```typ
#import "@preview/min-article:0.1.0": annex
#annex(
  annex
)
```

Este comando apenas captura os anexos inseridos ao longo do corpo do texto e
os envia para o comando `article`, onde os anexos são gerados de fato. Por
isso, você pode colocar este comando em qualquer lugar dentro do corpo do
documento, e ele será gerado no local correto, logo após os apêndices, se houver
algum, conforme determina a ABNT NBR 6022. É possível usar o comando várias vezes
para coletar múltiplos anexos. Os anexos são documentos criados ou informações
coletadas por terceiros, mas que foram citados ou estão relacionados ao documento
atual.

#arg("annex <- conteúdo <required>")[
  O conteúdo do anexo em si. Em documentos mais extensos, é recomendado usar
  arquivos _typ_ separados para anexos e incluí-los aqui. Dentro do conteúdo,
  toda seção primária (título de nível 1) é tratada como um novo anexo.
]


= Comando Acknowledgments

```typ
#import "@preview/min-article:0.1.0": acknowledgments
#acknowledgments(
  thanks
)
```

Este comando apenas captura o conteúdo dos agradecimentos e o envia para o
comando `article`, onde a seção de agradecimentos é gerada de fato. Por isso,
você pode colocar este comando em qualquer lugar dentro do corpo do documento,
e ele será gerado no local correto, bem no final do documento, conforme determina
a ABNT NBR 6022. Os agradecimentos são um texto para agradecer e reconhecer o
valor das pessoas que desempenharam papéis importantes na criação do artigo.


= Comando Figure

```typ
#import "@preview/min-article:0.1.0": figure
#figure(
  source: none,
  alignment: center,
  ..figure-arguments
)
```

Este comando sobrepõe o comando padrão `#figure` para adicionar dois argumentos
a ele. Conforme exige a ABNT NBR 6022, todas as figuras devem ter uma legenda
na parte superior e uma fonte na parte inferior, e este comando atende a essa
exigência adicionando o argumento `source`. O outro argumento, `alignment`, é
apenas um recurso adicional para alinhar a figura usando menos código.

#arg("source: <- string | conteúdo <required>")[
  A fonte da informação mostrada na figura — mesmo se for o próprio autor.
  Geralmente, é uma citação bibliográfica ou apenas "Autor" seguido do ano de
  criação da figura, entre parênteses.
]

#arg("alignment: <- alinhamento <required>")[
  Um recurso adicional para alinhar a figura na página usando menos código.
]

#arg("..figure-arguments <- argument <required>")[
  Quaisquer argumentos padrão do comando `#figure` original; todos eles são
  suportados por esse comando.
]


= Nota Sobre Bibliografias

Infelizmente, não há como carregar o arquivo de bibliografia para que _min-article_
o processe e gere a bibliografia no lugar correto automaticamente. Portanto,
essa tarefa fica por sua conta. Isso significa que, se você inserir o comando em
algum lugar, ele aparecerá exatamente onde foi escrito e não no local correto
automaticamente. Estou buscando uma solução para esse problema, mas parece ser
uma limitação do Typst.

Por isso, como é necessário definir manualmente onde a bibliografia será
inserida, escreva o comando `bibliography` após o fim de todo o conteúdo do
texto. Assim, ele será exibido no local correto, conforme exige a ABNT NBR 6022:
depois do texto e antes do glossário, se houver. Ele pode ser escrito antes de
qualquer um dos comandos coletores descritos aqui, mas qualquer outro conteúdo
adicionado após ele será exibido depois da bibliografia — no local errado.


= Traduções

This package uses #univ("linguify") to translate the headings automatically generated.
Currently, it offers support to English and Portuguese, and some other languages
by IA translations. If your language is not supported, or wrongly translated by
AI, consider contrivuting to this project by helping in the translation.

Este pacote usa #univ("linguify") para traduzir automaticamente os títulos
gerados. Atualmente, ele oferece suporte para inglês e português, além de outros
idiomas por meio de traduções obtidas por IA. Se o seu idioma não for suportado
ou for traduzido incorretamente pela IA, considere contribuir para este projeto
ajudando na tradução.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
Este manual é licenciado segundo os termos e direitos da licença MIT \
O código-fonte do manual é software livre: sinta-se a vontade para modificá-lo
ou redistribuí-lo. Não ha NENHUMA GARANTIA, na medida que a lei permitir.

O logo foi obtido do site #link("https://flaticon.com")[Flaticon].

Este projeto não possui qualquer relação com a Associação Brasileira de Normas
Técnicas, e as — caras — normas citadas aqui são todas de propriedade da ABNT.
Este não é um projeto oficial.