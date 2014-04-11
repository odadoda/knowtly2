<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/html.xsl"/>   
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
                        <xsl:value-of select="if(normalize-space(contentdata/wp_postdate) != '') then contentdata/wp_postdate else @published" />
                    </time>
                </header>
                
                <xsl:if test="contentdata/text != ''">
                  <xsl:call-template name="stk:html.process">
                      <xsl:with-param name="document" select="contentdata/text" />
                  </xsl:call-template>
                </xsl:if>
                
                <aside>
                    <ul class="tag-lis">
                        <xsl:for-each select="/result/contents/relatedcontents/content[@key = current()/contentdata/tags/content/@key]">
                            <li>
                                <a href="#">
                                    <xsl:value-of select="current()/contentdata/tag_name" />
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </aside>
                
            </article>
        </li>
    </xsl:template>
    
    
    
</xsl:stylesheet>