Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B327A89FB
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjITRDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjITRDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 13:03:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86DD3
        for <linux-iio@vger.kernel.org>; Wed, 20 Sep 2023 10:03:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso31033f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 20 Sep 2023 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695229402; x=1695834202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0qi+KbLecqFKhPv3lS1tkBt/BnZ4XVrImU5Wur+NK0=;
        b=bEGB4AcMMYeEkrsP3MWy9LN2HdwVqKV6iwa/U3j1tuCxLrL61CWTYIC1LOXKHEsKzx
         khZZMQVZyorzA+nsbKY1wpNCC/kjQG/XlNEXEnRUa6M15c1VYDz/eKo5a3obQnec78Om
         /ia1JMb6PigujqvinHzuwMYMbohEjB1OG1wqbJ37kb0krhUqljgMsM9uMzoMuQVK+M/x
         tWu8oqetCywpD0Mz3/sHlEbHt7FP4xXm+xg066WSetZe4xsyGxVMPdlMLDz5rkXfDhYJ
         odz7GvoaXRqlqxbudz3uS19MhdmDp6wP62Ge5CuQvl+s7nV1CaRXScJGS82BVFW7eU0A
         ewYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229402; x=1695834202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0qi+KbLecqFKhPv3lS1tkBt/BnZ4XVrImU5Wur+NK0=;
        b=VoG5kAurykDv+Sx8L1WyXlMWAeuMq9pXSbWasdR08MTCKAmfg8JwGMlXVdJ96nZ3cy
         wG5HuBb02gyvOH3WLzcguE1O/1aQNhS5d9Truoa0KRJQgLkITuWPAzfJWKPO34woswL8
         6sxeOMiWyzma2BMZdDoYDMYHIRHsnh8p4/tDFCyDY2TPRFKJnzw89q7limpY1oPhDI4l
         MInAWJA+9O60qAuomRd2gGraTd/5uWi6MVqOhkTHnh8eL5vvseWpg+0CmyTCjRzS9Xw+
         wilu1oQaDmz8gVNp9UGcfx94I4KN2V0mUaoDP1ah2lyY+kVsgGMeMDbWyWNFIgQbMxJg
         N8tg==
X-Gm-Message-State: AOJu0Yyy2YUrRLfYcps59zTWderuOo3dXrR7Ew6WMlYhKuJ0bRke7RbI
        huC8mJ07V64yQde6DlAwca1P6RzZqefHernyGz9nVx4s
X-Google-Smtp-Source: AGHT+IHWn8HSO3o4m52y0ff1wXqC4uY9vLIafgCIvOpsgkokz5ae5HWBtPK72dyqhcON6OFbiEftig==
X-Received: by 2002:a5d:58cd:0:b0:321:4de3:fd5c with SMTP id o13-20020a5d58cd000000b003214de3fd5cmr2929754wrf.51.1695229402288;
        Wed, 20 Sep 2023 10:03:22 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id g10-20020adff3ca000000b003200c918c81sm11221089wrp.112.2023.09.20.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:03:21 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: [PATCH 3/4] staging: iio: resolver: remove ad2s1210 driver
Date:   Wed, 20 Sep 2023 12:02:52 -0500
Message-Id: <20230920170253.203395-4-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920170253.203395-1-dlechner@baylibre.com>
References: <20230920170253.203395-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes the AD2S1210 resolver driver from staging. It will be
improved and resubmitted out of staging.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/Kconfig             |   1 -
 drivers/staging/iio/Makefile            |   1 -
 drivers/staging/iio/resolver/Kconfig    |  18 -
 drivers/staging/iio/resolver/Makefile   |   6 -
 drivers/staging/iio/resolver/ad2s1210.c | 716 ------------------------
 5 files changed, 742 deletions(-)
 delete mode 100644 drivers/staging/iio/resolver/Kconfig
 delete mode 100644 drivers/staging/iio/resolver/Makefile
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index d3968fe2ebb8..a60631c1f449 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -10,6 +10,5 @@ source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
-source "drivers/staging/iio/resolver/Kconfig"
 
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index c50f1019f829..628583535393 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -8,4 +8,3 @@ obj-y += adc/
 obj-y += addac/
 obj-y += frequency/
 obj-y += impedance-analyzer/
