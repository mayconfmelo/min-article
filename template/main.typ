#import "@preview/min-article:0.2.0": *

#set text(lang: "pt", region: "BR")

#show: article.with(   
	title: "Artigos em conformidade com a ABNT",
	subtitle: "Mudando o foco de estrutura para escrita",
	foreign-lang: "en",
	foreign-title: "ABNT-compliant articles",
	foreign-subtitle: "Shifting focus from structure to writing",
	authors: (
	  "Maycon F. Melo",
    [Desenvolvedor do pacote _min-article_ para a linguagem Typst.]
	),
)

#let pkg = "https://typst.app/universe/package/min-article"
#let univ = "https://typst.app/universe"

= Fundamentos para o temor no uso das normas de escrita

No Brasil, as normas de escrita técnica são definidas pela ABNT em documentos
chamados NBR, esta por sua vez baseia suas diretrizes em convenções adotadas por
círculos academicos, particularidades da língua portuguesa, acordos ortográficos,
entre outras fontes relacionadas. Estas normas não são exaustivas, e instituições
publicadoras possuem liberdadade para requerir diretrizes adicionais aos textos
que recebem; contudo, devido o esforço acadêmico para a padronização de
publicações de textos técnicos, geralmente estes requerimentos adicionais são
mínimos. Além de instituições de Ensino Superior e pesquisa, até mesmo algumas
escolas reforçam o uso das normas de modo facultativo ou compulsório, geralmente
a partir do Ensino Médio.

Não raramente, quando a observância das normas é requerida ao redigir textos
formais, o principal foco inicial do projeto passa a ser a conformidade com este
requerimento; e esta preocupação continua permeiando todo o processo de escrita.
No entanto, a estruturação não deve ser um fator primário de atenção na composição
de quaisquer textos, principalmente em textos formais de rigor científico e/ou
técnico; nestes casos, a primazia deve ser dada à forma de escrita e à acurácia
dos dados apresentados. Este desvio de prioridadades pode prejudicar grandemente
a qualidade final do conteúdo escrito, ao passo que reduz o tempo disponível para
sua elboração e checagem. O uso das normas também costuma se tornar motivo de
preocupação e estresse, principalmente quando requerido em escolas, pois o alto
preço dos documentos normativos ABNT e as informações conflitantes disponíveis
_on-line_ povoam esta tarefa com dúvidas incertezas.

Um fator importante para o longo tempo gasto na adequação de textos às normas
são os programas editores do tipo WYSIWYG que, embora sejam mais intuitivos por
permitirem a edição do conteúdo diretamente em um ambiente virtualmente idêntico
ao resultado final, geralmente arquivos _PDF_, tornam a formatação e estruturação
uma tarefa repetitiva por necessitar que estas sejam aplicadas repetidamente de
forma manual, utilizando o _mouse_.


= Abordagens alternativas para escrita digital

Uma alternativa viável contornar a lentidão do processo de formatação e
estruturação em editores WYSIWYG são programas editores WYSIWYM, que interpretam
linguagens de marcação compostas apenas por texto e códigos para gerar o
resultado final, por meio da compilação. Isto trás a enorme vantagem de permitir
formatar e estruturar o texto enquanto o escreve, utilizando apenas o teclado; e
ainda separar o conteúdo do texto escrito de sua apresentação visual. Por outro
lado, esta separação adiciona um passo adicional para ser possível visualizar o
resultado final: a compilação do texto, que pode ser demorada dependendo de seu
tamanho.#footnote[Embora atualmente já existam soluções para visualização
instantânea de documentos WYSIWYM.]

Existem diversas linguagens de marcação, e dentre elas uma das mais utilizadas é
o Markdown: uma linguagem intuitiva voltada para textos simples e que compila
documentos para HTML, uma outra linguagem de marcação mais robusta.

#import "@preview/metalogo:1.2.0": LaTeX, TeX

Na escrita técnica, a linguagem predominantemente usada há décadas é o #LaTeX
[latéc]. derivada do #TeX [téc], sendo amplamente usada e endossada por
instituições de pesquisa e publicação técnico-cientifica. Embora ainda possua a
hegemonia, recentemente surgiram algumas alternativas ao #LaTeX, pois a linguagem
já possui mais de 40 anos e não se adequou às tendências de linguagens modernas;
uma dessas linguagens é o Typst [taipst], que surge com a proposta de trazer a
experiência de escrita de linguagens de programação modernas para a escrita de
textos, com códigos mais simples e compreensíveis. No Typst reside a una ótima
oportunidade de aliar toda a praticidade de linguagens WYSIWYM com a simplicidade
e legibilidade do código Typst na criação de textos técnicos em conformidade com
a ABNT.

