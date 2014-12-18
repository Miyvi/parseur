<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="basedir" required="yes" as="xs:string"/>
    
    <xsl:template match="map">
        <xsl:choose>
            <xsl:when test="@title">
                <map title="{@title}">
                    <xsl:apply-templates/>
                </map>
            </xsl:when>
            <xsl:otherwise>
                <map title="{title}">
                    <xsl:apply-templates/>
                </map>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="topicref">
        
       <!-- <xsl:variable name="fullDocRoot" select="concat($basedir,@href)"/>-->
        <xsl:variable name="fullDocRoot" select="@href"/>
      
        <xsl:variable name="basename">
            <xsl:call-template name="substring-before-last">
                <xsl:with-param name="string1" select="$fullDocRoot" />
                <xsl:with-param name="string2" select="'/'" />
            </xsl:call-template>
        </xsl:variable>
        
        
        <topic dir="{$basename}" href="{$fullDocRoot}">
             <xsl:copy-of select="document($fullDocRoot)/task"></xsl:copy-of>
             <xsl:copy-of select="document($fullDocRoot)/concept"></xsl:copy-of>
        </topic>
        <xsl:apply-templates select="topicref"></xsl:apply-templates>
        
        
    </xsl:template>
    
    
    
    
    
    <xsl:template name="substring-before-last">
        <xsl:param name="string1" select="''" />
        <xsl:param name="string2" select="''" />
        
        <xsl:if test="$string1 != '' and $string2 != ''">
            <xsl:variable name="head" select="substring-before($string1, $string2)" />
            <xsl:variable name="tail" select="substring-after($string1, $string2)" />
            <xsl:value-of select="$head" />
            <xsl:if test="contains($tail, $string2)">
                <xsl:value-of select="$string2" />
                <xsl:call-template name="substring-before-last">
                    <xsl:with-param name="string1" select="$tail" />
                    <xsl:with-param name="string2" select="$string2" />
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>