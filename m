Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4512B378E4F
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbhEJNIt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351151AbhEJNDB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F136C061357
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128so9113157wma.5
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=Lr5e5hAhepix80/auVGmWv35sMZKiHwiPXMBvRRKvw47RJZz+6gL5h8mNIuKzpbFkR
         DZYeDuuL7bXfiq9iMvI3ve0Cz4gSwXaedKGggc08lzWhZwFlc0MXMpYtsqf/RiNnhjTG
         5qiMp5fk9zuDNHhoKMYZMoYl+ksXhMoy76WkPkwCQ/AfgIToljzrMdCfOoal1QkUJfRh
         hAQTy1S8KraibbRGTE6dFowX7oO9xB7GjNlj16zhDDvpU9a2mG/fNNGwYg+i4/J3477Z
         0NpwJGsUdCdj42IPm+lOf1UjV4HDz7jenxAUeOVufDk7FjaD3TRElF/fHbX/3Z7Fzp5h
         xxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=TxDH1p3wgIvZUE3EobURPW8HWfE6fBXrYzVLAd0ou9DzvpeXsZTklxR7LfXQmrAuVZ
         kFyjK+zdgyqF6sDCbNft6DQqjKNH35kMmCBerUnff45F+tJoKeo95uGOM+AFg37pZhVW
         C1snqC8EGLT9B5bQyyi1NZCbPzlB0NEjR/QWb1F5L/XAZSb6tLwM/xIW0SGg2W8t9GH6
         HbAn9tWWMyBb9zaXBoJu7HB4HDnbhliTWpqL0sqRj7fN6w9wtwmwl52fSl4JHoxI0RV4
         /aHLLgiZ0JFThXb6DCdm+/+ZUTdmzXIMkCWifgs4RjzL0SmsV1E/azEQKql65ptZbEM7
         bQiA==
X-Gm-Message-State: AOAM531D8d02eLRUeyZ6ISDLhdpGYaIB9vCM/a7NqbPvKliDJdpySH/q
        FWCkuSeV0uLiCgkx3cykoG0TduTor+4+Uw==
X-Google-Smtp-Source: ABdhPJzfCWIjFheLRodvW2tB3gcbbJCVkj6syVjdCT7p5qZAbqJOBuUqd9oKePnBH6ObA96mmWbrxA==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr26361635wmf.96.1620651354825;
        Mon, 10 May 2021 05:55:54 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:54 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 04/11] iio: adc: ad7780: convert to device-managed functions
Date:   Mon, 10 May 2021 15:55:16 +0300
Message-Id: <20210510125523.1271237-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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

