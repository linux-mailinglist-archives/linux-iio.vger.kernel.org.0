Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEB468C32
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhLERAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbhLERAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4853C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35BFD61115
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DFBC341C5;
        Sun,  5 Dec 2021 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723398;
        bh=+8f85jLbOhFUqgQTauDyss+tX7C7YtBntci6KJtnays=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2LzPXa9xxoXJ2WhsN5+YEMb96YL0mGSUwDQJbtzjdyrRx9x/6We7ft5oZjy3gDSc
         MZQn9+h/OumAz68vFRJpSjVG+E0JmNZB0KFhJmnSAcqsTdiR6vPVMAlubdcCr/uvMn
         kcOuMFUZ0L5JvO5XQPj5VJGL8yfalkix3xOYIa6j2sa9iksx/zO6i2E1jj19itPMu8
         VKW3xvBR/9HrVRO3CyjwyCLpoWN2fgybQKAXPUaF1VmCJRTkNaSQxAJ98YJBWKoWiK
         qQmkdzRe9GRwXMu4xf8Jm4pUJbgNmfJZZtqlWVt3JHOKu2oCdYiAerL7If1gjQ+64e
         Mk/M52m2IjuFw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/12] iio:dac:ad5755: Switch to generic firmware properties and drop pdata
Date:   Sun,  5 Dec 2021 17:01:29 +0000
Message-Id: <20211205170140.2783914-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Lars pointed out that platform data can also be supported via the
generic properties interface, so there is no point in continuing to
support it separately.  Hence squish the linux/platform_data/ad5755.h
header into the c file and drop accessing the platform data directly.

Done by inspection only.  Mostly completely mechanical with the
exception of a few places where default value handling is
cleaner done by first setting the value, then calling the
firmware reading function but and not checking the return value,
as opposed to reading firmware then setting the default if an error
occurs.

Part of general attempt to move all of IIO over to generic
device properties, both to enable other firmware types and
to remove drivers that can be the source of of_ specific
behaviour in new drivers.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

v3: Moved dev_fwnode() check into _parse_fw() as it allows simplification
of handling at call site.

 drivers/iio/dac/ad5755.c             | 152 ++++++++++++++++++++-------
 include/linux/platform_data/ad5755.h | 102 ------------------
 2 files changed, 116 insertions(+), 138 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index cabc38d54085..7a62e6e1d5f1 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -13,10 +13,10 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/property.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/platform_data/ad5755.h>
 
 #define AD5755_NUM_CHANNELS 4
 
@@ -63,6 +63,101 @@
 #define AD5755_SLEW_RATE_SHIFT			3
 #define AD5755_SLEW_ENABLE			BIT(12)
 
