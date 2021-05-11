Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20837A09F
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhEKHUA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKHTx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D05C06138A
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g14so21646851edy.6
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=Ngt4ldMeIjtsK1bTG61nOj3xVLJzWiXbfQ46F9gLilKHvEUmgNh1wjCjb5VfbmNdnf
         +P0f43WWGEe9IJMDH7sVDTAsHwTYX2wa1LGNII+4RfWJV6+09NjMrkDSUy2l1Z/r0uzW
         7cEKm0IGNTSXWOU7VmQr0GCikcEY6PkCzPQIlHeW6Yo9mZqheDfpz5MuGySR2bucm7YK
         LsBJcoBtnx1XqWC9ysiVXIppSdQ/0HCnBxe/Xk4/g7EKuZ8dE2RUTcc+JhLRLL4Z/Gxq
         FBB6tYsoqoytdBCg+Y1zirEaeCaaojTKws5OWKTkBw6vAuPx0Vd1mAzr35XmcvkVeVPY
         r1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=FxjdTjVlAwBn5Im+mL8hnhAjhbdVONZeK3dosAylOODxYT7SrDam1EvHftIAskcWEY
         XDLd1x2NZtc5e6KseCwkWbZJM/TEqt+CpZCWbMg0sADbV5UYBHOlHQNqHweZAXWEpRUn
         YtWgCko/GimQ9znm5GHlaiLb4rBC9wPXDK9zmN3rWP26b0s0IbC18C095wBvq7YbISb1
         m4EMEvd+2V0mci/5EAYjf/TvpE/y0YarkCF+UCXClKC5xelLtW2yxp105mXnlIMAzHbt
         KBagG9nse2ysnNP00bEC3A4mDaR9y105/78LrX9NdFVn5yaCkbKK9P0z3N6tsiXrQ0hg
         e5UA==
X-Gm-Message-State: AOAM5322xOAhKO/nGDKcyif5362eth9j2NvOUZbI4S5yWHLCSB9wbsvA
        b0tv3szowRXosJArQ0DwEqoWvjLi9ra/sZrs
X-Google-Smtp-Source: ABdhPJxaKUHgxAySwLu+3JslTTK3k1lv2ct/WvvBRWyge9DS+apk5ucW9haqyU+lwe6yNsx5ZMc8rw==
X-Received: by 2002:a05:6402:40c:: with SMTP id q12mr1848526edv.0.1620717521297;
        Tue, 11 May 2021 00:18:41 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:41 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 06/12] iio: adc: ad7793: convert to device-managed functions
Date:   Tue, 11 May 2021 10:18:25 +0300
Message-Id: <20210511071831.576145-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7793 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7793.c | 53 ++++++++++++----------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5e980a06258e..5dab2e5b5bac 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -768,6 +768,11 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
+static void ad7793_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -802,11 +807,13 @@ static int ad7793_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
+		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
+		if (ret)
+			return ret;
+
 		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0) {
-			ret = vref_mv;
-			goto error_disable_reg;
-		}
+		if (vref_mv < 0)
+			return vref_mv;
 
 		vref_mv /= 1000;
 	} else {
@@ -816,50 +823,21 @@ static int ad7793_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->iio_info;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = ad7793_setup(indio_dev, pdata, vref_mv);
 	if (ret)
-		goto error_remove_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_remove_trigger;
-
-	return 0;
-
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7793_remove(struct spi_device *spi)
-{
-	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7793_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
-		regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7793_id[] = {
@@ -881,7 +859,6 @@ static struct spi_driver ad7793_driver = {
 		.name	= "ad7793",
 	},
 	.probe		= ad7793_probe,
-	.remove		= ad7793_remove,
 	.id_table	= ad7793_id,
 };
 module_spi_driver(ad7793_driver);
-- 
2.31.1

