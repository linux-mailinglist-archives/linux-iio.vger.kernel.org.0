Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77302B66FB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgKQOH5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:07:57 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33721 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgKQOH4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:07:56 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2E96B100010;
        Tue, 17 Nov 2020 14:07:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 02/11] iio: adc: at91_adc: rework resolution selection
Date:   Tue, 17 Nov 2020 15:06:47 +0100
Message-Id: <20201117140656.1235055-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move the possible resolution values back to the driver. This removes the
atmel,adc-res and atmel,adc-res-names properties, leaving only
atmel,adc-use-res. As atmel,adc-res-names had to contain "lowres" and
"highres", those where already the only allowed values for
atmel,adc-use-res.

Also introduce a new compatible string for the sama5d3 as this is the only
one with a different resolution. Also it doesn't even have the LOWRES
bit.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 97 ++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 62bd35af8b13..0d67c812ef3d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -204,6 +204,9 @@ struct at91_adc_caps {
 	u32 (*calc_startup_ticks)(u32 startup_time, u32 adc_clk_khz);
 
 	u8	num_channels;
+
+	u8	low_res_bits;
+	u8	high_res_bits;
 	struct at91_adc_reg_desc registers;
 };
 
@@ -229,7 +232,6 @@ struct at91_adc_state {
 	bool			use_external;
 	u32			vref_mv;
 	u32			res;		/* resolution used for convertions */
-	bool			low_res;	/* the resolution corresponds to the lowest one */
 	wait_queue_head_t	wq_data_avail;
 	struct at91_adc_caps	*caps;
 
@@ -754,58 +756,6 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 }
 
-static int at91_adc_of_get_resolution(struct iio_dev *idev,
-				      struct platform_device *pdev)
-{
-	struct at91_adc_state *st = iio_priv(idev);
-	struct device_node *np = pdev->dev.of_node;
-	int count, i, ret = 0;
-	char *res_name, *s;
-	u32 *resolutions;
-
-	count = of_property_count_strings(np, "atmel,adc-res-names");
-	if (count < 2) {
-		dev_err(&idev->dev, "You must specified at least two resolution names for "
-				    "adc-res-names property in the DT\n");
-		return count;
-	}
-
-	resolutions = kmalloc_array(count, sizeof(*resolutions), GFP_KERNEL);
-	if (!resolutions)
-		return -ENOMEM;
-
-	if (of_property_read_u32_array(np, "atmel,adc-res", resolutions, count)) {
-		dev_err(&idev->dev, "Missing adc-res property in the DT.\n");
-		ret = -ENODEV;
-		goto ret;
-	}
-
-	if (of_property_read_string(np, "atmel,adc-use-res", (const char **)&res_name))
-		res_name = "highres";
-
-	for (i = 0; i < count; i++) {
-		if (of_property_read_string_index(np, "atmel,adc-res-names", i, (const char **)&s))
-			continue;
-
-		if (strcmp(res_name, s))
-			continue;
-
-		st->res = resolutions[i];
-		if (!strcmp(res_name, "lowres"))
-			st->low_res = true;
-		else
-			st->low_res = false;
-
-		dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
-		goto ret;
-	}
-
-	dev_err(&idev->dev, "There is no resolution for %s\n", res_name);
-
-ret:
-	kfree(resolutions);
-	return ret;
-}
 
 static u32 calc_startup_ticks_9260(u32 startup_time, u32 adc_clk_khz)
 {
@@ -891,6 +841,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 	struct device_node *trig_node;
 	int i = 0, ret;
 	u32 prop;
+	char *s;
 
 	st->caps = (struct at91_adc_caps *)
 		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
@@ -924,9 +875,13 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 	}
 	st->vref_mv = prop;
 
-	ret = at91_adc_of_get_resolution(idev, pdev);
-	if (ret)
-		goto error_ret;
+	st->res = st->caps->high_res_bits;
+	if (st->caps->low_res_bits &&
+	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
+	    && !strcmp(s, "lowres"))
+		st->res = st->caps->low_res_bits;
+
+	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
 
 	st->registers = &st->caps->registers;
 	st->num_channels = st->caps->num_channels;
@@ -1248,7 +1203,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	reg = AT91_ADC_PRESCAL_(prsc) & st->registers->mr_prescal_mask;
 	reg |= AT91_ADC_STARTUP_(ticks) & st->registers->mr_startup_mask;
-	if (st->low_res)
+	if (st->res == st->caps->low_res_bits)
 		reg |= AT91_ADC_LOWRES;
 	if (st->sleep_mode)
 		reg |= AT91_ADC_SLEEP;
@@ -1363,6 +1318,8 @@ static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 static struct at91_adc_caps at91sam9260_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9260,
 	.num_channels = 4,
+	.low_res_bits = 8,
+	.high_res_bits = 10,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -1377,6 +1334,8 @@ static struct at91_adc_caps at91sam9rl_caps = {
 	.has_ts = true,
 	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
 	.num_channels = 6,
+	.low_res_bits = 8,
+	.high_res_bits = 10,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -1391,6 +1350,8 @@ static struct at91_adc_caps at91sam9g45_caps = {
 	.has_ts = true,
 	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
 	.num_channels = 8,
+	.low_res_bits = 8,
+	.high_res_bits = 10,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -1408,6 +1369,8 @@ static struct at91_adc_caps at91sam9x5_caps = {
 	.ts_pen_detect_sensitivity = 2,
 	.calc_startup_ticks = calc_startup_ticks_9x5,
 	.num_channels = 12,
+	.low_res_bits = 8,
+	.high_res_bits = 10,
 	.registers = {
 		.channel_base = AT91_ADC_CDR0_9X5,
 		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
@@ -1419,11 +1382,31 @@ static struct at91_adc_caps at91sam9x5_caps = {
 	},
 };
 
+static struct at91_adc_caps sama5d3_caps = {
+	.has_ts = true,
+	.has_tsmr = true,
+	.ts_filter_average = 3,
+	.ts_pen_detect_sensitivity = 2,
+	.calc_startup_ticks = calc_startup_ticks_9x5,
+	.num_channels = 12,
+	.low_res_bits = 0,
+	.high_res_bits = 12,
+	.registers = {
+		.channel_base = AT91_ADC_CDR0_9X5,
+		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
+		.status_register = AT91_ADC_SR_9X5,
+		.trigger_register = AT91_ADC_TRGR_9X5,
+		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
+		.mr_startup_mask = AT91_ADC_STARTUP_9X5,
+	},
+};
+
 static const struct of_device_id at91_adc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-adc", .data = &at91sam9260_caps },
 	{ .compatible = "atmel,at91sam9rl-adc", .data = &at91sam9rl_caps },
 	{ .compatible = "atmel,at91sam9g45-adc", .data = &at91sam9g45_caps },
 	{ .compatible = "atmel,at91sam9x5-adc", .data = &at91sam9x5_caps },
+	{ .compatible = "atmel,sama5d3-adc", .data = &sama5d3_caps },
 	{},
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
-- 
2.28.0

