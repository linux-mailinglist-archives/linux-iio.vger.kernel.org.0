Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5817937D372
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbhELSWM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350799AbhELRwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:52:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD7C06134C
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so36250596ejc.10
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=g0mM27wtPuRCt6rBjngtsvAOSrPcnf7C/Z7EhpJ0zXwIn23BKQFAUsNFCtqdCY/XTh
         h0TWgja4t+6wQ5d7kytntR6viEA9iO8pTIRjoDk3h463/FyTbtPZgHy+5sPEZMN0A6FY
         0w0cF/J6JarAesGk9Zc8NkfsHL3n1M0b+mWUTIzse6PmegkLdEJ4DDWRrx2C3I7d8NVW
         /65nqrpWdLsmeVEkz0PP2YRClpX4e6VqXtNBHahYNni+rM/ue7Lh9UzD8+Dh/jJfVFj4
         hopnjreFvZdW/vT+VhOCrZNUnobe6WlqZ3b0EenHIcQAkVxP08gFVxsMHp2R6XSggQmm
         xmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=WZfIATLu1560kd/2Mh8l6M37mTasnHWF2GHwyWr6rMoesvPRHiq7kSH5DrJivY7K/z
         aK0hsCiT9HyfTZmQ/PGmywBHxzlA1InG3W/oglRiUjFsLwNFs1UeVH3B5sSzuoZi7H8z
         HCLpkLjBpD34oTIHwCnP+/SYIO7D8PjYFjyuDgoUlYvxtUblyKRy1DDkBxVxd0FL9eX2
         OHoGnOkmelSIR/7dUeJsphxGr4Gsuh9Z+E9vNkU3DhVl6uwwE7mw2TtySF+r5EWo4I7O
         UR3XfwcAJ0tjAk36IHGz8BMTJUUh1sY6jpKACnTttTynF2uXkpcEhOlz8xE9AklZmAJT
         rIsA==
X-Gm-Message-State: AOAM5300vcCXaU4j2kjfF00rbOH1QUpnshRsFbzEuceI8WBW53VAP0q3
        tO3cEc5yVijGK+hF8ayxrB0Uus2xWPQ4Iw==
X-Google-Smtp-Source: ABdhPJxfBub/JbH4fkULgPfA6bjBJQqFm3EveARM0tNtexC6e+Td6lKU1VLpOfABtCh+fADbMukCXA==
X-Received: by 2002:a17:906:82cb:: with SMTP id a11mr39225121ejy.213.1620841804642;
        Wed, 12 May 2021 10:50:04 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:04 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 08/12] iio: adc: ad7780: convert to device-managed functions
Date:   Wed, 12 May 2021 20:49:10 +0300
Message-Id: <20210512174914.10549-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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

