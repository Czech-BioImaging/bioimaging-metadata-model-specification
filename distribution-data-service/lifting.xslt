<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/" xmlns:ns0="http://purl.org/dc/terms/" xmlns:ns1="http://www.w3.org/ns/dcat#" xmlns:ns2="http://xmlns.com/foaf/0.1/">
  <xsl:import href="https://model.ccmm.cz/research-data/distribution-data-service/lifting.xslt"/>
  <xsl:import href="../data-service/lifting.xslt"/>
  <xsl:import href="../application-profile/lifting.xslt"/>
  <xsl:import href="../documentation/lifting.xslt"/>
  <xsl:import href="../related-resource/lifting.xslt"/>
  <xsl:import href="../identifier/lifting.xslt"/>
  <xsl:import href="../alternate-title/lifting.xslt"/>
  <xsl:import href="../resource-to-agent-relationship/lifting.xslt"/>
  <xsl:import href="../time-reference/lifting.xslt"/>
  <xsl:import href="../resource-type/lifting.xslt"/>
  <xsl:import href="../resource-relation-type/lifting.xslt"/>
  <xsl:import href="../time-interval/lifting.xslt"/>
  <xsl:import href="../time-instant/lifting.xslt"/>
  <xsl:import href="../date-type/lifting.xslt"/>
  <xsl:import href="../organization/lifting.xslt"/>
  <xsl:import href="../person/lifting.xslt"/>
  <xsl:import href="../resource-agent-role-type/lifting.xslt"/>
  <xsl:import href="../contact-details/lifting.xslt"/>
  <xsl:import href="../address/lifting.xslt"/>
  <xsl:import href="../identifier-scheme/lifting.xslt"/>
  <xsl:import href="../alternate-title-type/lifting.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" media-type="application/rdf+xml" indent="yes"/>
  <xsl:template match="/ccmm:distribution-data-service">
    <rdf:RDF>
      <xsl:variable name="result" as="element()*">
        <xsl:call-template name="_0ebb6596-4243-45ef-881d-8d08e1dfacc0_002fclass-1762011714325-a238-e785-9c3d"/>
      </xsl:variable>
      <xsl:for-each select="$result">
        <xsl:copy>
          <xsl:call-template name="remove-top"/>
        </xsl:copy>
      </xsl:for-each>
      <xsl:for-each select="$result//top-level/node()">
        <xsl:copy>
          <xsl:call-template name="remove-top"/>
        </xsl:copy>
      </xsl:for-each>
    </rdf:RDF>
  </xsl:template>
  <xsl:template match="@xml:lang">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template name="remove-top">
    <xsl:for-each select="@*">
      <xsl:copy/>
    </xsl:for-each>
    <xsl:for-each select="node()[not(. instance of element(top-level))]">
      <xsl:copy>
        <xsl:call-template name="remove-top"/>
      </xsl:copy>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="_0ebb6596-4243-45ef-881d-8d08e1dfacc0_002fclass-1762011714325-a238-e785-9c3d">
    <xsl:param name="arc" select="()"/>
    <xsl:param name="no_iri" select="false()"/>
    <rdf:Description>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="id">
        <id>
          <xsl:choose>
            <xsl:when test="ccmm:iri and not($no_iri)">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="ccmm:iri"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="rdf:nodeID">
                <xsl:value-of select="generate-id()"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </id>
      </xsl:variable>
      <xsl:copy-of select="$id//@*"/>
      <rdf:type rdf:resource="https://model.ccmm.cz/vocabulary/ccmm#Distribution-DataService"/>
      <xsl:copy-of select="$arc"/>
      <xsl:for-each select="ccmm:title">
        <ns0:title rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:title>
      </xsl:for-each>
      <xsl:for-each select="ccmm:access_service">
        <ns1:accessService>
          <xsl:call-template name="_5676a1ed-e34e-42a1-980e-fe3d5232a661_002fclass-1742341134353-4364-b792-b174"/>
        </ns1:accessService>
      </xsl:for-each>
      <xsl:for-each select="ccmm:conforms_to_specification">
        <ns0:conformsTo>
          <xsl:call-template name="_aba531cb-0df0-48be-8090-1bb17eba35dc_002fclass-1742235803801-3bb0-3064-a2dc"/>
        </ns0:conformsTo>
      </xsl:for-each>
      <xsl:for-each select="ccmm:documentation">
        <ns2:page>
          <xsl:call-template name="_4c68f2fd-7a65-40b8-8953-8a14a8f736b7_002fclass-1742341119213-d3b3-b949-8fcd"/>
        </ns2:page>
      </xsl:for-each>
      <xsl:for-each select="ccmm:description">
        <ns0:description>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:description>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
