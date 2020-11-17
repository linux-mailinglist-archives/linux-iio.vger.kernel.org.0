Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923942B671A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbgKQOIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:08:40 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:7327 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbgKQOIG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:08:06 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C64EF24001C;
        Tue, 17 Nov 2020 14:08:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 07/11] iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
Date:   Tue, 17 Nov 2020 15:06:52 +0100
Message-Id: <20201117140656.1235055-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

at91_adc_probe_dt is now small enough to be merged back in at91_adc_probe.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 117 ++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 83539422b704..347464844263 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -833,70 +833,6 @@ static int at91_adc_probe_dt_ts(struct device_node *node,
 	}
 }
 
-static int at91_adc_probe_dt(struct iio_dev *idev,
-			     struct platform_device *pdev)
-{
-	struct at91_adc_state *st = iio_priv(idev);
-	struct device_node *node = pdev->dev.of_node;
-	int ret;
-	u32 prop;
-	char *s;
-
-	st->caps = (struct at91_adc_caps *)
-		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
-
-	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
-
-	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
-		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->channels_mask = prop;
-
-	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
-
-	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
-		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->startup_time = prop;
-
-	prop = 0;
-	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
-	st->sample_hold_time = prop;
-
-	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
-		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->vref_mv = prop;
-
-	st->res = st->caps->high_res_bits;
-	if (st->caps->low_res_bits &&
-	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
-	    && !strcmp(s, "lowres"))
-		st->res = st->caps->low_res_bits;
-
-	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
-
-	st->registers = &st->caps->registers;
-	st->num_channels = st->caps->num_channels;
-
-	/* Check if touchscreen is supported. */
-	if (st->caps->has_ts)
-		return at91_adc_probe_dt_ts(node, st, &idev->dev);
-	else
-		dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");
-
-	return 0;
-
-error_ret:
-	return ret;
-}
-
 static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 };
@@ -1062,10 +998,12 @@ static void at91_ts_unregister(struct at91_adc_state *st)
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
+	struct device_node *node = pdev->dev.of_node;
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
-	u32 reg;
+	u32 reg, prop;
+	char *s;
 
 	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
 	if (!idev)
@@ -1073,9 +1011,52 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(idev);
 
-	ret = at91_adc_probe_dt(idev, pdev);
-	if (ret)
-		return ret;
+	st->caps = (struct at91_adc_caps *)
+		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
+
+	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
+
+	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
+		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
+		return -EINVAL;
+	}
+	st->channels_mask = prop;
+
+	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
+
+	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
+		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
+		return -EINVAL;
+	}
+	st->startup_time = prop;
+
+	prop = 0;
+	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
+	st->sample_hold_time = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
+		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
+		return -EINVAL;
+	}
+	st->vref_mv = prop;
+
+	st->res = st->caps->high_res_bits;
+	if (st->caps->low_res_bits &&
+	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
+	    && !strcmp(s, "lowres"))
+		st->res = st->caps->low_res_bits;
+
+	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
+
+	st->registers = &st->caps->registers;
+	st->num_channels = st->caps->num_channels;
+
+	/* Check if touchscreen is supported. */
+	if (st->caps->has_ts) {
+		ret = at91_adc_probe_dt_ts(node, st, &idev->dev);
+		if (ret)
+			return ret;
+	}
 
 	platform_set_drvdata(pdev, idev);
 
-- 
2.28.0

