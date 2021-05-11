Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC337A0A3
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhEKHUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhEKHT4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA36C061345
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b17so21651695ede.0
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=Aru7+pGXL6R0fKf9Jmg/OM2Euu4Z/QeHfRHArxk3rw3BwaumbAzRhOyoJe/N5Qu53W
         mN0FLGnp4HHB7MsxdV0AlYQBRfXkpBZqM+v/48mq3w+veteFNtYcUUKch7BZayL8bu/7
         Ji2hxG7MOGP4im1WkWf8U9Syq5wkJIRlK79ylF2bPhqnySZZZ8U7F+Kce2F2RfHjbImp
         ZGdme/cWDsPP1b4JHMcsaXoBZF+nMV2aUl7aDAIw+4Pi9FCk9ldD7exJAvm0l7NgKhKL
         UN6v4bl5LR6GmNOCfTYI3vFwut0LVPKyW/ACqsrb7D9aUxPSOqDhpeVQ9tisKz616oRU
         4HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=Qz7lX6FyatH7Fpio+P5zOPblAGHOhEXoPXJi9jCxzcmOASIO+7mk3TsLztrMvGm7DW
         b4OEu29/LlkGZMWQwcWaO4whi8CNaV/PNex8KEqfnjJn5AIzWecKWIQtDZzBilu3ESil
         +LP73INbOcslm+bjOuzEJ5jzPpdCcsjrmwmur9A73uGkRFwAAGnS1gSKSeZpcNvnjCub
         +bSv+DrPd7WTENSqxL0c1OtvWQc8c8IpCVeKGOJv8Xh/15ZmP+e5yoV77+JGBRbxGUN5
         emqoCck2JEjZWPj1OMSRo//BtkaSrcIa8gbb6g5Qx+uuxakhzZm7LoL9ACvwulz0p2H+
         muWA==
X-Gm-Message-State: AOAM531VVY6Y5CwL2H9vnMctU5IlRyUrQNw/ZWlW3mwrKt5Xpds4vEGD
        Q1xb3Gjz9iQY/oZLg52L/qBnkal1KptJaHma
X-Google-Smtp-Source: ABdhPJxMfpNCThxaSXxZu/zeq9MhUQEZSVfqasIONNR0kSUdu0iZVVxhvo+41a/bkv+W/g4FsDm4Kw==
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr34772094edc.197.1620717523129;
        Tue, 11 May 2021 00:18:43 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:42 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 08/12] iio: adc: ad7780: convert to device-managed functions
Date:   Tue, 11 May 2021 10:18:27 +0300
Message-Id: <20210511071831.576145-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7780 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7780.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 42e7e8e595d1..42bb952f4738 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -300,6 +300,11 @@ static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
 	return 0;
 }
 
+static void ad7780_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_state *st;
@@ -318,8 +323,6 @@ static int ad7780_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
@@ -340,35 +343,15 @@ static int ad7780_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, ad7780_reg_disable, st->reg);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_buffer_and_trigger;
-
-	return 0;
-
-error_cleanup_buffer_and_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7780_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7780_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7780_id[] = {
@@ -385,7 +368,6 @@ static struct spi_driver ad7780_driver = {
 		.name	= "ad7780",
 	},
 	.probe		= ad7780_probe,
-	.remove		= ad7780_remove,
 	.id_table	= ad7780_id,
 };
 module_spi_driver(ad7780_driver);
-- 
2.31.1

