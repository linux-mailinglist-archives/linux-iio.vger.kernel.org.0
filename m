Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD17A9F20
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIUUSH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIUURm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:17:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A1515A5
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:25:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1241206f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317139; x=1695921939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms6XtDC2gqm1+y4qBooiAiA+r/YZdcas3vjvFP4dBPU=;
        b=NlybUepeTqztwClLKEBbjEH/KFIlskNCmG01/jZ4BDBg2Za4lwaTkwXdpxilmaLLuE
         PLDOyc2CTazT9B1SyntJq8jO/RbXE+rWquqFbsJsR4gaedI73+nBW79D6PFvbnFjjvon
         PRA9PreYLLTK1KT2DIAM6LPhsE9uf/V1FlIYrbF2fAHM7rV3aFq91JnURZoiJ/CYMqs3
         mYEGJsYQxKq+6GsTWLFtWoNkVLKX6Vm7qGVBl/iHmPMwFQLPSiY8m8pbqOaJ7WN7wA6z
         +ajU7WZswp5rUHrC75DMwrFqB6Gw/4gV81D/u2jiU6AexrG4TcUXnwKyjGfDh4l05hsw
         tBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317139; x=1695921939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms6XtDC2gqm1+y4qBooiAiA+r/YZdcas3vjvFP4dBPU=;
        b=pPkutVbh8FniBrHWBgf0Hf3etjYKl5Lc3tcOaEfcA0qw2y5/goaU6K7DY690GNUBql
         y/Jp5nVxp1uPVfDYNM8jdnGjc0nSauWVZ7Px8YIz3K38LH91GoLsGdjPMZSisfxr5Djp
         vbXTdOwx9rAUbXeXHFcZlruRVeHNSMnG6CYzw/2i9Etc+/Bmip7ImYokjah+thpuy4d0
         4CKeBdxREmKO+JwH+Fn1FRAVa+jtgxJg+LOHRW5UnB8K7b8AQ64E7c+t1uzHcxQyvsWV
         IfPHDOz/1r79voanSjOo57imnU4lYBOEnvs/QS8XcDPFIOZzEg29qqfjM60BxaUSFDFm
         IS9g==
X-Gm-Message-State: AOJu0YziXQX4FLzCRzgfMMDMVD+KFUShCqJqWn1hsoT4V6eQx1p2gYHh
        iOLHeaNfUB4HSqkL16r/9IKNP1j5ZBJ2EtyeauRqIKlo
X-Google-Smtp-Source: AGHT+IGGmEyk1OjFw9m0pn/8yG9jZBYUcbB2fnTx4NWYXyDuPq5yL654tmO33MmRV0H62lUW8r3SXw==
X-Received: by 2002:adf:ea8b:0:b0:31a:e772:ddf0 with SMTP id s11-20020adfea8b000000b0031ae772ddf0mr5106504wrm.53.1695306160016;
        Thu, 21 Sep 2023 07:22:40 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:39 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 09/19] staging: iio: resolver: ad2s1210: use regmap for config registers
Date:   Thu, 21 Sep 2023 09:19:37 -0500
Message-Id: <20230921141947.57784-12-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes use of the regmap API to read and write the configuration
registers. This simplifies code quite a bit and makes it safer
(previously, it was easy to write a bad value to the config registers
which causes the chip to lock up and need to be reset).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 251 ++++++++++++++----------
 1 file changed, 149 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 153ac7704ad7..3c81ee61b897 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2010-2010 Analog Devices Inc.
  * Copyright (C) 2023 BayLibre, SAS
  */
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -12,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -22,21 +24,20 @@
 
 #define DRV_NAME "ad2s1210"
 
+/* default value of control register on powerup */
 #define AD2S1210_DEF_CONTROL		0x7E
 
