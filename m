Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE9517C1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfFXP4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 11:56:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62564 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbfFXP4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 11:56:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OEw7ew031348;
        Mon, 24 Jun 2019 11:14:03 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9h86dvj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vww7HDk56cmYccz3zZ5GIDpckPeL++iVrcsHf+rTX/A=;
 b=fRuTNwa+7KbtBWIVJ3bcd9gdXgJEETiJmT6V5axbIrtxNVWPN0Y0wcLkMTEW/4cN82Sj1LH77J+Cfzxl6ChG/UX2+rptrEX4fyDXLEmq1yHbiCIkGhRkdV2WlpT5+8LHYiP2Cmf9lhrjRr+yLWsoYh/nvxrsm5wyZ2IuxxTLFRA=
Received: from CY4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:903:33::14)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.15; Mon, 24 Jun
 2019 15:14:01 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CY4PR03CA0004.outlook.office365.com
 (2603:10b6:903:33::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 15:14:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 15:14:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5OFE0Ve005078
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 08:14:00 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Jun 2019
 11:14:00 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 4/4] iio: frequency: adf4371: Add support for output stage mute
Date:   Mon, 24 Jun 2019 18:13:56 +0300
Message-ID: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(199004)(189003)(8676002)(50466002)(8936002)(48376002)(72206003)(7696005)(50226002)(51416003)(356004)(6666004)(77096007)(316002)(16586007)(47776003)(5660300002)(186003)(26005)(486006)(107886003)(7636002)(305945005)(476003)(126002)(2906002)(246002)(426003)(44832011)(7416002)(2616005)(110136005)(14444005)(54906003)(36756003)(4326008)(70586007)(70206006)(336012)(106002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 114e134d-9bc0-4324-a7b0-08d6f8b6965d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22580F797F34475FE9ACD33C9DE00@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: V1b3skHKnU76/cFd4+ln50URT19VYShvobTzmsR9A+rpN+3IvFtkWqNS1kdFq8RYAFb48WzQXbNwW7/miO0K9w8S5GVvWwWKdPdyk+b0V8YOkN+/RxesJnbJzP6dH4UTj3rrB6MG9Luyt+zS/WLbiQiEHTLOPmN3IZRtXCcnlwnh+NroORGKiACy8GTgVpx+wrPjukUAVtVo7W2npl9HaeVajCmovZ8XVnjeWMayX6Q6dVVHRaLjoSZ8DfPDkXDHlAuaYhOHw/+Scki/YMOCF5kM4pmuOGcJnes1bhMQR4MLql43hsX7bNJe4kQYtcjIEtU0nZCPJxm7gmHU+Uo9Nneqhb4HnAt61VMCZPYPONcSG6dcwsN3YCg6xULV2SJYvFC0UkswAQTfruuvlTFOcbSOdpxlXwZs4Z968fgCiYQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 15:14:00.8989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114e134d-9bc0-4324-a7b0-08d6f8b6965d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Another feature of the ADF4371/ADF4372 is that the supply current to the
RF8P and RF8N output stage can shut down until the ADF4371 achieves lock
as measured by the digital lock detect circuitry. The mute to lock
detect bit (MUTE_LD) in REG25 enables this function.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/frequency/adf4371.yaml          |  6 ++++++
 drivers/iio/frequency/adf4371.c                             | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index a268a9d..6db8742 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -32,6 +32,12 @@ properties:
     items:
       - clkin
 
+  adi,mute-till-lock-en:
+    description:
+      If this property is present, then the supply current to RF8P and RF8N
+      output stage will shut down until the ADF4371/ADF4372 achieves lock as
+      measured by the digital lock detect circuitry.
+
 required:
   - compatible
   - reg
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index f874219..e48f15c 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -45,6 +45,10 @@
 #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
 #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
 
+/* ADF4371_REG25 */
+#define ADF4371_MUTE_LD_MSK		BIT(7)
+#define ADF4371_MUTE_LD(x)		FIELD_PREP(ADF4371_MUTE_LD_MSK, x)
+
 /* ADF4371_REG32 */
 #define ADF4371_TIMEOUT_MSK		GENMASK(1, 0)
 #define ADF4371_TIMEOUT(x)		FIELD_PREP(ADF4371_TIMEOUT_MSK, x)
@@ -484,6 +488,15 @@ static int adf4371_setup(struct adf4371_state *st)
 	if (ret < 0)
 		return ret;
 
+	/* Mute to Lock Detect */
+	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en")) {
+		ret = regmap_update_bits(st->regmap, ADF4371_REG(0x25),
+					 ADF4371_MUTE_LD_MSK,
+					 ADF4371_MUTE_LD(1));
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Set address in ascending order, so the bulk_write() will work */
 	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x0),
 				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
-- 
2.7.4

