<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:param name="categorykey" select="'5'" />
    
    <xsl:output method="xhtml" />
    
    <xsl:template match="/">
            <xsl:variable name="content" select="/result/note/contents/content" />
            <div class="insert-form">
                
            <form action="/site/0/createnote" method="post">
                <input type="hidden" name="homeUrl" value="{portal:createPageUrl(0,())}" />
                <input type="hidden" name="categorykey" value="5"/>
                <input type="hidden" name="contentKey" value="{$content/@key}" />
                <label for="title">Title</label>
                <input id="title" type="text" name="title" value="{$content/contentdata/title}"/>
                <label for="text">Text</label>
                <textarea id="text" name="text" class="tinymceMe">
                    <xsl:copy-of select="$content/contentdata/text"/>
                </textarea>
            <label>Tags</label>
			<div class="note-tags">
			<ul id="selected-tags">
			    <xsl:for-each select="$content/contentdata/tags/content">
			        <li><xsl:value-of select="/result/note/contents/relatedcontents/content[@key = current()/@key]/contentdata/tag_name"/></li>
			    </xsl:for-each>
			</ul>
            <input name="input-tags" id="note-tags-input" list="taglist"/>
			</div>
            <button name="submitbutton" value="save">Arkiver </button>
            <button name="submitbutton" value="save-and-continue">Arkiver og fortsett</button>
        </form>
        </div>
    </xsl:template>
    
</xsl:stylesheet>