+enum ad5755_mode {
+	AD5755_MODE_VOLTAGE_0V_5V		= 0,
+	AD5755_MODE_VOLTAGE_0V_10V		= 1,
+	AD5755_MODE_VOLTAGE_PLUSMINUS_5V	= 2,
+	AD5755_MODE_VOLTAGE_PLUSMINUS_10V	= 3,
+	AD5755_MODE_CURRENT_4mA_20mA		= 4,
+	AD5755_MODE_CURRENT_0mA_20mA		= 5,
+	AD5755_MODE_CURRENT_0mA_24mA		= 6,
+};
+
+enum ad5755_dc_dc_phase {
+	AD5755_DC_DC_PHASE_ALL_SAME_EDGE		= 0,
+	AD5755_DC_DC_PHASE_A_B_SAME_EDGE_C_D_OPP_EDGE	= 1,
+	AD5755_DC_DC_PHASE_A_C_SAME_EDGE_B_D_OPP_EDGE	= 2,
+	AD5755_DC_DC_PHASE_90_DEGREE			= 3,
+};
+
+enum ad5755_dc_dc_freq {
+	AD5755_DC_DC_FREQ_250kHZ = 0,
+	AD5755_DC_DC_FREQ_410kHZ = 1,
+	AD5755_DC_DC_FREQ_650kHZ = 2,
+};
+
+enum ad5755_dc_dc_maxv {
+	AD5755_DC_DC_MAXV_23V	= 0,
+	AD5755_DC_DC_MAXV_24V5	= 1,
+	AD5755_DC_DC_MAXV_27V	= 2,
+	AD5755_DC_DC_MAXV_29V5	= 3,
+};
+
+enum ad5755_slew_rate {
+	AD5755_SLEW_RATE_64k	= 0,
+	AD5755_SLEW_RATE_32k	= 1,
+	AD5755_SLEW_RATE_16k	= 2,
+	AD5755_SLEW_RATE_8k	= 3,
+	AD5755_SLEW_RATE_4k	= 4,
+	AD5755_SLEW_RATE_2k	= 5,
+	AD5755_SLEW_RATE_1k	= 6,
+	AD5755_SLEW_RATE_500	= 7,
+	AD5755_SLEW_RATE_250	= 8,
+	AD5755_SLEW_RATE_125	= 9,
+	AD5755_SLEW_RATE_64	= 10,
+	AD5755_SLEW_RATE_32	= 11,
+	AD5755_SLEW_RATE_16	= 12,
+	AD5755_SLEW_RATE_8	= 13,
+	AD5755_SLEW_RATE_4	= 14,
+	AD5755_SLEW_RATE_0_5	= 15,
+};
+
+enum ad5755_slew_step_size {
+	AD5755_SLEW_STEP_SIZE_1 = 0,
+	AD5755_SLEW_STEP_SIZE_2 = 1,
+	AD5755_SLEW_STEP_SIZE_4 = 2,
+	AD5755_SLEW_STEP_SIZE_8 = 3,
+	AD5755_SLEW_STEP_SIZE_16 = 4,
+	AD5755_SLEW_STEP_SIZE_32 = 5,
+	AD5755_SLEW_STEP_SIZE_64 = 6,
+	AD5755_SLEW_STEP_SIZE_128 = 7,
+	AD5755_SLEW_STEP_SIZE_256 = 8,
+};
+
+/**
+ * struct ad5755_platform_data - AD5755 DAC driver platform data
+ * @ext_dc_dc_compenstation_resistor: Whether an external DC-DC converter
+ * compensation register is used.
+ * @dc_dc_phase: DC-DC converter phase.
+ * @dc_dc_freq: DC-DC converter frequency.
+ * @dc_dc_maxv: DC-DC maximum allowed boost voltage.
+ * @dac: Per DAC instance parameters.
+ * @dac.mode: The mode to be used for the DAC output.
+ * @dac.ext_current_sense_resistor: Whether an external current sense resistor
+ * is used.
+ * @dac.enable_voltage_overrange: Whether to enable 20% voltage output overrange.
+ * @dac.slew.enable: Whether to enable digital slew.
+ * @dac.slew.rate: Slew rate of the digital slew.
+ * @dac.slew.step_size: Slew step size of the digital slew.
+ **/
+struct ad5755_platform_data {
+	bool ext_dc_dc_compenstation_resistor;
+	enum ad5755_dc_dc_phase dc_dc_phase;
+	enum ad5755_dc_dc_freq dc_dc_freq;
+	enum ad5755_dc_dc_maxv dc_dc_maxv;
+
+	struct {
+		enum ad5755_mode mode;
+		bool ext_current_sense_resistor;
+		bool enable_voltage_overrange;
+		struct {
+			bool enable;
+			enum ad5755_slew_rate rate;
+			enum ad5755_slew_step_size step_size;
+		} slew;
+	} dac[4];
+};
+
 /**
  * struct ad5755_chip_info - chip specific information
  * @channel_template:	channel specification
@@ -111,7 +206,6 @@ enum ad5755_type {
 	ID_AD5737,
 };
 
-#ifdef CONFIG_OF
 static const int ad5755_dcdc_freq_table[][2] = {
 	{ 250000, AD5755_DC_DC_FREQ_250kHZ },
 	{ 410000, AD5755_DC_DC_FREQ_410kHZ },
@@ -154,7 +248,6 @@ static const int ad5755_slew_step_table[][2] = {
 	{ 2, AD5755_SLEW_STEP_SIZE_2 },
 	{ 1, AD5755_SLEW_STEP_SIZE_1 },
 };
-#endif
 
 static int ad5755_write_unlocked(struct iio_dev *indio_dev,
 	unsigned int reg, unsigned int val)
@@ -604,30 +697,29 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 	},
 };
 
-#ifdef CONFIG_OF
-static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
+static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
-	struct device_node *pp;
+	struct fwnode_handle *pp;
 	struct ad5755_platform_data *pdata;
 	unsigned int tmp;
 	unsigned int tmparray[3];
 	int devnr, i;
 
+	if (!dev_fwnode(dev))
+		return NULL;
+
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
 	pdata->ext_dc_dc_compenstation_resistor =
-	    of_property_read_bool(np, "adi,ext-dc-dc-compenstation-resistor");
+	    device_property_read_bool(dev, "adi,ext-dc-dc-compenstation-resistor");
 
-	if (!of_property_read_u32(np, "adi,dc-dc-phase", &tmp))
-		pdata->dc_dc_phase = tmp;
-	else
-		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+	pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+	device_property_read_u32(dev, "adi,dc-dc-phase", &pdata->dc_dc_phase);
 
 	pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
-	if (!of_property_read_u32(np, "adi,dc-dc-freq-hz", &tmp)) {
+	if (!device_property_read_u32(dev, "adi,dc-dc-freq-hz", &tmp)) {
 		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_freq_table); i++) {
 			if (tmp == ad5755_dcdc_freq_table[i][0]) {
 				pdata->dc_dc_freq = ad5755_dcdc_freq_table[i][1];
@@ -641,7 +733,7 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	}
 
 	pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
-	if (!of_property_read_u32(np, "adi,dc-dc-max-microvolt", &tmp)) {
+	if (!device_property_read_u32(dev, "adi,dc-dc-max-microvolt", &tmp)) {
 		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_maxv_table); i++) {
 			if (tmp == ad5755_dcdc_maxv_table[i][0]) {
 				pdata->dc_dc_maxv = ad5755_dcdc_maxv_table[i][1];
@@ -654,25 +746,23 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	}
 
 	devnr = 0;
-	for_each_child_of_node(np, pp) {
+	device_for_each_child_node(dev, pp) {
 		if (devnr >= AD5755_NUM_CHANNELS) {
 			dev_err(dev,
 				"There are too many channels defined in DT\n");
 			goto error_out;
 		}
 
-		if (!of_property_read_u32(pp, "adi,mode", &tmp))
-			pdata->dac[devnr].mode = tmp;
-		else
-			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+		pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+		fwnode_property_read_u32(pp, "adi,mode", &pdata->dac[devnr].mode);
 
 		pdata->dac[devnr].ext_current_sense_resistor =
-		    of_property_read_bool(pp, "adi,ext-current-sense-resistor");
+		    fwnode_property_read_bool(pp, "adi,ext-current-sense-resistor");
 
 		pdata->dac[devnr].enable_voltage_overrange =
-		    of_property_read_bool(pp, "adi,enable-voltage-overrange");
+		    fwnode_property_read_bool(pp, "adi,enable-voltage-overrange");
 
-		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
+		if (!fwnode_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
 			pdata->dac[devnr].slew.enable = tmparray[0];
 
 			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
@@ -715,18 +805,11 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	devm_kfree(dev, pdata);
 	return NULL;
 }
-#else
-static
-struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
-{
-	return NULL;
-}
-#endif
 
 static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
-	const struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
+	const struct ad5755_platform_data *pdata;
 	struct iio_dev *indio_dev;
 	struct ad5755_state *st;
 	int ret;
@@ -751,13 +834,10 @@ static int ad5755_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	if (spi->dev.of_node)
-		pdata = ad5755_parse_dt(&spi->dev);
-	else
-		pdata = spi->dev.platform_data;
 
+	pdata = ad5755_parse_fw(&spi->dev);
 	if (!pdata) {
-		dev_warn(&spi->dev, "no platform data? using default\n");
+		dev_warn(&spi->dev, "no firmware provided parameters? using default\n");
 		pdata = &ad5755_default_pdata;
 	}
 
diff --git a/include/linux/platform_data/ad5755.h b/include/linux/platform_data/ad5755.h
deleted file mode 100644
index e371e08f04bc..000000000000
--- a/include/linux/platform_data/ad5755.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2012 Analog Devices Inc.
- */
-#ifndef __LINUX_PLATFORM_DATA_AD5755_H__
-#define __LINUX_PLATFORM_DATA_AD5755_H__
-
-enum ad5755_mode {
-	AD5755_MODE_VOLTAGE_0V_5V		= 0,
-	AD5755_MODE_VOLTAGE_0V_10V		= 1,
-	AD5755_MODE_VOLTAGE_PLUSMINUS_5V	= 2,
-	AD5755_MODE_VOLTAGE_PLUSMINUS_10V	= 3,
-	AD5755_MODE_CURRENT_4mA_20mA		= 4,
-	AD5755_MODE_CURRENT_0mA_20mA		= 5,
-	AD5755_MODE_CURRENT_0mA_24mA		= 6,
-};
-
-enum ad5755_dc_dc_phase {
-	AD5755_DC_DC_PHASE_ALL_SAME_EDGE		= 0,
-	AD5755_DC_DC_PHASE_A_B_SAME_EDGE_C_D_OPP_EDGE	= 1,
-	AD5755_DC_DC_PHASE_A_C_SAME_EDGE_B_D_OPP_EDGE	= 2,
-	AD5755_DC_DC_PHASE_90_DEGREE			= 3,
-};
-
-enum ad5755_dc_dc_freq {
-	AD5755_DC_DC_FREQ_250kHZ = 0,
-	AD5755_DC_DC_FREQ_410kHZ = 1,
-	AD5755_DC_DC_FREQ_650kHZ = 2,
-};
-
-enum ad5755_dc_dc_maxv {
-	AD5755_DC_DC_MAXV_23V	= 0,
-	AD5755_DC_DC_MAXV_24V5	= 1,
-	AD5755_DC_DC_MAXV_27V	= 2,
-	AD5755_DC_DC_MAXV_29V5	= 3,
-};
-
-enum ad5755_slew_rate {
-	AD5755_SLEW_RATE_64k	= 0,
-	AD5755_SLEW_RATE_32k	= 1,
-	AD5755_SLEW_RATE_16k	= 2,
-	AD5755_SLEW_RATE_8k	= 3,
-	AD5755_SLEW_RATE_4k	= 4,
-	AD5755_SLEW_RATE_2k	= 5,
-	AD5755_SLEW_RATE_1k	= 6,
-	AD5755_SLEW_RATE_500	= 7,
-	AD5755_SLEW_RATE_250	= 8,
-	AD5755_SLEW_RATE_125	= 9,
-	AD5755_SLEW_RATE_64	= 10,
-	AD5755_SLEW_RATE_32	= 11,
-	AD5755_SLEW_RATE_16	= 12,
-	AD5755_SLEW_RATE_8	= 13,
-	AD5755_SLEW_RATE_4	= 14,
-	AD5755_SLEW_RATE_0_5	= 15,
-};
-
-enum ad5755_slew_step_size {
-	AD5755_SLEW_STEP_SIZE_1 = 0,
-	AD5755_SLEW_STEP_SIZE_2 = 1,
-	AD5755_SLEW_STEP_SIZE_4 = 2,
-	AD5755_SLEW_STEP_SIZE_8 = 3,
-	AD5755_SLEW_STEP_SIZE_16 = 4,
-	AD5755_SLEW_STEP_SIZE_32 = 5,
-	AD5755_SLEW_STEP_SIZE_64 = 6,
-	AD5755_SLEW_STEP_SIZE_128 = 7,
-	AD5755_SLEW_STEP_SIZE_256 = 8,
-};
-
-/**
- * struct ad5755_platform_data - AD5755 DAC driver platform data
- * @ext_dc_dc_compenstation_resistor: Whether an external DC-DC converter
- * compensation register is used.
- * @dc_dc_phase: DC-DC converter phase.
- * @dc_dc_freq: DC-DC converter frequency.
- * @dc_dc_maxv: DC-DC maximum allowed boost voltage.
- * @dac.mode: The mode to be used for the DAC output.
- * @dac.ext_current_sense_resistor: Whether an external current sense resistor
- * is used.
- * @dac.enable_voltage_overrange: Whether to enable 20% voltage output overrange.
- * @dac.slew.enable: Whether to enable digital slew.
- * @dac.slew.rate: Slew rate of the digital slew.
- * @dac.slew.step_size: Slew step size of the digital slew.
- **/
-struct ad5755_platform_data {
-	bool ext_dc_dc_compenstation_resistor;
-	enum ad5755_dc_dc_phase dc_dc_phase;
-	enum ad5755_dc_dc_freq dc_dc_freq;
-	enum ad5755_dc_dc_maxv dc_dc_maxv;
-
-	struct {
-		enum ad5755_mode mode;
-		bool ext_current_sense_resistor;
-		bool enable_voltage_overrange;
-		struct {
-			bool enable;
-			enum ad5755_slew_rate rate;
-			enum ad5755_slew_step_size step_size;
-		} slew;
-	} dac[4];
-};
-
-#endif
-- 
2.34.1

