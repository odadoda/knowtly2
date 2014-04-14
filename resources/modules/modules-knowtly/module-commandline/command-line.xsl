<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    
    
    <xsl:template match="/">
        <div class="commandline">
            <form action="#" method="post" id="commandline">
               <label class="audible">Filter</label>
               <input type="text" class="searchfield" id="command-input" placeholder="Filtrer: tag / title" list="taglist"/>
               <datalist id="taglist">
                  <xsl:for-each select="/result/contents/content">
                      <option value="{current()/contentdata/tag_name}" data-tag_id="{current()/@key}">
                          <xsl:value-of select="current()/contentdata/tag_name" />
                      </option>
                  </xsl:for-each>
              </datalist>
          </form>    
        </div>
    </xsl:template>
    
    
</xsl:stylesheet>