Return-Path: <linux-iio+bounces-13309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130299EAE90
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D33D164F6E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A9212D63;
	Tue, 10 Dec 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tSKzuACE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5320212D6B
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827612; cv=none; b=Yi1MEG+gacl/HGUWWDfD3HUgc2bszxIhXyhzCojCss8ZCEOCdXagTpO9be7HouVPBg7k2Vy2tvKDdPJfkXFohDF+FMqc76oU5fMlyyHzV8gyf5ktm5B8jMIfPa6tA4fBWOnxvUonfObWxa7ucwHgafThbc2rt8Wmz7QUOvhTcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827612; c=relaxed/simple;
	bh=1M1DJAuVZtHPyo/hc5BlyYOmaLWfCXAlD10XfwAfT98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZ1y2BTgeVe+xFy3tO+Ye3oKS5gytxb83t9gG0kS2jS8sdrLgCE7zU76+jaVaaXj4OqvQ8D/38BE9FyOmVUdpNYvPZXEIurlNMQEXy0zVojlU90WA8pNb2qZMG4uBFDFwawcgiOaIS3m0/ngKp9ErIkMwUlUqvJvgxG5Bbmr/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tSKzuACE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a2033562so49043225e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827608; x=1734432408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJPpA0dssabAhWMgaCyy+vzs9z9QK/u/gCIbjkTF3ok=;
        b=tSKzuACEIQhAQ3KqsfabkbvyZm89tTW39FkzIeh+7GU0YU1aC5JyYUEx46aulb8Blq
         SsWveuH7DF68fgrT6Yjva8HUIrUt+dBrtY1vskJsFIXiqiMxEkoCBr00IEYEggPy2/kk
         ZcoVsczOLaOs9xqHQzpI2KCnV0igEqQVidB648HRnVf0FSQVeAEHQpLzs/hNiSWyeN4J
         k/2c9GW3PVdR3pz6oTW+BcyPW1zAeKT2tATwqH6cXgmh5tsyZODS7fDqlonTHd5oOqhD
         Sk44APxsIJkDrWtfA4K9oQtxraWP6jTdPakzekS9iMz74FhgDeLFgk80MZVsOQS6z+nU
         eBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827608; x=1734432408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJPpA0dssabAhWMgaCyy+vzs9z9QK/u/gCIbjkTF3ok=;
        b=N1OgCDbz9ZdjyoYE+oCgyom9znsx9LDlf4bgK0EOhJqGrsBmodTYvBM04EYaFF0RZr
         VSfwb3HIvjt+XJrt5oVYSbRkgJAv8QLD7vpcc+/4eAoUvhmovx3FiMiMqYplW8uCsLWm
         tkgOx3WqHyps9DiXhpfZjk3Kzn7s3RlRsLgQ+w6BtTK4p2CHTHcGrrngy1Iw2VikO6GI
         BNj56kxBEypJCrlnSG/oEpBDCW2P5Ns9laEgp5D4JpMWRgAno7o+FzA845PSk90gJAJ6
         RxDbvF2r17UZ6ry8u2DG7aEMQNo7dpKVpUGVa4sprg/IkZnO0XrIfmMhQpCJ2ptTCd5g
         uydg==
X-Forwarded-Encrypted: i=1; AJvYcCVBrApawd5wH8UzqjKZuXqTBqhduWloVTZd+qhZt2/yZFOUh9wUbHlEaxt0I5TX7GzL272FkhsK6SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrmvva6rL79a9raEnF207XvE4G0sS3vHFWeShej1K0Ha8laeN0
	8ADTZFIZ2JPjkrIUwfYADV8Azd4gCxDvai6Q4E7Aa2xZ/vRPYJP9i0ClhxLc+Ms=
X-Gm-Gg: ASbGncv5OEyc4zE9N5nxtYqrAP7YC1JW/37lHjQl3krJDCKgMCZo+4jdTtQYKMeBbkZ
	L6596nNrNi7Rb7DNwIHKbmoQhRZwSUO2DOi64MO0b7nMizjC5RjBtUA5MaOsmRQJUJVtAY/fLzE
	+yfK5S2XuKeLQg9c9QG1I+g6aERWBMQThHLWBCx7rb+vB4HIEyLgYM6mxEdCMbDaQhShqXEhpV/
	URQmLfivZgabiQg8U0kcQlZz5qU0MWpaRnZULdKw774xjJ5MlVZZ10536SZtg+lop9bKsJy8ltA
	Yw==
