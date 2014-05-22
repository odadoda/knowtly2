<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
   
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>  
    
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
        <li class="note">
            <article>
                <header>
                    <h1><xsl:value-of select="contentdata/title" /></h1>
                    <time class="published">
                        <xsl:value-of select="if(normalize-space(contentdata/wp_postdate) != '') then contentdata/wp_postdate else @publishfrom" />
                    </time>
                </header> 
                
                <div class="content">
                    <xsl:if test="contentdata/text != ''">
                        <xsl:choose>
                            <xsl:when test="@created &lt; '2014-04-12'">
                                <div class="editor">
                                    <xsl:value-of select="contentdata/text" disable-output-escaping="yes" />
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="stk:html.process">
                                    <xsl:with-param name="document" select="contentdata/text" />
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!---->
    
                    </xsl:if>
                </div>
                <aside>
                    <ul class="tag-list">
                        <xsl:for-each select="/result/contents/relatedcontents/content[@key = current()/contentdata/tags/content/@key]">
                            <li>
                                <a href="{portal:createPageUrl(('tag_name', current()/contentdata/tag_name, 'tag_id', current()/@key))}">
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