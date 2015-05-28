function! cicayda_es#EsInfo()
  let g:webapi#socks5 = "localhost:1337"
  let res = webapi#http#get(printf('http://%s:9200/_cat/health?format=json', $ES_HOST))
  let obj = webapi#json#decode(res.content)
  echo obj
endf

command! CicaydaES call cicayda_es#EsInfo()
