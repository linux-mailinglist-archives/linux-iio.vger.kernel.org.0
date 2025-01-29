Return-Path: <linux-iio+bounces-14699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B9A21BC1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55757164EA1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20B1DDC0F;
	Wed, 29 Jan 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dhuos5mH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDB1DDA20
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148713; cv=none; b=SpgVMuXk/zqghyT5eLavaL2kGGUi5X3j0tSK8CDX++IYzNUEzzOB6UzB0BND28NGNtHy/E5JLcVLIOT5YA8W8XBzUS8Dh4TzFoGhv39TTeRKj17y6QGhyGcy/cFzZoTXu+ywfVj0fzYPMFFvVsFXSsgPodT1+o5ktwRq/o6hIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148713; c=relaxed/simple;
	bh=85OlqVH97K7F9YU3PJts40Anjk8hAqk1vgt8dqfrDhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gV2JLb57i7tTw0MKdbPPNxuLqEAzI49gToVRWYU//M0atCaBXgOTjYTAeeeGdCPoJhdc+DFc7ttHw8jlz8qm42rvktf0r1Gpa3T6afVA1A8iC8XcljIWfb6vjDsV6J5XI6QH88SJ7/DZjN4YVPHhiHvXOIl6OriVhK9oC+GI8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dhuos5mH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso47269055e9.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148710; x=1738753510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHAR9w6iE1kUg7TAE0D6ak7vDA8Cy7dNc7XiaEG+akw=;
        b=Dhuos5mHGVy/ZK6SvHApGYKxSxGLAotbK9tcMRMzgzeHAEWQXyWSK8bHZY7vP456kE
         vYj1Q06rp+PmusR1O7XrvBraiZvbToQvYvcH9BS/qc6bdITe7wUeYy5pdCCuQd0dqeo4
         WjSYtpSjtHQzjFHLvZ8AU0IIQIbyxO9CFZUoP3NJYs2TCDg5z8t4h7D2lQa+tejYrJUu
         FiTQ8pcQgYiyTd0g5H2/K7c65zf0I1cmzdo0CxGv2ScD1fjuxqxYyfdRD1F2cpX+xtvT
         m17MyI3Exz69QsNLO6dSFAi4b2v85nfHNrXCguy0DMRwb/5l39IXwh5X7+JZPoKCLWNu
         a4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148710; x=1738753510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHAR9w6iE1kUg7TAE0D6ak7vDA8Cy7dNc7XiaEG+akw=;
        b=FK8a0ys/w2uwCbdc9bYv0mT1mNTZSr8eRVsvSF11hCZdsglKGUEllVqCQpJZDiTdZm
         RHpNen0m+76uD+KX17QRlDCbKF7JaSaoetSWM8CVXOUppXFRPggNNoSPNGhoefYhTn0c
         yculXLc+8vzOsg8l3qa+5SsY8nLEFNkfxLqVpeRROGbqvWPbtKPzvqrNibCWM9MtN8/G
         JWsuLWgmFpREE1XkBxTtoGDxrtD0gmWBCkD5M7YT6kDsl0Lv7ZOY/1Kfl5jpbhi4U7z0
         N+/wnoZnR4oH6atJee+XWeVQjadu5APxOdw/MaSVhvduDar25K0Ljf3XfeasOD1Y4IOm
         Kfcw==
X-Forwarded-Encrypted: i=1; AJvYcCVAVKNqXYN5Hlm01Qrk/DnHSS8jksoweI7hIlb74zk40wJ/X1r2LMcVaXfQS9VQgGuryyxbnOnAN7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd08FzAXNMpHd9qIl7B1k/Tc3X9s8SCDICw/BIllI5FCbcMwsl
	mvRvixZ1erg2Fc++PtBB/iPbdLhdNc4YP1wwvb3jpXrqXVTW+whUNRLXm1hTngo=
X-Gm-Gg: ASbGnctWtrk0zriDjF2wxsVdtPNgWXeaqbZtISwmYzQHIpGDUSqzaRWUOmiho4/40+v
	72dNZzy7B3ZPqzWj7xH64yVrwbPmZkTDrnM7RczZnBgFa7Ah+/EMg/jk9x+L5Kupf6wjFy3a3ko
	PjlF/Ilt4682PK9ZX8a3tv0WljQC3XAte8fa1+ezIYYs8ExFd/C3SPO8CzMoGhXn7nmUq09y8qS
	EBxyMh/xaIXZnP47igrETQkw6RIoNTZjnXM9/el8uiLQBd5yIcydyyn4IOquXJcuvaurfS4UQZH
	whAPYYQ0ZrdyUYJibxE2ZLqD2IwtoQ69zepDmuY0S0agcp6pCW6wxwKiPB7duH5VgxmWNAA=
X-Google-Smtp-Source: AGHT+IFnISRAdIOu2I025O7IEY3zw9Th1g5UVnXU5gSxkPBoqoRfUsE5SpFijUzs9cafLVfb91opuQ==
X-Received: by 2002:a05:6000:4013:b0:385:f631:612 with SMTP id ffacd0b85a97d-38c5195f2e5mr2251088f8f.17.1738148709667;
        Wed, 29 Jan 2025 03:05:09 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:05:08 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:06 +0100
Subject: [PATCH v3 05/10] iio: adc: ad7606: move software functions into
 common file
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-5-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

Since the register are always the same, whatever bus is used, moving the
software functions into the main file avoids the code to be duplicated
in both SPI and parallel version of the driver.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 133 ++++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h     |  37 ++++++++++--
 drivers/iio/adc/ad7606_spi.c | 137 +------------------------------------------
 3 files changed, 158 insertions(+), 149 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 376c808df11c..7985570ed152 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -85,6 +85,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
 
+static const unsigned int ad7606b_oversampling_avail[9] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256,
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
 
@@ -1138,16 +1148,118 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+static int ad7606_write_mask(struct ad7606_state *st, unsigned int addr,
+			     unsigned long mask, unsigned int val)
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
+				 mode);
+}
+
+static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				 AD7616_OS_MASK, val << 2);
+}
+
+static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st, AD7606_RANGE_CH_ADDR(ch),
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
+	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				 AD7616_BURST_MODE | AD7616_SEQEN_MODE,
+				 AD7616_BURST_MODE | AD7616_SEQEN_MODE);
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
+		gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
+				      st->gpio_os->info, os);
+	}
+	/* OS of 128 and 256 are available only in software mode */
+	st->oversampling_avail = ad7606b_oversampling_avail;
+	st->num_os_ratios = ARRAY_SIZE(ad7606b_oversampling_avail);
+
+	st->write_scale = ad7606_write_scale_sw;
+	st->write_os = &ad7606_write_os_sw;
 
 	return st->bops->sw_mode_config(indio_dev);
 }
@@ -1326,9 +1438,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
index e2c147525706..885bf0b68e77 100644
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
@@ -194,118 +160,20 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
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
-	struct ad7606_state *st = iio_priv(indio_dev);
-
 	/*
 	 * Scale can be configured individually for each channel
 	 * in software mode.
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
@@ -350,7 +218,6 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
 	.sw_mode_config = ad7616_sw_mode_config,
 };
@@ -359,7 +226,6 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606B_sw_mode_config,
 };
@@ -368,7 +234,6 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.read_block = ad7606_spi_read_block18to32,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606c_18_sw_mode_config,
 };

-- 
2.47.0


