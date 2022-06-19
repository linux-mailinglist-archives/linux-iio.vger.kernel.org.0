Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A708550CA4
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiFSS7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiFSS7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4559BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51EAC61129
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D28C34114;
        Sun, 19 Jun 2022 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665153;
        bh=S9WOG1Q6EUD0fWP2nvgJCs3YRl1INJz5gme815rFwMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4L87S1W1UdnjybicLPWffkSFJajzNm0jA+J+H1vvPoKaGKxhZ9BlTTNhK0mdYHhF
         IlRu76biSXDB+MA89fuSJEKHDVQTq+YX9qgkOKSbSwyGW1/4JmaBgSbKsFRjqlV/e0
         FedGp2QgiEyUMnqxivVDgXDwqNtMnGAQhQHyNlWaSdFDUiwf+YRujMD79reFro6bLY
         pKHxFOplyT2h6c4TJRRhaO3ndPdvWZlfqk1AizEMkbHSBqL/+Qs/CuhAXaNJ/Sj+Em
         FgbTC7CDqG4sY9qZZPJwe+fvfQuQi4lmIjfidG9sfxAPZscXFvYj6XrKpcnpF0dPn4
         d1I/kat08rxEg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/17] staging: iio: cdc: ad7746: Break up use of chan->address and use FIELD_PREP etc
Date:   Sun, 19 Jun 2022 19:58:30 +0100
Message-Id: <20220619185839.1363503-9-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Instead of encoding several different fields into chan->address use
an indirection to a separate per channel structure where the various
fields can be expressed in a more readable form.  This also allows
the register values to be constructed at runtime using FIELD_PREP()

Drop the now redundant _SHIFT macros.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 152 ++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 41d9ea4ccb02..a1b0a440728f 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -48,11 +49,12 @@
 #define AD7746_CAPSETUP_CACHOP		BIT(0)
 
 /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
-#define AD7746_VTSETUP_VTEN		(1 << 7)
-#define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
-#define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
+#define AD7746_VTSETUP_VTEN		BIT(7)
+#define AD7746_VTSETUP_VTMD_MASK	GENMASK(6, 5)
+#define AD7746_VTSETUP_VTMD_INT_TEMP	0
+#define AD7746_VTSETUP_VTMD_EXT_TEMP	1
+#define AD7746_VTSETUP_VTMD_VDD_MON	2
+#define AD7746_VTSETUP_VTMD_EXT_VIN	3
 #define AD7746_VTSETUP_EXTREF		BIT(4)
 #define AD7746_VTSETUP_VTSHORT		BIT(1)
 #define AD7746_VTSETUP_VTCHOP		BIT(0)
@@ -64,23 +66,22 @@
 #define AD7746_EXCSETUP_NEXCB		BIT(4)
 #define AD7746_EXCSETUP_EXCA		BIT(3)
 #define AD7746_EXCSETUP_NEXCA		BIT(2)
-#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
+#define AD7746_EXCSETUP_EXCLVL_MASK	GENMASK(1, 0)
 
 /* Config Register Bit Designations (AD7746_REG_CFG) */
-#define AD7746_CONF_VTFS_SHIFT		6
-#define AD7746_CONF_CAPFS_SHIFT		3
 #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
 #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
-#define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
-#define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7746_CONF_MODE_PWRDN		(3 << 0)
-#define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
+#define AD7746_CONF_MODE_MASK		GENMASK(2, 0)
+#define AD7746_CONF_MODE_IDLE		0
+#define AD7746_CONF_MODE_CONT_CONV	1
+#define AD7746_CONF_MODE_SINGLE_CONV	2
+#define AD7746_CONF_MODE_PWRDN		3
+#define AD7746_CONF_MODE_OFFS_CAL	5
+#define AD7746_CONF_MODE_GAIN_CAL	6
 
 /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
 #define AD7746_CAPDAC_DACEN		BIT(7)
