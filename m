Return-Path: <linux-iio+bounces-2087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D47846E85
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450FBB2AC1D
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C7E13E234;
	Fri,  2 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="WZhVvBW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73B18B15;
	Fri,  2 Feb 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871567; cv=fail; b=Rkg2qw0C4evAv0ounmXNaoAmzYyx+m13WefJj9KsAs19rGNPsrZDh6hANJ4frmgB9CTcs9Whn2/+VzOjUMeSqBOmKVXKyDS2H7Nq9FhEl0XZhSxDAEKUIuMzKLSH5e/JvSdktTrzrohEiV4RLPn2Sf5p52GoOGyFsdj9dGjNe6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871567; c=relaxed/simple;
	bh=xQiCJifW4+MX21tJAzGpKArBYAlngqOtzJqe4VSGg5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hx02Dt415fOOCy51Qt6zio55D4XVLzozdrnJ9CD0fgmrg2gcbEO+alqkS0/ukVh2fAfcpk90c2cmzz2qwg0OpC5mRWiQw9afBDyhxrKHWKNxEeCtTjVX0kpZUvO2/v78Q8/0hPSQ79lF8SGjcz3D7iN9ERo9F7t9IYoS6YLTrWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=WZhVvBW2; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA49z1ZXZwnzA2IVRXvT002l0zisZYUV2TPk2rZiq/5BPMHnFtpOZM4IpTletJ+ijQ9DFvDuu5Rvv1K+8IPM6VoYMDI4Ol6G68L50tvWKPTYlFIRoPhLXO/GtF4wyWXWe8x/6yWQIRuvUMpGZFu6T4PGbf7gkzzhejdIQbpzFTUB53MG0+mO+1bH3i4GWv/H/swZWch/kzDbeESuqdjkoLfhAsUZjr/2drvVK2iMEpqrLnzwKAMlr3Tuvvx2MZeOlEdzEmi2AFrsNjTUYFv7br5aaoq1tAnsAM9FGORmA4kz15wqKsX9A7aVS5JArsjkeBqd+aV3npApkFtnTokVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv7rLzG7S71yvBs7CmhefZECATNSpp5fL7OTacdspf0=;
 b=Uk8sTJNXbOW5V34O4j2SMhpTW9m85aOnLFE0Ke8Gxo3Tl6EZ1PXQQ8K0ka3vkkuiaipNAT17t69T2LM7EVJA2J5P/35MdJm50/uJgMcuyA4nI2h1RjFZaV6VKOYjRYDSlClAvaaNrEm5nxdd9JiGFu+K1N6mrzCR9s+Tq1yqDFPAn7LZ6tBtyLydxSWMlM9umZbhjCqK010fiJT6+QZSEPAbX54auMe5+c9ew8cs0uByrTihnzSm2anf7ATEQphaAxz9F12i1fLxeywl+W3PJo6RbltVMlDfZKgICe6oNpJkmIs/vg38gonwUa5sW32bY7o5GRBGiX24prI8nImeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv7rLzG7S71yvBs7CmhefZECATNSpp5fL7OTacdspf0=;
 b=WZhVvBW2lNamV/t9fABjfNpJR3TJ1Tk4Eh5YdiiL5CwAjM0z2VoZAHHSpSIcRyK8bbmfgjjPrgSpOzUDdPVC+TcJfgyq7mUFw3KnYoRkgDRt0TPTZCT7DWpvbbhRwxCBnORU2ZlksMYYIUZ/zea8FJ9MUWbTQFALvyJ1nhKVKsnuZob1A3vcPEQx2dQIIxaTGUHwOFiNziNVN84JGMW1s+XW7KNL4ot/3jRywRw9DBM7gPTLXCyIpb6donmI5pPadHotrHM4fLU5UxA8sI7gU4lieSFNRD7Px10cqGF3RLNhKPCKQJCFhWcBRqifpiDTEW5Z8nKsL8RpBfOSTwbKIg==
