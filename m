Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AC4AB181
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbiBFS54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiBFS5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE43C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D5CBB80E63
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CC0C340F0;
        Sun,  6 Feb 2022 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173872;
        bh=jbkgdYPqg908iu+nevjb7o40CAfWnwc5B6Dpql+cC+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8r7lrcx2qzMjAgLimY/pphBn+oEzuisncXlvehqq+rfuMufnkDM+fjYXG1zOpx+j
         iseHDCwBcxMRVGiUV3BnivigOml/iERslV3XMH+fvv3egGuZYWHe6X9xiymOEbuBE/
         2GpaW6QDC/vJKi/K149QTFl4sGvhKdAPNmXjBvsMVW6N6Hta6qO4Ob3GIikE4Pmb49
         7CB6o4u0gXtXKx9EZIwe+ucYsG/UFYdP7EftvQ4YdwnFPjZA56BxnC5FX4X9GA4N8X
         ZYC8WAMcDPMCZ5OcTIWetv8utqynZde3JQR/2zHicZoN6quRF9E7ZtN23tK74pZT8e
         fAeVGZORaZsSA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 14/20] staging:iio:adc:ad7280a: Use device properties to replace platform data.
Date:   Sun,  6 Feb 2022 19:03:22 +0000
Message-Id: <20220206190328.333093-15-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Convert all the device specific info that was previously in platform data
over to generic firmware query interfaces.

dt-bindings to follow shortly.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 100 +++++++++++++++++++++++++-----
 drivers/staging/iio/adc/ad7280a.h |  31 ---------
 2 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index df4a03f42c7a..e8c9f22971cb 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -23,8 +23,6 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
-#include "ad7280a.h"
-
 /* Registers */
 
 #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
@@ -81,6 +79,11 @@
 #define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
 
 #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
+#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
+#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
+#define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)
+#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
+#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
 #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
 #define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
 
@@ -163,6 +166,8 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
 struct ad7280_state {
 	struct spi_device		*spi;
 	struct iio_chan_spec		*channels;
+	unsigned int			chain_last_alert_ignore;
+	bool				thermistor_term_en;
 	int				slave_num;
 	int				scan_cnt;
 	int				readback_delay_us;
@@ -947,14 +952,8 @@ static const struct iio_info ad7280_info_no_irq = {
 	.write_raw = ad7280_write_raw,
 };
 
-static const struct ad7280_platform_data ad7793_default_pdata = {
-	.acquisition_time = AD7280A_ACQ_TIME_400ns,
-	.thermistor_term_en = true,
-};
-
 static int ad7280_probe(struct spi_device *spi)
 {
-	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct device *dev = &spi->dev;
 	struct ad7280_state *st;
 	int ret;
@@ -969,17 +968,90 @@ static int ad7280_probe(struct spi_device *spi)
 	st->spi = spi;
 	mutex_init(&st->lock);
 
-	if (!pdata)
-		pdata = &ad7793_default_pdata;
+	st->thermistor_term_en =
+		device_property_read_bool(dev, "adi,thermistor-termination");
+
+	if (device_property_present(dev, "adi,acquisition-time-ns")) {
+		u32 val;
+
+		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 400:
+			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
+			break;
+		case 800:
+			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
+			break;
+		case 1200:
+			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
+			break;
+		case 1600:
+			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
+			break;
+		default:
+			dev_err(dev, "Firmware provided acquisition time is invalid\n");
+			return -EINVAL;
+		}
+	} else {
+		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
+	}
+
+	/* Alert masks are intended for when particular inputs are not wired up */
+	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
+		u32 val;
 
+		ret = device_property_read_u32(dev, "adi,voltage-alert-last-chan", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 3:
+			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN4_VIN5;
+			break;
+		case 4:
+			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN5;
+			break;
+		case 5:
+			break;
+		default:
+			dev_err(dev,
+				"Firmware provided last voltage alert channel invalid\n");
+			break;
+		}
+	}
+	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
+		u32 val;
+
+		ret = device_property_read_u32(dev, "adi,temp-alert-last-chan", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 3:
+			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX3_AUX5;
+			break;
+		case 4:
+			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
+			break;
+		case 5:
+			break;
+		default:
+			dev_err(dev,
+				"Firmware provided last temp alert channel invalid\n");
+			break;
+		}
+	}
 	crc8_populate_msb(st->crc_tab, POLYNOM);
 
 	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
 	st->spi->mode = SPI_MODE_1;
 	spi_setup(st->spi);
 
-	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
-		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);
+	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
+		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
 	st->oversampling_ratio = 0; /* No oversampling */
 
 	ret = ad7280_chain_setup(st);
@@ -990,7 +1062,6 @@ static int ad7280_probe(struct spi_device *spi)
 	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
 	st->cell_threshhigh = 0xFF;
 	st->aux_threshhigh = 0xFF;
-	st->acquisition_time = pdata->acquisition_time;
 
 	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
 	if (ret)
@@ -1017,7 +1088,8 @@ static int ad7280_probe(struct spi_device *spi)
 		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
 				   AD7280A_ALERT_REG, 0,
 				   AD7280A_ALERT_GEN_STATIC_HIGH |
-				   (pdata->chain_last_alert_ignore & 0xF));
+				   FIELD_PREP(AD7280A_ALERT_REMOVE_MSK,
+					      st->chain_last_alert_ignore));
 		if (ret)
 			return ret;
 
diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
deleted file mode 100644
index 99297789a46d..000000000000
--- a/drivers/staging/iio/adc/ad7280a.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AD7280A Lithium Ion Battery Monitoring System
- *
- * Copyright 2011 Analog Devices Inc.
- */
-
-#ifndef IIO_ADC_AD7280_H_
-#define IIO_ADC_AD7280_H_
-
-/*
- * TODO: struct ad7280_platform_data needs to go into include/linux/iio
- */
-
-#define AD7280A_ACQ_TIME_400ns			0
-#define AD7280A_ACQ_TIME_800ns			1
-#define AD7280A_ACQ_TIME_1200ns			2
-#define AD7280A_ACQ_TIME_1600ns			3
-
-#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
-#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
-#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
-#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
-
-struct ad7280_platform_data {
-	unsigned int		acquisition_time;
-	unsigned int		chain_last_alert_ignore;
-	bool			thermistor_term_en;
-};
-
-#endif /* IIO_ADC_AD7280_H_ */
-- 
2.35.1

