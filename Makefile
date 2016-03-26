DIR_PUBLISH=publish
DIR_PAGES=_pages
DIR_POSTS=_posts
DIR_DOCS=_miscs/docs
DIR_LYRICS=_miscs/lyrics
DIR_STATICS=_statics

MD_POSTS = $(wildcard $(DIR_POSTS)/*.md)
PG_POSTS = $(addprefix $(DIR_PUBLISH)/, $(MD_POSTS:$(DIR_POSTS)/%=%))
MD_BIBS = $(wildcard $(DIR_POSTS)/*.bib)
PG_BIBS = $(addprefix $(DIR_PUBLISH)/, $(MD_BIBS:$(DIR_POSTS)/%=%))
MD_PAGES = $(wildcard $(DIR_PAGES)/*.md)
PG_PAGES = $(addprefix $(DIR_PUBLISH)/, $(MD_PAGES:$(DIR_PAGES)/%=%))
MD_DOCS = $(wildcard $(DIR_DOCS)/*.md)
PG_DOCS = $(addprefix $(DIR_PUBLISH)/, $(MD_DOCS:$(DIR_DOCS)/%=%))

ITEMS = \
	$(DIR_PUBLISH)/Makefile \
	$(DIR_PUBLISH)/filter.pl \
	$(DIR_PUBLISH)/footer.html \
	$(DIR_PUBLISH)/index.md \

all: items move statics lyrics html

items move statics lyrics html: $(DIR_PUBLISH)
$(DIR_PUBLISH):
	mkdir -p $(DIR_PUBLISH)

# copy & make
items: $(ITEMS)
$(DIR_PUBLISH)/Makefile: publish.mk
	cp $< $@
$(DIR_PUBLISH)/filter.pl: filter.pl
	cp $< $@
$(DIR_PUBLISH)/footer.html: footer.html
	cp $< $@
$(DIR_PUBLISH)/index.md: index.md
	cp $< $@

move: $(PG_POSTS) $(PG_BIBS) $(PG_PAGES)
$(DIR_PUBLISH)/%.md: $(DIR_POSTS)/%.md
	perl cp.pl $< \
		$(DIR_PUBLISH)/$(<:$(DIR_POSTS)/%.md=%.readinglist) \
		$(DIR_PUBLISH)/$(<:$(DIR_POSTS)/%.md=%.tags) > \
		$@
$(DIR_PUBLISH)/%.bib: $(DIR_POSTS)/%.bib
	cp $< $@
$(DIR_PUBLISH)/%.md: $(DIR_PAGES)/%.md
	perl cp.pl $< \
		$(DIR_PUBLISH)/$(<:$(DIR_PAGES)/%.md=%.readinglist) \
		$(DIR_PUBLISH)/$(<:$(DIR_PAGES)/%.md=%.tags) > \
		$@
$(DIR_PUBLISH)/%.md: $(DIR_DOCS)/%.md
	perl cp.pl $< \
		$(DIR_PUBLISH)/$(<:$(DIR_DOCS)/%.md=%.readinglist) \
		$(DIR_PUBLISH)/$(<:$(DIR_DOCS)/%.md=%.tags) > \
		$@

extras: items
extras: 
	$(MAKE) -C $(DIR_PUBLISH) extras

filter:
	$(MAKE) -C $(DIR_PUBLISH) filter

statics:
	$(MAKE) -C $(DIR_STATICS)

lrc: lyrics
lyrics:
	$(MAKE) -C $(DIR_LYRICS)

# publish html
html: $(DIR_PUBLISH)/Makefile
html:
	make -C $(DIR_PUBLISH) html

# clean
clean:
	rm -rf $(DIR_PUBLISH)/

# update
gh: github
github:
	git add -A && git commit -m "`date` - `uname` $(CMTMSG)" && git push
status:
	git status
diff:
	git diff
push:
	git push
pull:
	git pull

qn: qiniu
qiniu: 
	qrsync conf.json

# edits
EDITS = \
	$(DIR_PAGES)/notes.md \
	$(DIR_PAGES)/koans.md \
	$(DIR_POSTS)
it:
	$(EDITOR) -p $(EDITS)
i: index
index:
	$(EDITOR) index.md
f: footer
footer:
	$(EDITOR) footer.html
k: koan
koan:
	$(EDITOR) $(DIR_PAGES)/koans.md
n: note
note:
	$(EDITOR) $(DIR_PAGES)/notes.md
a: about
about:
	$(EDITOR) $(DIR_PAGES)/about.md
bq: blogquery
blogquery:
	$(EDITOR) $(DIR_STATICS)/blog-query.js
c: css
css:
	$(EDITOR) $(DIR_STATICS)/main.css
j: js
js:
	$(EDITOR) $(DIR_STATICS)/main.js
pm: poem
poem:
	$(EDITOR) $(DIR_PAGES)/poems.md
xm: xiami
xiami:
	$(EDITOR) $(DIR_PAGES)/xiami.md
q: quote
quote:
	$(EDITOR) $(DIR_PAGES)/quotes.md
l: link
link:
	$(EDITOR) $(DIR_PAGES)/links.md
day:
	$(EDITOR) $(DIR_PAGES)/days.md
d: dent
dent:
	$(EDITOR) $(DIR_PAGES)/dents.md
db: douban
douban:
	$(EDITOR) $(DIR_PAGES)/douban.md
fun:
	$(MAKE) -C $(PAGES) fun
s: song
song:
	$(MAKE) -C $(DIR_LYRICS) song
t: typing
typing:
	$(MAKE) -C $(PAGES) typing
	
time:
	date +%s | clip 2>/dev/null || date +%s | xclip -selection clipboard

m: make
make:
	$(EDITOR) Makefile
