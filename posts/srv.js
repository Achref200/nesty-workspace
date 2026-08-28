const http=require('http'),fs=require('fs'),path=require('path');
const ROOT='C:/Users/Team_2/proejcts/Nesty/posts';
http.createServer((req,res)=>{
  let p=decodeURIComponent(req.url.split('?')[0]);
  let f=path.join(ROOT,p);
  fs.readFile(f,(e,d)=>{
    if(e){res.writeHead(404);return res.end('nope');}
    res.writeHead(200,{'Content-Type':p.endsWith('.html')?'text/html; charset=utf-8':'text/plain; charset=utf-8'});
    res.end(d);
  });
}).listen(8899,()=>console.log('up on 8899'));
