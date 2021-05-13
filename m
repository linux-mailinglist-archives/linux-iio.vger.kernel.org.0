Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0D37F679
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhEMLME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 07:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhEMLME (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 07:12:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD0C06174A
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 04:10:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t15so2847455edr.11
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/q+s57F67pD/twDnWoAFb0ySoFRs7juRREvhDykgyhg=;
        b=OHdVmKJG3AY8kWYIsPPBdHN7CfQlhu1aVPg0R4/Hh9Xx7IAn5pz7BUcP8bKIwJ2IfD
         JJT427bh9K1jA3reM9KipQGGAcQkFzO6jmFLdrMjzJ8hG2hGF2I5wdU7GKXTG222gOu4
         PQhfbABzWs6Uu2aBVvTm/+OPIL2DQwM9CqValwucdcb0GYaF+hDlKtZhBb6qskVMcAw3
         YaJe7ROmGuJursaEc7fM1FdLqb21XB5WVe8M/INjBU8AwLY/mLAzET40NxkwPuGAAX6j
         xmvjSqhVSY9RMG8v35Pd8bjZLujjVFxn6BdyjaHh96LDKnSwisOcnQhx+UGiu+IH4Y2Q
         waAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/q+s57F67pD/twDnWoAFb0ySoFRs7juRREvhDykgyhg=;
        b=kWxc9Y4v4yU6jVXbGpMMvSng/VXV6UQRAiJFudAxXhiDQhgwAO7jMKhDZbZCjC8Khr
         hCqdS2x5BQs3y2K+XGmLlg1eOGK5PnQDLfFpKMXElt+ibWKmJ76Xn+PDeVBAsnKokfau
         7pMYJbNqAxabOMuwY91h/9IP9jYK116BvTzct4VvAIKC5TRjTq9JyxO+YhkCC2cYyuY5
         xlJqOzm4wtdQUOnqQ077VhGN9gWx3JqnSGXttG9wIUxSqCnL7w8cEBGxn6NJEERPvmDu
         yYjX2uwPWTeXbla5/Bzcx0AJvoZgzXongZZlbF50wk6k6mvAMvDDJpTy18YDNZptpHqn
         q5Fg==
X-Gm-Message-State: AOAM532JgDlJHjc9zLj7EfT1zXtH3SjYXydUYjg08SkmW9IrXMHq19RX
        mr5OuYvY4x4PvNYzIaAipwkEUeTBtDMVeA==
X-Google-Smtp-Source: ABdhPJxRKb3uFpu2SvvOvlzHI8VRlYXm7ByX5DXV9lxg9RmyP/roTBsOTitJWjxAxi0rY6RhcKxhmg==
X-Received: by 2002:a50:a446:: with SMTP id v6mr46914399edb.254.1620904252708;
        Thu, 13 May 2021 04:10:52 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id i19sm1590749ejd.114.2021.05.13.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:10:52 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, kernel@pengutronix.de, dmuprhy@ti.com,
        martenli@axis.com, alazar@startmail.com, tremyfr@yahoo.fr,
        linux@deviqon.com, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: remove unused private data assigned with spi_set_drvdata()
Date:   Thu, 13 May 2021 14:10:35 +0300
Message-Id: <20210513111035.77950-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These were usually used before the conversion to devm_ functions, so that
the remove hook would be able to retrieve the pointer and do cleanups on
remove.
When the conversion happened, they should have been removed, but were
omitted.

Some drivers were copied from drivers that fit the criteria described
above. In any case, in order to prevent more drivers from being used as
example (and have spi_set_drvdata() needlessly set), this change removes it
from the IIO ADC group.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7476.c        | 2 --
 drivers/iio/adc/ad7766.c        | 2 --
 drivers/iio/adc/ad7768-1.c      | 1 -
 drivers/iio/adc/ad7887.c        | 1 -
 drivers/iio/adc/ad9467.c        | 2 --
 drivers/iio/adc/hi8435.c        | 1 -
 drivers/iio/adc/max1027.c       | 2 --
 drivers/iio/adc/max1241.c       | 2 --
 drivers/iio/adc/ti-adc084s021.c | 3 ---
 drivers/iio/adc/ti-ads124s08.c  | 2 --
 drivers/iio/adc/ti-tsc2046.c    | 2 --
 11 files changed, 20 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 9d5a71df02b0..a1e8b32671cf 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -389,8 +389,6 @@ static int ad7476_probe(struct spi_device *spi)
 	if (IS_ERR(st->convst_gpio))
 		return PTR_ERR(st->convst_gpio);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 236a455aaa18..61184ef24140 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -273,8 +273,6 @@ static int ad7766_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
-
 	ad7766->spi = spi;
 
 	/* First byte always 0 */
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 41752777e96c..8615485490b3 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -610,7 +610,6 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 
 	indio_dev->channels = ad7768_channels;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 9b3cbe1ddc6f..f64999714a4d 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -268,7 +268,6 @@ static int ad7887_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 19a45dd43796..dbfc8517cb8a 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -434,8 +434,6 @@ static int ad9467_probe(struct spi_device *spi)
 		mdelay(10);
 	}
 
-	spi_set_drvdata(spi, st);
-
 	conv->chip_info = &info->axi_adc_info;
 
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 074c30970465..8b353e26668e 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -483,7 +483,6 @@ static int hi8435_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(reset_gpio, 1);
 	}
 
-	spi_set_drvdata(spi, idev);
 	mutex_init(&priv->lock);
 
 	idev->name		= spi_get_device_id(spi)->name;
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index e3c8ec107722..655ab02d03d8 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -430,8 +430,6 @@ static int max1027_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index 0cbbb3c56d08..b60f8448f21a 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -147,8 +147,6 @@ static int max1241_probe(struct spi_device *spi)
 	adc->spi = spi;
 	mutex_init(&adc->lock);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	adc->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(adc->vdd)) {
 		dev_err(dev, "failed to get vdd regulator\n");
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 33aea961d850..ce3f5a3814f9 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -210,9 +210,6 @@ static int adc084s021_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	/* Connect the SPI device and the iio dev */
-	spi_set_drvdata(spi, indio_dev);
-
 	/* Initiate the Industrial I/O device */
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index b4a128b19188..17d0da5877a9 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -327,8 +327,6 @@ static int ads124s_probe(struct spi_device *spi)
 
 	ads124s_priv->chip_info = &ads124s_chip_info_tbl[spi_id->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
-
 	ads124s_priv->spi = spi;
 
 	indio_dev->name = spi_id->name;
diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 89a818b653b4..26c98b3d74f1 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -639,8 +639,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	priv = iio_priv(indio_dev);
 	priv->dcfg = dcfg;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	priv->spi = spi;
 
 	indio_dev->name = TI_TSC2046_NAME;
-- 
2.31.1