#figure(
  kind: "board",
  supplement: "Quadro",
  caption: [Códigos #LaTeX (esquerda) e Typst (direita) dado o mesmo conteúdo.],
  source: "Elaborado pelo autor.",
  board(
    columns: 2,
    ```latex
    \documentclass{article}
    \usepackage{graphicx}
    \begin{document}
    \section{Título}
    Lorem ipsum dolor sit amet consectetur adipiscing elit, quisque.

    \includegraphics{path/to/image.png}

    \subsection{Sub-titulo nível 2}
    \begin{verbatim}
    print("Hello World")
    \end{verbatim}
    \end{document}
    ```,
    
    ````typ
    = Título
    Lorem ipsum dolor sit amet consectetur adipiscing elit, quisque.
    
    #image("path/to/image.png")
    
    == Sub-titulo nível 2
    ```python
    print("Hello World")
    ```
    ````,
  )
)


= A proposta do pacote _Minimal Articles_

De forma similar ao #LaTeX e às linguagens de programação, o Typst permite que
usuários escritores criem e compartilhem os códigos de suas soluçôes em
formatação e estruturação utilizando pacotes, disponíveis a partir do portal
_Typst Universe_. #footnote[*Typst Universe*. Disponível em: <#link(univ)>.] Na
escrita técnica de artigos destaca-se o pacote _min-article_, #footnote[*Typst
Universe --- min-article*. Disponível em: <#link(pkg)>.] voltado para a
composição de artigos em conformidade com as normas ABNT.

O pacote automatiza todo o processo de estruturação e formatação da obra de
acordo com as normas, contando com título e resumo em língua estrangeira
(lingua-franca, geralmente inglês), referências bibliográficas, figuras com
legendas e fontes, equações matemáticas, gerenciamento automático de abreviações,
além de glossários, apêndices, anexos, e agradecimentos, todos dentro dos padrões
estabelecidos @abnt-6022; também define a formatação geral requerida @abnt-6022
@abnt-14724, e a numeração padrão de seções, subseções e outros titulos
@abnt-6022 @abnt-6024.


== Removendo a preocupação com estruturação utilizando comandos coletores

Embora linguagens WYSIWYM removam a preocupação com a formatação visual da obra,
elas ainda são estruturadas segundo o fluxo do texto: o conteúdo aparece no
resultado final na mesma ordem em que se encontra escrito no código-fonte. Isso
continua sendo uma fonte de procupações e problemas, uma vez que se faz
necessário conhecer a ordem correta em que elementos, como resumo ou bibliografia,
aparecem na obra e mantê-los nesta ordem.

O @estrutura-geral providencia um esquema de estrutura para artigos e textos
técnicos assemelhados, e especifica sua ordem; mas embora conhecer a estrutura
seja importante, a tarefa mais trabalhosa é mantê-la durante o processo de
escrita uma vez que o Typst, assim como toda linguagem WYSIWYM, também segue o
fluxo do texto durante a compilação e portando delega a estruturação à escrita:

#import "@preview/cetz:0.4.2": canvas, draw, decorations
#figure(
  kind: "diagram",
  supplement: "Diagrama",
  caption: [Esquema de relação entre a ordem dos elementos no código e no
    resultado final.],
  source: "Elaborado pelo autor.",
  canvas({
    draw.content(
      (0,0),
      anchor: "north-east",
      ````typ
      = Título
      Lorem ipsum dolor sit amet
      consectetur adipiscing elit,
      quisque.
      
      #image("path/to/image.png")
      
      == Sub-titulo nível 2
      ```python
      print("Hello World")
      ```
      ````
    )
    draw.content(
      (4,-0.5),
      ```typc heading(level: 1)```,
      anchor: "west",
      name: "heading",
      padding: 0.1,
    )
    draw.content(
      (4,-1),
      ```typc par()```,
      anchor: "west",
      name: "par",
      padding: 0.1,
    )
    draw.content(
      (4,-1.5),
      anchor: "west",
      ```typc image()```,
      name: "image",
      padding: 0.1,
    )
    draw.content(
      (4,-2),
      anchor: "west",
      ```typc heading(level: 2)```,
      name: "sub-heading",
      padding: 0.1,
    )
    draw.content(
      (4,-2.5),
      anchor: "west",
      ```typc raw()```,
      name: "raw",
      padding: 0.1,
    )
    
    draw.set-style(
      mark: (
        stroke: gray.lighten(50%),
        fill: gray.lighten(50%)
      ),
      stroke: gray.lighten(50%)
    )
    
    decorations.brace(
      (0,-0.2), (0,-1.5),
      name: "par-brace",
      fill: gray.lighten(50%)
    )
    decorations.brace(
      (0,-3.1), (0,-4.1),
      name: "raw-brace",
      fill: gray.lighten(50%)
    )
    
    draw.set-style(mark: (end: ">", scale: 0.9))
    
    draw.line((0,0), "heading.west")
    draw.line("par-brace.east", "par.west")
    draw.line((0,-2.1), "image.west")
    draw.line((0,-2.9), "sub-heading.west")
    draw.line("raw-brace.east", "raw.west")
  })
) <ordem>

