Return-Path: <linux-iio+bounces-11614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB89B6487
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17370282263
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E51F4712;
	Wed, 30 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="crKWKW6l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD21EE02F
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295888; cv=none; b=IhBCroljeePYo7hEM+Ma5Ckl2fm90z8hg4ethcjfQ0oAm7N8xXr/lNPRWIZlNi+li3h6IFU+TObzWtAIV+o1JoZTYUC1daGWTBwDfjodJo8b8Uglf3UCeQAXonpf4ryiORtSnBXU2mw4HIQgIi5e665jTzKajOhxpky+4XgNmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295888; c=relaxed/simple;
	bh=0ttDZj2ZkhjsaK1OSdKhg8Gk7/t274r5Lr3eaZacvx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtTBZvjktpFrVEN6tMpHJElQsBxPX7rItgxvwTKlrKYXDqGN9BtJKzq6jnx4ahVXyRvH6J6MQE0oucqnpbkvL9xwYUjzhtmqYTQZHfV4b/i7A9K0tkeu84kS8PTiIC0K2445OiA6ZYSB3GfExgbB9Gus4aeKX26/tg/QvjqNyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=crKWKW6l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so61889975e9.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730295882; x=1730900682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/zZXJm1iv61pxbZuPv42modR1pl77w3Mk/LfpLxIz0=;
        b=crKWKW6l51z4fW0N7DEeEm6Ec5Eec6DEs8fCmuYEuBZY/DEQKeyckg0fAZ6129ucxN
         6SPowolOgosrZKIYg6G6wsM1FXNwNaIwBDqnNKkkfdOK4IJiMoySzw7RMKkOu1eQV784
         molvM+Lv90UN0zLUQolAjNRTxDsR+l+U07jCOPuPWHDvXNa+cdrvJFWgNvT0dJJYNav0
         7LD7HOhXQbwqabW7VkG0wjD65tqeQJkBW0hdxOs9BCiA9MOvG8vhK1QhMSiS+1pBR5oH
         3nQ1za+zIaxA1CXvABXqxuj+LtmbpRwqQhhloyxXOn0zw704QkKF/tGL8wONKho1rl/Y
         F8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295882; x=1730900682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/zZXJm1iv61pxbZuPv42modR1pl77w3Mk/LfpLxIz0=;
        b=v9QrKxOhahW2abVTQCHvwwQNmJ0mYAbnCDI5y6JczE2kco3QZCIE4L0OV8MpWJiDwF
         Oh4mUUfvUyAg68mTm3i7XmWTlGa2mw30Yqd1uKjALKLyJ+tBgkBgxNZBrEnh2pBJPpbZ
         GYxw5KvqGhgDgoDo3unuk0zJGTwP7WSjQjKBjWBRgFmJ1jhUhgbEEIxc2weXhdyKLkT+
         +zymbv7Vb2IaFp6kUIa7WZ+lk9Bhuc+n/chFrVCs/8Cp0aQUR9twlcGpAnPL0dTKV4xL
         pRIM/KlqmzVH4FL8k1r29sPyZ99eWFSYijtp57RmIoAJ/LKAl857FgRwKmQdRB/BF9Ul
         SgyQ==
X-Gm-Message-State: AOJu0Yyh7Iiz5IYIBD0X7qZIPKgsiLQ0F/wKge9jbs2p+eu4glZ6A4bs
	gZwGa1sEvyETn6COcj/WePR1a6pNVHNF96GgZF2I+/vgALCIHUWcYzwDfmLJOWg=
X-Google-Smtp-Source: AGHT+IH17rOSoL/+Lmy1UYoEUw7+laWLknanbEqrYmHEt8FE6IyYxVCDW16e7fLc+z+VlUPugQo25Q==
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-431bb9d14afmr24830055e9.23.1730295881538;
        Wed, 30 Oct 2024 06:44:41 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d693sm22135175e9.24.2024.10.30.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:44:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 30 Oct 2024 14:44:28 +0100
Subject: [PATCH v4 4/5] iio: adc: ad7380: add support for adaq4370-4 and
 adaq4380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-ad7380-add-adaq4380-4-support-v4-4-864ff02babae@baylibre.com>
References: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
In-Reply-To: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
acquisition signal chain μModule solutions compatible with the ad738x
family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This implies that IIO_CHAN_INFO_SCALE can not be shared by type for
these new devices.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 130 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 206c894953f057acca20805fb30185cb7ab8a902..4f32cb22f140442b831dc9a4f275e88e4ab2388e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -13,6 +13,8 @@
  * ad7381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7381-4.pdf
  * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
  * ad7386/7/8-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7386-4-7387-4-7388-4.pdf
