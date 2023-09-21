Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0757A9910
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjIUSK6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIUSKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 14:10:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414484625
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:37:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c022ce8114so22052241fa.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317850; x=1695922650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phvZq4VpwSFX4vyqlS17/uN/agj73xAJlQboMqH0z3o=;
        b=fB7vXW/NhMOI6Js/N26E3xJTM2CK9dwdtonKQCa9J0L3hICLNlHTMeHnWyMCCbY0Yv
         IjoWJ6KbrYO/MvAYhdesR8LFbRWaqV8X4eTulB05mO/pQ6pZkmaCbmLjvj+IjW55wV81
         Kce5HvWtPluOhtvOEUX0e2iGh/LkKIukXGVX8KOd4EWsGLreulEBG8sjbVnF4AW4b+i3
         Kig0lxjquOt9WG2qbRuhUJiUR0cWaDy7Yi/t+88kmmEMOX4SthkWD22bhQQ5rNg+EIju
         eI2m3/D+Y4ZjcrnSQ+m/Ums606n8+MrX698OvL49DygcLweR+Ael+BKtdnJf3EVrlEhY
         8U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317850; x=1695922650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phvZq4VpwSFX4vyqlS17/uN/agj73xAJlQboMqH0z3o=;
        b=Luz/YI+Ozm3eFBfuX4yLbt0Sc4rZvpI5SCY0dB36y5YV7n+QBvMb6TVxoxGe2Xf/Iu
         qQzbiyttvYxpgKJArsd40fbYLOuL8CZbcB/aPwhkRpOxae7ghrEN0IdgX3dRIX4fDPGY
         4zBwhrRTaoAl+OZ1XWDpBexblKqSidRnVCwvZvEUfYH+WhAvJclPXJhfgtD6CrXdKUDc
         mh4qL4mzl/iB4qd9uwx+tPW3EnYJ3xQUOcpGUQoq7vvoeuZARg0AqBhOMvgOb8SkXfEo
         77W3MhXxRpA+/tBS1K1zcEUJself4LthtOJ0TnKAz9bNm4fbhgd02phuXnKfOu6UZNON
         j3pQ==
X-Gm-Message-State: AOJu0YyFvgSpSCB/0jh3zaOZtCqJgigHsOzX6P7lEh2F19PkVixxxKh/
        3rIVaNkcboimd/gsgK25zk4juDEnZIF3r8in6vaanTfK
X-Google-Smtp-Source: AGHT+IFa6T7pfoopn5JTBSEWI36vfbyiw24+0AUsLx9pPvbJCm2m+UeOVaPi5jTX9jCOS8lz/+oyUg==
X-Received: by 2002:a05:600c:4ec7:b0:405:37bb:d93e with SMTP id g7-20020a05600c4ec700b0040537bbd93emr1147858wmq.9.1695307459769;
        Thu, 21 Sep 2023 07:44:19 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:19 -0700 (PDT)
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
Subject: [PATCH v2 08/19] staging: iio: resolver: ad2s1210: use devicetree to get fclkin
Date:   Thu, 21 Sep 2023 09:43:49 -0500
Message-Id: <20230921144400.62380-9-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes the fclkin sysfs attribute and replaces it with getting
the fclkin clock rate using the clk subsystem (i.e. from the
devicetree).

The fclkin clock comes from an external oscillator that is connected
directly to the AD2S1210 chip, so users of the sysfs attributes should
not need to be concerned with this.

Also sort includes while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/Kconfig    |  1 +
 drivers/staging/iio/resolver/ad2s1210.c | 76 +++++++++----------------
 2 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6d1e2622e0b0..bebb35822c9e 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -7,6 +7,7 @@ menu "Resolver to digital converters"
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
+	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say yes here to build support for Analog Devices spi resolver
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 95d43b241a75..153ac7704ad7 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -5,16 +5,17 @@
  * Copyright (c) 2010-2010 Analog Devices Inc.
  * Copyright (C) 2023 BayLibre, SAS
  */
-#include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -91,7 +92,8 @@ struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
-	unsigned int fclkin;
+	/** The external oscillator frequency in Hz. */
+	unsigned long fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
 	u8 resolution;
@@ -198,45 +200,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
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
 static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -546,8 +509,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(control, 0644,
@@ -596,7 +557,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
@@ -654,6 +614,24 @@ static const struct iio_info ad2s1210_info = {
 	.attrs = &ad2s1210_attribute_group,
 };
 
+static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	struct clk *clk;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	st->fclkin = clk_get_rate(clk);
+	if (st->fclkin < AD2S1210_MIN_CLKIN || st->fclkin > AD2S1210_MAX_CLKIN)
+		return dev_err_probe(dev, -EINVAL,
+				     "clock frequency out of range: %lu\n",
+				     st->fclkin);
+
+	return 0;
+}
+
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct spi_device *spi = st->sdev;
-- 
2.34.1

