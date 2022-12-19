Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBD6509D9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 11:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLSKNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 05:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiLSKNs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 05:13:48 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1532DFD;
        Mon, 19 Dec 2022 02:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu7NtUUArEJ22tWFqEGu2fePDgVRWUBEmKCbBjgQjAPAPzmd7PKQ6mUW/N+jLQMiRrABJhybHcrBiV5CDGNf6t25OMOS088VzfAiWffkZAPFqPHUPTDMEtBhGoafPAZsdws4IpYhiqA12Lr4fxkQI89mO023DkVMMO1Ncxhs8vCzFtNhWgb0ysyvA7BVPUVYcDOrN991F+dggWGz4F8rIJNuhJC6DKadS+U1P2+0PTXINTG0MuKm7FzbxQ1T5GWGgZOWZ1oC/2adq5JwU43U+DlxhitcZj5pywCoNEdV/+fxxxjK7Nc++wuZ4of9KaUg62DGGpP3O6h5nQDgoKHpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZe5CIVGsBFmM/6sBy37JYecPphAnK0ahY4LuG2v2hs=;
 b=m2igtNJlCtlWuhO5TsGy2R+xeODP0I7vLb2qetfvkf4bfcnctK2hKiQX62URnM71zpu0A93vot0OY7/vrY9G7nLUMFI81yNf72b2NiunXBDA695+DlNBNeIgL+oOoKdbZcx7ze51R1Yy1oiPYYLiFIEx6QYJ/6codAfna652WYGL83ZppeIo5ih/NaAIgp1h/nuEJv8/iwcXomBPk3TxU+B/GIbpcpx47fMaLKXleiclNFmbUAsH1C24xR+lW1VHnIzUCdFvaWJhwJp7DyVrjA7xnoDpQevfbIjdKcnqtLIcXgR6yj6/eeYvgZi+np1c1qnYyY3VpsqbhzIv10z2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZe5CIVGsBFmM/6sBy37JYecPphAnK0ahY4LuG2v2hs=;
 b=OdwbdYl+yxZJ/qchCPN8yPYu00HvxHwpT41IGr4sGZzAwbj45ZCpzBgpI4lN4xFCF1DFUE4nv2IcPGdSk26ZMGTZiuAidy23GdvdUmWmg09nQyOqp5utyf4Z/OyMtidjK5LB8nCDYBEfouvYkKA6Gq8P4oBCoThS/YECS6z7oH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Mon, 19 Dec 2022 10:13:41 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:13:39 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] iio: adc: add imx93 adc support
