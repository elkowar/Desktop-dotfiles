(module utils
  {require {a aniseed.core
            nvim aniseed.nvim
            fun fun}
   require-macros [macros]})
 

(defn dbg [x]
  (a.pr x)
  x)

(defn contains? [list elem]
  (fun.any #(= elem $1) list))

(defn without-keys [keys t]
  (fun.filter #(not (contains? keys $1)) t))

(defn keymap [mode from to ?opts]
  "Set a mapping in the given mode, and some optional parameters, defaulting to {:noremap true :silent true}.
  If :buffer is set, uses buf_set_keymap rather than set_keymap"
  (local full-opts 
    (->> (or ?opts {})
      (a.merge {:noremap true :silent true})
      (without-keys [:buffer])
      fun.tomap))
  (if (and ?opts (?. ?opts :buffer))
    (nvim.buf_set_keymap 0 mode from to full-opts)
    (nvim.set_keymap mode from to full-opts)))

(defn del-keymap [mode from ?buf-local]
  "Remove a keymap. Arguments: mode, mapping, bool if mapping should be buffer-local."
  (if ?buf-local
    (nvim.buf_del_keymap 0 mode from)
    (nvim.del_keymap mode from)))



(defn colors []
  { :dark0_hard "#1d2021"
    :dark0 "#282828"
    :dark0_soft "#32302f"
    :dark1 "#3c3836"
    :dark2 "#504945"
    :dark3 "#665c54"
    :dark4 "#7c6f64"
    :light0_hard "#f9f5d7"
    :light0 "#fbf1c7"
    :light0_soft "#f2e5bc"
    :light1 "#ebdbb2"
    :light2 "#d5c4a1"
    :light3 "#bdae93"
    :light4 "#a89984"
    :bright_red "#fb4934"
    :bright_green "#b8bb26"
    :bright_yellow "#fabd2f"
    :bright_blue "#83a598"
    :bright_purple "#d3869b"
    :bright_aqua "#8ec07c"
    :bright_orange "#fe8019"
    :neutral_red "#cc241d"
    :neutral_green "#98971a"
    :neutral_yellow "#d79921"
    :neutral_blue "#458588"
    :neutral_purple "#b16286"
    :neutral_aqua "#689d6a"
    :neutral_orange "#d65d0e"
    :faded_red "#9d0006"
    :faded_green "#79740e"
    :faded_yellow "#b57614"
    :faded_blue "#076678"
    :faded_purple "#8f3f71"
    :faded_aqua "#427b58"
    :faded_orange "#af3a03"
    :gray "#928374"})


(defn highlight [group colset] 
  (let [default { :fg "NONE" :bg "NONE" :gui "NONE"}
        opts (a.merge default colset)]
    (nvim.command (.. "hi! "group" guifg='"opts.fg"' guibg='"opts.bg"' gui='"opts.gui"'"))))


(defn comp [f g]
  (fn [...]
    (f (g ...))))