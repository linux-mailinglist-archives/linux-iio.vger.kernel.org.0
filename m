Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9F3ED243
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhHPKtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 06:49:05 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:55456 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhHPKtF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 06:49:05 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17GAUMO6044039;
        Mon, 16 Aug 2021 18:30:22 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 Aug
 2021 18:48:27 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 02/15] iio: adc: aspeed: completes the bitfield declare.
Date:   Mon, 16 Aug 2021 18:48:33 +0800
Message-ID: <20210816104846.13155-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816104846.13155-1-billy_tsai@aspeedtech.com>
References: <20210816104846.13155-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17GAUMO6044039
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch completes the declare of adc register bitfields and uses the
same prefix ASPEED_ADC_* for these bitfields.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 56 +++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 19efaa41bc34..7010d56ac3b9 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -3,6 +3,7 @@
  * Aspeed AST2400/2500 ADC
  *
  * Copyright (C) 2017 Google, Inc.
+ * Copyright (C) 2021 Aspeed Technology Inc.
  */
 
 #include <linux/clk.h>
@@ -16,6 +17,7 @@
 #include <linux/reset.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
@@ -28,15 +30,31 @@
 #define ASPEED_REG_INTERRUPT_CONTROL	0x04
 #define ASPEED_REG_VGA_DETECT_CONTROL	0x08
 #define ASPEED_REG_CLOCK_CONTROL	0x0C
-#define ASPEED_REG_MAX			0xC0
-
-#define ASPEED_OPERATION_MODE_POWER_DOWN	(0x0 << 1)
-#define ASPEED_OPERATION_MODE_STANDBY		(0x1 << 1)
-#define ASPEED_OPERATION_MODE_NORMAL		(0x7 << 1)
-
-#define ASPEED_ENGINE_ENABLE		BIT(0)
-
-#define ASPEED_ADC_CTRL_INIT_RDY	BIT(8)
+#define ASPEED_REG_COMPENSATION_TRIM	0xC4
+#define ASPEED_REG_MAX			0xCC
+
+#define ASPEED_ADC_ENGINE_ENABLE		BIT(0)
+#define ASPEED_ADC_OP_MODE			GENMASK(3, 1)
+#define ASPEED_ADC_OP_MODE_PWR_DOWN		0
+#define ASPEED_ADC_OP_MODE_STANDBY		1
+#define ASPEED_ADC_OP_MODE_NORMAL		7
+#define ASPEED_ADC_CTRL_COMPENSATION		BIT(4)
+#define ASPEED_ADC_AUTO_COMPENSATION		BIT(5)
+#define ASPEED_ADC_REF_VOLTAGE			GENMASK(7, 6)
+#define ASPEED_ADC_REF_VOLTAGE_2500mV		0
+#define ASPEED_ADC_REF_VOLTAGE_1200mV		1
+#define ASPEED_ADC_REF_VOLTAGE_EXT_HIGH		2
+#define ASPEED_ADC_REF_VOLTAGE_EXT_LOW		3
+#define ASPEED_ADC_BAT_SENSING_DIV		BIT(6)
+#define ASPEED_ADC_BAT_SENSING_DIV_2_3		0
+#define ASPEED_ADC_BAT_SENSING_DIV_1_3		1
+#define ASPEED_ADC_CTRL_INIT_RDY		BIT(8)
+#define ASPEED_ADC_CH7_MODE			BIT(12)
+#define ASPEED_ADC_CH7_NORMAL			0
+#define ASPEED_ADC_CH7_BAT			1
+#define ASPEED_ADC_BAT_SENSING_ENABLE		BIT(13)
+#define ASPEED_ADC_CTRL_CHANNEL			GENMASK(31, 16)
+#define ASPEED_ADC_CTRL_CHANNEL_ENABLE(ch)	FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, BIT(ch))
 
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
@@ -226,7 +244,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 	if (model_data->wait_init_sequence) {
 		/* Enable engine in normal mode. */
-		writel(ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE,
+		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
+				  ASPEED_ADC_OP_MODE_NORMAL) |
+			       ASPEED_ADC_ENGINE_ENABLE,
 		       data->base + ASPEED_REG_ENGINE_CONTROL);
 
 		/* Wait for initial sequence complete. */
@@ -245,10 +265,12 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_enable_error;
 
-	adc_engine_control_reg_val = GENMASK(31, 16) |
-		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
+	adc_engine_control_reg_val =
+		ASPEED_ADC_CTRL_CHANNEL |
+		FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
+		ASPEED_ADC_ENGINE_ENABLE;
 	writel(adc_engine_control_reg_val,
-		data->base + ASPEED_REG_ENGINE_CONTROL);
+	       data->base + ASPEED_REG_ENGINE_CONTROL);
 
 	model_data = of_device_get_match_data(&pdev->dev);
 	indio_dev->name = model_data->model_name;
@@ -264,8 +286,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	return 0;
 
 iio_register_error:
-	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
-		data->base + ASPEED_REG_ENGINE_CONTROL);
+	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
+	       data->base + ASPEED_REG_ENGINE_CONTROL);
 	clk_disable_unprepare(data->clk_scaler->clk);
 clk_enable_error:
 poll_timeout_error:
@@ -283,8 +305,8 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
-		data->base + ASPEED_REG_ENGINE_CONTROL);
+	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
+	       data->base + ASPEED_REG_ENGINE_CONTROL);
 	clk_disable_unprepare(data->clk_scaler->clk);
 	reset_control_assert(data->rst);
 	clk_hw_unregister_divider(data->clk_scaler);
-- 
2.25.1

