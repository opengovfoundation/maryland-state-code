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

				  <xsl:if test="current()/text">
					<section>
					  <xsl:value-of select="current()/text" />
					</section>
				  </xsl:if>
				  <xsl:if test="current()/table">
					<section>
						<table>
							<xsl:for-each select="current()/table/tgroup/tbody/row">
							    <xsl:if test="current()/entry != ''">
									<tr>
										<xsl:for-each select="current()/entry">
											<td>
												<xsl:value-of select="current()" />
											</td>
										</xsl:for-each>
									</tr>
								</xsl:if>
							</xsl:for-each>
						</table>
					</section>
				  </xsl:if>

				  <!-- Begin heirarchy -->
				  <!-- Subsection -->
				  <xsl:for-each select="subsection">
					<section prefix="{current()/enum}">
					  <xsl:value-of select="current()/text" />
					  <!-- Paragraph -->
					  <xsl:for-each select="current()/paragraph">
						<section prefix="{current()/enum}">
						  <xsl:value-of select="current()/text" />
						  <!-- Subparagraph -->
						  <xsl:for-each select="current()/subparagraph">
							<section prefix="{current()/enum}">
							  <xsl:value-of select="current()/text" />
							  <!-- Sub-Subparagraph -->
							  <xsl:for-each select="current()/sub-subparagraph">
								<section prefix="{current()/enum}">
								  <xsl:value-of select="current()/text" />
								  <!-- Sub-Sub-Subparagraph -->
								  <xsl:for-each select="current()/sub-sub-subparagraph">
									<section prefix="{current()/enum}">
									  <xsl:value-of select="current()/text" />
									</section>
								  </xsl:for-each>
								</section>
							  </xsl:for-each>
							</section>
						  </xsl:for-each>
						</section>
					  </xsl:for-each>
					</section>
				  </xsl:for-each>
					<!-- Just get the text in there. -->
				</text>
				<!-- TODO add history / metadata -->
			</law>
		</xsl:result-document>
	</xsl:template>

</xsl:stylesheet>