X-Google-Smtp-Source: AGHT+IHkWpXKRKEjhy2yaMWEvqIB27pEExJ43sq7i4bhX2uN8XZvMqTipqlmKD2aqkFbBR2an6Uc2w==
X-Received: by 2002:a7b:cd15:0:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-4360aaf8122mr10089195e9.20.1733827607666;
        Tue, 10 Dec 2024 02:46:47 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:47 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:44 +0000
Subject: [PATCH v2 4/9] iio: adc: ad7606: Move software functions into
 common file
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-4-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=16918;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=1M1DJAuVZtHPyo/hc5BlyYOmaLWfCXAlD10XfwAfT98=;
 b=UO5vI6dGg2k12CkmxBOcQUlJFgfgWrEjxxpES63oCLWhuMhHgfzxyAZ+1mHkls264UPMJCKYc
 1Jihts09bxQC4QRn0UUeBOoWPfW9q4miZlXYMUbzg2RFbRdHlDDm3MN
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the register are always the same, whatever bus is used, moving the
software functions into the main file avoids the code to be duplicated
in both SPI and parallel version of the driver.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 137 ++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h     |  37 ++++++++++--
 drivers/iio/adc/ad7606_spi.c | 135 +-----------------------------------------
 3 files changed, 162 insertions(+), 147 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dde372ce7569..2f13b9cd2ed2 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -85,6 +85,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
 
+static const unsigned int ad7606b_oversampling_avail[9] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256
+};
+
 static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
@@ -187,6 +191,8 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
+static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.channels = ad7605_channels,
@@ -239,6 +245,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7606b_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
@@ -250,6 +257,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7606b_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
@@ -294,6 +302,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
+	.sw_setup_cb = ad7606b_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
@@ -307,6 +316,7 @@ const struct ad7606_chip_info ad7616_info = {
 	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 	.os_req_reset = true,
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7616_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7616_info, "IIO_AD7606");
 
@@ -1138,16 +1148,122 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+static int ad7606_write_mask(struct ad7606_state *st,
+			     unsigned int addr,
+			     unsigned long mask,
+			     unsigned int val)
+{
+	int readval;
+
+	readval = st->bops->reg_read(st, addr);
+	if (readval < 0)
+		return readval;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return st->bops->reg_write(st, addr, readval);
+}
+
+static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int ch_addr, mode, ch_index;
 
-	st->sw_mode_en = st->bops->sw_mode_config &&
-			 device_property_present(st->dev, "adi,sw-mode");
-	if (!st->sw_mode_en)
-		return 0;
+	/*
+	 * Ad7616 has 16 channels divided in group A and group B.
+	 * The range of channels from A are stored in registers with address 4
+	 * while channels from B are stored in register with address 6.
+	 * The last bit from channels determines if it is from group A or B
+	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
+	 */
+	ch_index = ch >> 1;
+
+	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
+
+	if ((ch & 0x1) == 0) /* channel A */
+		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
+	else	/* channel B */
+		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
+
+	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
+	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
 
-	indio_dev->info = &ad7606_info_sw_mode;
+	return ad7606_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
+				     mode);
+}
+
+static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				     AD7616_OS_MASK, val << 2);
+}
+
+static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st,
+				 AD7606_RANGE_CH_ADDR(ch),
+				 AD7606_RANGE_CH_MSK(ch),
+				 AD7606_RANGE_CH_MODE(ch, val));
+}
+
+static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return st->bops->reg_write(st, AD7606_OS_MODE, val);
+}
+
+static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Scale can be configured individually for each channel
+	 * in software mode.
+	 */
+
+	st->write_scale = ad7616_write_scale_sw;
+	st->write_os = &ad7616_write_os_sw;
+
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Activate Burst mode and SEQEN MODE */
+	return ad7606_write_mask(st,
+			      AD7616_CONFIGURATION_REGISTER,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+}
+
+static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	DECLARE_BITMAP(os, 3);
+
+	bitmap_fill(os, 3);
+	/*
+	 * Software mode is enabled when all three oversampling
+	 * pins are set to high. If oversampling gpios are defined
+	 * in the device tree, then they need to be set to high,
+	 * otherwise, they must be hardwired to VDD
+	 */
+	if (st->gpio_os) {
+		gpiod_set_array_value(st->gpio_os->ndescs,
+				      st->gpio_os->desc, st->gpio_os->info, os);
+	}
+	/* OS of 128 and 256 are available only in software mode */
+	st->oversampling_avail = ad7606b_oversampling_avail;
+	st->num_os_ratios = ARRAY_SIZE(ad7606b_oversampling_avail);
+
+	st->write_scale = ad7606_write_scale_sw;
+	st->write_os = &ad7606_write_os_sw;
 
 	return st->bops->sw_mode_config(indio_dev);
 }
