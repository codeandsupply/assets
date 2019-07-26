<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:param name="color.shield.stroke"/>
  <xsl:param name="color.shield.background"/>
  <xsl:param name="color.text.c"/>
  <xsl:param name="color.text.ampersand"/>
  <xsl:param name="color.text.s"/>
  
	 <!-- Match the root, recur -->
	<xsl:template match="/">
		<xsl:apply-templates select="." mode="copy" />
	</xsl:template>
	<!-- Specialty nodes go here -->
	<!-- End specialty nodes -->
	<xsl:template match="@* | text() | comment()" mode="copy">
		<xsl:copy />
	</xsl:template>
	<!-- Default action, keep recurring and copying -->
	<xsl:template match="*" mode="copy">
		<xsl:copy>
			<xsl:apply-templates select="@*" mode="copy" />
			<xsl:apply-templates mode="copy" />
		</xsl:copy>
	</xsl:template> 

  <xsl:template match="polygon[@id='shield']" priority="1" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:attribute name="fill">
        #<xsl:value-of select="$color.shield.background"/>
      </xsl:attribute>
      <xsl:attribute name="stroke">
        #<xsl:value-of select="$color.shield.stroke"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path[@id='c']" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:attribute name="fill">
        #<xsl:value-of select="$color.text.c"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path[@id='ampersand']" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:attribute name="fill">
        #<xsl:value-of select="$color.text.ampersand"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="path[@id='s']" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:attribute name="fill">
        #<xsl:value-of select="$color.text.s"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*|@*" priority="-1" name="identity" mode="nope">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:comment><xsl:value-of select="name(.)"/></xsl:comment>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