-#define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
+#define AD7746_CAPDAC_DACP_MASK		0x7F
 
 struct ad7746_chip_info {
 	struct i2c_client *client;
@@ -107,6 +108,52 @@ enum ad7746_chan {
 	CIN2_DIFF,
 };
 
+struct ad7746_chan_info {
+	u8 addr;
+	union {
+		u8 vtmd;
+		struct { /* CAP SETUP fields */
+			unsigned int cin2 : 1;
+			unsigned int capdiff : 1;
+		};
+	};
+};
+
+static const struct ad7746_chan_info ad7746_chan_info[] = {
+	[VIN] = {
+		.addr = AD7746_REG_VT_DATA_HIGH,
+		.vtmd = AD7746_VTSETUP_VTMD_EXT_VIN,
+	},
+	[VIN_VDD] = {
+		.addr = AD7746_REG_VT_DATA_HIGH,
+		.vtmd = AD7746_VTSETUP_VTMD_VDD_MON,
+	},
+	[TEMP_INT] = {
+		.addr = AD7746_REG_VT_DATA_HIGH,
+		.vtmd = AD7746_VTSETUP_VTMD_INT_TEMP,
+	},
+	[TEMP_EXT] = {
+		.addr = AD7746_REG_VT_DATA_HIGH,
+		.vtmd = AD7746_VTSETUP_VTMD_EXT_TEMP,
+	},
+	[CIN1] = {
+		.addr = AD7746_REG_CAP_DATA_HIGH,
+	},
+	[CIN1_DIFF] = {
+		.addr =  AD7746_REG_CAP_DATA_HIGH,
+		.capdiff = 1,
+	},
+	[CIN2] = {
+		.addr = AD7746_REG_CAP_DATA_HIGH,
+		.cin2 = 1,
+	},
+	[CIN2_DIFF] = {
+		.addr = AD7746_REG_CAP_DATA_HIGH,
+		.cin2 = 1,
+		.capdiff = 1,
+	},
+};
+
 static const struct iio_chan_spec ad7746_channels[] = {
 	[VIN] = {
 		.type = IIO_VOLTAGE,
@@ -114,8 +161,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_EXT_VIN,
+		.address = VIN,
 	},
 	[VIN_VDD] = {
 		.type = IIO_VOLTAGE,
@@ -124,24 +170,21 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.extend_name = "supply",
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_VDD_MON,
+		.address = VIN_VDD,
 	},
 	[TEMP_INT] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_INT_TEMP,
+		.address = TEMP_INT,
 	},
 	[TEMP_EXT] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_EXT_TEMP,
+		.address = TEMP_EXT,
 	},
 	[CIN1] = {
 		.type = IIO_CAPACITANCE,
@@ -151,7 +194,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8,
+		.address = CIN1,
 	},
 	[CIN1_DIFF] = {
 		.type = IIO_CAPACITANCE,
@@ -163,8 +206,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CAPDIFF
+		.address = CIN1_DIFF,
 	},
 	[CIN2] = {
 		.type = IIO_CAPACITANCE,
@@ -174,8 +216,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CIN2,
+		.address = CIN2,
 	},
 	[CIN2_DIFF] = {
 		.type = IIO_CAPACITANCE,
@@ -187,8 +228,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
+		.address = CIN2_DIFF,
 	}
 };
 
@@ -224,10 +264,13 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_CAPACITANCE:
-		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
+		cap_setup = FIELD_PREP(AD7746_CAPSETUP_CIN2,
+				       ad7746_chan_info[chan->address].cin2) |
+			FIELD_PREP(AD7746_CAPSETUP_CAPDIFF,
+				   ad7746_chan_info[chan->address].capdiff) |
+			FIELD_PREP(AD7746_CAPSETUP_CAPEN, 1);
 		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
-		idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
-			AD7746_CONF_CAPFS_SHIFT;
+		idx = FIELD_GET(AD7746_CONF_CAPFS_MASK, chip->config);
 		delay = ad7746_cap_filter_rate_table[idx][1];
 
 		ret = ad7746_set_capdac(chip, chan->channel);
@@ -239,10 +282,11 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 		break;
 	case IIO_VOLTAGE:
 	case IIO_TEMP:
-		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
+		vt_setup = FIELD_PREP(AD7746_VTSETUP_VTMD_MASK,
+				      ad7746_chan_info[chan->address].vtmd) |
+			FIELD_PREP(AD7746_VTSETUP_VTEN, 1);
 		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
-		idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
-			AD7746_CONF_VTFS_SHIFT;
+		idx = FIELD_GET(AD7746_CONF_VTFS_MASK, chip->config);
 		delay = ad7746_cap_filter_rate_table[idx][1];
 		break;
 	default:
