Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429B7A96A0
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIURJL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjIURIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:08:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E305FC7
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:05:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503065c4b25so2018330e87.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695315866; x=1695920666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=FTKhmdRKziNVonAqV1tS+yANcIBLFlvcT8TzgRhZaoz4OEW49UpItsU6gTm2Gdikfe
         v4vwWjU3nu+v5avjWqrQlN0cJOJmxO5WPH1CTfHP4pvjWQfu4FDI7qWvINIRymkA1NFZ
         5aUk8gh0Ru5fNHzrVdYvNHsTMlN+0D2l35Db0t20YVyBsUVe8RPm0Sh+0yIB4rG1M9xy
         D0OLf1cLcjrX+Eu5uJ2k4aNNBX4fg3cTUmSOYnPF6MsgOzLHyuJ/rlNik9zi5K72Ccrq
         mu58FnPMkjo7T9tjthbluhSd3qEbpWBrm6Z/iZfn74Vv3N3Er46GlLdw4VaTLBE77iws
         obZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315866; x=1695920666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=toKFXh5nKuA1Vv74zwQB3yds9PSpiY0pfUOwDeHv1oIspbTTyZbPdRARNuBduA2umq
         nSlisuUQl2hD7Vx0kVJpQL5bt5Hwf9l4zZtcvpD7F+g0LfuXJWAV6Dhn97udltEUWKn1
         c7LLlaJUgk9ehLCHE6w2jrfm3DPwCHv+zHIkpgTyHwNWn3x7ZwwfPqlPLdBM/3GuIkSu
         flit9bwU2OZBzPUcHFsIAp+//eYIR9Gkxoe4PNc/4uWP6DpJe28GztSRM5V3RlYpv8KQ
         wrapFzaryqkU8avYKcM5t1kfRSEq1lcD6oWk1n70MMG4oDQpin7pVvAux3bGRHtIC7WW
         w/qg==
X-Gm-Message-State: AOJu0Yz9TGJgIrgIKZJUCD93yizAKgoor7eg7nSgn/3500fl19+38vOX
        c3an6U9tAZyV9CbRZxVHJ3/rHwe56P5Y/8x4MOI8flep
X-Google-Smtp-Source: AGHT+IE3B+SaoX0g3CMJ9V5Y/q70jyzL1xViK2W3Iiv0NWLiHVmRrng5O6gT7YrWiM082uoyEj3L0A==
X-Received: by 2002:a05:600c:152:b0:404:2dbb:8943 with SMTP id w18-20020a05600c015200b004042dbb8943mr5663278wmm.2.1695306169283;
        Thu, 21 Sep 2023 07:22:49 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:49 -0700 (PDT)
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
Subject: [v2 19/19] staging: iio: resolver: ad2s1210: add triggered buffer support
Date:   Thu, 21 Sep 2023 09:19:47 -0500
Message-Id: <20230921141947.57784-22-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for triggered buffers to the AD2S1210 resolver driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 84 ++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f5b8b290e860..44a2ecaeeeff 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -19,8 +19,11 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DRV_NAME "ad2s1210"
 
@@ -85,6 +88,12 @@ struct ad2s1210_state {
 	unsigned long fclkin;
 	/** The selected resolution */
 	enum ad2s1210_resolution resolution;
+	/** Scan buffer */
+	struct {
+		__be16 chan[2];
+		/* Ensure timestamp is naturally aligned. */
+		s64 timestamp __aligned(8);
+	} scan;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
 };
@@ -592,18 +601,35 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.info_mask_separate_available =
 					BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.datasheet_name = "position",
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
-	}
+		.datasheet_name = "velocity",
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static struct attribute *ad2s1210_attributes[] = {
@@ -665,6 +691,55 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	size_t chan = 0;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	memset(&st->scan, 0, sizeof(st->scan));
+	gpiod_set_value(st->sample_gpio, 1);
+
+	if (test_bit(0, indio_dev->active_scan_mask)) {
+		ret = ad2s1210_set_mode(st, MOD_POS);
+		if (ret < 0)
+			goto error_ret;
+
+		/* REVIST: we can read 3 bytes here and also get fault flags */
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_ret;
+
+		memcpy(&st->scan.chan[chan++], st->rx, 2);
+	}
+
+	if (test_bit(1, indio_dev->active_scan_mask)) {
+		ret = ad2s1210_set_mode(st, MOD_VEL);
+		if (ret < 0)
+			goto error_ret;
+
+		/* REVIST: we can read 3 bytes here and also get fault flags */
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_ret;
+
+		memcpy(&st->scan.chan[chan++], st->rx, 2);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+
+error_ret:
+	gpiod_set_value(st->sample_gpio, 0);
+	mutex_unlock(&st->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.read_avail = ad2s1210_read_avail,
@@ -850,6 +925,13 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad2s1210_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.34.1