O @ordem explicita que a mesma ordem dos elementos no código é vista no resultado
final. A abordagem do pacote _Mininal Articles_ é remover este problema utilizando
comandos coletores, que ao invés de inserir o conteúdo diretamente apenas coleta
os dados, que são automaticamente inseridos em seus devidos locais; isto
significa, por exemplo, que é possível inserir o comando `#abstract`#footnote[
Comando do _Mininal Articles_ responsável por coletar dados para o resumo.] no
final do código-fonte e ainda assim ele aparecerá no local correto @manual.

#figure(
  kind: "diagram",
  supplement: "Diagrama",
  caption: "Gerenciamento de comandos coletores.",
  source: "Elaborado pelo autor.",
  canvas({
    draw.content(
      (0,0),
      anchor: "north-east",
      ````typ
      = Título
      Lorem ipsum dolor sit amet
      consectetur adipiscing elit,
      quisque.
      
      #image("path/to/image.png")
      #abstract(abs)
      #bibliography(bib)
      
      == Sub-titulo nível 2
      ```python
      print("Hello World")
      ```
      ````
    )
    draw.content(
      (4,0),
      `abs`,
      anchor: "west",
      name: "abs",
      padding: 0.1,
    )
    draw.content(
      (4,-0.5),
      ```typc heading(level: 1)```,
      anchor: "west",
      name: "heading",
      padding: 0.1,
    )
    draw.content(
      (4,-1),
      ```typc par()```,
      anchor: "west",
      name: "par",
      padding: 0.1,
    )
    draw.content(
      (4,-1.5),
      anchor: "west",
      ```typc image()```,
      name: "image",
      padding: 0.1,
    )
    draw.content(
      (4,-2),
      anchor: "west",
      ```typc heading(level: 2)```,
      name: "sub-heading",
      padding: 0.1,
    )
    draw.content(
      (4,-2.5),
      anchor: "west",
      ```typc raw()```,
      name: "raw",
      padding: 0.1,
    )
    draw.content(
      (4,-3),
      anchor: "west",
      `bib`,
      name: "bib",
      padding: 0.1,
    )
    
    draw.set-style(
      mark: (
        stroke: gray.lighten(80%),
        fill: gray.lighten(80%)
      ),
      stroke: gray.lighten(80%),
    )
    
    decorations.brace(
      (0,-0.2), (0,-1.5),
      name: "par-brace",
      fill: gray.lighten(80%),
    )
    decorations.brace(
      (0,-3.9), (0,-4.9),
      name: "raw-brace",
      fill: gray.lighten(80%),
    )
    
    draw.set-style(mark: (end: ">", scale: 0.9))
    
    draw.line((0,0), "heading.west")
    draw.line("par-brace.east", "par.west")
    draw.line((0,-2.1), "image.west")
    draw.line((0,-3.6), "sub-heading.west")
    draw.line("raw-brace.east", "raw.west")
    
    draw.set-style(
      stroke: black.lighten(30%),
      mark: (
        stroke: black.lighten(30%),
        fill: black.lighten(30%),
      )
    )
    
    draw.line((0,-2.5), (2,-1.3), "abs.west")
    draw.line((0,-2.9), (2,-1.3), "bib.west")
    
    draw.content(
      (2,-1.3),
      block(```typc article()```, fill: white, inset: 0.2em),
      name: "cmd",
    )
  })
) <coletores>

O @coletores ilustra o processo de gerenciamento de comandos coletores: os
comandos apenas obtém os dados e repassam para o `article()`, que por sua vez
processa as informações e as insere no local correto dentro da estrutura do
artigo; isto é, o processo de estruturação é delegado ao _Mininal Articles_.