-obj-y += resolver/
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
deleted file mode 100644
index 6d1e2622e0b0..000000000000
--- a/drivers/staging/iio/resolver/Kconfig
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Resolver/Synchro drivers
-#
-menu "Resolver to digital converters"
-
-config AD2S1210
-	tristate "Analog Devices ad2s1210 driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say yes here to build support for Analog Devices spi resolver
-	  to digital converters, ad2s1210, provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad2s1210.
-
-endmenu
diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
deleted file mode 100644
index 398631f7e79b..000000000000
--- a/drivers/staging/iio/resolver/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for Resolver/Synchro drivers
-#
-
-obj-$(CONFIG_AD2S1210) += ad2s1210.o
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
deleted file mode 100644
index 06de5823eb8e..000000000000
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ /dev/null
@@ -1,716 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
- *
- * Copyright (c) 2010-2010 Analog Devices Inc.
- */
-#include <linux/types.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/of.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-#define DRV_NAME "ad2s1210"
-
-#define AD2S1210_DEF_CONTROL		0x7E
-
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
-#define AD2S1210_REG_LOS_THRD		0x88
-#define AD2S1210_REG_DOS_OVR_THRD	0x89
-#define AD2S1210_REG_DOS_MIS_THRD	0x8A
-#define AD2S1210_REG_DOS_RST_MAX_THRD	0x8B
-#define AD2S1210_REG_DOS_RST_MIN_THRD	0x8C
-#define AD2S1210_REG_LOT_HIGH_THRD	0x8D
-#define AD2S1210_REG_LOT_LOW_THRD	0x8E
-#define AD2S1210_REG_EXCIT_FREQ		0x91
-#define AD2S1210_REG_CONTROL		0x92
-#define AD2S1210_REG_SOFT_RESET		0xF0
-#define AD2S1210_REG_FAULT		0xFF
-
-#define AD2S1210_MIN_CLKIN	6144000
-#define AD2S1210_MAX_CLKIN	10240000
-#define AD2S1210_MIN_EXCIT	2000
-#define AD2S1210_MAX_EXCIT	20000
-#define AD2S1210_MIN_FCW	0x4
-#define AD2S1210_MAX_FCW	0x50
-
-#define AD2S1210_DEF_EXCIT	10000
-
-enum ad2s1210_mode {
-	MOD_POS = 0,
-	MOD_VEL,
-	MOD_CONFIG,
-	MOD_RESERVED,
-};
-
-enum ad2s1210_gpios {
-	AD2S1210_SAMPLE,
-	AD2S1210_A0,
-	AD2S1210_A1,
-	AD2S1210_RES0,
-	AD2S1210_RES1,
-};
-
-struct ad2s1210_gpio {
-	const char *name;
-	unsigned long flags;
-};
-
-static const struct ad2s1210_gpio gpios[] = {
-	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_OUT_LOW },
-};
-
-static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
-
-struct ad2s1210_state {
-	struct mutex lock;
-	struct spi_device *sdev;
-	struct gpio_desc *gpios[5];
-	unsigned int fclkin;
-	unsigned int fexcit;
-	bool hysteresis;
-	u8 resolution;
-	enum ad2s1210_mode mode;
-	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
-	u8 tx[2];
-};
-
-static const int ad2s1210_mode_vals[4][2] = {
-	[MOD_POS] = { 0, 0 },
-	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 1 },
-};
-
-static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
-				     struct ad2s1210_state *st)
-{
-	gpiod_set_value(st->gpios[AD2S1210_A0], ad2s1210_mode_vals[mode][0]);
-	gpiod_set_value(st->gpios[AD2S1210_A1], ad2s1210_mode_vals[mode][1]);
-	st->mode = mode;
-}
-
-/* write 1 bytes (address or data) to the chip */
-static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
-{
-	int ret;
-
-	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = data;
-	ret = spi_write(st->sdev, st->tx, 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-/* read value from one of the registers */
-static int ad2s1210_config_read(struct ad2s1210_state *st,
-				unsigned char address)
-{
-	struct spi_transfer xfers[] = {
-		{
-			.len = 1,
-			.rx_buf = &st->rx[0],
-			.tx_buf = &st->tx[0],
-			.cs_change = 1,
-		}, {
-			.len = 1,
-			.rx_buf = &st->rx[1],
-			.tx_buf = &st->tx[1],
-		},
-	};
-	int ret = 0;
-
-	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = address | AD2S1210_MSB_IS_HIGH;
-	st->tx[1] = AD2S1210_REG_FAULT;
-	ret = spi_sync_transfer(st->sdev, xfers, 2);
-	if (ret < 0)
-		return ret;
-
-	return st->rx[1];
-}
-
-static inline
-int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
-{
-	int ret;
-	unsigned char fcw;
-
-	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
-	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
-		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
-		return -ERANGE;
-	}
-
-	ret = ad2s1210_config_write(st, AD2S1210_REG_EXCIT_FREQ);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, fcw);
-}
-
-static const int ad2s1210_res_pins[4][2] = {
-	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
-};
-
-static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
-{
-	gpiod_set_value(st->gpios[AD2S1210_RES0],
-			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
-	gpiod_set_value(st->gpios[AD2S1210_RES1],
-			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
-}
-
-static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
-{
-	int ret;
-
-	ret = ad2s1210_config_write(st, AD2S1210_REG_SOFT_RESET);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, 0x0);
-}
-
-static ssize_t ad2s1210_show_fclkin(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fclkin);
-}
-
-static ssize_t ad2s1210_store_fclkin(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fclkin;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fclkin);
-	if (ret)
-		return ret;
-	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
-		dev_err(dev, "ad2s1210: fclkin out of range\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&st->lock);
-	st->fclkin = fclkin;
-
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_show_fexcit(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fexcit);
-}
-
-static ssize_t ad2s1210_store_fexcit(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fexcit;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fexcit);
-	if (ret < 0)
-		return ret;
-	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
-		dev_err(dev,
-			"ad2s1210: excitation frequency out of range\n");
-		return -EINVAL;
-	}
-	mutex_lock(&st->lock);
-	st->fexcit = fexcit;
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_show_control(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : sprintf(buf, "0x%x\n", ret);
-}
-
-static ssize_t ad2s1210_store_control(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char udata;
-	unsigned char data;
-	int ret;
-
-	ret = kstrtou8(buf, 16, &udata);
-	if (ret)
-		return -EINVAL;
-
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = udata & AD2S1210_MSB_IS_LOW;
-	ret = ad2s1210_config_write(st, data);
-	if (ret < 0)
-		goto error_ret;
-
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev,
-			"ad2s1210: write control register fail\n");
-		goto error_ret;
-	}
-	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	ad2s1210_set_resolution_pin(st);
-	ret = len;
-	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
-static ssize_t ad2s1210_show_resolution(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%d\n", st->resolution);
-}
-
-static ssize_t ad2s1210_store_resolution(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char data;
-	unsigned char udata;
-	int ret;
-
-	ret = kstrtou8(buf, 10, &udata);
-	if (ret || udata < 10 || udata > 16) {
-		dev_err(dev, "ad2s1210: resolution out of range\n");
-		return -EINVAL;
-	}
-	mutex_lock(&st->lock);
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
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = ret;
-	if (data & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev, "ad2s1210: setting resolution fail\n");
-		goto error_ret;
-	}
-	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	ad2s1210_set_resolution_pin(st);
-	ret = len;
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
-/* read the fault register since last sample */
-static ssize_t ad2s1210_show_fault(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : sprintf(buf, "0x%x\n", ret);
-}
-
-static ssize_t ad2s1210_clear_fault(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	int ret;
-
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
-	if (ret < 0)
-		goto error_ret;
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_show_reg(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, iattr->address);
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : sprintf(buf, "%d\n", ret);
-}
-
-static ssize_t ad2s1210_store_reg(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char data;
-	int ret;
-	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret)
-		return -EINVAL;
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, iattr->address);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : len;
-}
-
-static int ad2s1210_read_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int *val,
-			     int *val2,
-			     long m)
-{
-	struct ad2s1210_state *st = iio_priv(indio_dev);
-	u16 negative;
-	int ret = 0;
-	u16 pos;
-	s16 vel;
-
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	/* delay (6 * tck + 20) nano seconds */
-	udelay(1);
-
-	switch (chan->type) {
-	case IIO_ANGL:
-		ad2s1210_set_mode(MOD_POS, st);
-		break;
-	case IIO_ANGL_VEL:
-		ad2s1210_set_mode(MOD_VEL, st);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	if (ret < 0)
-		goto error_ret;
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0)
-		goto error_ret;
-
-	switch (chan->type) {
-	case IIO_ANGL:
-		pos = be16_to_cpup((__be16 *)st->rx);
-		if (st->hysteresis)
-			pos >>= 16 - st->resolution;
-		*val = pos;
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_ANGL_VEL:
-		vel = be16_to_cpup((__be16 *)st->rx);
-		vel >>= 16 - st->resolution;
-		if (vel & 0x8000) {
-			negative = (0xffff >> st->resolution) << st->resolution;
-			vel |= negative;
-		}
-		*val = vel;
-		ret = IIO_VAL_INT;
-		break;
-	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
-	}
-
-error_ret:
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, 0644,
-		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
-static IIO_DEVICE_ATTR(control, 0644,
-		       ad2s1210_show_control, ad2s1210_store_control, 0);
-static IIO_DEVICE_ATTR(bits, 0644,
-		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
-static IIO_DEVICE_ATTR(fault, 0644,
-		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
-
-static IIO_DEVICE_ATTR(los_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOS_THRD);
-static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_OVR_THRD);
-static IIO_DEVICE_ATTR(dos_mis_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_MIS_THRD);
-static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_RST_MAX_THRD);
-static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_RST_MIN_THRD);
-static IIO_DEVICE_ATTR(lot_high_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOT_HIGH_THRD);
-static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOT_LOW_THRD);
-
-static const struct iio_chan_spec ad2s1210_channels[] = {
-	{
-		.type = IIO_ANGL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
-};
-
-static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
-	&iio_dev_attr_fexcit.dev_attr.attr,
-	&iio_dev_attr_control.dev_attr.attr,
-	&iio_dev_attr_bits.dev_attr.attr,
-	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_los_thrd.dev_attr.attr,
-	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
-	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
-	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
-	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_high_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_low_thrd.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad2s1210_attribute_group = {
-	.attrs = ad2s1210_attributes,
-};
-
-static int ad2s1210_initial(struct ad2s1210_state *st)
-{
-	unsigned char data;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ad2s1210_set_resolution_pin(st);
-
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = AD2S1210_DEF_CONTROL & ~(AD2S1210_SET_RESOLUTION);
-	data |= (st->resolution - 10) >> 1;
-	ret = ad2s1210_config_write(st, data);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		goto error_ret;
-	}
-
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
-static const struct iio_info ad2s1210_info = {
-	.read_raw = ad2s1210_read_raw,
-	.attrs = &ad2s1210_attribute_group,
-};
-
-static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
-{
-	struct spi_device *spi = st->sdev;
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
-		st->gpios[i] = devm_gpiod_get(&spi->dev, gpios[i].name,
-					      gpios[i].flags);
-		if (IS_ERR(st->gpios[i])) {
-			ret = PTR_ERR(st->gpios[i]);
-			dev_err(&spi->dev,
-				"ad2s1210: failed to request %s GPIO: %d\n",
-				gpios[i].name, ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int ad2s1210_probe(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev;
-	struct ad2s1210_state *st;
-	int ret;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
-
-	spi_set_drvdata(spi, indio_dev);
-
-	mutex_init(&st->lock);
-	st->sdev = spi;
-	st->hysteresis = true;
-	st->mode = MOD_CONFIG;
-	st->resolution = 12;
-	st->fexcit = AD2S1210_DEF_EXCIT;
-
-	indio_dev->info = &ad2s1210_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ad2s1210_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
-	indio_dev->name = spi_get_device_id(spi)->name;
-
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
-	ad2s1210_initial(st);
-
-	return 0;
-}
-
-static const struct of_device_id ad2s1210_of_match[] = {
-	{ .compatible = "adi,ad2s1210", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
-
-static const struct spi_device_id ad2s1210_id[] = {
-	{ "ad2s1210" },
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad2s1210_id);
-
-static struct spi_driver ad2s1210_driver = {
-	.driver = {
-		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(ad2s1210_of_match),
-	},
-	.probe = ad2s1210_probe,
-	.id_table = ad2s1210_id,
-};
-module_spi_driver(ad2s1210_driver);
-
-MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD2S1210 Resolver to Digital SPI driver");
-MODULE_LICENSE("GPL v2");
-- 
2.34.1