-#define AD2S1210_MSB_IS_HIGH		0x80
-#define AD2S1210_MSB_IS_LOW		0x7F
-#define AD2S1210_PHASE_LOCK_RANGE_44	0x20
-#define AD2S1210_ENABLE_HYSTERESIS	0x10
-#define AD2S1210_SET_ENRES1		0x08
-#define AD2S1210_SET_ENRES0		0x04
-#define AD2S1210_SET_RES1		0x02
-#define AD2S1210_SET_RES0		0x01
-
-#define AD2S1210_SET_RESOLUTION		(AD2S1210_SET_RES1 | AD2S1210_SET_RES0)
-
-#define AD2S1210_REG_POSITION		0x80
-#define AD2S1210_REG_VELOCITY		0x82
+/* control register flags */
+#define AD2S1210_ADDRESS_DATA		BIT(7)
+#define AD2S1210_PHASE_LOCK_RANGE_44	BIT(5)
+#define AD2S1210_ENABLE_HYSTERESIS	BIT(4)
+#define AD2S1210_SET_ENRES		GENMASK(3, 2)
+#define AD2S1210_SET_RES		GENMASK(1, 0)
+
+#define AD2S1210_REG_POSITION_MSB	0x80
+#define AD2S1210_REG_POSITION_LSB	0x81
+#define AD2S1210_REG_VELOCITY_MSB	0x82
+#define AD2S1210_REG_VELOCITY_LSB	0x83
 #define AD2S1210_REG_LOS_THRD		0x88
 #define AD2S1210_REG_DOS_OVR_THRD	0x89
 #define AD2S1210_REG_DOS_MIS_THRD	0x8A
@@ -92,6 +93,8 @@ struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
+	/** Used to access config registers. */
+	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
 	unsigned int fexcit;
@@ -116,24 +119,51 @@ static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 	st->mode = mode;
 }
 
-/* write 1 bytes (address or data) to the chip */
-static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
+/*
+ * Writes the given data to the given register address.
+ *
+ * If the mode is configurable, the device will first be placed in
+ * configuration mode.
+ */
+static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
+				     unsigned int val)
 {
-	int ret;
+	struct ad2s1210_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.len = 1,
+			.rx_buf = &st->rx[0],
+			.tx_buf = &st->tx[0],
+			.cs_change = 1,
+		}, {
+			.len = 1,
+			.rx_buf = &st->rx[1],
+			.tx_buf = &st->tx[1],
+		},
+	};
+
+	/* values can only be 7 bits, the MSB indicates an address */
+	if (val & ~0x7F)
+		return -EINVAL;
+
+	st->tx[0] = reg;
+	st->tx[1] = val;
 
 	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = data;
-	ret = spi_write(st->sdev, st->tx, 1);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 }
 
-/* read value from one of the registers */
-static int ad2s1210_config_read(struct ad2s1210_state *st,
-				unsigned char address)
+/*
+ * Reads value from one of the registers.
+ *
+ * If the mode is configurable, the device will first be placed in
+ * configuration mode.
+ */
+static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
+				    unsigned int *val)
 {
+	struct ad2s1210_state *st = context;
 	struct spi_transfer xfers[] = {
 		{
 			.len = 1,
@@ -146,22 +176,34 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
 			.tx_buf = &st->tx[1],
 		},
 	};
-	int ret = 0;
+	int ret;
 
 	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = address | AD2S1210_MSB_IS_HIGH;
+	st->tx[0] = reg;
+	/* Must be valid register address here otherwise this could write data.
+	 * It doesn't matter which one.
+	 */
 	st->tx[1] = AD2S1210_REG_FAULT;
-	ret = spi_sync_transfer(st->sdev, xfers, 2);
+
+	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 	if (ret < 0)
 		return ret;
 
-	return st->rx[1];
+	/* If the D7 bit is set on any read/write register, it indicates a
+	 * parity error. The fault register is read-only and the D7 bit means
+	 * something else there.
+	 */
+	if (reg != AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
+		return -EBADMSG;
+
+	*val = st->rx[1];
+
+	return 0;
 }
 
 static inline
 int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 {
-	int ret;
 	unsigned char fcw;
 
 	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
@@ -170,11 +212,7 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 		return -ERANGE;
 	}
 
-	ret = ad2s1210_config_write(st, AD2S1210_REG_EXCIT_FREQ);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, fcw);
+	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
 }
 
 static const int ad2s1210_res_pins[4][2] = {
@@ -191,13 +229,7 @@ static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 {
-	int ret;
-
-	ret = ad2s1210_config_write(st, AD2S1210_REG_SOFT_RESET);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, 0x0);
+	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
 
 static ssize_t ad2s1210_show_fexcit(struct device *dev,
@@ -242,12 +274,13 @@ static ssize_t ad2s1210_show_control(struct device *dev,
 				     char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
+	ret = regmap_read(st->regmap, AD2S1210_REG_CONTROL, &value);
 	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : sprintf(buf, "0x%x\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "0x%x\n", value);
 }
 
 static ssize_t ad2s1210_store_control(struct device *dev,
@@ -264,25 +297,13 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = udata & AD2S1210_MSB_IS_LOW;
-	ret = ad2s1210_config_write(st, data);
+	data = udata & ~AD2S1210_ADDRESS_DATA;
+	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
 		goto error_ret;
 
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev,
-			"ad2s1210: write control register fail\n");
-		goto error_ret;
-	}
 	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
 	ad2s1210_set_resolution_pin(st);
 	ret = len;
 	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
@@ -315,30 +336,17 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 		dev_err(dev, "ad2s1210: resolution out of range\n");
 		return -EINVAL;
 	}
+
+	data = (udata - 10) >> 1;
+
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = ret;
-	data &= ~AD2S1210_SET_RESOLUTION;
-	data |= (udata - 10) >> 1;
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_SET_RES, data);
 	if (ret < 0)
 		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = ret;