== Unindo a praticidade WYSIWYM com a intuitividade visual WYSIWYG

A principal desvantagem das linguagens WYSIWYG é que durante a escrita o autor
visaliza apenas o texto do codigo-fonte, e se por um lado isto o ajuda a focar
na escrita, por outro o impossibilita de saber como está o visual de sua obra.
Para ver o resultado final, o autor precisa então parar a escrita e compilar
o código-fonte, uma tarefa que pode ser demorada se realizada em conputadores
menos potentes ou obras extensas.

Com a popularização de ferramentas _online_ de escrita e colaboração, algumas
propostas surgiram para solucionar este problema ser perder os beneficios de
linguagens WYSIWYM. A primeira que destacaremos é o website _Overleaf_,#footnote[
*Overleaf, Online LaTeX Editor*. Disponível em: <#link("https://www.overleaf.com/")>.]
que permite criar e editar textos em #LaTeX _online_ com uma pré-visualização
do resultado final, além de outras vantagens como colaboração online e a
eliminacão da necessidade de instalar quaisquer programas ou executar tarefas
onerosas no proprio computador: tudo é feito online. De forma similar, o Typst
já surge atrelado a um website com todas as facilidades citadas anteriormente
de forma integrada e oficial,#footnote[*Typst: Sign In*. Disponível em: <#link(
"https://typst.app/signin/")>.] enquanto que o Overleaf é uma ferramenta de
terceiros. Estas ferramentas abriram as portas para a utilização plena
dessas linguagens WYSIWYM até mesmo em dispositivos moveis, onde editores WYSIWYG
são muito limitados.

#figure(
  caption: [Execução de código Typst com pré-visualização instantânea em um
    dispositivo móvel.],
  source: "Capturado pelo autor.",
  rotate(-90deg, image("assets/img/typst-web.png"), reflow: true)
)

No caso do Typst, a pré-visualização instantânea está disponível também quando
ba versão instalada diretamente no computador: o comando `typst watch`, monitora
constantemente o codigo e imediatamente re-compila apenas as áreas com
modificações, quando há alguma; isto reduz consideravelmente o tempo de compilação,
fazendo com que as mudanças possam ser visualizadas logo assim que realizadas.

= Conclusão

Frente às desvantagens de editores WYSIWYG, que transformam a escrita de textos
longos em tarefas repetitivas, demoradas e estressantes devido aos processos de
formatação e estruturação, a abordagem de escrita utilização linguagens WYSIWYM
é ideal. Mas embora agilizem a formatação e devolvam o foco à escrita, essas
linguagens ainda oneram o escritor com a estruturação do texto, que em textos
técnicos devem seguir uma estrutura rígida bem definida. Nesses casos, o uso do
pacote _Mininal Articles_ remove esta etapa e verdadeiramente liberta o escritor
da estruturação de textos técnicos. Sem dúvidas, os editores WYSIWYG são e ainda
serão a abordagem mais popular para escrita devido sua grande intuitividade e
apelo visual; mas os avanços em linguagens WYSIWYM cada vez mais simples e
semânticas, e o uso de ferramentas auxiliares visuais podem ser amplamente
benéficos, e com isso angariar maior popularidade para as mesmas.


// The following commands are here on purpose, their place does not matter:

#abstract[
  Escrever quaisquer textos técnicos de acordo com as normas da abnt geralmente
  se torna motivo de preocupação e estresse no Brasil. Sejam em artigos, teses,
  ou torna motivo de preocupação e estresse no Brasil. Sejam em artigos, teses,
  ou trabalhos escolares, quando a observância das normas é requerida ao redigir
  textos, este requerimento passa a ser o foco inicial do projeto e continua
  importante durante todo o processo, tirando o foco da escrita para a
  estruturação do texto. Nesta breve obra, exploraremos as consequências desse
  foco e preocupação alocados na estruturação, tanto no tempo despendido na
  elaboração da obra quanto na qualidade de seu texto final; também conheceremos
  e proporemos alternativas viáveis de escrita técnica com foco principal no
  texto escrito sem sacrificar a intuitividade, e que ferramentas podem ser usadas.
  
  Palavras-chave: ABNT; artigo; tese; trabalho escolar; escrita formal; normas
  de escrita técnica.
]