@@ -325,7 +369,8 @@ static ssize_t ad7746_start_offset_calib(struct device *dev,
 		return ret;
 
 	return ad7746_start_calib(dev, attr, buf, len,
-				  AD7746_CONF_MODE_OFFS_CAL);
+				  FIELD_PREP(AD7746_CONF_MODE_MASK,
+					     AD7746_CONF_MODE_OFFS_CAL));
 }
 
 static ssize_t ad7746_start_gain_calib(struct device *dev,
@@ -340,7 +385,8 @@ static ssize_t ad7746_start_gain_calib(struct device *dev,
 		return ret;
 
 	return ad7746_start_calib(dev, attr, buf, len,
-				  AD7746_CONF_MODE_GAIN_CAL);
+				  FIELD_PREP(AD7746_CONF_MODE_MASK,
+					     AD7746_CONF_MODE_GAIN_CAL));
 }
 
 static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
@@ -367,7 +413,7 @@ static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
 		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
 
 	chip->config &= ~AD7746_CONF_CAPFS_MASK;
-	chip->config |= i << AD7746_CONF_CAPFS_SHIFT;
+	chip->config |= FIELD_PREP(AD7746_CONF_CAPFS_MASK, i);
 
 	return 0;
 }
@@ -385,7 +431,7 @@ static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
 		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
 
 	chip->config &= ~AD7746_CONF_VTFS_MASK;
-	chip->config |= i << AD7746_CONF_VTFS_SHIFT;
+	chip->config |= FIELD_PREP(AD7746_CONF_VTFS_MASK, i);
 
 	return 0;
 }
@@ -468,7 +514,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		val /= 338646;
 		mutex_lock(&chip->lock);
 		chip->capdac[chan->channel][chan->differential] = val > 0 ?
-			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
+			FIELD_PREP(AD7746_CAPDAC_DACP_MASK, val) | AD7746_CAPDAC_DACEN : 0;
 
 		ret = ad7746_set_capdac(chip, chan->channel);
 		if (ret < 0) {
@@ -517,14 +563,16 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
 		return ret;
 	delay = ret;
 
-	regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
+	regval = chip->config | FIELD_PREP(AD7746_CONF_MODE_MASK,
+					   AD7746_CONF_MODE_SINGLE_CONV);
 	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
 	if (ret < 0)
 		return ret;
 
 	msleep(delay);
 	/* Now read the actual register */
-	ret = i2c_smbus_read_i2c_block_data(chip->client,  chan->address >> 8,
+	ret = i2c_smbus_read_i2c_block_data(chip->client,
+					    ad7746_chan_info[chan->address].addr,
 					    sizeof(data), data);
 	if (ret < 0)
 		return ret;
@@ -598,8 +646,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
-					  [chan->differential]) * 338646;
+		*val = FIELD_GET(AD7746_CAPDAC_DACP_MASK,
+				 chip->capdac[chan->channel][chan->differential]) * 338646;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -622,13 +670,11 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
-			idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
-				AD7746_CONF_CAPFS_SHIFT;
+			idx = FIELD_GET(AD7746_CONF_CAPFS_MASK, chip->config);
 			*val = ad7746_cap_filter_rate_table[idx][0];
 			return IIO_VAL_INT;
 		case IIO_VOLTAGE:
-			idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
-				AD7746_CONF_VTFS_SHIFT;
+			idx = FIELD_GET(AD7746_CONF_VTFS_MASK, chip->config);
 			*val = ad7746_vt_filter_rate_table[idx][0];
 			return IIO_VAL_INT;
 		default:
@@ -694,16 +740,16 @@ static int ad7746_probe(struct i2c_client *client,
 	if (!ret) {
 		switch (vdd_permille) {
 		case 125:
-			regval |= AD7746_EXCSETUP_EXCLVL(0);
+			regval |= FIELD_PREP(AD7746_EXCSETUP_EXCLVL_MASK, 0);
 			break;
 		case 250:
-			regval |= AD7746_EXCSETUP_EXCLVL(1);
+			regval |= FIELD_PREP(AD7746_EXCSETUP_EXCLVL_MASK, 1);
 			break;
 		case 375:
-			regval |= AD7746_EXCSETUP_EXCLVL(2);
+			regval |= FIELD_PREP(AD7746_EXCSETUP_EXCLVL_MASK, 2);
 			break;
 		case 500:
-			regval |= AD7746_EXCSETUP_EXCLVL(3);
+			regval |= FIELD_PREP(AD7746_EXCSETUP_EXCLVL_MASK, 3);
 			break;
 		default:
 			break;
-- 
2.36.1

