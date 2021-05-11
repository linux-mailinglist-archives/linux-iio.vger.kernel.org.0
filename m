Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69337A0A2
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhEKHUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhEKHTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB84C061343
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so6775299edt.13
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=BM5I0JVYaWiKMQYRSDBOk8/kvBqUYIC0tO+Bt8CRC+OpkAGt+A89wDgurdK07jqEcs
         tRuWxcOzb6SCItKXbxx4ybqxBgjYTGzyM6Z7eTG2nyvC2jAV/shP3OO9ob5Fd7YjROpI
         pOnO/puKxV00u5dBltQwCVibua/yLGQG1cN10BiLeRXe5JnkqMq9n3o7YXpk+8z9Djf/
         X4rk0LkePWOV4uZOpc2jNG42x8vff7kYvDU8Ko6QKnPcKRnMoEX1X/Q3y7N1xVj8Kv4j
         P4ypWEw9NJWQmQRxVTnKz4xAr91ciDqclj2Mx29BPQK1PnaIc2usDcqKYqtcy0K6RKMk
         QSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=nHlscpKGHDR40+m9OnMuvJXjT1iQ6OBwD6p5sCaf5Ou7zqO/4/lDFuwV9TFn5KlQj9
         gZIRHhGWOGsVVrDrkcwpzWl3Ncgd11LMXqMwPC+1UqfpgQCqRxj9Q0hA09wWaNeBUMCW
         R8xrQRUP4YrUDrTHMGeQtD8y7gsw5CMc66utQ8ZFNwvQZBmYPPgRS7ArH0xC3aVn3dz4
         HT+XMp2o/fx19mh0PapFyO5drxMba/4perC7Vg98aFg0TqXUCVU8IFqwVxvE26ReHmqk
         hn/ZZUEd7oXixS0wVNvUq6vFgmOjvLIBwGfuB/PHi8e4pOogwgJY+0EdRD0MN4y4Oihx
         dyxg==
X-Gm-Message-State: AOAM532ynORP0NJoCjeO9UlPehu51hO42wZn75uqBm0rNSC3nctKAOJW
        cbwQJLERZ2K/yN/FaX5JFn2LJV2hkGL/Lh5m
X-Google-Smtp-Source: ABdhPJyWmZENVLyR/8uAQK3cr5JCztj0xscC2XVLz41SUr+tpPkmyz3NxAq61n/rZb1VSNGRtJ1rmQ==
X-Received: by 2002:aa7:d14e:: with SMTP id r14mr33660734edo.119.1620717522217;
        Tue, 11 May 2021 00:18:42 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:41 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 07/12] iio: adc: ad7791: convert to device-managed functions
Date:   Tue, 11 May 2021 10:18:26 +0300
Message-Id: <20210511071831.576145-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7791 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7791.c | 44 ++++++++++++----------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index d57ad966e17c..cb579aa89f39 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -394,6 +394,11 @@ static int ad7791_setup(struct ad7791_state *st,
 		st->mode);
 }
 
+static void ad7791_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7791_probe(struct spi_device *spi)
 {
 	struct ad7791_platform_data *pdata = spi->dev.platform_data;
@@ -420,11 +425,13 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7791_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
@@ -434,39 +441,15 @@ static int ad7791_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7791_no_filter_info;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = ad7791_setup(st, pdata);
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
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7791_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7791_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7791_spi_ids[] = {
@@ -484,7 +467,6 @@ static struct spi_driver ad7791_driver = {
 		.name	= "ad7791",
 	},
 	.probe		= ad7791_probe,
-	.remove		= ad7791_remove,
 	.id_table	= ad7791_spi_ids,
 };
 module_spi_driver(ad7791_driver);
-- 
2.31.1

