Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853E66DF6E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjAQNxJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 08:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjAQNwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 08:52:50 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC6F3BDA6;
        Tue, 17 Jan 2023 05:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN2M2CK0v3H3K+HsHriTlhzKOK75PDqqAN+HF2QT2T14WPPkBvo/gqN6MLUlYO67UvuPyE3M3+4pe5Jz/vHZALKduqF3mldtC7TbRmORTunx5ayrvGF3Vo+konExSgZwXnOSXK08IAroircUZIOmQATOeKad1kesv+m6vjnhiVHjlzwtfMMl5XUU/mT1U9CBO9KNelaWxIILqKSYs16VZdiVJf6Ktze+GR4zT0DDUbYypqx+FIxSOoxGBtv4JZ1Ljf3eKiNdqxNXEu2LnHoJztrAmnTzGnX4oP5SYdmNYdSsMdXmDYCaJXSAzFcKVH38J8dvzDF/yF8IsKMaQPPQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6o46xZb36OyUJXG+I7j5Jf+aUrYcnwdHYAVhjIMHbI=;
 b=Tc6PDsaeUHv5Gz3NXqwC/fRa//04zyh9edmNiXavWzf9rjHP/lYpO0qsd3koZeoM6RnQI3MpVNobVW6ojX4WZ3uREPIt2AveJ2KjCd/8JoYEGySe+kc2x+5oa/+0ITDGBAjEXOAWtLghvVleZKh2hUDJWNnwTPQrhiI4FovnjX+s8cIvbblZ408jZvHY21Sm38TmcGpqsQrwgzyPZmGqoa4rgOTiVNGdinlea9TU+M7MxTPcxd56E5oTiWFqviEwW8AArwBs5MCur9e7BJc1y6SMrCc3oS5iHw/iiwZMoklEAS35C8bnmn+f6Zk7q/G8VzXZGuYAQsDlBy9pzL8TuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6o46xZb36OyUJXG+I7j5Jf+aUrYcnwdHYAVhjIMHbI=;
 b=I2ooudVnYQAp1T3lm0ebQ6FRfcrTHFhcXT2Gi4fkaQfISZL9j8ZMmGK/8ZRgC9+jQP0onay4rJBxXFlB1sd71MwkID0wMGOKlUU+7oh1igb/nxg6N91HdwVfLgLASQhh/MFzHEb4gnYWFRHfRCX/DxzdS4hs7jRhfPsp3xcNahY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:51:18 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:51:18 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v6 1/3] iio: adc: add imx93 adc support
