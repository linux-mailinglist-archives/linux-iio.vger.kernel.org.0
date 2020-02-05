Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC01528F5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 11:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBEKRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 05:17:06 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:34088 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBEKRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 05:17:06 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 7967B103DBA;
        Wed,  5 Feb 2020 11:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 7967B103DBA
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH 2/5] iio: light: vcnl4000: add enable attributes for vcnl4040/4200
Date:   Wed,  5 Feb 2020 11:16:52 +0100
Message-Id: <20200205101655.11728-3-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200205101655.11728-1-tomas@novotny.cz>
References: <20200205101655.11728-1-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both vcnl4040 and vcnl4200 chips start with ambient light and proximity
channels disabled. The driver enables both channels during
initialization. The channels may be enabled or disabled with this
change.

Disabled ambient light channel returns the last measured value on read.
This differs from proximity, which returns 0. Channels return these
values with the configured sampling rate.

The driver doesn't configure some defaults during probe now. Only the
enable bit is handled.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/vcnl4000.c | 118 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9f673e89084a..f351b100a165 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -58,6 +58,10 @@
 #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
 #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
 
+/* Bit masks for various configuration registers */
+#define VCNL4200_AL_SD		BIT(0) /* Ambient light shutdown */
+#define VCNL4200_PS_SD		BIT(0) /* Proximity shutdown */
+
 enum vcnl4000_device_ids {
 	VCNL4000,
 	VCNL4010,
@@ -86,10 +90,16 @@ struct vcnl4000_data {
 
 struct vcnl4000_chip_spec {
 	const char *prod;
+	const struct iio_chan_spec *channels;
+	size_t num_channels;
 	const struct regmap_config *regmap_config;
 	int (*init)(struct vcnl4000_data *data);
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
+	int (*is_enabled)(struct vcnl4000_data *data, enum iio_chan_type type,
+			int *val);
+	int (*enable)(struct vcnl4000_data *data, enum iio_chan_type type,
+			bool val);
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -102,6 +112,30 @@ static const struct i2c_device_id vcnl4000_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
 
+static const struct iio_chan_spec vcnl4000_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static const struct iio_chan_spec vcnl4200_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_ENABLE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_ENABLE),
+	}
+};
+
 static const struct regmap_config vcnl4000_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -171,11 +205,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 
 	data->rev = (ret >> 8) & 0xf;
 
-	/* Set defaults and enable both channels */
-	ret = regmap_write(data->regmap, VCNL4200_AL_CONF, 0);
+	ret = data->chip_spec->enable(data, IIO_LIGHT, true);
 	if (ret < 0)
 		return ret;
-	ret = regmap_write(data->regmap, VCNL4200_PS_CONF1, 0);
+	ret = data->chip_spec->enable(data, IIO_PROXIMITY, true);
 	if (ret < 0)
 		return ret;
 
@@ -300,9 +333,46 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
 	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
 }
 
+static int vcnl4200_is_enabled(struct vcnl4000_data *data,
+			       enum iio_chan_type type, int *val)
+{
+	int ret;
+
+	switch (type) {
+	case IIO_LIGHT:
+		ret = regmap_read(data->regmap, VCNL4200_AL_CONF, val);
+		*val = !(*val & VCNL4200_AL_SD);
+		break;
+	case IIO_PROXIMITY:
+		ret = regmap_read(data->regmap, VCNL4200_PS_CONF1, val);
+		*val = !(*val & VCNL4200_PS_SD);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return ret < 0 ? ret : IIO_VAL_INT;
+}
+
+static int vcnl4200_enable(struct vcnl4000_data *data, enum iio_chan_type type,
+			   bool val)
+{
+	switch (type) {
+	case IIO_LIGHT:
+		return regmap_update_bits(data->regmap, VCNL4200_AL_CONF,
+				VCNL4200_AL_SD, !val);
+	case IIO_PROXIMITY:
+		return regmap_update_bits(data->regmap, VCNL4200_PS_CONF1,
+				VCNL4200_PS_SD, !val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	[VCNL4000] = {
 		.prod = "VCNL4000",
+		.channels = vcnl4000_channels,
+		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.regmap_config = &vcnl4000_regmap_config,
 		.init = vcnl4000_init,
 		.measure_light = vcnl4000_measure_light,
@@ -310,6 +380,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	},
 	[VCNL4010] = {
 		.prod = "VCNL4010/4020",
+		.channels = vcnl4000_channels,
+		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.regmap_config = &vcnl4000_regmap_config,
 		.init = vcnl4000_init,
 		.measure_light = vcnl4000_measure_light,
@@ -317,31 +389,28 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	},
 	[VCNL4040] = {
 		.prod = "VCNL4040",
+		.channels = vcnl4200_channels,
+		.num_channels = ARRAY_SIZE(vcnl4200_channels),
 		.regmap_config = &vcnl4200_regmap_config,
 		.init = vcnl4200_init,
 		.measure_light = vcnl4200_measure_light,
 		.measure_proximity = vcnl4200_measure_proximity,
+		.is_enabled = vcnl4200_is_enabled,
+		.enable = vcnl4200_enable,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
+		.channels = vcnl4200_channels,
+		.num_channels = ARRAY_SIZE(vcnl4200_channels),
 		.regmap_config = &vcnl4200_regmap_config,
 		.init = vcnl4200_init,
 		.measure_light = vcnl4200_measure_light,
 		.measure_proximity = vcnl4200_measure_proximity,
+		.is_enabled = vcnl4200_is_enabled,
+		.enable = vcnl4200_enable,
 	},
 };
 
-static const struct iio_chan_spec vcnl4000_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
-	}, {
-		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
-};
-
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -372,6 +441,22 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = data->al_scale;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_ENABLE:
+		return data->chip_spec->is_enabled(data, chan->type, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4000_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		return data->chip_spec->enable(data, chan->type, val);
 	default:
 		return -EINVAL;
 	}
@@ -379,6 +464,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
+	.write_raw = vcnl4000_write_raw,
 };
 
 static int vcnl4000_probe(struct i2c_client *client,
@@ -412,8 +498,8 @@ static int vcnl4000_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &vcnl4000_info;
-	indio_dev->channels = vcnl4000_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
+	indio_dev->channels = data->chip_spec->channels;
+	indio_dev->num_channels = data->chip_spec->num_channels;
 	indio_dev->name = VCNL4000_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.16.4

