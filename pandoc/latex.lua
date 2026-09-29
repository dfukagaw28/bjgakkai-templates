-- latex.lua — Markdown → LaTeX（sample.tex）用の pandoc フィルタ
--
-- 1. 表を longtable（2段組では使えない）ではなく table + tabular で出力する。
--    ::: wide で囲んだ表は2段抜き（table*）にし、文字を \footnotesize にする。
-- 2. 番号なし見出し（.unnumbered）は bunkajoho.cls の番号なし見出しにする。
-- 3. 付録（.appendix の付いた最初の第1レベル見出し）の前に \appendix を入れる。
-- 4. 文献リスト（#refs）の位置に \printbibliography を置く。
-- 5. 図は段幅基準（width=90% → 0.9\linewidth）の figure にする。
-- 6. 別行数式（$$...$$）は番号付きの equation 環境にする。

local function latex(s)
  return pandoc.RawInline("latex", s)
end

local function to_latex(blocks_or_inlines)
  local doc
  if pandoc.utils.type(blocks_or_inlines) == "Inlines" then
    doc = pandoc.Pandoc({ pandoc.Plain(blocks_or_inlines) })
  else
    doc = pandoc.Pandoc(blocks_or_inlines)
  end
  -- 引用は本体と同じ方式（--biblatex）で書き出す
  local opts = { cite_method = PANDOC_WRITER_OPTIONS.cite_method, wrap_text = "preserve" }
  return (pandoc.write(doc, "latex", opts):gsub("%s+$", ""))
end

local ALIGN = {
  AlignLeft = "l",
  AlignRight = "r",
  AlignCenter = "c",
  AlignDefault = "l",
}

local function row_latex(row)
  local cells = {}
  for _, cell in ipairs(row.cells) do
    table.insert(cells, to_latex(cell.contents))
  end
  return table.concat(cells, " & ") .. " \\\\"
end

local function table_latex(tbl, wide)
  local env = wide and "table*" or "table"
  local spec = {}
  for _, cs in ipairs(tbl.colspecs) do
    table.insert(spec, ALIGN[cs[1]] or "l")
  end
  local lines = { "\\begin{" .. env .. "}[tb]", "  \\centering" }
  local caption = pandoc.utils.stringify(tbl.caption.long) ~= "" and to_latex(tbl.caption.long) or nil
  if caption then
    table.insert(lines, "  \\caption{" .. caption .. "}")
  end
  if tbl.identifier ~= "" then
    table.insert(lines, "  \\label{" .. tbl.identifier .. "}")
  end
  if wide then
    table.insert(lines, "  \\footnotesize")
  end
  table.insert(lines, "  \\begin{tabular}{" .. table.concat(spec) .. "}")
  table.insert(lines, "    \\toprule")
  for _, row in ipairs(tbl.head.rows) do
    table.insert(lines, "    " .. row_latex(row))
  end
  table.insert(lines, "    \\midrule")
  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.body) do
      table.insert(lines, "    " .. row_latex(row))
    end
  end
  table.insert(lines, "    \\bottomrule")
  table.insert(lines, "  \\end{tabular}")
  table.insert(lines, "\\end{" .. env .. "}")
  return pandoc.RawBlock("latex", table.concat(lines, "\n"))
end

local function figure_latex(fig)
  local img
  fig.content:walk({
    Image = function(i)
      img = img or i
    end,
  })
  if not img then
    return nil
  end
  local width = img.attributes.width or "100%"
  local w = width:match("^([%d.]+)%%$")
  local opt = w and string.format("width=%.2f\\linewidth", tonumber(w) / 100) or ("width=" .. width)
  local lines = { "\\begin{figure}[tb]", "  \\centering", "  \\includegraphics[" .. opt .. "]{" .. img.src .. "}" }
  if pandoc.utils.stringify(fig.caption.long) ~= "" then
    table.insert(lines, "  \\caption{" .. to_latex(fig.caption.long) .. "}")
  end
  if fig.identifier ~= "" then
    table.insert(lines, "  \\label{" .. fig.identifier .. "}")
  end
  table.insert(lines, "\\end{figure}")
  return pandoc.RawBlock("latex", table.concat(lines, "\n"))
end

local in_appendix = false

return {
  {
    Div = function(div)
      -- ::: wide 内の表は2段抜き
      if div.classes:includes("wide") then
        return div.content:walk({
          Table = function(tbl)
            return table_latex(tbl, true)
          end,
        })
      end
      -- 文献リスト
      if div.identifier == "refs" then
        return pandoc.RawBlock("latex", "\\printbibliography")
      end
    end,
  },
  {
    Table = function(tbl)
      return table_latex(tbl, false)
    end,
    Figure = figure_latex,
    Math = function(m)
      if m.mathtype == "DisplayMath" then
        return latex("\\begin{equation}\n  " .. m.text .. "\n\\end{equation}")
      end
    end,
    Header = function(h)
      local blocks = {}
      if h.classes:includes("appendix") and h.level == 1 and not in_appendix then
        in_appendix = true
        table.insert(blocks, pandoc.RawBlock("latex", "\\appendix"))
      end
      if h.classes:includes("unnumbered") then
        table.insert(blocks, pandoc.RawBlock("latex", "\\unnumberedsection{" .. to_latex(h.content) .. "}"))
        return blocks
      end
      if #blocks > 0 then
        table.insert(blocks, h)
        return blocks
      end
    end,
  },
}