@@ -1326,9 +1442,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	ret = ad7606_sw_mode_setup(indio_dev);
-	if (ret)
-		return ret;
+	st->sw_mode_en = st->chip_info->sw_setup_cb &&
+			 device_property_present(st->dev, "adi,sw-mode");
+	if (st->sw_mode_en) {
+		indio_dev->info = &ad7606_info_sw_mode;
+		st->chip_info->sw_setup_cb(indio_dev);
+	}
 
 	ret = ad7606_chan_scales_setup(indio_dev);
 	if (ret)
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 8778ffe515b3..7a044b499cfe 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -10,6 +10,36 @@
 
 #define AD760X_MAX_CHANNELS	16
 
+#define AD7616_CONFIGURATION_REGISTER	0x02
+#define AD7616_OS_MASK			GENMASK(4, 2)
+#define AD7616_BURST_MODE		BIT(6)
+#define AD7616_SEQEN_MODE		BIT(5)
+#define AD7616_RANGE_CH_A_ADDR_OFF	0x04
+#define AD7616_RANGE_CH_B_ADDR_OFF	0x06
+/*
+ * Range of channels from a group are stored in 2 registers.
+ * 0, 1, 2, 3 in a register followed by 4, 5, 6, 7 in second register.
+ * For channels from second group(8-15) the order is the same, only with
+ * an offset of 2 for register address.
+ */
+#define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
+/* The range of the channel is stored in 2 bits */
+#define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
+#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
+
+#define AD7606_CONFIGURATION_REGISTER	0x02
+#define AD7606_SINGLE_DOUT		0x00
+
+/*
+ * Range for AD7606B channels are stored in registers starting with address 0x3.
+ * Each register stores range for 2 channels(4 bits per channel).
+ */
+#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_MODE(ch, mode)	\
+	((GENMASK(3, 0) & (mode)) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
+#define AD7606_OS_MODE			0x08
+
 #define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -71,6 +101,7 @@ struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan, int ch);
+typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -80,6 +111,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
  * @num_channels:	number of channels
  * @num_adc_channels	the number of channels the ADC actually inputs.
  * @scale_setup_cb:	callback to setup the scales for each channel
+ * @sw_setup_cb:	callback to setup the software mode if available.
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
@@ -94,6 +126,7 @@ struct ad7606_chip_info {
 	unsigned int			num_adc_channels;
 	unsigned int			num_channels;
 	ad7606_scale_setup_cb_t		scale_setup_cb;
+	ad7606_sw_setup_cb_t		sw_setup_cb;
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
@@ -206,10 +239,6 @@ struct ad7606_bus_ops {
 	int (*reg_write)(struct ad7606_state *st,
 				unsigned int addr,
 				unsigned int val);
-	int (*write_mask)(struct ad7606_state *st,
-				 unsigned int addr,
-				 unsigned long mask,
-				 unsigned int val);
 	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index e2c147525706..e08563dd1108 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -15,36 +15,6 @@
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
-#define AD7616_CONFIGURATION_REGISTER	0x02
-#define AD7616_OS_MASK			GENMASK(4, 2)
-#define AD7616_BURST_MODE		BIT(6)
-#define AD7616_SEQEN_MODE		BIT(5)
-#define AD7616_RANGE_CH_A_ADDR_OFF	0x04
-#define AD7616_RANGE_CH_B_ADDR_OFF	0x06
-/*
- * Range of channels from a group are stored in 2 registers.
- * 0, 1, 2, 3 in a register followed by 4, 5, 6, 7 in second register.
- * For channels from second group(8-15) the order is the same, only with
- * an offset of 2 for register address.
- */
-#define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
-/* The range of the channel is stored in 2 bits */
-#define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
-#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
-
-#define AD7606_CONFIGURATION_REGISTER	0x02
-#define AD7606_SINGLE_DOUT		0x00
-
-/*
- * Range for AD7606B channels are stored in registers starting with address 0x3.
- * Each register stores range for 2 channels(4 bits per channel).
- */
-#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
-#define AD7606_RANGE_CH_MODE(ch, mode)	\
-	((GENMASK(3, 0) & mode) << (4 * ((ch) & 0x1)))
-#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
-#define AD7606_OS_MODE			0x08
-
 static const struct iio_chan_spec ad7616_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 	AD7616_CHANNEL(0),
@@ -89,10 +59,6 @@ static const struct iio_chan_spec ad7606c_18_sw_channels[] = {
 	AD7606_SW_CHANNEL(7, 18),
 };
 
-static const unsigned int ad7606B_oversampling_avail[9] = {
-	1, 2, 4, 8, 16, 32, 64, 128, 256
-};
-
 static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
 {
 	/*
@@ -194,76 +160,6 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
 
-static int ad7606_spi_write_mask(struct ad7606_state *st,
-				 unsigned int addr,
-				 unsigned long mask,
-				 unsigned int val)
-{
-	int readval;
-
-	readval = st->bops->reg_read(st, addr);
-	if (readval < 0)
-		return readval;
-
-	readval &= ~mask;
-	readval |= val;
-
-	return st->bops->reg_write(st, addr, readval);
-}
-
-static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int ch_addr, mode, ch_index;
-
-
-	/*
-	 * Ad7616 has 16 channels divided in group A and group B.
-	 * The range of channels from A are stored in registers with address 4
-	 * while channels from B are stored in register with address 6.
-	 * The last bit from channels determines if it is from group A or B
-	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
-	 */
-	ch_index = ch >> 1;
-
-	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
-
-	if ((ch & 0x1) == 0) /* channel A */
-		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
-	else	/* channel B */
-		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
-
-	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
-	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
-	return st->bops->write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
-				     mode);
-}
-
-static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return st->bops->write_mask(st, AD7616_CONFIGURATION_REGISTER,
-				     AD7616_OS_MASK, val << 2);
-}
-
-static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_spi_write_mask(st,
-				     AD7606_RANGE_CH_ADDR(ch),
-				     AD7606_RANGE_CH_MSK(ch),
-				     AD7606_RANGE_CH_MODE(ch, val));
-}
-
-static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_spi_reg_write(st, AD7606_OS_MODE, val);
-}
-
 static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -274,38 +170,12 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 	 */
 	indio_dev->channels = ad7616_sw_channels;
 
