Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89B63FBACB
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhH3RWs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:22:48 -0400
Received: from mx20.baidu.com ([111.202.115.85]:33494 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237976AbhH3RWq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 13:22:46 -0400
Received: from BJHW-MAIL-EX04.internal.baidu.com (unknown [10.127.64.14])
        by Forcepoint Email with ESMTPS id 4C2DF96757A6066B6F37;
        Tue, 31 Aug 2021 01:21:50 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 31 Aug 2021 01:21:50 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 31 Aug 2021 01:21:49 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH 1/6] iio: adc: Init the driver for NXP i.MX8QuadXPlus
Date:   Tue, 31 Aug 2021 01:21:35 +0800
Message-ID: <20210830172140.414-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830172140.414-1-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. This patch init
this ADC driver.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/adc/imx8qxp-adc.c | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
new file mode 100644
index 000000000000..aec1b45c8fb9
--- /dev/null
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP i.MX8QXP ADC driver
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/sysfs.h>
+
+#define ADC_DRIVER_NAME		"imx8qxp-adc"
+
+static int imx8qxp_adc_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx8qxp_adc_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx8qxp_adc_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int imx8qxp_adc_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops imx8qxp_adc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx8qxp_adc_runtime_suspend, imx8qxp_adc_runtime_resume, NULL)
+};
+
+static const struct of_device_id imx8qxp_adc_match[] = {
+	{ .compatible = "nxp,imx8qxp-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
+
+static struct platform_driver imx8qxp_adc_driver = {
+	.probe		= imx8qxp_adc_probe,
+	.remove		= imx8qxp_adc_remove,
+	.driver		= {
+		.name	= ADC_DRIVER_NAME,
+		.of_match_table = imx8qxp_adc_match,
+		.pm	= &imx8qxp_adc_pm_ops,
+	},
+};
+
+module_platform_driver(imx8qxp_adc_driver);
+
+MODULE_DESCRIPTION("i.MX8QuadXPlus ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