Received: from AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) by
 AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 10:59:19 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::a2) by AM0PR03CA0063.outlook.office365.com
 (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 2 Feb 2024 10:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 10:59:18 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 02 Feb 2024 10:59:17 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 10:59:11 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 10:59:11 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
Date: Fri, 2 Feb 2024 11:59:01 +0100
Message-ID: <20240202105901.925875-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202105901.925875-1-mike.looijmans@topic.nl>
References: <20240202105901.925875-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.6274d473-fd3f-439a-bf61-89eea8028afa@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0104.eurprd02.prod.outlook.com
 (2603:10a6:208:154::45) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB7991:EE_|AMS0EPF00000194:EE_|AS8PR04MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a026c2-9316-49c5-a80b-08dc23de0129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 8r2hxST8U6r/eWGIx+dLXDgRN043JDXoW5ofZQsBEgt6IyZBT3VKTdyKoyY3TqS4obNdhhgNnqn+gDcZUvubdQmx+vWJWamG2Rf7rDwf0CQ6oPkS5fAdJ6hYh1lEd8eteVUcuAGdmGXMyxB09l5u84567rTHhiiLcA6g56ACeHrDeRnCsHSNP+xq44D7B0qQmQA1iQOFA6HQ+rP2bAidzMbJ9B6mgXVygv4or8RBXDfLPOp4k4c2Xv9/yh5gmOkb7vdirevOX4ijss9/6DUj5w7WNHCz5AqluX83fsIn51lCGJ/f9G/wFMZ3JvLYfO3osfcdB4T0IObbQjCMbF5JaI9cK9oLTBov77ErUOi7gJXpc8IF6O4otX3voKVaRunP3yPzQP+XcojCk9qKzAxb8gRQivxAb/ewMCgOkgVEOn9QeqLeyWrAs4qGWmqciLSxsSoz4WbBEpaLB0Q6R8d7mOewtnKq5XyqcfwtpXTlLXV8gVByhJU8EbY8F/9O3XsBPcCJQkloQwqlo4mt4sQcIyvdwZDdM2jtagFzcunpZPS+i9mInUZkkhXUQyf9swN7L+L4sbthx+SRz8JYAyWeO095Tg9k3H0Rf+GHxc3KpfPTcrSgPjvsd0YVCRjnIP6/ttF8Zy3Qi1TKbrHiefYmGxezj9wib3yzYaC90RLI+TQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39840400004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(1076003)(6512007)(26005)(38100700002)(2616005)(44832011)(66476007)(5660300002)(52116002)(4326008)(8676002)(8936002)(7416002)(6506007)(6486002)(478600001)(2906002)(30864003)(6666004)(54906003)(66946007)(316002)(66556008)(38350700005)(36756003)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991
X-CodeTwo-MessageID: fe7b53a8-2734-4361-83bc-97b0e4860dcc.20240202105917@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	176e9b3a-001d-4397-0027-08dc23ddfcd8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s8c/R3er0c0e0JvuPCCnIAXgUQ+FB4rA8d8eSI11xPnXoY17yBu7osbdJma7TYRezy9ndUaA7WkXbG88FlhgFN22n2OMEZdiK17/YZguhUnuJy7Vbs73vhaU4NRLP4YK+HHhmn9nkiw+2kc/EhZM0w+KfZT0JCSOb3ayFwWtxXKu2MHTaWC72h9SBA0oKblBtPt6N0zlYLYtLRiLdXwIf0Sa34YTNPY1jqpZnUc7irrqHURcp2xH3qUt7ZOfwSOmQgSjY7eO9CiwpI+8vF9mhCHXRMThg4sH5ICNBsoXzntrHLlJ3QBKSXeTHFMUCyregdggtJj/30i8Ju6AubJ/+vPvc5gZkv9Pb2v8JhNtYaKICgfVQcGB0kYdAYlGq4ZvRR+l/wNhaCxuvnsPoAXpWquBVfdSxEO03nQDX970BLlPwFoi0AEQm1R09KC4PCWMslvTXsnrvJrdRNUNGPJYBYSz4debmitRL4Ryk305WlzcZaP7AW9M+pQDIZpmD0TZL49OWJs+C0gaomOTTiPWK+Cu0sWEGtAzD73zIEAfUxI0RUlg5KhdKRhw+as4yYPIJHOjPgb5FKn6T+c1rsGu8c6FJ177eOXprQiKWNPZCh66GhTGtrwjCRjnuJtbt76Q6v39MESHIOJ0kDNRnqq/tNjsc021otFot7f2ilkvZa1stexuSzV+tCh5F8QbRz+sRcMli80pnv1u1OE2N0qtCe7clNyVCvbfZzyHrGse0BZ1nzRUBCEd6jvPb3wGZl3w
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39840400004)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(6506007)(36860700001)(40480700001)(7636003)(356005)(7596003)(83380400001)(47076005)(336012)(2616005)(6512007)(30864003)(2906002)(7416002)(54906003)(5660300002)(44832011)(15974865002)(316002)(36756003)(8936002)(8676002)(4326008)(86362001)(6666004)(70586007)(70206006)(6486002)(26005)(1076003)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:59:18.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a026c2-9316-49c5-a80b-08dc23de0129
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064