-	st->write_scale = ad7616_write_scale_sw;
-	st->write_os = &ad7616_write_os_sw;
-
-	/* Activate Burst mode and SEQEN MODE */
-	return st->bops->write_mask(st,
-			      AD7616_CONFIGURATION_REGISTER,
-			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
-			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+	return 0;
 }
 
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	DECLARE_BITMAP(os, 3);
-
-	bitmap_fill(os, 3);
-	/*
-	 * Software mode is enabled when all three oversampling
-	 * pins are set to high. If oversampling gpios are defined
-	 * in the device tree, then they need to be set to high,
-	 * otherwise, they must be hardwired to VDD
-	 */
-	if (st->gpio_os) {
-		gpiod_set_array_value(st->gpio_os->ndescs,
-				      st->gpio_os->desc, st->gpio_os->info, os);
-	}
-	/* OS of 128 and 256 are available only in software mode */
-	st->oversampling_avail = ad7606B_oversampling_avail;
-	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
-
-	st->write_scale = ad7606_write_scale_sw;
-	st->write_os = &ad7606_write_os_sw;
 
 	/* Configure device spi to output on a single channel */
 	st->bops->reg_write(st,
@@ -350,7 +220,6 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
 	.sw_mode_config = ad7616_sw_mode_config,
 };
@@ -359,7 +228,6 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606B_sw_mode_config,
 };
@@ -368,7 +236,6 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.read_block = ad7606_spi_read_block18to32,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606c_18_sw_mode_config,
 };

-- 
2.34.1