Date:   Mon, 19 Dec 2022 18:13:34 +0800
Message-Id: <20221219101336.3929570-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219101336.3929570-1-haibo.chen@nxp.com>
References: <20221219101336.3929570-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: c01e0f86-303c-4e44-8dd1-08dae1a9b299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NNarH1/B/G50+8ZiPSdBR76gaQuJsw1FHgJaRjEJjF7eIcDnqvcD1LBW7Zd325fy/8lGnQb0AX2CO2dMzh6x6Dqr+oY2ct1iOcPvYKZcU1fguoEbJ86ffmMH9g+3oi5z8ak25TXm5WuZguK5f77/jXxI9M3nw5OpfRTG+8e6bim6kX/caau0q2d5V+2FcQzNycA+T3U0C8lw1UgydinM3jMX6nWKlygsxxeFBySa2dtsNRoClPdbf0cYuHJH0eiXrkTTeHJVU26J+NQ2gIUXyZoGNxbgLNrtI1S0bnfDWm1iUHehBFuX1hTnkzKuqmZduBDHiVs4Mhk+0SXc8XBjCJLsOlawBWopgynHBH65HTBxXV0+gZEDTfs7VQMvCtEu21z0EIEiQqwJ/Amun4cOq+WHje4buXaiBcp/SRcA+ngVkfbvQRDnEBmBj3FCyFZSvu8YFR2jos7jcR4mCrCsjYDj0K9nIMqLgDZnd0e7fY+JrGpkheh7cCKXBp+59yPFLYhbUjOKJM++5WoHpWZ7jTw8MAS3TzkMn03svJqCndPv4SdkkvXAbO8uub/M0FAd2Cg9PmEoPlVDGlaqFW2WH0tJjRBjp2lwwxrP7114g4K8BVYZ8fbd/s2WDG+6YtUx7lwVOsywH4sybjdI2JwS7qMbv1l2dYn+3bLdq+Na6KsRpQlsuDTuXBD/pT3olS1gByjlQbdEcl+S0l5RfT+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(66556008)(38350700002)(41300700001)(7416002)(66476007)(66946007)(30864003)(8676002)(86362001)(8936002)(6512007)(36756003)(52116002)(26005)(2906002)(478600001)(6666004)(4326008)(186003)(2616005)(83380400001)(1076003)(6506007)(316002)(38100700002)(5660300002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qoV59v8usOfbPywGlKQ0z0wejafysxB+dXpEmlKGusb2ErpDmq2yLV0mzXw?=
 =?us-ascii?Q?uSoUOVvgaTByx40/JredxIsmdyLihCzn7XV0q5fh6L/s2/aWeAzUb/46CE9G?=
 =?us-ascii?Q?rNev2gZ3tX1oly6XmLK40/I1dPI1EJ8U3lWzRIDp/NDfM69Vjz5h/QrbzBq0?=
 =?us-ascii?Q?tLsOd0pbBnAmFn47RMHktdU0JBbvvjsga41XnY2jBK14HZd4qOdfAbEdBS5m?=
 =?us-ascii?Q?Wbtq9H4iXdEeaGFeG533wYYljZ7efKLR12JbYYetg4r4JsgvgPjm4cmFkwDE?=
 =?us-ascii?Q?yq5vAzXYwix5vn1kfEdmLG2uWNJA84zpyaM8+JXbMOd7R9hhobX1EGhr9RzQ?=
 =?us-ascii?Q?MdzgkNYLf64rn8a8FiRQC5LwjB4bRpl8FgIgzuaNWBTJlm5dPJo0cE/nQ8YP?=
 =?us-ascii?Q?CWeofehZKND60KwmOvXGhAMxehfQKQKU2iDzrNoRsA6ZDXl0v7KYIB5EQm1G?=
 =?us-ascii?Q?pleJloTkbB4beQ2nSMyWpi8ZvTeYhWYApcsTh9iNIsewODUqzP3H/xtKLla+?=
 =?us-ascii?Q?/S8dqulxry/iMoaBrUE0n8Cx9BZ6yBurNfGnIUilcFgLjMsM7Gc6W/hZkYVN?=
 =?us-ascii?Q?C+s7CkYd4ZaBO75QUGGqsv5TjBqXy5trEyemE/g9ywXEXSgrtEe1vw1zWIJK?=
 =?us-ascii?Q?JiD1k8j2mdm1AcG1APqDWKLh0O3yeRTccIsLWquY8o+nkLm0/dzTExhs4MzN?=
 =?us-ascii?Q?q2dZ1rv8nUn+9ib9IUn1nfCHTRCR4UzPFZFULsveQPF/EMD3srBV31BNnKWA?=
 =?us-ascii?Q?AhU9f5F8i4kl8yVpZZXFQkfN0SKbsdYHQ53Gjj2+wA/4KY8jFuzo7bPtTYX9?=
 =?us-ascii?Q?LEfDsTwpX8vCQFmM5JlasdAuPhno8An+KDnpcjYDDswEXwN4GEon22pxo3P4?=
 =?us-ascii?Q?1ztwxS4DVgx4hY1bAqb5XAfeMJZ1RigTN3lnXIoh27SdWFpKsvLV6T9GZBXx?=
 =?us-ascii?Q?7dKylleQGg2WcAL9cqbVFdfkGQauR6Bnq18BoXfVQ5dbss4kYp5MqmJD8gnu?=
 =?us-ascii?Q?FZzfPrx3dfDDYgBQmagvw4dgsHk78qeshGTfzzrEy1DufcDduh63yZDU0J4B?=
 =?us-ascii?Q?rGSUUVejTshxJMA1xECpNYoMGC9bkTfG6czhiRn6XLMKbLhX0jHRA+UTDQpk?=
 =?us-ascii?Q?q6KmMWypk0vRbKyz1knTnFDAwFyY1MjFvKKo9Q700zPl+eL2G/jRc0sfSiSh?=
 =?us-ascii?Q?EE7hqs68ExmpG/30rqm4cx5bVsV6q8ZLUh4NFoCadMs9sg6SwMj1RxpZ+DIQ?=
 =?us-ascii?Q?SP24OP4Pp5aCKri3hvOpGyG2XunC1kEOiRqmXHcTseAA8jUjSYiaFQAfgq+3?=
 =?us-ascii?Q?gxnq1xaPdfzGvAOf4WiCBCSlvQquVM1B+7tWyaW1F03PwWI1BX85ISjaYy4L?=
 =?us-ascii?Q?a+Q71hJXh6Ow2MeucDbf2qQtTiDKO1GuIAsR7fNCj7lI54OjLweZfiOgnyV/?=
 =?us-ascii?Q?wOW2V6B3oI7PcgDeMIrTMUjvNDVpHz26IqjQDj4nYEnaONIwAgVJZUYHj8gm?=
 =?us-ascii?Q?uQCNMjiLZNIYr2RGlYyvJA1IroRkAxJL9IcZvGdr9RPVAsxCojlfcwlOWsEz?=
 =?us-ascii?Q?gP0fvGbrF76blVexaJKPbQKZFeVY7LYPtC5ioJqO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e0f86-303c-4e44-8dd1-08dae1a9b299
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 10:13:39.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14oei8KHeo6aENk0V5nMCTD0ydcx21Oekf8jBDH7dFgz/2H6XVhJvz4lQVi8UDii2NLJ2FGclwUE0eroWbMOFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The ADC in i.mx93 is a total new ADC IP, add a driver to support
this ADC.

Currently, only support one shot normal conversion triggered by
software. For other mode, will add in future.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 MAINTAINERS                 |   4 +-
 drivers/iio/adc/Kconfig     |  10 +
 drivers/iio/adc/Makefile    |   1 +
 drivers/iio/adc/imx93_adc.c | 474 ++++++++++++++++++++++++++++++++++++
 4 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/imx93_adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 30e032abd196..37431a02cd60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15020,14 +15020,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 F:	drivers/iio/adc/imx8qxp-adc.c
 
-NXP i.MX 7D/6SX/6UL AND VF610 ADC DRIVER
+NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	linux-iio@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
 F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
+F:	Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 F:	drivers/iio/adc/imx7d_adc.c
+F:	drivers/iio/adc/imx93_adc.c
 F:	drivers/iio/adc/vf610_adc.c
 
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 46c4fc2fc534..4fc826f52b8c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -565,6 +565,16 @@ config IMX8QXP_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called imx8qxp-adc.
 
+config IMX93_ADC
+	tristate "IMX93 ADC driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for IMX93 ADC.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called imx93_adc.
+
 config LP8788_ADC
 	tristate "LP8788 ADC driver"
 	depends on MFD_LP8788
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 6e08415c3f3a..df8c0f26307d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
+obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
new file mode 100644
index 000000000000..3ea16a70e746
--- /dev/null
+++ b/drivers/iio/adc/imx93_adc.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP i.MX93 ADC driver
+ *
+ * Copyright 2022 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#define IMX93_ADC_DRIVER_NAME	"imx93-adc"
+
+/* Register map definition */
+#define IMX93_ADC_MCR		0x00
+#define IMX93_ADC_MSR		0x04
+#define IMX93_ADC_ISR		0x10
+#define IMX93_ADC_IMR		0x20
+#define IMX93_ADC_CIMR0		0x24
+#define IMX93_ADC_CTR0		0x94
+#define IMX93_ADC_NCMR0		0xA4
+#define IMX93_ADC_PCDR0		0x100
+#define IMX93_ADC_PCDR1		0x104
+#define IMX93_ADC_PCDR2		0x108
+#define IMX93_ADC_PCDR3		0x10c
+#define IMX93_ADC_PCDR4		0x110
+#define IMX93_ADC_PCDR5		0x114
+#define IMX93_ADC_PCDR6		0x118
+#define IMX93_ADC_PCDR7		0x11c
+#define IMX93_ADC_CALSTAT	0x39C
+
+/* ADC bit shift */
+#define IMX93_ADC_MCR_MODE_MASK			BIT(29)
+#define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
+#define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
+#define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
+#define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
+#define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
+#define IMX93_ADC_MSR_CALBUSY_MASK		BIT(29)
+#define IMX93_ADC_MSR_ADCSTATUS_MASK		GENMASK(2, 0)
+#define IMX93_ADC_ISR_ECH_MASK			BIT(0)
+#define IMX93_ADC_ISR_EOC_MASK			BIT(1)
+#define IMX93_ADC_ISR_EOC_ECH_MASK		(IMX93_ADC_ISR_EOC_MASK | \
+						 IMX93_ADC_ISR_ECH_MASK)
+#define IMX93_ADC_IMR_JEOC_MASK			BIT(3)
+#define IMX93_ADC_IMR_JECH_MASK			BIT(2)
+#define IMX93_ADC_IMR_EOC_MASK			BIT(1)
+#define IMX93_ADC_IMR_ECH_MASK			BIT(0)
+#define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
+
+/* ADC status */
+#define IMX93_ADC_IDLE			0
+#define IMX93_ADC_POWER_DOWN		1
+#define IMX93_ADC_WAIT_STATE		2
+#define IMX93_ADC_BUSY_IN_CALIBRATION	3
+#define IMX93_ADC_SAMPLE		4
+#define IMX93_ADC_CONVERSION		6
+
+#define IMX93_ADC_TIMEOUT		msecs_to_jiffies(100)
+
+struct imx93_adc {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *ipg_clk;
+	int irq;
+	struct regulator *vref;
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
+	struct completion completion;
+};
+
+#define IMX93_ADC_CHAN(_idx) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static const struct iio_chan_spec imx93_adc_iio_channels[] = {
+	IMX93_ADC_CHAN(0),
+	IMX93_ADC_CHAN(1),
+	IMX93_ADC_CHAN(2),
+	IMX93_ADC_CHAN(3),
+};
+
+static void imx93_adc_power_down(struct imx93_adc *adc)
+{
+	u32 mcr, msr;
+	int ret;
+
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
+		((msr & IMX93_ADC_MSR_ADCSTATUS_MASK) == IMX93_ADC_POWER_DOWN), 1, 50);
+	if (ret == -ETIMEDOUT)
+		dev_warn(adc->dev,
+			 "ADC do not in power down mode, current MSR is %x\n",
+			 msr);
+}
+
+static void imx93_adc_power_up(struct imx93_adc *adc)
+{
+	u32 mcr;
+
+	/* bring ADC out of power down state, in idle state */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+}
+
+static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
+{
+	u32 mcr;
+
+	/* put adc in power down mode */
+	imx93_adc_power_down(adc);
+
+	/* config the AD_CLK equal to bus clock */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	imx93_adc_power_up(adc);
+}
+
+static int imx93_adc_calibration(struct imx93_adc *adc)
+{
+	u32 mcr, msr;
+	int ret;
+
+	/* make sure ADC in power down mode */
+	imx93_adc_power_down(adc);
+
+	/* config SAR controller operating clock */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	imx93_adc_power_up(adc);
+
+	/*
+	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
+	 * can add the setting of these bit if need in future.
+	 */
+
+	/* run calibration */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_CALSTART_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/* wait calibration to be finished */
+	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
+		!(msr & IMX93_ADC_MSR_CALBUSY_MASK), 1000, 2000000);
+	if (ret == -ETIMEDOUT) {
+		dev_warn(adc->dev, "ADC do not finish calibration in 1 min!\n");
+		return ret;
+	}
+
+	/* check whether calbration is success or not */
+	msr = readl(adc->regs + IMX93_ADC_MSR);
+	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+		dev_warn(adc->dev, "ADC calibration failed!\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int imx93_adc_read_channel_conversion(struct imx93_adc *adc,
+						int channel_number,
+						int *result)
+{
+	u32 channel;
+	u32 imr, mcr, pcda;
+	long ret;
+
+	reinit_completion(&adc->completion);
+
+	/* config channel mask register */
+	channel = 1 << channel_number;
+	writel(channel, adc->regs + IMX93_ADC_NCMR0);
+
+	/* TODO: can config desired sample time in CTRn if need */
+
+	/* config interrupt mask */
+	imr = FIELD_PREP(IMX93_ADC_IMR_EOC_MASK, 1);
+	writel(imr, adc->regs + IMX93_ADC_IMR);
+	writel(channel, adc->regs + IMX93_ADC_CIMR0);
+
+	/* config one-shot mode */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_MODE_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/* start normal conversion */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_NSTART_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	ret = wait_for_completion_interruptible_timeout(&adc->completion,
+							IMX93_ADC_TIMEOUT);
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	if (ret < 0)
+		return ret;
+
+	pcda = readl(adc->regs + IMX93_ADC_PCDR0 + channel_number * 4);
+
+	*result = FIELD_GET(IMX93_ADC_PCDR_CDATA_MASK, pcda);
+
+	return ret;
+}
+
+static int imx93_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+	long ret;
+	u32 vref_uv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&adc->lock);
+		ret = imx93_adc_read_channel_conversion(adc, chan->channel, val);
+		mutex_unlock(&adc->lock);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_sync_autosuspend(dev);
+		if (ret > 0)
+			return IIO_VAL_INT;
+		else
+			return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = vref_uv = regulator_get_voltage(adc->vref);
+		if (ret < 0)
+			return ret;
+		*val = vref_uv / 1000;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(adc->ipg_clk);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t imx93_adc_isr(int irq, void *dev_id)
+{
+	struct imx93_adc *adc = dev_id;
+	u32 isr, eoc, unexpected;
+
+	isr = readl(adc->regs + IMX93_ADC_ISR);
+
+	if (FIELD_GET(IMX93_ADC_ISR_EOC_ECH_MASK, isr)) {
+		eoc = isr & IMX93_ADC_ISR_EOC_ECH_MASK;
+		writel(eoc, adc->regs + IMX93_ADC_ISR);
+		complete(&adc->completion);
+	}
+
+	unexpected = isr & ~IMX93_ADC_ISR_EOC_ECH_MASK;
+	if (unexpected) {
+		writel(unexpected, adc->regs + IMX93_ADC_ISR);
+		dev_err(adc->dev, "Unexpected interrupt 0x%08x.\n", unexpected);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info imx93_adc_iio_info = {
+	.read_raw = &imx93_adc_read_raw,
+};
+
+static int imx93_adc_probe(struct platform_device *pdev)
+{
+	struct imx93_adc *adc;
+	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev) {
+		dev_err(dev, "Failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	adc = iio_priv(indio_dev);
+	adc->dev = dev;
+
+	mutex_init(&adc->lock);
+	adc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adc->regs))
+		return PTR_ERR(adc->regs);
+
+	/* The third irq is for ADC conversion usage */
+	adc->irq = platform_get_irq(pdev, 2);
+	if (adc->irq < 0)
+		return adc->irq;
+
+	adc->ipg_clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(adc->ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(adc->ipg_clk),
+				     "Failed getting clock.\n");
+
+	adc->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(adc->vref))
+		return dev_err_probe(dev, PTR_ERR(adc->vref),
+				     "Failed getting reference voltage.\n");
+
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev, "Can't enable adc reference top voltage.\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&adc->completion);
+
+	indio_dev->name = IMX93_ADC_DRIVER_NAME;
+	indio_dev->info = &imx93_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = imx93_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(imx93_adc_iio_channels);
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not prepare or enable the clock.\n");
+		goto error_regulator_disable;
+	}
+
+	ret = request_irq(adc->irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);
+	if (ret < 0) {
+		dev_err(dev, "Failed requesting irq, irq = %d\n", adc->irq);
+		goto error_ipg_clk_disable;
+	}
+
+	ret = imx93_adc_calibration(adc);
+	if (ret < 0)
+		goto error_free_adc_irq;
+
+	imx93_adc_config_ad_clk(adc);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "Couldn't register the device.\n");
+		goto error_free_adc_irq;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+error_free_adc_irq:
+	free_irq(adc->irq, adc);
+error_ipg_clk_disable:
+	clk_disable_unprepare(adc->ipg_clk);
+error_regulator_disable:
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static int imx93_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	/* adc power down need clock on */
+	pm_runtime_get_sync(dev);
+	imx93_adc_power_down(adc);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	iio_device_unregister(indio_dev);
+	free_irq(adc->irq, adc);
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static int imx93_adc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+
+	imx93_adc_power_down(adc);
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static int imx93_adc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev,
+			"Can't enable adc reference top voltage, err = %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable clock.\n");
+		goto err_disable_reg;
+	}
+
+	imx93_adc_power_up(adc);
+
+	return 0;
+
+err_disable_reg:
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx93_adc_pm_ops,
+				 imx93_adc_runtime_suspend,
+				 imx93_adc_runtime_resume, NULL);
+
+static const struct of_device_id imx93_adc_match[] = {
+	{ .compatible = "nxp,imx93-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx93_adc_match);
+
+static struct platform_driver imx93_adc_driver = {
+	.probe		= imx93_adc_probe,
+	.remove		= imx93_adc_remove,
+	.driver		= {
+		.name	= IMX93_ADC_DRIVER_NAME,
+		.of_match_table = imx93_adc_match,
+		.pm	= pm_ptr(&imx93_adc_pm_ops),
+	},
+};
+
+module_platform_driver(imx93_adc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX93 ADC driver");
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1

