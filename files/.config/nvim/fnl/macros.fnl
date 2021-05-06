{:augroup
 (fn [name ...]
   `(do
      (nvim.ex.augroup ,(tostring name))
      (nvim.ex.autocmd_)
      ,...
      (nvim.ex.augroup :END)))

 :autocmd
 (fn [...]
   `(nvim.ex.autocmd ,...))

 :_:
 (fn [name ...]
   `((. nvim.ex ,(tostring name)) ,...))
 
 :viml->fn
 (fn [name]
   `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))

 :dbg-call
 (fn [x ...]
   `(do
     (a.println ,...)
     (,x ,...)))

 :pkg
 (fn [name mappings ...]
   (if (~= nil (. packer_plugins `,(tostring name)))
       `(let ,mappings ,...)
       (print (.. "plugin disabled " `,(tostring name)))))}



