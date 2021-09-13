Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53234085AB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhIMHwq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 03:52:46 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:39882 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbhIMHwq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 03:52:46 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18D7VLpP004719;
        Mon, 13 Sep 2021 15:31:21 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Sep
 2021 15:51:06 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: [v6 04/11] iio: adc: aspeed: Use model_data to set clk scaler.
Date:   Mon, 13 Sep 2021 15:53:30 +0800
Message-ID: <20210913075337.19991-5-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913075337.19991-1-billy_tsai@aspeedtech.com>
References: <20210913075337.19991-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18D7VLpP004719
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch uses need_prescaler and scaler_bit_width to set the ADC clock
scaler.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 43 ++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index aec335956310..e53d1541ad1d 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -210,9 +210,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct aspeed_adc_data *data;
-	const char *clk_parent_name;
 	int ret;
 	u32 adc_engine_control_reg_val;
+	unsigned long scaler_flags = 0;
+	char clk_name[32], clk_parent_name[32];
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
 	if (!indio_dev)
@@ -229,24 +230,32 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
-	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
-
-	data->clk_prescaler = clk_hw_register_divider(
-				&pdev->dev, "prescaler", clk_parent_name, 0,
-				data->base + ASPEED_REG_CLOCK_CONTROL,
-				17, 15, 0, &data->clk_lock);
-	if (IS_ERR(data->clk_prescaler))
-		return PTR_ERR(data->clk_prescaler);
-
+	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
+		 of_clk_get_parent_name(pdev->dev.of_node, 0));
+
+	if (data->model_data->need_prescaler) {
+		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",
+			 data->model_data->model_name);
+		data->clk_prescaler = clk_hw_register_divider(
+			&pdev->dev, clk_name, clk_parent_name, 0,
+			data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
+			&data->clk_lock);
+		if (IS_ERR(data->clk_prescaler))
+			return PTR_ERR(data->clk_prescaler);
+		snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name),
+			 clk_name);
+		scaler_flags = CLK_SET_RATE_PARENT;
+	}
 	/*
 	 * Register ADC clock scaler downstream from the prescaler. Allow rate
 	 * setting to adjust the prescaler as well.
 	 */
+	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-scaler",
+		 data->model_data->model_name);
 	data->clk_scaler = clk_hw_register_divider(
-				&pdev->dev, "scaler", "prescaler",
-				CLK_SET_RATE_PARENT,
-				data->base + ASPEED_REG_CLOCK_CONTROL,
-				0, 10, 0, &data->clk_lock);
+		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
+		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
+		data->model_data->scaler_bit_width, 0, &data->clk_lock);
 	if (IS_ERR(data->clk_scaler)) {
 		ret = PTR_ERR(data->clk_scaler);
 		goto scaler_error;
@@ -318,7 +327,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 reset_error:
 	clk_hw_unregister_divider(data->clk_scaler);
 scaler_error:
-	clk_hw_unregister_divider(data->clk_prescaler);
+	if (data->model_data->need_prescaler)
+		clk_hw_unregister_divider(data->clk_prescaler);
 	return ret;
 }
 
@@ -333,7 +343,8 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->clk_scaler->clk);
 	reset_control_assert(data->rst);
 	clk_hw_unregister_divider(data->clk_scaler);
-	clk_hw_unregister_divider(data->clk_prescaler);
+	if (data->model_data->need_prescaler)
+		clk_hw_unregister_divider(data->clk_prescaler);
 
 	return 0;
 }
-- 
2.25.1

