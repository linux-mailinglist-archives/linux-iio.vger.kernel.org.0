Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9437F784
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhEMMKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhEMMJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8EC061760
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n25so30707633edr.5
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=meABjWyjJzNCmMmk4uABA27da+3g1Rm0qYKHF6KbuXw8Pnf0wpfrJRxnnunsgzRbwF
         9rZj3la9fEWk7ePr9pXJWHuxGPkLu6nU0CNkY7UQoDN0o5wWM9mNiiv+gpo5aQzt8k34
         J+ED/E0pBhEoL9qxwgBKNT6ZOztVIZ6TQQODCE11Unkok1tEo72vqZQhfP8j8FZdZw7h
         ZPqg1kDeIMk3RKaI0O/1DkoBBpbXMQVVGA2dUePI8WTEBS2Pz5SO/fwjMtALFIqKNn/6
         q0SlMFRRvzz1xJ7vir7UJgFnRln4qK8WDRSqh+TA1mvo7Ovyok0ppqqKn7qyE2Xma4jV
         GM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=N1T0/2HUBZWyymknk0IPczPC5pqi14s6sYNNR+Bg8rQhXoWwOT2pCxXKM6h7lZweek
         Z143Lr61Lil0O6OljwLtABHTql+6LzOIc+m08vYvAFJA0cTt6VBdU633njbebxExi8Es
         Q+reAib5h9RIM7fjAu/pDhbcEOujvwxKl2r72cRDAZvNvg4JVosQV4DF0D5ZQIqD17cK
         dr4m4O+MKz6jdlratJlwm15G38ilwYBYcqouThsEZkA0+YqsXrCS9JMnbcmznUMaV9pZ
         sd5XhGkl6ABeQ4f3bcD2l2SUXRAA/4fmFmNNoZtAWC4VjR2F64Mh8Fi5fKGwTyNZ2Hyu
         kkSQ==
X-Gm-Message-State: AOAM530uRNo3jRuy5ttSoyN3CWNxvxX5RFYkCXmu1hQWUqTrD26f/K3r
        3dLsdiwJf5DbJa7VV5VGSmuKEAyDBLRxaw==
X-Google-Smtp-Source: ABdhPJzDDUdu8llXB1/j62SmZAhmCS+7LxStlTRv8lKnpNYr7NwOwuLEpB7BqGBMJb/OqUJCGPMGIA==
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr50286207edt.4.1620907687135;
        Thu, 13 May 2021 05:08:07 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:06 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 08/12] iio: adc: ad7780: convert to device-managed functions
Date:   Thu, 13 May 2021 15:07:48 +0300
Message-Id: <20210513120752.90074-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

