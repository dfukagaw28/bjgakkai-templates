-- docx.lua — Markdown → Word（sample.docx）用の pandoc フィルタ
--
-- 1. タイトル部（種別・表題・副題・著者名・要旨）を本文の先頭に組み、
--    その後に1段組のセクション区切りを入れる（以降は reference.docx の2段組）。
-- 2. 見出しに番号「1.」「1.1」「1.1.1」を付ける（.unnumbered は番号なし）。
--    付録（.appendix 以降の第1レベル見出し）は「付録 A.」とする。
-- 3. 文献リスト（#refs）の前に見出し「文献」を入れる。
-- 4. 別行数式（$$...$$）は独立した段落（中央、右端に通し番号「(1)」）にする。
--    数式の後に続く文は字下げしない。
-- 5. 図表のキャプションに「図 1　」「表 1　」を付ける。
--
-- --citeproc の後に指定すること（pandoc --citeproc --lua-filter=pandoc/docx.lua）。

local stringify = pandoc.utils.stringify

local TYPE_NAMES = {
  paper = "研究論文",
  note = "研究ノート",
  material = "資料紹介",
  review = "書評",
}

-- 1段組のセクション区切り（タイトル部の終わり）。寸法は Word テンプレートと同じ。
local TITLE_SECTION_BREAK = [[
<w:p><w:pPr><w:sectPr>
<w:pgSz w:w="11906" w:h="16838" w:code="9"/>
<w:pgMar w:top="1871" w:right="1418" w:bottom="851" w:left="1418" w:header="1134" w:footer="992" w:gutter="0"/>
<w:cols w:space="300"/>
<w:docGrid w:type="linesAndChars" w:linePitch="288" w:charSpace="1044"/>
</w:sectPr></w:pPr></w:p>]]

local function styled(style, blocks)
  return pandoc.Div(blocks, { ["custom-style"] = style })
end

local function inlines_of(meta_value)
  if meta_value == nil then
    return nil
  end
  if pandoc.utils.type(meta_value) == "Inlines" then
    return meta_value
  end
  return pandoc.Inlines(stringify(meta_value))
end

local function title_block(meta)
  local blocks = {}
  local type_name = TYPE_NAMES[meta.type and stringify(meta.type) or "paper"] or stringify(meta.type)
  table.insert(blocks, styled("Paper Type", { pandoc.Para(type_name) }))
  if meta.title then
    table.insert(blocks, styled("Title", { pandoc.Para(inlines_of(meta.title)) }))
  end
  if meta.subtitle then
    local sub = pandoc.Inlines("―")
    sub:extend(inlines_of(meta.subtitle))
    sub:insert(pandoc.Str("―"))
    table.insert(blocks, styled("Subtitle", { pandoc.Para(sub) }))
  end
  if meta.author then
    local names = pandoc.Inlines({})
    local authors = pandoc.utils.type(meta.author) == "List" and meta.author or { meta.author }
    for i, a in ipairs(authors) do
      if i > 1 then
        names:insert(pandoc.Str("・"))
      end
      names:extend(inlines_of(a))
    end
    table.insert(blocks, styled("Author", { pandoc.Para(names) }))
  end
  if meta.abstract then
    local abs = meta.abstract
    if pandoc.utils.type(abs) == "Inlines" then
      abs = { pandoc.Para(abs) }
    end
    table.insert(blocks, styled("Abstract", abs))
  end
  table.insert(blocks, pandoc.RawBlock("openxml", TITLE_SECTION_BREAK))
  return blocks
end

-- 見出し番号
local function number_headers(blocks)
  local counts = { 0, 0, 0 }
  local in_appendix = false
  return blocks:walk({
    Header = function(h)
      if h.classes:includes("appendix") and h.level == 1 and not in_appendix then
        in_appendix = true
        counts = { 0, 0, 0 }
      end
      if h.classes:includes("unnumbered") or h.level > 3 then
        return nil
      end
      counts[h.level] = counts[h.level] + 1
      for l = h.level + 1, 3 do
        counts[l] = 0
      end
      local label
      local top = in_appendix and ("付録 " .. string.char(64 + counts[1])) or tostring(counts[1])
      if h.level == 1 then
        label = top .. "."
      else
        label = top
        for l = 2, h.level do
          label = label .. "." .. counts[l]
        end
      end
      local content = pandoc.Inlines({ pandoc.Str(label), pandoc.Space() })
      content:extend(h.content)
      h.content = content
      return h
    end,
  })
end

-- 別行数式の番号
local function number_equations(blocks)
  local n = 0
  return blocks:walk({
    Para = function(p)
      local out = pandoc.Blocks({})
      local cur = pandoc.Inlines({})
      local continued = false
      local function flush()
        -- 前後の空白・改行を落とす
        while #cur > 0 and (cur[1].t == "Space" or cur[1].t == "SoftBreak") do
          cur:remove(1)
        end
        while #cur > 0 and (cur[#cur].t == "Space" or cur[#cur].t == "SoftBreak") do
          cur:remove(#cur)
        end
        if #cur > 0 then
          if continued then
            out:insert(styled("Body Text Continued", { pandoc.Para(cur) }))
          else
            out:insert(pandoc.Para(cur))
          end
        end
        cur = pandoc.Inlines({})
      end
      local found = false
      for _, el in ipairs(p.content) do
        if el.t == "Math" and el.mathtype == "DisplayMath" then
          found = true
          flush()
          n = n + 1
          out:insert(styled("Equation", {
            pandoc.Para({
              pandoc.RawInline("openxml", "<w:r><w:tab/></w:r>"),
              pandoc.Math("InlineMath", "\\displaystyle " .. el.text),
              pandoc.RawInline("openxml", "<w:r><w:tab/></w:r>"),
              pandoc.Str("(" .. n .. ")"),
            }),
          }))
          continued = true
        else
          cur:insert(el)
        end
      end
      if not found then
        return nil
      end
      flush()
      return out
    end,
  })
end

-- 図表番号
local function number_captions(blocks)
  local nfig, ntab = 0, 0
  local function prefix(caption, label)
    local long = caption.long
    if #long == 0 then
      return caption
    end
    local first = long[1]
    local inl = pandoc.Inlines({ pandoc.Str(label .. "\u{3000}") })
    inl:extend(first.content)
    first.content = inl
    return caption
  end
  return blocks:walk({
    Figure = function(fig)
      nfig = nfig + 1
      fig.caption = prefix(fig.caption, "図 " .. nfig)
      return fig
    end,
    Table = function(tbl)
      ntab = ntab + 1
      tbl.caption = prefix(tbl.caption, "表 " .. ntab)
      return tbl
    end,
  })
end

-- 文献リストの見出し
local function add_refs_heading(blocks)
  local out = pandoc.Blocks({})
  for _, b in ipairs(blocks) do
    if b.t == "Div" and b.identifier == "refs" then
      out:insert(pandoc.Header(1, "文献", pandoc.Attr("", { "unnumbered" })))
    end
    out:insert(b)
  end
  return out
end

function Pandoc(doc)
  local meta = doc.meta
  local blocks = pandoc.Blocks(title_block(meta))
  blocks:extend(add_refs_heading(number_captions(number_equations(number_headers(doc.blocks)))))
  -- pandoc 自身のタイトル部は出さない
  meta.title = nil
  meta.subtitle = nil
  meta.abstract = nil
  meta.author = nil
  doc.meta = meta
  doc.blocks = blocks
  return doc
end
