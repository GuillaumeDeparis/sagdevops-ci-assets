<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	
	<xsl:param name="deployerHost"/>
	<xsl:param name="deployerPort"/>
	<xsl:param name="deployerUsername"/>
	<xsl:param name="deployerPassword"/>
	
	<xsl:param name="testISHost"/>
	<xsl:param name="testISPort"/>
	<xsl:param name="testISUsername"/>
	<xsl:param name="testISPassword"/>
	
	<xsl:param name="testUMrealmHost"/>
	<xsl:param name="testUMrealmPort"/>
	<xsl:param name="testUMUsername"/>
	<xsl:param name="testUMPassword"/>
	
	<xsl:param name="repoName"/>
	<xsl:param name="repoPath"/>
	<xsl:param name="projectName"/>
		
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@sourceType">
		<xsl:attribute name="sourceType">Runtime</xsl:attribute>
	</xsl:template>
	<xsl:template match="DeployerSpec/DeployerServer">
		<DeployerServer>
			<host><xsl:value-of select="$deployerHost"/>:<xsl:value-of select="$deployerPort"/></host>
			<user><xsl:value-of select="$deployerUsername"/></user>
			<pwd><xsl:value-of select="$deployerPassword"/></pwd>
		</DeployerServer>
	</xsl:template>

	<xsl:template match="DeployerSpec/Environment">
	    <Environment>
			<IS>
				<isalias name="testServer">
					<host><xsl:value-of select="$testISHost"/></host>
					<port><xsl:value-of select="$testISPort"/></port>
					<user><xsl:value-of select="$testISUsername"/></user>
					<pwd><xsl:value-of select="$testISPassword"/></pwd>
					<useSSL>false</useSSL>
					<version>9.10</version>
					<installDeployerResource>true</installDeployerResource>
					<Test>true</Test>
					<executeACL>Administrators</executeACL>
				</isalias>
			</IS>
			<xsl:apply-templates select="@* | *" />
		</Environment>
	</xsl:template>	
	
	<xsl:template match="DeployerSpec/Projects">
		<Projects>
			<xsl:attribute name="projectPrefix"></xsl:attribute>
			<xsl:apply-templates select="@* | *" />
			
			<Project description="" overwrite="true" type="Runtime">
			<xsl:attribute name="name"><xsl:value-of select="$projectName"/></xsl:attribute>			

				<DeploymentSet defaultDependencyAction="fulladd" mode="Deploy" description="" name="myDeploymentSet" otherRegExp="" packageRegExp="" srcAlias="local" type="IS">
					<Package name="Test" srcAlias="local"/>
				</DeploymentSet>
				<DeploymentBuild description="" name="myBuild"/>
			</Project>

		</Projects>		
	</xsl:template>
</xsl:stylesheet>
