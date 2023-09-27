<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:foaf="http://xmlns.com/foaf/0.1/">

    <xsl:template match="/">
        <xml>
            <person>
                <xsl:for-each select="//foaf:Person">
                    <xsl:if test="position()=1">
                        <h2>Person</h2>
                        <xsl:apply-templates select="foaf:name" />
                        <xsl:apply-templates
                            select="foaf:title" />
                        <xsl:apply-templates select="foaf:givenname" />
                        <xsl:apply-templates
                            select="foaf:family_name" />
                        <xsl:apply-templates
                            select="foaf:mbox_sha1sum" />
                        <xsl:apply-templates select="foaf:homepage" />
                        <xsl:apply-templates
                            select="foaf:weblog" />
                        <xsl:apply-templates
                            select="foaf:workplaceHomepage" />
                        <xsl:apply-templates
                            select="foaf:schoolHomepage" />
                    </xsl:if>
                </xsl:for-each>
            </person>
            <xsl:apply-templates select="//foaf:knows" />
        </xml>
    </xsl:template>

    <xsl:template
        match="foaf:name | foaf:title | foaf:givenname | foaf:family_name | foaf:mbox_sha1sum | foaf:homepage | foaf:weblog | foaf:workplaceHomepage | foaf:schoolHomepage">
        <xsl:if test="string(.) != ''">
            <p>
                <strong><xsl:value-of select="local-name()" />:</strong>
                <xsl:if test="local-name()='homepage'">
                    <a href="{.}" target="_blank">
                        <xsl:value-of select="." />
                    </a>
                </xsl:if>
                <xsl:if test="local-name()='name'">
                    <xsl:if test="../rdfs:seeAlso/@rdf:resource">
                        <a href="{../rdfs:seeAlso/@rdf:resource}" target="_blank">
                            <xsl:value-of select="." />
                        </a>
                    </xsl:if>
                    <xsl:if
                        test="not(../rdfs:seeAlso/@rdf:resource)">
                        <xsl:value-of select="." />
                    </xsl:if>
                </xsl:if>
                <xsl:if test="local-name()!='homepage' and local-name()!='name'">
                    <xsl:value-of select="." />
                </xsl:if>
            </p>
        </xsl:if>
    </xsl:template>

    <xsl:template match="foaf:knows">
        <h2>Knows</h2>
        <xsl:for-each select="foaf:Person">
            <person>
                <p>
                    <strong>Name:</strong>
                    <xsl:if test="foaf:homepage">
                        <a href="{foaf:homepage}" target="_blank">
                            <xsl:value-of select="foaf:name" />
                        </a>
                    </xsl:if>
                    <xsl:if test="rdfs:seeAlso/@rdf:resource">
                        <a href="{rdfs:seeAlso/@rdf:resource}" target="_blank">
                            <xsl:value-of select="foaf:name" />
                        </a>
                    </xsl:if>
                    <xsl:if test="not(foaf:homepage) and not(rdfs:seeAlso/@rdf:resource)">
                        <xsl:value-of select="foaf:name" />
                    </xsl:if>
                </p>
                <xsl:apply-templates select="foaf:mbox_sha1sum" />
            </person>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>