#abstract[foreign][
  Writing any technical text according to ABNT standards often becomes a source
  of concern and stress in Brazil. Whether in articles, theses, or school papers,
  when compliance with standards is required when writing texts, this requirement
  becomes the initial focus of the project and remains important throughout the
  process, shifting the focus from writing to structuring the text. In this brief
  work, we will explore the consequences of this focus and concern placed on
  structuring, both in the time spent preparing the work and in the quality of
  its final text. We will also explore and propose viable alternatives for
  technical writing with a primary focus on writing the text without sacrificing
  intuitiveness, and what tools can be used.
  
  Keywords: ABNT; article; thesis; school paper; formal writing; standards
  of technical writing.
]

#appendix[
  = Pequena amostra de uso do pacote _Mininal Articles_
  
  == Matemática
  #lorem(14)
  $ E = m c^2 $ <eq>
  #lorem(14)
  
  Referência: @eq.\
  Inline math: $E = m c^2$.
  
  == Figuras
  #lorem(14)
  #figure(
    kind: "board",
    supplement: "Quadro",
    caption: "Um exemplo de quadro",
    source: "Elaborado pelo autor.",
    rect[Conteudo do quadro]
  )
  #lorem(14)
  
  == Tabelas
  #lorem(14)
  #figure(
    caption: "Examplo de tabela",
    source: "Elaborado pelo autor.",
    table(
      columns: 3,
      table.header[*Coisas*][*Itens*][*Resultados*],
      [Uma coisa],   [Um item],    [Um resultado],
      [Outra coisa], [Outro item], [Outro resultado]
    )
  )
  #lorem(14)
  
  == Comandos estruturais
  #columns(cmd.help(new-page: false))
  
  = Estrutura geral de um artigo <estrutura-geral>
  
  O @estrutura a seguir é baseado no Esquema 1 @abnt-14724 disponibilizado no
  @excerpt-abnt-14724, voltado para trabalhos acadêmicos encadernados, como
  teses e dissertações. Mas este é adequado para artigos e outros textos técnicos
  assemelhados.
  
  #figure(
    kind: "scheme",
    supplement: "Esquema",
    caption: "Estrutura de um artigo.",
    source: "Elaborado pelo autor.",
    canvas({
      draw.set-style(padding: 0.5em)
      
      draw.content(
        (0,0),
        [
          Título na língua vernácula (obrigatório)\
          Titulo em língua estrangeira\
          Autores (obrigatório)\
          Resumo na língua vernácula (obrigatório)\
          Resumo em língua estrangeira\
          Sumário (obrigatório)
        ],
        name: "pre-text",
      )
      draw.content(
        "pre-text.south-west",
        [
          Introdução\
          Desenvolvimento\
          Conclusão
        ],
        anchor: "north-west",
        name: "text",
      )
      draw.content(
        "text.south-west",
        [
          Referências (obrigatório)\
          Glossário (opcional)\
          Apêndice (opcional)\
          Anexo (opcional)\
        ],
        anchor: "north-west",
        name: "post-text",
      )
      
      decorations.brace(
        "pre-text.north-west", "pre-text.south-west",
        name: "pre-text-brace",
        flip: true,
      )
      decorations.brace(
        "text.north-west", "text.south-west",
        name: "text-brace",
        flip: true,
      )
      decorations.brace(
        "post-text.north-west", "post-text.south-west",
        name: "post-text-brace",
        flip: true,
      )
      
      draw.content(
        "pre-text-brace",
        [Elementos\ pré-textuais],
        anchor: "east",
        padding: 1.5em,
      )
      draw.content(
        "text-brace",
        [Elementos\ textuais],
        anchor: "east",
        padding: 2em,
      )
      draw.content(
        "post-text-brace",
        [Elementos\ pós-textuais],
        anchor: "east",
        padding: 1.5em,
      )
    })
  ) <estrutura>
]

#annex[
  = Excerto da norma ABNT NBR 14274 <excerpt-abnt-14724>
  
  #figure(
    supplement: "Esquema",
    caption: "Estrutura do trabalho acadêmico.",
    source: [@abnt-14724],
    image("assets/img/abnt-14724.jpg")
  )
]

#acknowledgments[
  Meus agradecimentos a Martin Ernst Haug, por ter criado o Typst,\
  E também aos meus professores, que me incentivaram a escrever.

  Extendo minhas congratulações também a você, caro leitor, pela atenciosa
  leitura e paciência.
]

#abbreviations(yaml("assets/abbrev.yaml"))

#glossary(yaml("assets/glossary.yaml"))

#bibliography(read("assets/bib.yaml"), full: true)