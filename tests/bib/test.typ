#set page(width: 15cm, height: auto, margin: 1em)
#set bibliography(style: "/src/assets/abnt.csl")
#set text(lang: "pt", region: "BR")

Tese de doutorado @thesis[p. 0]\
Monografia/livro/folheto @book[p. 0]\
Parte de tese/monografia/livro @part[p. 0]\
Carta @letter\
Periódico: @periodical[p. 0]\
Fascículo @entry[p. 0]\
Artigo em periódico @article-periodical[p. 0]\
Artigo em jornal @article-newspaper[p. 0]\
Evento @event[p. 0]\
Parte de Evento em monografia @event-part-thesis[p. 0]\
Parte de Evento em periódico @event-part-periodical[p. 0]\
Patente @patent[p. 0]\
Legislação @legislation[p. 0]\
Jurisprudência @legal-case[p. 0]\
Documentos civis @document[p. 0]\
Documento audiovisual @video[p. 0]\
Documento sonoro @audio[p. 0]\
Partitura @music-sheet[p. 0]\
Documento iconográfico @image[p. 0]\
Documento cartográfico @map[p. 0]\
Documento tridimensional @3d[p. 0]\
Documento eletrônico @online[p. 0]\

Artigo online @blog-post[p. 0]\

#v(3em)
#line()
#bibliography("bib.yaml", title: none, full: true)

#pagebreak(weak: true)

#import "@preview/debug-city:0.0.2": debug-cite
#debug-cite(<fio>)
