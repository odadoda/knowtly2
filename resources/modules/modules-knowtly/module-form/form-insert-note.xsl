<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:param name="categorykey" select="'5'" />
    
    <xsl:output method="html" />
    
    <xsl:template match="/">
            <div class="insert-form">
        <form action="{portal:createServicesUrl('content', 'create', ())}" method="post">
            <input type="hidden" name="categorykey" value="5"/>
            <label for="title">Title</label>
            <input id="title" type="text" name="title" />
            <label for="text">Text</label>
            <textarea id="text" name="text" class="tinymceMe"></textarea>
            <label>Tags</label>
			<div class="note-tags">
			<ul id="selected-tags"></ul>
            <input name="input-tags" id="note-tags-input" list="taglist"/>
			</div>
            <datalist id="taglist">
				<xsl:for-each select="/result/contents/content[@contenttype = 'tag']">
                	<option data-value="{current()/@key}"><xsl:value-of select="display-name"/></option>
				</xsl:for-each>
                <!-- option data-value="43">java</option-->

            </datalist>
			<button>Arkiver og publiser</button>
            <button>Arkiver kladd</button>
        </form>
        </div>
    </xsl:template>
    
</xsl:stylesheet>