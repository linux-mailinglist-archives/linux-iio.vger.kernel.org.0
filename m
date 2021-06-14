Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F043A65BC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhFNLmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234717AbhFNLhc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0888661360;
        Mon, 14 Jun 2021 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670434;
        bh=6vWq4Yh1ITlaNUbxjiGykgH0QdzkC1dErOw5pvgfbF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2uD1abu9HZHHq3ash2/zsMZYd5o49w7u9Q9jZ2S/i4wstafvZGfh5abWoQpiIkhQ
         9FpkBk02yIjg/zD+Gnrx4zW8/c9Nxhb3gTyT1Np5MGoeR1vR260vnAKVPePOoGwWxa
         Y2aroNDytHHeNLEDaIHEtbnC1ey7T1KeN/818JFpWwHW+8cKqcrHwp9yI04/KBKLLL
         ckQZRZl5yaS7Pw5OAJHtDkfGrxndQNRNicpwbapkNNzJex7GgZaglmtAtZJ9WccT6f
         dC5r8weoOqlxdsYUtrKM8qjMT/HwItSacWFNhWh7wO9RPrJkg+3yfrdUinsc+vaZ/M
         vf0d4Qs56Igrw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/17] staging:iio:adc:ad7280a: Use device properties to replace platform data.
Date:   Mon, 14 Jun 2021 12:35:04 +0100
Message-Id: <20210614113507.897732-15-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index acaae1b33986..0806238debe3 100644
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
+#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
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
@@ -932,14 +937,8 @@ static const struct iio_info ad7280_info_no_irq = {
 	.write_event_value = &ad7280a_write_thresh,
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
@@ -954,17 +953,90 @@ static int ad7280_probe(struct spi_device *spi)
 	st->spi = spi;
 	mutex_init(&st->lock);
 
-	if (!pdata)
-		pdata = &ad7793_default_pdata;
+	st->thermistor_term_en =
+		device_property_read_bool(dev, "adi,thermistor-termination");
+
+	if (device_property_present(dev, "adi,acquistion-time-ns")) {
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
+		u8 val;
 
+		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);
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
+		u8 val;
+
+		ret = device_property_read_u8(dev, "adi,temp-alert-last-chan", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 3:
+			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX4_AUX5;
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
@@ -975,7 +1047,6 @@ static int ad7280_probe(struct spi_device *spi)
 	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
 	st->cell_threshhigh = 0xFF;
 	st->aux_threshhigh = 0xFF;
-	st->acquisition_time = pdata->acquisition_time;
 
 	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
 	if (ret)
@@ -1002,7 +1073,8 @@ static int ad7280_probe(struct spi_device *spi)
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
2.32.0

