Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188613ED251
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhHPKtp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 06:49:45 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:24939 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhHPKto (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 06:49:44 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17GAUOsM044052;
        Mon, 16 Aug 2021 18:30:24 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 Aug
 2021 18:48:29 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 11/15] iio: adc: aspeed: Fix the calculate error of clock.
Date:   Mon, 16 Aug 2021 18:48:42 +0800
Message-ID: <20210816104846.13155-12-billy_tsai@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 17GAUOsM044052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The adc clcok formula is
ast2400/2500:
ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
ast2600:
ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
They all have one fixed divided 2 and the legacy driver didn't handle it.
This patch register the fixed factory clock device as the parent of adc
clock scaler to fix this issue.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index ea3e9a52fcc9..8fe7da1a651f 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -4,6 +4,12 @@
  *
  * Copyright (C) 2017 Google, Inc.
  * Copyright (C) 2021 Aspeed Technology Inc.
+ *
+ * ADC clock formula:
+ * Ast2400/Ast2500:
+ * clock period = period of PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
+ * Ast2600:
+ * clock period = period of PCLK * 2 * (ADC0C[15:0] + 1)
  */
 
 #include <linux/clk.h>
@@ -77,6 +83,7 @@ struct aspeed_adc_data {
 	struct regulator	*regulator;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
+	struct clk_hw		*fixed_div_clk;
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
@@ -196,6 +203,13 @@ static void aspeed_adc_unregister_divider(void *data)
 	clk_hw_unregister_divider(clk);
 }
 
+static void aspeed_adc_unregister_fixed_divider(void *data)
+{
+	struct clk_hw *clk = data;
+
+	clk_hw_unregister_fixed_factor(clk);
+}
+
 static void aspeed_adc_reset_assert(void *data)
 {
 	struct reset_control *rst = data;
@@ -312,6 +326,18 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
 	snprintf(clk_parent_name, 32, of_clk_get_parent_name(pdev->dev.of_node, 0));
+	snprintf(clk_name, 32, "%s-fixed-div", data->model_data->model_name);
+	data->fixed_div_clk = clk_hw_register_fixed_factor(
+		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
+	if (IS_ERR(data->fixed_div_clk))
+		return PTR_ERR(data->fixed_div_clk);
+
+	ret = devm_add_action_or_reset(data->dev,
+				       aspeed_adc_unregister_fixed_divider,
+				       data->clk_prescaler);
+	if (ret)
+		return ret;
+	snprintf(clk_parent_name, 32, clk_name);
 	if (data->model_data->need_prescaler) {
 		snprintf(clk_name, 32, "%s-prescaler",
 			 data->model_data->model_name);
-- 
2.25.1