+ * adaq4370-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4370-4.pdf
+ * adaq4380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4380-4.pdf
  */
 
 #include <linux/align.h>
@@ -22,11 +24,14 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -36,6 +41,8 @@
 #define MAX_NUM_CHANNELS		8
 /* 2.5V internal reference voltage */
 #define AD7380_INTERNAL_REF_MV		2500
+/* 3.3V internal reference voltage for ADAQ */
+#define ADAQ4380_INTERNAL_REF_MV	3300
 
 /* reading and writing registers is more reliable at lower than max speed */
 #define AD7380_REG_WR_SPEED_HZ		10000000
@@ -82,6 +89,7 @@
  * supports only 1 SDO line (standard SPI transaction)
  */
 #define AD7380_NUM_SDO_LINES		1
+#define AD7380_DEFAULT_GAIN_MILLI	1000
 
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
@@ -92,10 +100,12 @@ struct ad7380_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int num_simult_channels;
+	bool has_hardware_gain;
 	bool has_mux;
 	const char * const *supplies;
 	unsigned int num_supplies;
 	bool external_ref_only;
+	bool adaq_internal_ref_only;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -187,11 +197,12 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	},
 };
 
-#define AD7380_CHANNEL(index, bits, diff, sign) {				\
+#define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
 	.type = IIO_VOLTAGE,							\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
 		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |			\
+	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |	\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
 	.info_mask_shared_by_type_available =					\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
@@ -205,6 +216,12 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits##_##sign),	\
 }
 
+#define AD7380_CHANNEL(index, bits, diff, sign)		\
+	_AD7380_CHANNEL(index, bits, diff, sign, false)
+
+#define ADAQ4380_CHANNEL(index, bits, diff, sign)	\
+	_AD7380_CHANNEL(index, bits, diff, sign, true)
+
 #define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign)	\
 static const struct iio_chan_spec name[] = {		\
 	AD7380_CHANNEL(0, bits, diff, sign),		\
@@ -221,6 +238,15 @@ static const struct iio_chan_spec name[] = {		\
 	IIO_CHAN_SOFT_TIMESTAMP(4),			\
 }
 
+#define DEFINE_ADAQ4380_4_CHANNEL(name, bits, diff, sign)	\
+static const struct iio_chan_spec name[] = {			\
+	ADAQ4380_CHANNEL(0, bits, diff, sign),			\
+	ADAQ4380_CHANNEL(1, bits, diff, sign),			\
+	ADAQ4380_CHANNEL(2, bits, diff, sign),			\
+	ADAQ4380_CHANNEL(3, bits, diff, sign),			\
+	IIO_CHAN_SOFT_TIMESTAMP(4),				\
+}
+
 #define DEFINE_AD7380_8_CHANNEL(name, bits, diff, sign)	\
 static const struct iio_chan_spec name[] = {		\
 	AD7380_CHANNEL(0, bits, diff, sign),		\
@@ -239,6 +265,7 @@ DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1, s);
 DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1, s);
 DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1, s);
 DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1, s);
+DEFINE_ADAQ4380_4_CHANNEL(adaq4380_4_channels, 16, 1, s);
 /* pseudo differential */
 DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0, s);
 DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0, s);
@@ -257,6 +284,10 @@ static const char * const ad7380_supplies[] = {
 	"vcc", "vlogic",
 };
 
+static const char * const adaq4380_supplies[] = {
+	"ldo", "vcc", "vlogic", "vs-p", "vs-n", "refin",
+};
+
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
 };
@@ -347,6 +378,11 @@ static const int ad7380_oversampling_ratios[] = {
 	1, 2, 4, 8, 16, 32,
 };
 
