Typesetting system
======
"solana-whitepaper-jp.tex" in this directory can be rendered to PDF by [LuaTeX](http://www.luatex.org/ "LuaTex Official Website").

How to setup LuaTeX on Mac
======
1. Install [MacTeX](http://www.tug.org/mactex/ "MacTex Official Site").
2. Compile .tex file
- $ lualatex solana-whitepaper-jp.tex

How to setup LuaTeX on Ubuntu Desktop
======
1. Install [TeX Live](https://www.tug.org/texlive/ "TeX Live Official Site").
- $ wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
- $ tar xvf install-tl-unx.tar.gz && cd install-tl\*
- $ sudo ./install-tl --repository http://mirror.ctan.org/systems/texlive/tlnet/
- When prompted "Enter command:" type "I" and hit Enter key, then just wait until installation has completed. This may take a few hours.
2. Deploy a symbolic link under /etc/local/bin
- $ sudo /usr/local/texlive/2018/bin/x86_64-linux/tlmgr path add
3. Update TeX Live
- $ sudo tlmgr update --self --all
4. Compile .tex file
- $ lualatex solana-whitepaper-jp.tex

