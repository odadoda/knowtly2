<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:param name="redirect">
        <type>page</type>
    </xsl:param>
    
    <xsl:output method="html" />
    
    <xsl:template match="/">
        <form action="{portal:createServicesUrl('user', 'login', portal:createPageUrl($redirect, ()))}" method="post">
            <input type="hidden" name="categorykey" />
                <label for="title" class="audible">Navn</label>
                <input id="title" type="text" name="uid" placeholder="navn" />
                <label for="preface" class="audible">Pass</label>
                <input id="title" type="password" name="password" placeholder="passord" />
                <input type="submit" value="Logg inn" />
        </form>
    </xsl:template>
    
</xsl:stylesheet>