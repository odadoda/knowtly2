<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/image.xsl"/>   
    <xsl:import href="/modules/library-stk/text.xsl"/>    
    <xsl:import href="/modules/library-stk/time.xsl"/>  
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        
        <xsl:if test="/result/contents/content != ''">
            <ul class="note-list">
                 <xsl:apply-templates select="/result/contents/content" />
            </ul>
        </xsl:if>
        
    </xsl:template>
    
    
    <xsl:template match="content">
        <li>
            <article>
                <header>
                    <h1><xsl:value-of select="contentdata/title" /></h1>
                    <time class="published">
                        <xsl:value-of select="@published" />
                    </time>
                </header>
            </article>
        </li>
    </xsl:template>
    
    
    
</xsl:stylesheet>