+/* Gains stored as fractions of 1000 so they can be expressed by integers. */
+static const int ad7380_gains[] = {
+	300, 600, 1000, 1600,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
@@ -516,6 +552,32 @@ static const struct ad7380_chip_info ad7388_4_chip_info = {
 	.timing_specs = &ad7380_4_timing,
 };
 
+static const struct ad7380_chip_info adaq4370_4_chip_info = {
+	.name = "adaq4370-4",
+	.channels = adaq4380_4_channels,
+	.num_channels = ARRAY_SIZE(adaq4380_4_channels),
+	.num_simult_channels = 4,
+	.supplies = adaq4380_supplies,
+	.num_supplies = ARRAY_SIZE(adaq4380_supplies),
+	.adaq_internal_ref_only = true,
+	.has_hardware_gain = true,
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info adaq4380_4_chip_info = {
+	.name = "adaq4380-4",
+	.channels = adaq4380_4_channels,
+	.num_channels = ARRAY_SIZE(adaq4380_4_channels),
+	.num_simult_channels = 4,
+	.supplies = adaq4380_supplies,
+	.num_supplies = ARRAY_SIZE(adaq4380_supplies),
+	.adaq_internal_ref_only = true,
+	.has_hardware_gain = true,
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
@@ -526,6 +588,7 @@ struct ad7380_state {
 	bool seq;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
+	unsigned int gain_milli[MAX_NUM_CHANNELS];
 	/* xfers, message an buffer for reading sample data */
 	struct spi_transfer normal_xfer[2];
 	struct spi_message normal_msg;
@@ -876,8 +939,15 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		 *    * (2 × VREF) / 2^N, for differential chips
 		 *    * VREF / 2^N, for pseudo-differential chips
 		 * where N is the ADC resolution (i.e realbits)
+		 *
+		 * The gain is stored as a fraction of 1000 and, as we need to
+		 * divide vref_mv by the gain, we invert the gain/1000 fraction.
 		 */
-		*val = st->vref_mv;
+		if (st->chip_info->has_hardware_gain)
+			*val = mult_frac(st->vref_mv, MILLI,
+					 st->gain_milli[chan->scan_index]);
+		else
+			*val = st->vref_mv;
 		*val2 = scan_type->realbits - chan->differential;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -1059,7 +1129,19 @@ static int ad7380_probe(struct spi_device *spi)
 				     "Failed to enable power supplies\n");
 	fsleep(T_POWERUP_US);
 
-	if (st->chip_info->external_ref_only) {
+	if (st->chip_info->adaq_internal_ref_only) {
+		/*
+		 * ADAQ chips use fixed internal reference but still
+		 * require a specific reference supply to power it.
+		 * "refin" is already enabled with other power supplies
+		 * in bulk_get_enable().
+		 */
+
+		st->vref_mv = ADAQ4380_INTERNAL_REF_MV;
+
+		/* these chips don't have a register bit for this */
+		external_ref_en = false;
+	} else if (st->chip_info->external_ref_only) {
 		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
 		if (ret < 0)
 			return dev_err_probe(dev, ret,
@@ -1103,6 +1185,42 @@ static int ad7380_probe(struct spi_device *spi)
 		st->vcm_mv[i] = ret / 1000;
 	}
 
+	for (i = 0; i < MAX_NUM_CHANNELS; i++)
+		st->gain_milli[i] = AD7380_DEFAULT_GAIN_MILLI;
+
+	if (st->chip_info->has_hardware_gain) {
+		device_for_each_child_node_scoped(dev, node) {
+			unsigned int channel, gain;
+			int gain_idx;
+
+			ret = fwnode_property_read_u32(node, "reg", &channel);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to read reg property\n");
+
+			if (channel >= st->chip_info->num_channels - 1)
+				return dev_err_probe(dev, -EINVAL,
+						     "Invalid channel number %i\n",
+						     channel);
+
+			ret = fwnode_property_read_u32(node, "adi,gain-milli",
+						       &gain);
+			if (ret && ret != -EINVAL)
+				return dev_err_probe(dev, ret,
+						     "Failed to read gain for channel %i\n",
+						     channel);
+			if (ret != -EINVAL) {
+				/*
+				 * Match gain value from dt to one of supported
+				 * gains
+				 */
+				gain_idx = find_closest(gain, ad7380_gains,
+							ARRAY_SIZE(ad7380_gains));
+				st->gain_milli[channel] = ad7380_gains[gain_idx];
+			}
+		}
+	}
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad7380_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
@@ -1185,6 +1303,8 @@ static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7386-4", .data = &ad7386_4_chip_info },
 	{ .compatible = "adi,ad7387-4", .data = &ad7387_4_chip_info },
 	{ .compatible = "adi,ad7388-4", .data = &ad7388_4_chip_info },
+	{ .compatible = "adi,adaq4370-4", .data = &adaq4370_4_chip_info },
+	{ .compatible = "adi,adaq4380-4", .data = &adaq4380_4_chip_info },
 	{ }
 };
 
@@ -1203,6 +1323,8 @@ static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7386-4", (kernel_ulong_t)&ad7386_4_chip_info },
 	{ "ad7387-4", (kernel_ulong_t)&ad7387_4_chip_info },
 	{ "ad7388-4", (kernel_ulong_t)&ad7388_4_chip_info },
+	{ "adaq4370-4", (kernel_ulong_t)&adaq4370_4_chip_info },
+	{ "adaq4380-4", (kernel_ulong_t)&adaq4380_4_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.47.0