-	if (data & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev, "ad2s1210: setting resolution fail\n");
-		goto error_ret;
-	}
+
 	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
 	ad2s1210_set_resolution_pin(st);
 	ret = len;
 error_ret:
@@ -351,13 +359,14 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
+	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
 	mutex_unlock(&st->lock);
 
-	return (ret < 0) ? ret : sprintf(buf, "0x%02x\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "0x%02x\n", value);
 }
 
 static ssize_t ad2s1210_clear_fault(struct device *dev,
@@ -366,6 +375,7 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 				    size_t len)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -373,7 +383,7 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
+	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
 	if (ret < 0)
 		goto error_ret;
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
@@ -390,13 +400,14 @@ static ssize_t ad2s1210_show_reg(struct device *dev,
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, iattr->address);
+	ret = regmap_read(st->regmap, iattr->address, &value);
 	mutex_unlock(&st->lock);
 
-	return ret < 0 ? ret : sprintf(buf, "%d\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "%d\n", value);
 }
 
 static ssize_t ad2s1210_store_reg(struct device *dev,
@@ -409,14 +420,11 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
 
 	ret = kstrtou8(buf, 10, &data);
-	if (ret)
+	if (ret < 0)
 		return -EINVAL;
+
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, iattr->address);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
-error_ret:
+	ret = regmap_write(st->regmap, iattr->address, data);
 	mutex_unlock(&st->lock);
 	return ret < 0 ? ret : len;
 }
@@ -583,23 +591,12 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	mutex_lock(&st->lock);
 	ad2s1210_set_resolution_pin(st);
 
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = AD2S1210_DEF_CONTROL & ~(AD2S1210_SET_RESOLUTION);
+	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;
 	data |= (st->resolution - 10) >> 1;
-	ret = ad2s1210_config_write(st, data);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
+	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
 		goto error_ret;
 
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		goto error_ret;
-	}
-
 	ret = ad2s1210_update_frequency_control_word(st);
 	if (ret < 0)
 		goto error_ret;
@@ -652,6 +649,52 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 	return 0;
 }
 
+static const struct regmap_range ad2s1210_regmap_readable_ranges[] = {
+	regmap_reg_range(AD2S1210_REG_POSITION_MSB, AD2S1210_REG_VELOCITY_LSB),
+	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
+	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
+	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
+};
+
+static const struct regmap_access_table ad2s1210_regmap_rd_table = {
+	.yes_ranges = ad2s1210_regmap_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_readable_ranges),
+};
+
+static const struct regmap_range ad2s1210_regmap_writeable_ranges[] = {
+	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
+	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
+	regmap_reg_range(AD2S1210_REG_SOFT_RESET, AD2S1210_REG_SOFT_RESET),
+	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
+};
+
+static const struct regmap_access_table ad2s1210_regmap_wr_table = {
+	.yes_ranges = ad2s1210_regmap_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_writeable_ranges),
+};
+
+static int ad2s1210_setup_regmap(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.disable_locking = true,
+		.reg_read = ad2s1210_regmap_reg_read,
+		.reg_write = ad2s1210_regmap_reg_write,
+		.rd_table = &ad2s1210_regmap_rd_table,
+		.wr_table = &ad2s1210_regmap_wr_table,
+		.can_sleep = true,
+	};
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "failed to allocate register map\n");
+
+	return 0;
+}
+
 static int ad2s1210_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -679,6 +722,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = ad2s1210_setup_regmap(st);
+	if (ret < 0)
+		return ret;
+
 	ret = ad2s1210_initial(st);
 	if (ret < 0)
 		return ret;
-- 
2.34.1

