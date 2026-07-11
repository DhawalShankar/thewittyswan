<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:template match="/rss/channel">
<html>
<head>
  <meta charset="utf-8"/>
  <title><xsl:value-of select="title"/> — RSS feed</title>
  <style>
    body { font-family: Georgia, serif; background: #faf7f2; color: #1a1a1a; max-width: 720px; margin: 0 auto; padding: 2rem 1.5rem; line-height: 1.7; }
    h1 { margin-bottom: 0.25rem; }
    .desc { color: #6b6b64; margin-bottom: 2rem; }
    .item { padding: 1rem 0; border-bottom: 1px solid #e4e0d8; }
    .item a { color: #1a1a1a; font-size: 1.1rem; text-decoration: none; }
    .item a:hover { text-decoration: underline; }
    .meta { color: #6b6b64; font-size: 0.85rem; margin-top: 0.25rem; }
    .note { color: #6b6b64; font-size: 0.85rem; margin-top: 2rem; }
  </style>
</head>
<body>
  <h1><xsl:value-of select="title"/></h1>
  <p class="desc"><xsl:value-of select="description"/></p>
  <xsl:for-each select="item">
    <div class="item">
      <a href="{link}"><xsl:value-of select="title"/></a>
      <div class="meta">
        <xsl:value-of select="pubDate"/> · <xsl:value-of select="category"/>
      </div>
    </div>
  </xsl:for-each>
  <p class="note">This is an RSS feed. Subscribe using any feed reader by pasting this page's URL.</p>
</body>
</html>
</xsl:template>
</xsl:stylesheet>