Date:   Tue, 17 Jan 2023 21:51:35 +0800
Message-Id: <20230117135137.1735536-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117135137.1735536-1-haibo.chen@nxp.com>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: b76cc42b-c04d-405f-cbeb-08daf891e84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74+a07wRDjd6CYK33V6xfeu3Vt5B29NlMgyJi4EIieXfoocNTLH9A0GANHFIsY166+XKY5OHZ71/WJGV89YClC5qZZSo6fqXKiPRJbt/ezHISMf5jmkBRFoeoBDAWm1HY4EcrE28BP6BV0H0KFs2QJN15qmPd4yqwzD4LIC2gl78pCCutwdwJri5V8igu5O/N5GTfVemIgdEWa2qkG9F8xx8J3WzWroNp6t0vokJHapsvhxneUg3/Fzr90b+ylzKHpFaacQLHZ8X+ZbjTlLHfaNhDwKeaCzKz1WqF6NNNnaSwGvzsFcUhJLz60GfavCoi6Dc7Ihd3iBF6CDNqRBbiOyILPjg+Yra5GjDHrl1TOAzV9c3NC2VWXizwn+3dYRYOvJobO9M9Tq+pAVCw51gZUMoXhWp625hyDI7ZirKfOoZ9qxhz0lvtkuLxyenxwzmv1Jkg1r9ad1Po1RK8205MDeumzhuTWr1ugbsYmAJcvLSKJgFaryrnQ4AQZ16/NiChoFSd/jLRZfO0UfzzOFrjPWJo0HHhAerQw0YGInGxqZAjyKluzdPZY2JKzT8giEsxb2JVLJMpCTniFnj2Fv+DNszzmiEFrTBLrFEFh+9aZLq31Uo1rVbhFPLVwcWipRe6gYHC53d/90Sfopfx2wqfln+GqXNU7R2R1th/LE779SzzVB/ftpcpWFK4uQ3Qjk3R32JvBx/e6NbGqM6YvzdRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(86362001)(30864003)(66946007)(66556008)(8936002)(8676002)(66476007)(7416002)(2906002)(4326008)(38100700002)(83380400001)(5660300002)(38350700002)(316002)(6666004)(6486002)(52116002)(41300700001)(478600001)(2616005)(6512007)(1076003)(9686003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gTuxsj5E10NPfyKVioHcwF+Yl5585wrblHsyQtff/sKX/LavgKJmgTiGNltA?=
 =?us-ascii?Q?x2oYIqgRlEYl8QxkjNivFwj2WfOvG9YEZjJmuMRo+GvbnofyWhC6+KiwUOmv?=
 =?us-ascii?Q?4kqBV+WWpcBL/1En1Hqo/OX/igk41PkTSMHmJslFzT8cX9Kh70ZA8EzW04nn?=
 =?us-ascii?Q?qk1dn+xFHkAQfDJ/lwYHti2G79ZCHG8azQyhhpCWlIZjHdZnKzy65b0gliOC?=
 =?us-ascii?Q?aIQTagEmFgDXRKuGsvyTuOE7IphqF1hfxp3kLAEuPNn/aSjfsNxLpujOIhSr?=
 =?us-ascii?Q?OfPvYZxBY9DsNVM6evXbXm4I6ffSugPdrhWt/tPDlL1ot40ckjZxEb36rtnP?=
 =?us-ascii?Q?3xUAcjP+HhQKKOgCHzEf4v7p6NE3fzf+RUdoqcpeddAhHlG+s+kZrBAADO5K?=
 =?us-ascii?Q?4sqkMEcHeDfkS61sboKIDU951YfQa1QDVAnOZRS0XRnqaaVNi+ecCc31xnZQ?=
 =?us-ascii?Q?f8+oi16McegZoc15gL3Mt/Zc+LPAmQe0A8noYTlsphhVYg00OJwOB9ZhQHoq?=
 =?us-ascii?Q?P+d5EluR+nnlcURMLUSU7eta+4glw3ze8x0lIAqzt2OVOOKHaiuQ2xx8Aceg?=
 =?us-ascii?Q?K9dKytLeBIH6xeXjxuQj0TsXWu56xEzAUGTJGmZfyNCeUX74ecJwrzJBS1LM?=
 =?us-ascii?Q?rY3AqzYusrmESP+DzW8ro5IIDCYo1sRv7i2nUOrauTr8q1pdEYr6B4plC331?=
 =?us-ascii?Q?iLN5D9tEkEXdUASIXcZaIqB/F1M/YjjhxZhxqlABQwsRZkiCEzsXdBsCw9Ym?=
 =?us-ascii?Q?dK9Krnmtkgje+xlfpqrAtuxsILLaVoi2x0kDn+GRUsP6fwuB/aQuOJ1sAIBi?=
 =?us-ascii?Q?MfhGWVfXtYNU9t0KC+mob1WSQM+Vvl3aJUE6rZMenFsu+8Beqswem4QH+/B7?=
 =?us-ascii?Q?ZAvxE6A+/2oN9Eo8ad2j3Kcys3c3TcMhERnMVKrDYwdJQvJYZq8PHFJTJ1EY?=
 =?us-ascii?Q?cm9ERmKM4a5VTPPTC8LdXAS1xEsdjoXlYepQRHHt0armCvKXg82m0TApH8In?=
 =?us-ascii?Q?l5pb/ae+nxxNwczMfnq2jkgwMo09fv6unv30MrhEgPMxDgpgIwFtEkClyO3m?=
 =?us-ascii?Q?KlesqGA+p0Tr+iwYewmcu9TznjAhiXd48EH+tshfrxYMOGt62r9AcjcNpf0J?=
 =?us-ascii?Q?5sHLwl/OWZ8Q6yBjyFYhVTNTNYUtcVVwQEz3BN9UGzpN7XzPhBLTYtpBje78?=
 =?us-ascii?Q?RoBxgYorPYr4h5+GfDAl3/yQiJb/3neaeLazN1S08ugj0lgeeYc4KWS7GpAA?=
 =?us-ascii?Q?CIyi6weAfoTYrobhfrA9HdpKCwV7cyTtmdk+UKM2Z/ZaL2jl+Zl/sqCadVFC?=
 =?us-ascii?Q?9xPvt2UbEm0bjOY0QrF+3XgdlPzRnxNVaLHjcjcnYLzgY5xxyAfTKmS2d00n?=
 =?us-ascii?Q?fT/fNNOXIrkun2sz7S+I0AD4hQG+W1CkP1OiAktY5uGK/Ly8xq4g1CJgodNn?=
 =?us-ascii?Q?h0SKE8Btplygj3B8loLy/inRSJXfYjmJRsWipn9C6Pjblk9fDOld2rHdL2ex?=
 =?us-ascii?Q?OiEq61AWzx7W895g+X3y7RVjDFv2SQZ++L0jmiF1jI0JSBAOvygBWfj947V1?=
 =?us-ascii?Q?y5A9IGTAUf2DmB0ulUyej5QtmmGxRj05jZ/LkCbS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76cc42b-c04d-405f-cbeb-08daf891e84a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:51:18.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BblGIz7AWFrCWKMurYL8jzv1vrqCFTarLQLI7rOlfIYfmNRRwHR+xajBDJwnuQpHWClCXiCe8+bJvu7vW9fa1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
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
 drivers/iio/adc/imx93_adc.c | 484 ++++++++++++++++++++++++++++++++++++
 4 files changed, 498 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/imx93_adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 31ffd4b4e90a..0a9e1da216a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14870,14 +14870,16 @@ S:	Maintained
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
index 1b990bd658e1..af4785dae2ef 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -566,6 +566,16 @@ config IMX8QXP_ADC
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
index 000000000000..d8de8284e13d
--- /dev/null
+++ b/drivers/iio/adc/imx93_adc.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP i.MX93 ADC driver
+ *
+ * Copyright 2023 NXP
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
+		dev_warn(adc->dev, "ADC do not finish calibration in 2 min!\n");
+		imx93_adc_power_down(adc);
+		return ret;
+	}
+
+	/* check whether calbration is success or not */
+	msr = readl(adc->regs + IMX93_ADC_MSR);
+	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+		dev_warn(adc->dev, "ADC calibration failed!\n");
+		imx93_adc_power_down(adc);
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
+		goto error_adc_power_down;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+error_adc_power_down:
+	imx93_adc_power_down(adc);
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
+
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+
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

