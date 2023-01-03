Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842C65BF3C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jan 2023 12:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbjACLoH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Jan 2023 06:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbjACLna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2023 06:43:30 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D42A5;
        Tue,  3 Jan 2023 03:43:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaZEfq4zTKfsVt6co+NpMj5OHPcTGeL4pi30tsToMTTXj3AHSsbRa4MqUg9lLsmnSMvYAq9I+OZNbBZv+l9sW6H6dpYGH7uNdPE+pZ/g8u1M7k6Biard4NOJMdAzfVojtpjILTrYTSl2OmFX2vRDYLB51ZaY+NewgSUdtUySuHKDDNeIszEB2wsMAK0cbTjgkHeQIrUd0QSJWrGhdYLgG0R4/5kVuNMdBaePe9hyAIhZYabyUUePeRhVnOaoNt39sDPm4gDKD/wfBlEIWgnTYH2hEJ4RwULWcqHLvH5a8MWeXRMwoiGf0bMjPpvkyxPRSFnTlQ7F81aOzNtMw7m5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op8zeHcBdxDraHZvpXmZDA1F79/E6YPSzeLYvYFVLes=;
 b=i5t03SrrUo/gz/hRiC17Y5zj8rlDbykZxGCCduQK4a8KT+W9bn7x6emQF3/vJXw9H4Qn0dURX9YqTak9QyKEt3/q4XqpoZfsesqB7eaW+B96CjhJ9/DV24UeV2tFwvtkox8LhTG0Ng3B2SZBJAhsJ4uDRCWZ9eJ+OcwDJma/qVS8b+zBxpYOoRzAoqMURwf8FA9Fv5BDfGEf47oWU49Ugh3ctwMju8eIPgO8hoOCZDJ3sqTEWYDKIkGxYPWak0ToHKXZZpo7W4yVmUDym4b88wommtIJgBUYcCPZ5+vLfLYBbLMgTinuhpjfw6ztSreYuRs8tKxBOTzC84NmE4Nq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op8zeHcBdxDraHZvpXmZDA1F79/E6YPSzeLYvYFVLes=;
 b=p0ThTZieVEKeTzl4Dbpsod6algUIYjXlh+r6duyUos1zRlRFNky087qzRQDWmzz2Gg08R3mWUWr4Wk/lfYiOgRcqHStd+aQUSRFH80e+RkV+6brl4uxIXtSq5xeUrIVIaNBdwWF+QqOgvcPK2ykm2L6sGM9nccIjHkjKjcT6bUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:43:20 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:43:20 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/3] iio: adc: add imx93 adc support