Skeleton driver for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Remove accidental "default y" in Kconfig
Indentation and similar cosmetic fixes
Magic numbers into constants
Short return paths in read_raw and write_raw
DMA buffer alignment
Bounce buffer is u32 instead of u8
Avoid races using claim_direct_mode
Check errors on all register accesses
Immediate SPI restart to reduce underruns
"name" is chip name, not unique

 drivers/iio/adc/Kconfig      |  11 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1298.c | 769 +++++++++++++++++++++++++++++++++++
 3 files changed, 781 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1298.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 35f9867da12c..1d2d2eff15da 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1318,6 +1318,17 @@ config TI_ADS8688
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads8688.
=20
+config TI_ADS1298
+	tristate "Texas Instruments ADS1298"
+	depends on SPI
+	select IIO_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1298
+	  medical ADC chips
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1298.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index bee11d442af4..ff0e3633eded 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_TI_ADS7924) +=3D ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
+obj-$(CONFIG_TI_ADS1298) +=3D ti-ads1298.o
 obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
 obj-$(CONFIG_TI_ADS131E08) +=3D ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
new file mode 100644
index 000000000000..539598b9f3fa
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -0,0 +1,769 @@
+// SPDX-License-Identifier: GPL-2.0
+/* TI ADS1298 chip family driver
+ * Copyright (C) 2023 - 2024 Topic Embedded Products
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#define ADS1298_WAKEUP  0x02
+#define ADS1298_STANDBY 0x04
+#define ADS1298_RESET   0x06
+#define ADS1298_START   0x08
+#define ADS1298_STOP    0x0A
+#define ADS1298_RDATAC  0x10
+#define ADS1298_SDATAC  0x11
+#define ADS1298_RDATA   0x12
+
+/* Commands */
+#define ADS1298_CMD_WAKEUP	0x02
+#define ADS1298_CMD_STANDBY	0x04
+#define ADS1298_CMD_RESET	0x06
+#define ADS1298_CMD_START	0x08
+#define ADS1298_CMD_STOP	0x0a
+#define ADS1298_CMD_RDATAC	0x10
+#define ADS1298_CMD_SDATAC	0x11
+#define ADS1298_CMD_RDATA	0x12
+#define ADS1298_CMD_RREG	0x20
+#define ADS1298_CMD_WREG	0x40
+
+/* Registers */
+#define ADS1298_REG_ID		0x00
+#define ADS1298_MASK_ID_FAMILY			GENMASK(7, 3)
+#define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
+#define ADS1298_ID_FAMILY_ADS129X		0x90
+#define ADS1298_ID_FAMILY_ADS129XR		0xd0
+#define ADS1298_REG_CONFIG1	0x01
+#define ADS1298_MASK_CONFIG1_HR			BIT(7)
+#define ADS1298_MASK_CONFIG1_DR			0x07
+#define ADS1298_SHIFT_DR_HR			6
+#define ADS1298_SHIFT_DR_LP			7
+#define ADS1298_LOWEST_DR			0x06
+#define ADS1298_REG_CONFIG2	0x02
+#define ADS1298_MASK_CONFIG2_RESERVED		BIT(6)
+#define ADS1298_MASK_CONFIG2_WCT_CHOP		BIT(5)
+#define ADS1298_MASK_CONFIG2_INT_TEST		BIT(4)
+#define ADS1298_MASK_CONFIG2_TEST_AMP		BIT(2)
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_DC	GENMASK(1, 0)
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_SLOW	0
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_FAST	BIT(0)
+#define ADS1298_REG_CONFIG3	0x03
+#define ADS1298_MASK_CONFIG3_PWR_REFBUF		BIT(7)
+#define ADS1298_MASK_CONFIG3_RESERVED		BIT(6)
+#define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
+#define ADS1298_REG_LOFF	0x04
+#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_MASK_CH_PD		BIT(7)
+#define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
+#define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
+#define ADS1298_REG_LOFF_STATP	0x12
+#define ADS1298_REG_LOFF_STATN	0x13
+
+#define ADS1298_REG_CONFIG4	0x17
+#define ADS1298_MASK_CONFIG4_SINGLE_SHOT	BIT(3)
+#define ADS1298_REG_WCT1	0x18
+#define ADS1298_REG_WCT2	0x19
+
+#define ADS1298_MAX_CHANNELS	8
+#define ADS1298_CLK_RATE_HZ	2048000
+#define ADS1298_CLOCKS_TO_USECS(x) \
+		(DIV_ROUND_UP((x * MICROHZ_PER_HZ), ADS1298_CLK_RATE_HZ))
+/*
+ * Read/write register commands require 4 clocks to decode, for speeds abo=
ve
+ * 2x the clock rate, this would require extra time between the command by=
te and
+ * the data. Much simpler is to just limit the SPI transfer speed while do=
ing
+ * register access.
+ */
+#define ADS1298_SPI_BUS_SPEED_SLOW	ADS1298_CLK_RATE_HZ
+/* For reading and writing registers, we need a 3-byte buffer */
+#define ADS1298_SPI_CMD_BUFFER_SIZE	3
+/* Outputs status word and 8 24-bit samples, plus the command byte */
+#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 + 1)
+
+struct ads1298_private {
+	const struct ads1298_chip_info *chip_info;
+	struct spi_device *spi;
+	struct regulator *reg_avdd;
+	struct regulator *reg_vref;
+	struct clk *clk;
+	struct regmap *regmap;
+	struct completion completion;
+	struct iio_trigger *trig;
+	struct spi_transfer rdata_xfer;
+	struct spi_message rdata_msg;
+	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
+	int rdata_xfer_busy;
+
+	/* Temporary storage for demuxing data after SPI transfer */
+	u32 bounce_buffer[ADS1298_MAX_CHANNELS];
+
+	/* For synchronous SPI exchanges (read/write registers) */
+	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
+
+	/* Buffer used for incoming SPI data */
+	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];
+	/* Contains the RDATA command and zeroes to clock out */
+	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];
+};
+
+/* Three bytes per sample in RX buffer, starting at offset 4 */
+#define ADS1298_OFFSET_IN_RX_BUFFER(index)	(3 * (index) + 4)
+
+#define ADS1298_CHAN(index)				\
+{							\
+	.type =3D IIO_VOLTAGE,				\
+	.indexed =3D 1,					\
+	.channel =3D index,				\
+	.address =3D ADS1298_OFFSET_IN_RX_BUFFER(index),	\
+	.info_mask_separate =3D				\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all =3D			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.scan_index =3D index,				\
+	.scan_type =3D {					\
+		.sign =3D 's',				\
+		.realbits =3D 24,				\
+		.storagebits =3D 32,			\
+		.endianness =3D IIO_CPU,			\
+	},						\
+}
+
+static const struct iio_chan_spec ads1298_channels[] =3D {
+	ADS1298_CHAN(0),
+	ADS1298_CHAN(1),
+	ADS1298_CHAN(2),
+	ADS1298_CHAN(3),
+	ADS1298_CHAN(4),
+	ADS1298_CHAN(5),
+	ADS1298_CHAN(6),
+	ADS1298_CHAN(7),
+};
+
+static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
+{
+	struct spi_transfer cmd_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D sizeof(command),
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay =3D {
+			.value =3D 2,
+			.unit =3D SPI_DELAY_UNIT_USECS,
+		},
+	};
+
+	priv->cmd_buffer[0] =3D command;
+
+	return spi_sync_transfer(priv->spi, &cmd_xfer, 1);
+}
+
+static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
+{
+	int ret;
+
+	/* Enable the channel  */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(chan_index),
+				 ADS1298_MASK_CH_PD, 0);
+	if (ret)
+		return ret;
+
+	/* Enable single-shot mode, so we don't need to send a STOP */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG4,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT);
+	if (ret)
+		return ret;
+
+	reinit_completion(&priv->completion);
+
+	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_START);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "CMD_START error: %d\n", ret);
+		return ret;
+	}
+
+	/* Cannot take longer than 40ms (250Hz) */
+	ret =3D wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(5=
0));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ads1298_get_samp_freq(struct ads1298_private *priv, int *val)
+{
+	unsigned long rate;
+	int ret;
+	unsigned int cfg;
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, &cfg);
+	if (ret)
+		return ret;
+
+	if (priv->clk)
+		rate =3D clk_get_rate(priv->clk);
+	else
+		rate =3D ADS1298_CLK_RATE_HZ;
+	if (!rate)
+		return -EINVAL;
+
+	/* Data rate shift depends on HR/LP mode */
+	if (cfg & ADS1298_MASK_CONFIG1_HR)
+		rate >>=3D ADS1298_SHIFT_DR_HR;
+	else
+		rate >>=3D ADS1298_SHIFT_DR_LP;
+
+	*val =3D rate >> (cfg & ADS1298_MASK_CONFIG1_DR);
+
+	return IIO_VAL_INT;
+}
+
+static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
+{
+	unsigned long rate;
+	unsigned int factor;
+	unsigned int cfg;
+
+	if (priv->clk)
+		rate =3D clk_get_rate(priv->clk);
+	else
+		rate =3D ADS1298_CLK_RATE_HZ;
+	if (!rate)
+		return -EINVAL;
+
+	factor =3D (rate >> ADS1298_SHIFT_DR_HR) / val;
+	if (factor >=3D 128) {
+		cfg =3D ADS1298_LOWEST_DR;
+	} else if (factor <=3D 1) {
+		cfg =3D ADS1298_MASK_CONFIG1_HR; /* Fastest possible */
+	} else {
+		cfg =3D fls(factor) - 1;
+		cfg |=3D ADS1298_MASK_CONFIG1_HR; /* Use HR mode */
+	}
+
+	return regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG1,
+			ADS1298_MASK_CONFIG1_HR | ADS1298_MASK_CONFIG1_DR,
+			cfg);
+}
+
+static const u8 ads1298_pga_settings[] =3D { 6, 1, 2, 3, 4, 8, 12 };
+
+static int ads1298_get_scale(struct ads1298_private *priv,
+			     int channel, int *val, int *val2)
+{
+	int ret;
+	unsigned int regval;
+	u8 gain;
+
+	if (priv->reg_vref) {
+		ret =3D regulator_get_voltage(priv->reg_vref);
+		if (ret < 0)
+			return ret;
+
+		*val =3D ret / 1000; /* Convert to millivolts */
+	} else {
+		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
+		if (ret)
+			return ret;
+
+		/* Refererence in millivolts */
+		*val =3D regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
+	}
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_CHnSET(channel), &regval);
+	if (ret)
+		return ret;
+
+	gain =3D ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
+	*val /=3D gain; /* Full scale is VREF / gain */
+
+	*val2 =3D 23; /* Signed 24-bit, max amplitude is 2^23 */
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static int ads1298_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret =3D ads1298_read_one(priv, chan->scan_index);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret)
+			return ret;
+
+		*val =3D sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->addres=
s),
+				     23);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return ads1298_get_scale(priv, chan->channel, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ads1298_get_samp_freq(priv, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
+		if (ret)
+			return ret;
+
+		*val =3D (16 << (*val & ADS1298_MASK_CONFIG1_DR));
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1298_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ads1298_set_samp_freq(priv, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1298_reg_write(void *context, unsigned int reg, unsigned int=
 val)
+{
+	struct ads1298_private *priv =3D context;
+	struct spi_transfer reg_write_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D 3,
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay =3D {
+			.value =3D 2,
+			.unit =3D SPI_DELAY_UNIT_USECS,
+		},
+	};
+
+	priv->cmd_buffer[0] =3D ADS1298_CMD_WREG | reg;
+	priv->cmd_buffer[1] =3D 0x0;
+	priv->cmd_buffer[2] =3D val;
+
+	return spi_sync_transfer(priv->spi, &reg_write_xfer, 1);
+}
+
+static int ads1298_reg_read(void *context, unsigned int reg, unsigned int =
*val)
+{
+	struct ads1298_private *priv =3D context;
+	struct spi_transfer reg_read_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D 3,
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay =3D {
+			.value =3D 2,
+			.unit =3D SPI_DELAY_UNIT_USECS,
+		},
+	};
+	int ret;
+
+	priv->cmd_buffer[0] =3D ADS1298_CMD_RREG | reg;
+	priv->cmd_buffer[1] =3D 0x0;
+	priv->cmd_buffer[2] =3D 0;
+
+	ret =3D spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
+	if (ret)
+		return ret;
+
+	*val =3D priv->cmd_buffer[2];
+
+	return 0;
+}
+
+static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(priv->regmap, reg, readval);
+
+	return regmap_write(priv->regmap, reg, writeval);
+}
+
+static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
+{
+	unsigned long flags;
+
+	/* Notify we're no longer waiting for the SPI transfer to complete */
+	spin_lock_irqsave(&priv->irq_busy_lock, flags);
+	priv->rdata_xfer_busy =3D 0;
+	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
+}
+
+static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
+				    const unsigned long *scan_mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+	int i;
+
+	/* Make the interrupt routines start with a clean slate */
+	ads1298_rdata_unmark_busy(priv);
+
+	/* Power down channels that aren't in use */
+	for (i =3D 0; i < ADS1298_MAX_CHANNELS; i++) {
+		val =3D test_bit(i, scan_mask) ? 0 : ADS1298_MASK_CH_PD;
+		ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
+					 ADS1298_MASK_CH_PD, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_info ads1298_info =3D {
+	.read_raw =3D &ads1298_read_raw,
+	.write_raw =3D &ads1298_write_raw,
+	.update_scan_mode =3D &ads1298_update_scan_mode,
+	.debugfs_reg_access =3D &ads1298_reg_access,
+};
+
+static void ads1298_rdata_release_busy_or_restart(struct ads1298_private *=
priv)
+{
+	unsigned long flags;
+	int wasbusy;
+
+	spin_lock_irqsave(&priv->irq_busy_lock, flags);
+
+	wasbusy =3D --priv->rdata_xfer_busy;
+	if (wasbusy) {
+		/*
+		 * DRDY interrupt occurred before SPI completion. Start a new
+		 * SPI transaction now to retrieve the data that wasn't latched
+		 * into the ADS1298 chip's transfer buffer yet.
+		 */
+		spi_async(priv->spi, &priv->rdata_msg);
+		/*
+		 * If more than one DRDY took place, there was an overrun. Since
+		 * the sample is already lost, reset the counter to 1 so that
+		 * we will wait for a DRDY interrupt after this SPI transaction.
+		 */
+		if (wasbusy > 1)
+			priv->rdata_xfer_busy =3D 1;
+	}
+
+	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
+}
+
+/* Called from SPI completion interrupt handler */
+static void ads1298_rdata_complete(void *context)
+{
+	struct iio_dev *indio_dev =3D context;
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int scan_index;
+	u32 *bounce =3D priv->bounce_buffer;
+
+	if (!iio_buffer_enabled(indio_dev)) {
+		/* Happens when running in single transfer mode */
+		ads1298_rdata_unmark_busy(priv);
+		complete(&priv->completion);
+		return;
+	}
+
+	/* Demux the channel data into our bounce buffer */
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan =3D
+					&indio_dev->channels[scan_index];
+		const u8 *data =3D priv->rx_buffer + scan_chan->address;
+
+		*bounce++ =3D get_unaligned_be24(data);
+	}
+
+	/* rx_buffer can be overwritten from this point on */
+	ads1298_rdata_release_busy_or_restart(priv);
+
+	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
+}
+
+static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev =3D dev_id;
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	unsigned long flags;
+	int wasbusy;
+
+	spin_lock_irqsave(&priv->irq_busy_lock, flags);
+
+	wasbusy =3D priv->rdata_xfer_busy++;
+	/* When no SPI transfer in transit, start one now */
+	if (!wasbusy)
+		spi_async(priv->spi, &priv->rdata_msg);
+
+	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
+
+	return IRQ_HANDLED;
+};
+
+static int ads1298_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int ret;
+
+	/* Disable single-shot mode */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG4,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT, 0);
+	if (ret)
+		return ret;
+
+	return ads1298_write_cmd(priv, ADS1298_CMD_START);
+}
+
+static int ads1298_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+
+	return ads1298_write_cmd(priv, ADS1298_CMD_STOP);
+}
+
+static const struct iio_buffer_setup_ops ads1298_setup_ops =3D {
+	.postenable =3D &ads1298_buffer_postenable,
+	.predisable =3D &ads1298_buffer_predisable,
+};
+
+static void ads1298_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static const struct regmap_range ads1298_regmap_volatile_range[] =3D {
+	regmap_reg_range(ADS1298_REG_LOFF_STATP, ADS1298_REG_LOFF_STATN),
+};
+
+static const struct regmap_access_table ads1298_regmap_volatile =3D {
+	.yes_ranges =3D ads1298_regmap_volatile_range,
+	.n_yes_ranges =3D ARRAY_SIZE(ads1298_regmap_volatile_range),
+};
+
+static const struct regmap_config ads1298_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.reg_read =3D ads1298_reg_read,
+	.reg_write =3D ads1298_reg_write,
+	.max_register =3D ADS1298_REG_WCT2,
+	.volatile_table =3D &ads1298_regmap_volatile,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+static const char *ads1298_family_name(unsigned int id)
+{
+	switch (id & ADS1298_MASK_ID_FAMILY) {
+	case ADS1298_ID_FAMILY_ADS129X:
+		return "ADS129x";
+	case ADS1298_ID_FAMILY_ADS129XR:
+		return "ADS129xR";
+	default:
+		return "(unknown)";
+	}
+}
+
+static int ads1298_init(struct ads1298_private *priv)
+{
+	struct device *dev =3D &priv->spi->dev;
+	int ret;
+	unsigned int val;
+
+	/* Device initializes into RDATAC mode, which we don't want. */
+	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_ID, &val);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Found %s, %u channels\n", ads1298_family_name(val),
+		 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS));
+
+	/* Enable internal test signal, double amplitude, double frequency */
+	ret =3D regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
+		ADS1298_MASK_CONFIG2_RESERVED |
+		ADS1298_MASK_CONFIG2_INT_TEST |
+		ADS1298_MASK_CONFIG2_TEST_AMP |
+		ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
+	if (ret)
+		return ret;
+
+	val =3D ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
+	if (!priv->reg_vref) {
+		/* Enable internal reference */
+		val |=3D ADS1298_MASK_CONFIG3_PWR_REFBUF;
+		/* Use 4V VREF when power supply is at least 4.4V */
+		if (regulator_get_voltage(priv->reg_avdd) >=3D 4400000)
+			val |=3D ADS1298_MASK_CONFIG3_VREF_4V;
+	}
+	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
+}
+
+static int ads1298_probe(struct spi_device *spi)
+{
+	struct ads1298_private *priv;
+	struct iio_dev *indio_dev;
+	struct device *dev =3D &spi->dev;
+	struct gpio_desc *reset_gpio;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv =3D iio_priv(indio_dev);
+
+	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");
+
+	/* VREF can be supplied externally. Otherwise use internal reference */
+	priv->reg_vref =3D devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(priv->reg_vref)) {
+		if (PTR_ERR(priv->reg_vref) =3D=3D -ENODEV)
+			priv->reg_vref =3D NULL;
+		else
+			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
+					     "Failed to get vref regulator\n");
+	} else {
+		ret =3D regulator_enable(priv->reg_vref);
+		if (ret)
+			return ret;
+
+		ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
+					       priv->reg_vref);
+		if (ret)
+			return ret;
+	}
+
+	priv->clk =3D devm_clk_get_enabled(dev, "clk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed to get clk\n");
+
+	priv->reg_avdd =3D devm_regulator_get(dev, "avdd");
+	if (IS_ERR(priv->reg_avdd))
+		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
+				     "Failed to get avdd regulator\n");
+
+	ret =3D regulator_enable(priv->reg_avdd);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable avdd regulator\n");
+
+	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
+				       priv->reg_avdd);
+	if (ret)
+		return ret;
+
+	priv->spi =3D spi;
+	init_completion(&priv->completion);
+	spin_lock_init(&priv->irq_busy_lock);
+	priv->regmap =3D devm_regmap_init(dev, NULL, priv,
+					&ads1298_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->tx_buffer[0] =3D ADS1298_CMD_RDATA;
+	priv->rdata_xfer.tx_buf =3D priv->tx_buffer;
+	priv->rdata_xfer.rx_buf =3D priv->rx_buffer;
+	priv->rdata_xfer.len =3D ADS1298_SPI_RDATA_BUFFER_SIZE;
+	/* Must keep CS low for 4 clocks */
+	priv->rdata_xfer.delay.value =3D 2;
+	priv->rdata_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
+	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1);
+	priv->rdata_msg.complete =3D &ads1298_rdata_complete;
+	priv->rdata_msg.context =3D indio_dev;
+
+	indio_dev->name =3D spi_get_device_id(spi)->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->channels =3D ads1298_channels;
+	indio_dev->num_channels =3D ADS1298_MAX_CHANNELS;
+	indio_dev->info =3D &ads1298_info;
+
+	if (reset_gpio) {
+		udelay(ADS1298_CLOCKS_TO_USECS(2));
+		gpiod_set_value(reset_gpio, 0);
+	} else {
+		ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
+		if (ret)
+			return dev_err_probe(dev, ret, "RESET failed\n");
+	}
+	/* Wait 18 clock cycles for reset command to complete */
+	udelay(ADS1298_CLOCKS_TO_USECS(18));
+
+	ret =3D ads1298_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init failed\n");
+
+	ret =3D devm_request_irq(dev, spi->irq, &ads1298_interrupt,
+			       IRQF_TRIGGER_FALLING, indio_dev->name,
+			       indio_dev);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &ads1298_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ads1298_id[] =3D {
+	{ "ads1298" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1298_id);
+
+static const struct of_device_id ads1298_of_table[] =3D {
+	{ .compatible =3D "ti,ads1298" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1298_of_table);
+
+static struct spi_driver ads1298_driver =3D {
+	.driver =3D {
+		.name	=3D "ads1298",
+		.of_match_table =3D ads1298_of_table,
+	},
+	.probe		=3D ads1298_probe,
+	.id_table	=3D ads1298_id,
+};
+module_spi_driver(ads1298_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("TI ADS1298 ADC");
+MODULE_LICENSE("GPL");
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

