<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output indent="yes"/>
	<xsl:strip-space elements="*"/>

	<!-- <xsl:template match="@*|node()">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:template>	 -->

	<xsl:template match="article/section">
		<xsl:variable name="sectionNumber" select="replace(enum, '\.$', '')"/>

		<xsl:variable name="href">
			<xsl:choose>
				<xsl:when test="preceding-sibling::section/enum = current()/enum">5_translated/<xsl:value-of select="ancestor::article/@id" />-<xsl:value-of select="$sectionNumber" />(<xsl:number />).xml</xsl:when>
				<xsl:otherwise>5_translated/<xsl:value-of select="ancestor::article/@id" />-<xsl:value-of select="$sectionNumber" />.xml</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:result-document href="{$href}">
			<law>
				<structure>
					<unit label="article" identifier="{ancestor::article/@id}"
						order_by="{ancestor::article/@id}" level="1">
						<xsl:value-of select="ancestor::article/@id"/>
					</unit>
				</structure>
				<section_number>
					<xsl:value-of select="concat(ancestor::article/@id, '-', $sectionNumber)" />
				</section_number>
				<catch_line></catch_line>
				<order_by>
					<xsl:value-of select="$sectionNumber" />
				</order_by>
				<!-- TODO: need to nest indented paragraphs -->
				<text>
					<xsl:copy-of select="current()/text" />
					<!-- Just get the text in there. -->
				</text>
				<!-- TODO add history / metadata -->
			</law>
		</xsl:result-document>
	</xsl:template>

</xsl:stylesheet>