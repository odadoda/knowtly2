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
    
    <xsl:output method="xhtml" />
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="portal:isWindowInline()">
                <div class="commandline">
                    <form action="#" method="post" id="commandline" data-get-url="{portal:createWindowUrl()}">
                       <label class="audible">Filter</label>
                        <div id="searchfield" class="searchfield">
                            <ol id="valid-commands"></ol>
                            <textarea tabindex="1" name="commands" id="commands" class="command-input"></textarea>
                        </div>
                       
                  </form>    
                </div>
                <ul class="tags-result tag-list"></ul>
                <ul class="command-line-result">
                    
                </ul>
            </xsl:when>
            <xsl:otherwise>
                
               <xsl:apply-templates select="/result/tags/contents/content" mode="tags" />
               <xsl:apply-templates select="/result/notes/contents/content|/result/tags/contents/relatedcontents/content" />                    
               
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content" mode="tags">
    <li class="tag" tabindex="1">
        <a><xsl:value-of select="display-name"/></a>
    </li>
    </xsl:template>
    
    <xsl:template match="content">
        <li class="note">
            <article>
                <header>
                    <h1><xsl:value-of select="contentdata/title" /></h1>
                    <time class="published">
                        <xsl:value-of select="if(normalize-space(contentdata/wp_postdate) != '') then contentdata/wp_postdate else @publishfrom" />
                    </time>
                    <div class="actions">
                        <xsl:if test="/result/context/user/memberships/group/name = 'Authenticated Users'">
                            <a href="{portal:createPageUrl(3,('notekey', @key))}">Edit</a>
                        </xsl:if>
                    </div>
                </header> 
                
                <div class="content">
                    <xsl:if test="contentdata/text != ''">
                        <xsl:choose>
                            <xsl:when test="@created &lt; '2014-04-12' and @publishfrom &lt; '2014-09-07'">
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
                        <!-- <xsl:for-each select="/result/contents/relatedcontents/content[@key = current()/contentdata/tags/content/@key]">
                            <li>
                                <a href="{portal:createPageUrl(('tag_name', current()/contentdata/tag_name, 'tag_id', current()/@key))}">
                                    <xsl:value-of select="current()/contentdata/tag_name" />
                                </a>
                            </li>
                        </xsl:for-each>-->
                        <xsl:for-each select="contentdata/tags/content">
                            <li>
                                <a href="#"><xsl:value-of select="/result/notes/contents/relatedcontents/content[@key = current()/@key]/display-name" /></a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </aside>
                
            </article>
        </li>
    </xsl:template>
</xsl:stylesheet>