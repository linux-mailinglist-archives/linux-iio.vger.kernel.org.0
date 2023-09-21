Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15387A9F21
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIUUSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIUURu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:17:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B05A007
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:20:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502b0d23f28so2079174e87.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316838; x=1695921638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=z9Sp6KlC8MYRvpyQ4Rn45KIKhCZDSeGyb5Uzv8glvxu/fgQh5NRHbLgLccchuz9E8l
         1AOf9qfekJ5W7PqzvVrpeS9ItS0GVYbgYgaoQpYkIDO06Q61hqFnjex71ZucI6BdzLlv
         E2HHJm1jCk+JPGiTXOHe2Morl4O0Q9H0ykKoH9cjD1IFeFCEAw/EQ/bvBcpknszKAjoR
         I40Ast8y61lLeXypxY9r2jJRXCRkx5Otmiw+ytgtBKomJHjStyBU7AFqoq6pCAVpkMYU
         +j0zXTdIHOaENfzUx9z9lofckRHhh8S2SomI2YJT3VlQfwEFrZCMYmAMh+jT2J9X6/a7
         K+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316838; x=1695921638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=A1G+qqNuImBlm0Ejruarmg48o8rjTALENu+ltpCfrbWDmq9CjFcxd5OszQ93sX2o/X
         BoPiD4ADp+Bs7135o7t3RlKLvp3OoLbHX91hk21aLbylH0ndgkfuv35n3asy4RePRUAP
         kwGznv7K9fVpVaKrYBzT058yEiJ2tio2ooF7FeWT+goZlRlapw2NNa/0NogSM7Eg1nUm
         D+u/VfSWVP0RVwkoI5scWV/TilKHgBSeMhu5cBQzY7GRO9Agl7I4DLZtTH6R4H9TmyWk
         sa9ysTM9e7miIduNFtJF7TbASvxKJLe9OVTpWEDZeZL4PIAI6d8vG4hNPPmibStfE7ct
         JWKQ==
X-Gm-Message-State: AOJu0Yz9113TjBLYgJsCtPMeetct/46KJfxS/IpfRYyyfQEJZ3RXDdgX
        L9I/Zm+QhBSvSln3hhoXBTcftpbCTPDmzeLHniSk85Ro
X-Google-Smtp-Source: AGHT+IHNEr10kFqru6shnxnQjCxmHgYq/iqV95+VoS8aS+sGpqc8B3o89A4hIe6FM7kiYkFbjggLAA==
X-Received: by 2002:adf:f88f:0:b0:31d:3669:1c55 with SMTP id u15-20020adff88f000000b0031d36691c55mr5308299wrp.65.1695306153705;
        Thu, 21 Sep 2023 07:22:33 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:33 -0700 (PDT)
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
Subject: [PATCH 2/2] staging: iio: resolver: ad2s1210: add triggered buffer support
Date:   Thu, 21 Sep 2023 09:19:30 -0500
Message-Id: <20230921141947.57784-5-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

