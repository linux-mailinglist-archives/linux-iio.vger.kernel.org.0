Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C59378E4D
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhEJNI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351132AbhEJNDA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BCC061354
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n84so9161306wma.0
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=nB6V2OiSUjK8M4VzjC8wVNG5ROwF67dajwwuKKwkKwmqtxnk9yURjgDACoN+WGFieD
         fEDszTsrrA4Zim4igvPVD6BxrawG/hIFGo+rg/FXxsSh29k1U4sephLV9GFfufN70wT8
         unlt/taT2Et1hBwK2Z3bLPQ8koP46eLv9UJRimB0118m/KXPrXH3k5ACMdjPJ5p3rGqw
         dX7EwCGT7gjRbUHu5DRMFLh6Qfvaj674sMnPg5FVpH3flnjVrJK+3akmcpPmYHOQCvBf
         rrCYp/q6BBg6reb6DYEip5tU4dw7SCKjw4WjxCGqQfCi9kK19I9Rd4H//vK4G/jYnoB4
         xAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=T1OLN/qAFKkb1XKv2WvuR/g1whmcFK/Os85ttuip9mRYcDDikj0lq7pQ3nXCR31Lw+
         ceC2db8PT5OWqK2EnaIG54rqvcJgbbGYNsZB0pCDeSEsgN4TZUDYzsn/Q03LomE0O2l6
         ZpHm3zo+5huZ4+U949nSih0DxhzFNRmlRUpncnOsY1hfYDpDDYygEqps5mlp/PtRZCyG
         78Qu2k7O5jgYucwGOdEp4wr21TJqM5tGzO8UDLBCaI2OLwW/cb4FMIa5JuYBBzNIihb9
         InPc/k14MScEMeRFvSBFMjirgCeL2bHREUndAFilLKoZ7LsmdI0uBBqdaZtIrI4CDFNL
         nA6w==
X-Gm-Message-State: AOAM531qX+8vdqK8+MFxTHKFt6hulToQG/l1lliDOXNsiG/YDzq3ebTg
        gn0+YEdxjETt/shzFxzM5iMCe4W3orZd9w==
X-Google-Smtp-Source: ABdhPJwHCSjf7ERnk0dtX1pdHAlO1IVBcl/cBzc8KTTNAkH5xyuxaKg2nC5CmDB9usaRrGNKARj1ug==
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr37195201wmq.143.1620651353867;
        Mon, 10 May 2021 05:55:53 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:53 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 03/11] iio: adc: ad7791: convert to device-managed functions
Date:   Mon, 10 May 2021 15:55:15 +0300
Message-Id: <20210510125523.1271237-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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