Date:   Tue,  3 Jan 2023 19:43:56 +0800
Message-Id: <20230103114359.2663262-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103114359.2663262-1-haibo.chen@nxp.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: f5325ab3-759d-45e6-ba41-08daed7fb612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iswMUIS+XWC2qpHB5apu+g3sYnuBCGli8xadfNizQHnVHVqpgfwKTBgZ9fD/wQJ0yxI3n5LzCi88S9CKVNRR3R29V5lyk7RfjkN8Rxy6mri69CVe+2nduP1QnQUAH6v7jyBuMtIxD8GpfePDa9AoQt88gk2Mq7T9BbnU+PRISnHQbpes7ENAkigSZtQFeJag0CU2MsRGjjEyKdf5l+FCGMAclzSVDfOMhsgBe5opBVi2zrp7fZi3vUyxyAHArR21Uvyl2x7CqkRVRoWQ30gdB2vZLeVkeI5MwgS1zy0+IsntsqxF/1/PkvcD/r9O8z+Q4rVqocEOzV26ZHoobmKKdz0KCkmZo1k8qlWe8TtBtkixTGYWBeWBzOHt9UCC571M2ZNT7vloupt/viDJ2rT8suSjr75EpNWfymSSIVxQxwg+BsHA+K2FSOHb8gn3rxJPYxPM38LracnkfeymdE4oFVr3awXfMEqlYaAEXMSIciTS6QSwwdEAJYIXyq9KZarxyGonxcSqEYL7tWWnykkTXCKpKNfZw3JXZNaXdAU2h7tCThkHsp5PrB+jmPHsLafRhwULlZ4hQfQvexZV/VDIK2k+GIoDdpMwcsKNaBLpRPeHtzYfNojnf7kr2TWF5/t02GcaIXKY4KKeAEzpsfffpnqPslgRHV7aAXwPju35bfYMbe917fjMYrn+CmNvjjBpY/FnGZxsCrP33Gyr6D/T142xyRnfynFKqUMqoBXrwPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6512007)(9686003)(26005)(52116002)(6666004)(186003)(2906002)(6506007)(478600001)(6486002)(66556008)(66946007)(1076003)(66476007)(2616005)(4326008)(8676002)(41300700001)(316002)(83380400001)(5660300002)(7416002)(30864003)(36756003)(38350700002)(38100700002)(8936002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DoD5ZxKjQeEepRRZ2kG3v0895Op+uaHt+IbqG8281GUlnh0RbngtAdM0FsF2?=
 =?us-ascii?Q?/huTS1I8KhmQr+xVFnI041NuoIZtNVjUQw3Yfpw1ioKAOeK2IdKkdNFTarK2?=
 =?us-ascii?Q?3S6l/CHIUcZvIikZ61VNgZynNcdSiFFHoIcX7+Ty5XBlNS2Ftcrb8HjrBwyM?=
 =?us-ascii?Q?TpTJXhpPOh7qmIunDvapFuxlNm7X8m6lTRLWMHRHn3JgD7+Rc/8Oio7gFUjc?=
 =?us-ascii?Q?YHSfBF479i5Y4ecDmJP4xKI8eMLryDGze3hdtQ0V0u37N2Bldd8AIfL0EswK?=
 =?us-ascii?Q?1IcmFaT/83in6UVmUHpi23yheRYUQKukFvtoC8bYc7lh/eeAVcPm/PdDR5hx?=
 =?us-ascii?Q?OVP0TR3NHaJRzhiyRdIf5rsEYoaeK7Kmw8GSl4rGXnytvv0Zjl/WlfloES4Z?=
 =?us-ascii?Q?V/gDyY9M9lwLwE36E/Q62KJy77fzr/cyrEBym+MR8b5uHntDjMH7DJ55/VNp?=
 =?us-ascii?Q?FajjbjAGj1Kv+NwSxAksoT8SI4oEgSpnOePXGFNyJai28uQzqbc+RtUbAvxf?=
 =?us-ascii?Q?Ej+EHa2QmGqAlRQnbWGJEaW/inC76Z5YWbBl342AIQhp5lS6FYcYPUjusEdI?=
 =?us-ascii?Q?2ub2twSChjICnPM63lLCwcaHE9+k6kceW4YSkYUPi0rDU05i4NYrau4t2Ib9?=
 =?us-ascii?Q?MeZOrcOYrN3km899DXk9eCPflGoofTsW1XTehzdfpDtLh3H42rPxGQLsATxY?=
 =?us-ascii?Q?FwtG4X6B5vJtMXPllxCsxJS8i2esw+xFoHTyw3I7/qUUBDLH8ZhFvEfpC7M/?=
 =?us-ascii?Q?uECN/2ZbSx7Hy1bJYUU1n8OpRQzblanw4HnNcbJv3B0SmvkcdwqvRLTF/rtz?=
 =?us-ascii?Q?0WNLaDZwNBNL4/9c7xIxX8J86SHl8qdtNFwGmV3+6Fev1F/8RHRHhArLaCls?=
 =?us-ascii?Q?gzMPpScQiKoQpejrMKPRYwL8Q9DQtswu9cMIjhLtuda9KUtFUHArM8IuUhuO?=
 =?us-ascii?Q?Ih7MtcD4ZfFA5PGuoZNFoFwAlvK5cYL5NvpknlUL8iXU7IMcVYll+ONGZ5x7?=
 =?us-ascii?Q?BHUKzEGLJOq/B05+w/Gu4IsuAbvY20E6QK+K2oky5dpcl7UNXb+yCtjaWReD?=
 =?us-ascii?Q?pad2EYVpVvVLmYRqaU7vd2a2bm77W0ceGl8Og/fgAiWbJBR0rCDzFolq18rs?=
 =?us-ascii?Q?Wb7+xXdNUxeBytuDqa+EcDYaLDoN3SbfmFJgul/1y0WAQ3ANSi+ZrVdzyMI/?=
 =?us-ascii?Q?2whEftCPGDi2H3iKfVS3s7365qmBR8O7GA+BNNKZyFxKcIgW9NWOlEHDAzee?=
 =?us-ascii?Q?bwrCaiPF1KYnqQx4UIIB5AR8QcXraX5SXQWkhqEIz9UdUVikULanQ6g8U9Kj?=
 =?us-ascii?Q?Iy4Xd+NrlOzQIx2KpVYwT7bp4Pt37QhyvjNxZosZDL5oKjw/AGIKmTB/oVXD?=
 =?us-ascii?Q?nBPzaW4Jd+aZjzz9wgDJKp8Y7xHXIPvnJdcIvwCpS4ppVYSphd4qz8aI1aQ5?=
 =?us-ascii?Q?VjVODsmLvoSTDEzPNSUvuOZLnHrdmsuBclFBrdg3T8VPhOv11LiwdZ3/uTdO?=
 =?us-ascii?Q?3w4Zkh4XBGOzSfp4hfXqOsrl2dEXQRjXj0yc4svc4Gu8JcTHraXenjCUiSA0?=
 =?us-ascii?Q?+UpHOi/Xov39Bjh45sag/J8TXbhURsNfGwKc9I7T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5325ab3-759d-45e6-ba41-08daed7fb612
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:43:20.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOo7rq6OuBYWUxzibDP+NHp8KRr22RFSWMVdXzXBAVp+Ci8weErPOF2rT82IQJPbbpmipj2FSD+IKCY+OdTIOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
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
 drivers/iio/adc/imx93_adc.c | 477 ++++++++++++++++++++++++++++++++++++
 4 files changed, 491 insertions(+), 1 deletion(-)
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
index 000000000000..0c98de438919
--- /dev/null
+++ b/drivers/iio/adc/imx93_adc.c
@@ -0,0 +1,477 @@
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
+#define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
+#define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
+#define IMX93_ADC_MSR_ADCSTATUS_WAIT_STATE		2
+#define IMX93_ADC_MSR_ADCSTATUS_BUSY_IN_CALIBRATION	3
+#define IMX93_ADC_MSR_ADCSTATUS_SAMPLE			4
+#define IMX93_ADC_MSR_ADCSTATUS_CONVERSION		6
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
+				 ((msr & IMX93_ADC_MSR_ADCSTATUS_MASK) ==
+				  IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN),
+				 1, 50);
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
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
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
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed allocating iio device\n");
+
+	adc = iio_priv(indio_dev);
+	adc->dev = dev;
+
+	mutex_init(&adc->lock);
+	adc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adc->regs))
+		return dev_err_probe(dev, PTR_ERR(adc->regs),
+				     "Failed geting ioremap resource\n");
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
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable reference voltage.\n");
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&adc->completion);
+
+	indio_dev->name = "imx93-adc";
+	indio_dev->info = &imx93_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = imx93_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(imx93_adc_iio_channels);
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err_probe(dev, ret,
+			      "Failed to enable ipg clock.\n");
+		goto error_regulator_disable;
+	}
+
+	ret = request_irq(adc->irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);
+	if (ret < 0) {
+		dev_err_probe(dev, ret,
+			      "Failed requesting irq, irq = %d\n", adc->irq);
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
+		dev_err_probe(dev, ret,
+			      "Failed to register this iio device.\n");
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
+	imx93_adc_power_down(adc);
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
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+	iio_device_unregister(indio_dev);
+	imx93_adc_power_down(adc);
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

